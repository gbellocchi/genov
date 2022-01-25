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

#ifndef FIR_H_
#define FIR_H_

#include <iostream>
#include <fstream>
#include <cstdlib>

#include <assert.h>
#include <stdint.h>
#include <hls_stream.h>

using namespace std;

typedef uint32_t data_t;
typedef uint32_t coeff_t;
typedef uint32_t sum_t;

#define MAX_N_SAMPLES 512*512
#define N_SAMPLES 512*8
#define TAP 128

// void fir_128_mdc(
//           uint32_t n_samples,
//           uint32_t coeff[TAP], 
//           hls::stream<uint32_t> &din_strm, 
//           hls::stream<uint32_t> &dout_strm);

void fir_128_mdc(
          uint32_t n_samples,
          hls::stream<uint32_t> &din_strm, 
          hls::stream<uint32_t> &dout_strm);

#endif // FIR_H_ not defined