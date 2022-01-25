/**********
Copyright (c) 2018, Xilinx, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software
without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**********/

#include "mmult.h"

void mmult_sw( data_t *in1,   
               data_t *in2,   
               data_t *out,   
               data_t mat_dim    
             )
{
    for (data_t i = 0; i < mat_dim; i++){
        for (data_t j = 0; j < mat_dim; j++){
            for (data_t k = 0; k < mat_dim; k++){
                out[i * mat_dim + j] += in1[i * mat_dim + k] * in2[k * mat_dim  + j];
            }
        }
    }
}

static void mmult_hw(hls::stream<data_t> &in1, hls::stream<data_t> &in2, hls::stream<data_t> &out, int width, int height, int stripe_height)
{
    // These assertions let HLS know the upper bounds of loops
    assert(width < MAX_WIDTH);
    assert(height < MAX_HEIGHT);
    assert(stripe_height < MAX_STRIPE);

    int local_in1[stripe_height][width];
    int local_in2[height][stripe_height];
    int local_out[stripe_height][stripe_height]; 

    #pragma HLS ARRAY_PARTITION variable=local_in1 complete dim=2 
    #pragma HLS ARRAY_PARTITION variable=local_in2 complete dim=1 

    read_in: for(int iter = 0, i=0, j=0; iter< width*stripe_height; iter++,j++){
    #pragma HLS PIPELINE
    #pragma HLS LOOP_TRIPCOUNT min=width*stripe_height max=width*stripe_height
        if( j== width){ j = 0; i++; }
        local_in1[i][j] = in1.read();
        local_in2[j][i] = in2.read(); 
    }

    loop_1: for (int i = 0 ; i < stripe_height ; i++){
    #pragma HLS LOOP_TRIPCOUNT min=stripe_height max=stripe_height
        loop_2: for(int j = 0 ; j < stripe_height ; j++){
        #pragma HLS LOOP_TRIPCOUNT min=stripe_height max=stripe_height
        #pragma HLS PIPELINE
            int res = 0;
            loop_3: for(int k = 0; k < width; k++){
                res += local_in1[i][k]*local_in2[k][j];
            }
            local_out[i][j] = res;
        }
    }

    write_out: for(int iter = 0, i = 0, j = 0; iter < stripe_height * stripe_height; iter++, j++){
    #pragma HLS PIPELINE
    #pragma HLS LOOP_TRIPCOUNT min=stripe_height*stripe_height max=stripe_height*stripe_height
        if(j == stripe_height){ j = 0; i++; }
        out << local_out[i][j];
    }   
}

void mmult_mdc(hls::stream<data_t> &in1, hls::stream<data_t> &in2, hls::stream<data_t> &out, int width, int height, int stripe_height)
{
#pragma HLS INTERFACE axis port=&in1 
#pragma HLS INTERFACE axis port=&in2 
#pragma HLS INTERFACE axis port=&out 

#pragma HLS INTERFACE ap_ctrl_none port=return

  mmult_hw(in1, in2, out, width, height, stripe_height);
}
