
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
 * HWPE author: Francesco Conti <fconti@iis.ee.ethz.ch>
 * HWPE specialization tool: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: multi_dataflow_mac_mdc_package.sv
 *
 */

import hwpe_stream_package::*;

package multi_dataflow_mac_mdc_package;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_CNT_LEN = 1024; // maximum length of the vectors for a scalar product

  /* Registers */

  // TCDM

  // Input ports
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM0_ADDR              = 0;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM1_ADDR              = 1;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM2_ADDR              = 2;

  // Output ports
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_OUTSTREAM0_ADDR             = 3;

  // Standard registers

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_NB_ITER              = 4;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_SHIFT_LINESTRIDE     = 5;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_SHIFT_TILESTRIDE     = 6;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_CNT_LIMIT_OUTSTREAM0             = 7;

  // Custom register files

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_MULTI_DATAFLOW_MAC_MDC_REG_SIMPLE_MUL             = 8;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_MULTI_DATAFLOW_MAC_MDC_REG_SHIFT             = 9;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_MULTI_DATAFLOW_MAC_MDC_REG_LEN             = 10;

  // Input stream - inStream0 (programmable)
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM0_TRANS_SIZE       = 11;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM0_LINE_STRIDE      = 12;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM0_LINE_LENGTH      = 13;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM0_FEAT_STRIDE      = 14;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM0_FEAT_LENGTH      = 15;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM0_FEAT_ROLL        = 16;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM0_LOOP_OUTER       = 17;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM0_REALIGN_TYPE     = 18;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM0_STEP             = 19;
  // Input stream - inStream1 (programmable)
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM1_TRANS_SIZE       = 20;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM1_LINE_STRIDE      = 21;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM1_LINE_LENGTH      = 22;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM1_FEAT_STRIDE      = 23;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM1_FEAT_LENGTH      = 24;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM1_FEAT_ROLL        = 25;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM1_LOOP_OUTER       = 26;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM1_REALIGN_TYPE     = 27;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM1_STEP             = 28;
  // Input stream - inStream2 (programmable)
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM2_TRANS_SIZE       = 29;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM2_LINE_STRIDE      = 30;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM2_LINE_LENGTH      = 31;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM2_FEAT_STRIDE      = 32;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM2_FEAT_LENGTH      = 33;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM2_FEAT_ROLL        = 34;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM2_LOOP_OUTER       = 35;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM2_REALIGN_TYPE     = 36;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_INSTREAM2_STEP             = 37;

  // Output stream - outStream0 (programmable)
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_OUTSTREAM0_TRANS_SIZE       = 38;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_OUTSTREAM0_LINE_STRIDE      = 39;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_OUTSTREAM0_LINE_LENGTH      = 40;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_OUTSTREAM0_FEAT_STRIDE      = 41;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_OUTSTREAM0_FEAT_LENGTH      = 42;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_OUTSTREAM0_FEAT_ROLL        = 43;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_OUTSTREAM0_LOOP_OUTER       = 44;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_OUTSTREAM0_REALIGN_TYPE     = 45;
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_REG_OUTSTREAM0_STEP             = 46;

  /* Microcode processor */

  // offset indeces -- this should be aligned to the microcode compiler of course!
  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_UCODE_INSTREAM0_OFFS              = 0;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_UCODE_INSTREAM1_OFFS              = 1;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_UCODE_INSTREAM2_OFFS              = 2;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_UCODE_OUTSTREAM0_OFFS              = 3;

  // mnemonics -- this should be aligned to the microcode compiler of course!

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_UCODE_MNEM_NBITER     = 0;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_UCODE_MNEM_ITERSTRIDE = 1;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_UCODE_MNEM_ONESTRIDE  = 2;

  parameter int unsigned MULTI_DATAFLOW_MAC_MDC_UCODE_MNEM_TILESTRIDE = 3;

  /* Typedefs */

  typedef struct packed {
    logic clear;
    logic enable;
    logic start;

    logic unsigned [$clog2(MULTI_DATAFLOW_MAC_MDC_CNT_LEN):0] cnt_limit_outStream0;

    // Custom register
  logic unsigned [(32-1):0] reg_simple_mul;
  logic unsigned [(32-1):0] reg_shift;
  logic unsigned [(32-1):0] reg_len;
  } ctrl_engine_multi_dataflow_mac_mdc_t;

  typedef struct packed {

    logic unsigned [$clog2(MULTI_DATAFLOW_MAC_MDC_CNT_LEN):0] cnt_outStream0;

    logic done;
    logic ready;
  } flags_engine_multi_dataflow_mac_mdc_t;

  typedef struct packed {
    logic start;
  } ctrl_kernel_adapter_multi_dataflow_mac_mdc_t;

  typedef struct packed {
    logic done;
    logic idle;
    logic ready;
  } flags_kernel_adapter_multi_dataflow_mac_mdc_t;

  typedef struct packed {
  	
  hwpe_stream_package::ctrl_sourcesink_t inStream0_source_ctrl;
  hwpe_stream_package::ctrl_sourcesink_t inStream1_source_ctrl;
  hwpe_stream_package::ctrl_sourcesink_t inStream2_source_ctrl;

  hwpe_stream_package::ctrl_sourcesink_t outStream0_sink_ctrl;
  
  } ctrl_streamer_multi_dataflow_mac_mdc_t;

  typedef struct packed {

  hwpe_stream_package::flags_sourcesink_t inStream0_source_flags;
  hwpe_stream_package::flags_sourcesink_t inStream1_source_flags;
  hwpe_stream_package::flags_sourcesink_t inStream2_source_flags;

  hwpe_stream_package::flags_sourcesink_t outStream0_sink_flags;
  } flags_streamer_multi_dataflow_mac_mdc_t;

  typedef struct packed {

    // Input stream - inStream0 (programmable)
    logic unsigned [31:0] inStream0_trans_size;
    logic unsigned [15:0] inStream0_line_stride;
    logic unsigned [15:0] inStream0_line_length;
    logic unsigned [15:0] inStream0_feat_stride;
    logic unsigned [15:0] inStream0_feat_length;
    logic unsigned [15:0] inStream0_feat_roll;
    logic unsigned [15:0] inStream0_step;
    logic unsigned inStream0_loop_outer;
    logic unsigned inStream0_realign_type;
    // Input stream - inStream1 (programmable)
    logic unsigned [31:0] inStream1_trans_size;
    logic unsigned [15:0] inStream1_line_stride;
    logic unsigned [15:0] inStream1_line_length;
    logic unsigned [15:0] inStream1_feat_stride;
    logic unsigned [15:0] inStream1_feat_length;
    logic unsigned [15:0] inStream1_feat_roll;
    logic unsigned [15:0] inStream1_step;
    logic unsigned inStream1_loop_outer;
    logic unsigned inStream1_realign_type;
    // Input stream - inStream2 (programmable)
    logic unsigned [31:0] inStream2_trans_size;
    logic unsigned [15:0] inStream2_line_stride;
    logic unsigned [15:0] inStream2_line_length;
    logic unsigned [15:0] inStream2_feat_stride;
    logic unsigned [15:0] inStream2_feat_length;
    logic unsigned [15:0] inStream2_feat_roll;
    logic unsigned [15:0] inStream2_step;
    logic unsigned inStream2_loop_outer;
    logic unsigned inStream2_realign_type;

    // Output stream - outStream0 (programmable)
    logic unsigned [31:0] outStream0_trans_size;
    logic unsigned [15:0] outStream0_line_stride;
    logic unsigned [15:0] outStream0_line_length;
    logic unsigned [15:0] outStream0_feat_stride;
    logic unsigned [15:0] outStream0_feat_length;
    logic unsigned [15:0] outStream0_feat_roll;
    logic unsigned [15:0] outStream0_step;
    logic unsigned outStream0_loop_outer;
    logic unsigned outStream0_realign_type;

    // Computation
    logic unsigned [$clog2(MULTI_DATAFLOW_MAC_MDC_CNT_LEN):0] cnt_limit_outStream0;

    // Custom register
    logic unsigned [(32-1):0] reg_simple_mul;
    logic unsigned [(32-1):0] reg_shift;
    logic unsigned [(32-1):0] reg_len;

  } ctrl_fsm_multi_dataflow_mac_mdc_t;

  

endpackage
