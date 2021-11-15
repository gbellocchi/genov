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

#include "traffic_gen.h"

using namespace std;

int main(void)
{
    data_t * const ref = new data_t[TEST_TRNCT];

    hls::stream<data_t> stream_in("stream_in");
    hls::stream<data_t> stream_out("stream_out");

    int err_cnt = 0;
    int ret_val = 20;

    // Probability of request [0;100]
    data_t prob_req = 100;

    // Generate the source image with a fixed test pattern - checker-board
    for (int i = 0; i < TEST_TRNCT; i++) {
        ref[i] = i;
        stream_in << i;
    }

    // Generate DUT convolution image
    traffic_gen(stream_in, stream_out, TEST_TRNCT, prob_req);

    // Check DUT vs reference result

    for (int i = 0; i < TEST_TRNCT; i++) {
            data_t dut_val = stream_out.read();
            data_t ref_val = ref[i];
            // error check
            if (dut_val != ref_val) {
                err_cnt++;
#if 0
                cout << "!!! ERROR: Mismatch detected at coord(" << i;
                cout << ", " << j << " ) !!!";
                cout << endl;
#endif
        }
    }
    cout << endl;

    if (err_cnt == 0) {
        cout << "*** TEST PASSED ***" << endl;
        ret_val = 0;
    } else {
        cout << "!!! TEST FAILED - " << err_cnt << " mismatches detected !!!";
        cout << endl;
        ret_val = -1;
    }

    return ret_val;
}

