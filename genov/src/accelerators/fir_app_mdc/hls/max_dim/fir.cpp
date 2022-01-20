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

#include "fir.h"

void fir(hls::stream<data_t> &din, coeff_t coeff[TAP], hls::stream<data_t> &dout)
{
#pragma HLS INTERFACE ap_ctrl_none port=coeff
#pragma HLS ARRAY_PARTITION variable=coeff complete dim=1 

#pragma HLS INTERFACE ap_ctrl_none port=return

  data_t tout;
  const int n_samples = N_SAMPLES;
  const int n_taps = TAP;

  data_t local_din;
  data_t local_dout;

  data_t local_proc[n_taps];
  #pragma HLS ARRAY_PARTITION variable=local_proc complete dim=1

  // read_in: for(int i=0; i < n_samples; i++){
  // #pragma HLS PIPELINE
  // #pragma HLS LOOP_TRIPCOUNT min=n_samples max=n_samples
  //   local_din[i] = din.read();
  //   // std::cout << "round " << i << std::endl;
  //   // std::cout << "pre-fetch:" << local_din[i] << std::endl; // ok
  // }

  for (int j=0; j < n_taps; j++ ) {
    local_proc[j] = 0;
  }

  loop_A: for (int i=0; i<n_samples; i++ ) {
  // #pragma HLS pipeline II=n_taps
  #pragma HLS LOOP_TRIPCOUNT min=n_samples max=n_samples
  #pragma HLS pipeline

    local_din = din.read();
    local_dout = 0;
  
    loop_B: for (int j=0; j < n_taps ; j++) {
    // #pragma HLS LOOP_TRIPCOUNT min=n_taps max=n_taps
      // slide values on local buffer 
      local_proc[j] = (j<n_taps-1) ? local_proc[j+1] : local_din;
      // slide values on local buffer 
      local_dout += local_proc[j] * coeff[j];
    }

    dout << local_dout;

    std::cout << "round " << i << std::endl;
    std::cout << "loop_A - local_din = " << local_din << ", local_dout = " << local_dout << std::endl;
  }
}