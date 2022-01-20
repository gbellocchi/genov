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

#include <iostream>
#include <fstream>

#include "fir.h"

int main()
{
  data_t X[N_SAMPLES] = {10, -4, 1, 7, 1, 1, 0, 0, 1, 1, 1, -6, -2, -1, 2, 2, 0, 0, 0, 0};
  coeff_t H[TAP] = {1, 2, 2, 1};
  sum_t Y_ref[N_SAMPLES] = {0, 0, 0, 0, 0, 0, 0, 10, 16, 13, 11, 13, 18, 11, 3, 2, 3, 5, -1, -11};

  size_t n_samples = N_SAMPLES;
  size_t n_coeffs = TAP;
  size_t size_samples_B = sizeof(data_t) * n_samples;
  size_t size_coeffs_B = sizeof(data_t) * n_coeffs;

  data_t *din = (data_t *) malloc(size_samples_B);
  data_t *coeffs = (data_t *) malloc(size_coeffs_B);
  data_t *dout_hw = (data_t *) malloc(size_samples_B);
  data_t *dout_sw = (data_t *) malloc(size_samples_B);

  hls::stream<data_t> din_strm("din_strm");
  hls::stream<data_t> dout_hw_strm("dout_hw_strm");

  bool match = true;

  //Create test data
  for (int i = 0; i < n_samples; i++) {
      // original version
      din[i] = X[i];
      dout_hw[i] = 0;
      // stream version
      din_strm << X[i];
      dout_hw_strm << 0;
      dout_sw[i] = Y_ref[i];
  }

  for (int i = 0; i < n_coeffs; i++) {
      coeffs[i] = H[i];
  }

  //Launch the hardware solution
  // fir(din, H, dout_hw);
  fir(din_strm, H, dout_hw_strm);

  //Compare the results of hardware to the software 
  for(int i=0; i< n_samples; i++)
  {
    data_t out_ref = dout_sw[i];
    data_t out_dut = din_strm.read();
    if( out_ref != out_dut )
    {
      std::cout << "Ref:" << out_ref <<"\t Hardware:" << out_dut << std::endl;
      match = false;
      break;
    }
  }

    free(din);
    free(coeffs);
    free(dout_hw);
    free(dout_sw);

    std::cout << "\n\nTEST " << (match? "PASSED\n\n": "FAILED\n\n") << std::endl;
    return(match? EXIT_SUCCESS: EXIT_FAILURE);
}
