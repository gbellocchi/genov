/* =====================================================================
 * Project:      Verification dataset generator.
 * Title:        ref_app.c
 * Description:  Reference application libraries and defintions.
 *
 * $Date:        14.11.2021
 * ===================================================================== */
/*
 * Copyright (C) 2021 University of Modena and Reggio Emilia..
 *
 * Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
 *
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

/* Parameters. */

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