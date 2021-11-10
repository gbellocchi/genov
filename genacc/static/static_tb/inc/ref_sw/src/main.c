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

// Entire image dimension
#define MAX_IMG_ROWS 1080
#define MAX_IMG_COLS 1920

#define IM_UAV_ROWS 64
#define IM_UAV_COLS 64

#define UAV_FILTER_DIM 11

// Image block dimensions
#define IM_BLOCK_ROWS 64
#define IM_BLOCK_COLS 320
#define IM_BLOCK_SIZE (UAV_STRIPE_ROWS * UAV_STRIPE_COLS)

/* Generate synthetic stimuli. */

void gen_stim(uint32_t* stim, uint32_t width, uint32_t height)
{
  printf(">> Generating synthetic input stimuli.\n");

  /* Algorithm parameters declaration. */
    
  const int chkr_size = 5;
  const unsigned max_pix_val = 255;
  const unsigned min_pix_val = 0;

  /* Generate synthetic stimuli. */

  for (int i = 0; i < IM_UAV_ROWS; i++) {
    unsigned chkr_pair_val[2];
    if ((i / chkr_size) % 2 == 0) {
      chkr_pair_val[0] = max_pix_val; chkr_pair_val[1] = min_pix_val;
    } else {
      chkr_pair_val[0] = min_pix_val; chkr_pair_val[1] = max_pix_val;
    }
    for (int j = 0; j < IM_UAV_COLS; j++) {
      unsigned pix_val = chkr_pair_val[(j / chkr_size) % 2];
      stim[i * IM_UAV_COLS + j] = pix_val;
    }
  }
}

/* Generate golden results. */

void ref_app(uint32_t* in, uint32_t* out, uint32_t width, uint32_t height)
{
  printf(">> Running reference SW application to generate golden results.\n");

  // Filter dimension

  const int conv_size = UAV_FILTER_DIM;

  // Filter components

  uint32_t coeffs[UAV_FILTER_DIM] = {
    36, 111, 266, 498, 724, 821, 724, 498, 266, 111, 36
  };

  uint32_t in_temp;
  uint32_t out_temp;
  uint32_t out_H[width*height];
  uint32_t out_V[width*height];

  const int border_width = (int)(conv_size / 2);

  // Horizontal convolution

  Clear_out_H:for(int i = 0; i < height * width; i++){
    out_H[i]=0;
  }

  HconvH: for(int col = 0; col < height; col++){
    HconvW: for(int row = border_width; row < width - border_width; row++){
      int pixel = col * width + row;
      Hconv: for(int i = - border_width; i <= border_width; i++){
        out_H[pixel] += in[pixel + i] * coeffs[i + border_width];
      }
    }
  }

  // Vertical convolution

  Clear_out_V:for(int i = 0; i < height * width; i++){
    out_V[i]=0;
  }

  VconvH: for(int col = border_width; col < height - border_width; col++){
    VconvW: for(int row = 0; row < width; row++){
      int pixel = col * width + row;
      Vconv: for(int i = - border_width; i <= border_width; i++){
        int offset = i * width;
        out[pixel] += out_H[pixel + offset] * coeffs[i + border_width];
      }
    }
  }

  // Border pixels

  int border_width_offset = border_width * width;
  int border_height_offset = (height - border_width - 1) * width;

  // Border pixels

  Top_Border:for(int col = 0; col < border_width; col++){
    int offset = col * width;
    Top_Left:for(int row = 0; row < border_width; row++){
      int pixel = offset + row;
      out[pixel] = out[border_width_offset + border_width];
    }
    Top_Row:for(int row = border_width; row < width - border_width; row++){
      int pixel = offset + row;
      out[pixel] = out[border_width_offset + row];
    }
    Top_Right:for(int row = width - border_width; row < width; row++){
      int pixel = offset + row;
      out[pixel] = out[border_width_offset + width - border_width - 1];
    }
  }

  Side_Border:for(int col = border_width; col < height - border_width; col++){
    int offset = col * width;
    for(int row = 0; row < border_width; row++){
      int pixel = offset + row;
      out[pixel] = out[offset + border_width];
    }
    for(int row = width - border_width; row < width; row++){
      int pixel = offset + row;
      out[pixel] = out[offset + width - border_width - 1];
    }
  }

  Bottom_Border:for(int col = height - border_width; col < height; col++){
    int offset = col * width;
    for(int row = 0; row < border_width; row++){
      int pixel = offset + row;
      out[pixel] = out[border_height_offset + border_width];
    }
    for(int row = border_width; row < width - border_width; row++){
      int pixel = offset + row;
      out[pixel] = out[border_height_offset + row];
    }
    for(int row = width - border_width; row < width; row++){
      int pixel = offset + row;
      out[pixel] = out[border_height_offset + width - border_width - 1];
    }
  }
}

/* Generate output header file. */

void gen_Hfile(char* val_name, uint32_t* synth_data, uint32_t width, uint32_t height)
{
  printf(">> Export synthetic %s to header file.\n", val_name);

  char filename[100];
  char h_body[1000];

  // Create file
  strcpy(filename, val_name);
  strcat(filename, ".h");

  FILE *fp = fopen(filename, "w+");

  // Generate header file
  strcpy(h_body, "__attribute__((aligned(32))) int32_t ");
  strcat(h_body, val_name);
  strcat(h_body, "[] = {\n");
  fprintf(fp, "%s", h_body);

  for (int ii = 0; ii < height; ii++) {
    for (int jj = 0; jj < width; jj++) {
      if(ii*width+jj==width*height-1)
        fprintf(fp, "\t0x%lx\n", synth_data[ii*width+jj]);
      else
        fprintf(fp, "\t0x%lx,\n", synth_data[ii*width+jj]);
    }
  }

  fprintf(fp, "}");

  // Close file
  fclose(fp);
}


/* - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / - / */


int main(int argc, char *argv[])
{
  /* Stimuli dimension. */

  unsigned width          = IM_UAV_ROWS;
  unsigned height         = IM_UAV_COLS;
  unsigned stripe_height  = IM_BLOCK_ROWS;

  /* Allocate DRAM arrays. */

  uint32_t* l3_src = (uint32_t*)malloc(width*height*sizeof(uint32_t));
  uint32_t* l3_dst = (uint32_t*)malloc(width*height*sizeof(uint32_t)); 

  /* Additional parameters. */

  const unsigned stripe_len        = width*stripe_height;

  /* Generate synthetic stimuli. */

  gen_stim(l3_src, width, height);

  /* Generate golden results. */

  ref_app(l3_src, l3_dst, width, height);

  /* */

  gen_Hfile("stim_src", l3_src, width, height);
  gen_Hfile("golden_dst", l3_dst, width, height);

  /* Cleanup. */  

  free(l3_src);
  free(l3_dst);

  return 0;
}
