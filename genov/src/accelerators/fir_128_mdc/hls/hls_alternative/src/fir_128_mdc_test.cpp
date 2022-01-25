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
#include <cstdlib>

#include "fir_128_mdc.h"

#include "x_V.h"
// #include "taps.h"
#include "y_V_ref.h"

int main()
{
  size_t n_samples = N_SAMPLES;
  size_t n_coeffs = TAP;
  size_t size_samples_B = sizeof(uint32_t) * n_samples;
  size_t size_coeffs_B = sizeof(uint32_t) * n_coeffs;

  // uint32_t *coeffs = (uint32_t *) malloc(size_coeffs_B);

  hls::stream<uint32_t> din_strm("din_strm");
  hls::stream<uint32_t> dout_hw_strm("dout_hw_strm");

  int err_cnt = 0;

  //Create test data
  for (int i = 0; i < n_samples; i++) {
    din_strm << x_V[i];
    dout_hw_strm << 0;

    // std::cout << "Iter #" << i << std::endl;
    // std::cout << "x_V[i] = " << x_V[i] << std::endl; OK
    // std::cout << "din_strm = " << din_strm.read() << std::endl;
    // std::cout << "" << std::endl;
  }

  // for (int i = 0; i < n_coeffs; i++) {
  //   coeffs[i] = taps[i];
  //   // std::cout << "coeffs[i] = " << coeffs[i] << std::endl; OK
  // }

  //Launch the hardware solution
  // fir_128_mdc(n_samples, coeffs, din_strm, dout_hw_strm);
  fir_128_mdc(n_samples, din_strm, dout_hw_strm);

  //Compare the results of hardware to the software 
  for(int i=0; i< n_samples; i++)
  {
    uint32_t dut_val = dout_hw_strm.read();
    uint32_t ref_val = y_V_ref[i];

    // std::cout << "Iter #" << i << std::endl;
    // std::cout << "out_ref = " << out_ref << std::endl;
    // std::cout << "out_dut = " << out_dut << std::endl;

    if( dut_val != ref_val )
    {
      err_cnt++;
    }
  }

  int ret_val = 0;
  
  if (err_cnt == 0) {
    cout << "*** TEST PASSED ***" << endl;
    int ret_val = 0;
  } else {
    cout << "!!! TEST FAILED - " << err_cnt << " mismatches detected !!!";
    cout << endl;
    int ret_val = -1;
  }

  return ret_val;
}
