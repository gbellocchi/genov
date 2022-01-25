/*
 * Copyright 2020 Xilinx, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "fir_128_mdc.h"

template<typename T, int K>
static void process(int n_samples, const T * filter_coeffs,
        hls::stream<T> &din, hls::stream<T> &dout)
{
  const int n_taps = K;
  assert(n_samples < MAX_N_SAMPLES);

  // std::cout << ">> n_samples = " << n_samples << std::endl;

  T local_proc[n_taps];
  #pragma HLS ARRAY_PARTITION variable=local_proc complete dim=1

  for (int j=0; j < n_taps; j++ ) {
    local_proc[j] = 0;
  }

  loop_A: for (int i=0; i<n_samples; i++ ) {
  // #pragma HLS pipeline II=n_taps
  #pragma HLS LOOP_TRIPCOUNT min=n_samples max=n_samples
  #pragma HLS PIPELINE

    T local_din = din.read();
    T local_dout = 0;

    // std::cout << "Iter #" << i << std::endl;
    // std::cout << "loop_A - local_din = " << local_din << std::endl; OK
  
    loop_B: for (int j=0; j < n_taps ; j++) {
    // #pragma HLS LOOP_TRIPCOUNT min=n_taps max=n_taps
      local_proc[j] = (j<n_taps-1) ? local_proc[j+1] : local_din;
      local_dout += local_proc[j] * filter_coeffs[j];
    }

    dout << local_dout;

    // std::cout << "Iter #" << i << std::endl;
    // std::cout << "loop_A - local_din = " << local_din << std::endl;
    // std::cout << "loop_A - local_dout = " << local_dout << std::endl;

    // std::cout << "loop_A - din = " << din.read() << std::endl;
    // std::cout << "loop_A - dout = " << dout.read() << std::endl;
    // std::cout << "" << std::endl;

    // std::cout << "round " << i << std::endl;
    // std::cout << "loop_A - local_din = " << local_din << ", local_dout = " << local_dout << std::endl;
  }
}

void fir_128_mdc(
          uint32_t n_samples,
          uint32_t coeff[TAP], 
          hls::stream<uint32_t> &din_strm, 
          hls::stream<uint32_t> &dout_strm)
{
#pragma HLS INTERFACE axis port=&din_strm 
#pragma HLS INTERFACE axis port=&dout_strm 

#pragma HLS INTERFACE ap_ctrl_none port=n_samples

#pragma HLS INTERFACE ap_ctrl_none port=coeff
#pragma HLS ARRAY_PARTITION variable=coeff complete dim=1

#pragma HLS INTERFACE ap_ctrl_none port=return

#pragma HLS DATAFLOW
#pragma HLS INLINE // bring loops in sub-functions to this DATAFLOW region

  // const data_t _coeff[TAP] = coeff;

  process<uint32_t, TAP>(n_samples, coeff, din_strm, dout_strm);
}