/*
 * Copyright 2019 ETH Zurich, University of Bologna
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* Libraries. */

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <errno.h>

// Stimuli dimension
#define MAX_IMG_ROWS 1080
#define MAX_IMG_COLS 1920

#define IM_UAV_ROWS 320
#define IM_UAV_COLS 320

#define IM_BLOCK_ROWS 16
#define IM_BLOCK_COLS 320
#define IM_BLOCK_SIZE (UAV_STRIPE_ROWS * UAV_STRIPE_COLS)

// Filter dimension
#define UAV_FILTER_DIM 11

/* Host matrix multiplication. */

void ref_sw(uint32_t* in1, uint32_t* in2, uint32_t* out, uint32_t mat_dim, uint32_t stripe_height)
{
  for (unsigned i = 0; i < mat_dim; i++){
    for (unsigned j = 0; j < mat_dim; j++){
      for (unsigned k = 0; k < mat_dim; k++){
        out[i * mat_dim + j] += in1[i * mat_dim + k] * in2[j * mat_dim  + k];
      }
    }
  }
}

/* - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / */

/*
 *
 *     HOST processor - Main program.
 *
 */

int main(int argc, char *argv[])

  /* Matrix dimension. */

  unsigned width          = 512;
  unsigned height         = 512;
  unsigned stripe_height  = 8;

  /* General. */

  int status;
  int fd;

  /* Allocate DRAM arrays. */

  uint32_t* l3_in1      = (int32_t*)malloc(width*height*sizeof(uint32_t));
  uint32_t* l3_in2      = (int32_t*)malloc(width*height*sizeof(uint32_t)); 
  uint32_t* l3_test     = (int32_t*)malloc(width*height*sizeof(uint32_t)); 

  /* I/O arrays initialization. */

  for(int i=0; i<width*height; i++){
    l3_in1[i]   = rand() % 255;
    l3_in2[i]   = rand() % 255;
  }

  /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

  /* Additional parameters. */

  const unsigned stripe_len_in        = width*stripe_height;
  const unsigned stripe_len_out       = stripe_height*stripe_height;

  /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

  /* Execute reference SW application. */

  ref_sw( l3_in1, l3_in2, l3_test, width, stripe_height);

  /* Cleanup. */  

  free(l3_in1);
  free(l3_in2);
  free(l3_test);

  return 0;
}