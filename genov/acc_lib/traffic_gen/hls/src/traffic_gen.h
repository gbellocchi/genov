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

#ifndef TR_GEN_H_
#define TR_GEN_H_

#include <assert.h>
#include <stdint.h>
#include <hls_stream.h>

#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;

#define MAX_TRNCT 1080
#define TEST_TRNCT 320

typedef uint32_t data_t;

void traffic_gen(

    // Data ports
    hls::stream<data_t> &stream_in, 
    hls::stream<data_t> &stream_out,

    // Custom registers
    int n_trans,    // Number of triggered requests
    int prob_req   // Probability of emitting a request (1000 -> 100%)

    // Ideas for other parameters
    // I/O ratio -> How many in correspond to an output?

);

#endif // TR_GEN_H_y not defined

