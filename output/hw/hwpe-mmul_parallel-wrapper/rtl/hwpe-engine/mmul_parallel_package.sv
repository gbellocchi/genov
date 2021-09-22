
//
/*
 * HWPE: Francesco Conti <fconti@iis.ee.ethz.ch>
 *
 * Copyright (C) 2018 ETH Zurich, University of Bologna
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * Authors:     Francesco Conti <fconti@iis.ee.ethz.ch>
 * Contribute:  Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: mmul_parallel_package.sv
 *
 */
import hwpe_stream_package::*;
package mmul_parallel_package;
  parameter int unsigned MMUL_PARALLEL_CNT_LEN = 1024; // maximum length of the vectors for a scalar product
  /* Registers */
  // TCDM addresses
  parameter int unsigned MMUL_PARALLEL_REG_IN1_ADDR              = 0;
  parameter int unsigned MMUL_PARALLEL_REG_IN2_ADDR              = 1;
  parameter int unsigned MMUL_PARALLEL_REG_OUT_R_ADDR              = 1;
  // Standard registers
  parameter int unsigned MMUL_PARALLEL_REG_NB_ITER              = 3;
  parameter int unsigned MMUL_PARALLEL_REG_LEN_ITER             = 4;
  parameter int unsigned MMUL_PARALLEL_REG_SHIFT_SIMPLEMUL      = 5;
  parameter int unsigned MMUL_PARALLEL_REG_SHIFT_VECTSTRIDE     = 6;
  parameter int unsigned MMUL_PARALLEL_REG_SHIFT_VECTSTRIDE2    = 7; // Added to be aligned with sw (not used in hw)
  // Custom register files
  // microcode offset indeces -- this should be aligned to the microcode compiler of course!
  parameter int unsigned MMUL_PARALLEL_UCODE_IN1_OFFS              = 0;
  parameter int unsigned MMUL_PARALLEL_UCODE_IN2_OFFS              = 1;
  parameter int unsigned MMUL_PARALLEL_UCODE_OUT_R_OFFS              = 1;
  // microcode mnemonics -- this should be aligned to the microcode compiler of course!
  parameter int unsigned MMUL_PARALLEL_UCODE_MNEM_NBITER     = 4 - 4;
  parameter int unsigned MMUL_PARALLEL_UCODE_MNEM_ITERSTRIDE = 5 - 4;
  parameter int unsigned MMUL_PARALLEL_UCODE_MNEM_ONESTRIDE  = 6 - 4;
  typedef struct packed {
    logic clear;
    logic enable;
    logic simple_mul;
    logic start;
    logic unsigned [$clog2(32)-1       :0] shift;
    logic unsigned [$clog2(mmul_parallel_CNT_LEN):0] len; // 1 bit more as cnt starts from 1, not 0
    // Custom register files
  } ctrl_engine_t;
  typedef struct packed {
    logic unsigned [$clog2(mmul_parallel_CNT_LEN):0] cnt; // 1 bit more as cnt starts from 1, not 0
    logic done;
    logic idle;
    logic ready;
  } flags_engine_t;
  typedef struct packed {
    hwpe_stream_package::ctrl_sourcesink_t in1_source_ctrl;
    hwpe_stream_package::ctrl_sourcesink_t in2_source_ctrl;
    hwpe_stream_package::ctrl_sourcesink_t out_r_sink_ctrl;
  } ctrl_streamer_t;
  typedef struct packed {
    hwpe_stream_package::flags_sourcesink_t in1_source_flags;
    hwpe_stream_package::flags_sourcesink_t in2_source_flags;
    hwpe_stream_package::flags_sourcesink_t out_r_sink_flags;
  } flags_streamer_t;
  typedef struct packed {
    logic simple_mul;
    logic unsigned [$clog2(32)-1       :0] shift;
    logic unsigned [$clog2(mmul_parallel_CNT_LEN):0] len; // 1 bit more as cnt starts from 1, not 0
    // Custom register files
  } ctrl_fsm_t;
  typedef enum {
    FSM_IDLE,
    FSM_START,
    FSM_COMPUTE,
    FSM_WAIT,
    FSM_UPDATEIDX,
    FSM_TERMINATE
  } state_fsm_t;
endpackage