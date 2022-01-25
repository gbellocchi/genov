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
#include "taps.h"

template<typename T, int K>
static void process(int n_samples,
        hls::stream<T> &din, hls::stream<T> &dout)
{
  const int n_taps = K;
  assert(n_samples < MAX_N_SAMPLES);

  #pragma HLS INLINE

  T local_din[K];
  #pragma HLS ARRAY_PARTITION variable=local_din dim=1 complete

  T filter_coeffs[K];
  #pragma HLS ARRAY_PARTITION variable=filter_coeffs dim=1 complete

  T local_dout[K];
  #pragma HLS ARRAY_PARTITION variable=local_dout dim=1 complete

  // loop_clear:for(int i = 0; i < n_taps; i++){
  //   local_din[i]=0;
  // }

  for (int i = 0; i < n_taps; i++) {
    filter_coeffs[i] = taps[i];
  }

  loop_A: for (int i=0; i < n_samples; i++ ) {
  // #pragma HLS LOOP_TRIPCOUNT min=n_samples max=n_samples

    #pragma HLS PIPELINE

    // T local_din = ;
    // T local_dout = 0;
  
    loop_read: for (int j=0; j < n_taps ; j++) {
    // #pragma HLS LOOP_TRIPCOUNT min=n_taps max=n_taps
      local_din[j] = (j==0) ? din.read() : local_din[j-1];
    }

    loop_proc: for (int j=0; j < n_taps ; j++) {
    // #pragma HLS LOOP_TRIPCOUNT min=n_taps max=n_taps
      local_dout[j] += local_din[j] * filter_coeffs[j];
    }

    dout << local_dout[n_taps-1];
  }
}

void fir_128_mdc(
          uint32_t n_samples,
          hls::stream<uint32_t> &din_strm, 
          hls::stream<uint32_t> &dout_strm)
{
#pragma HLS INTERFACE axis port=&din_strm 
#pragma HLS INTERFACE axis port=&dout_strm 

#pragma HLS INTERFACE ap_ctrl_none port=n_samples
#pragma HLS INTERFACE ap_ctrl_none port=return

// #pragma HLS DATAFLOW
// #pragma HLS INLINE // bring loops in sub-functions to this DATAFLOW region

  process<uint32_t, TAP>(n_samples, din_strm, dout_strm);
}