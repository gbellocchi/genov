
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
 * HWPE author: Francesco Conti <fconti@iis.ee.ethz.ch>
 * HWPE specialization tool: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * Module: mmul_parallel_fsm.sv
 *
 */
import mmul_parallel_package::*;
import hwpe_ctrl_package::*;
module mmul_parallel_fsm (
  // Global signals
  input  logic                                  clk_i,
  input  logic                                  rst_ni,
  input  logic                                  test_mode_i,
  output logic                                  clear_i,
  // ctrl & flags
  output ctrl_streamer_t                        ctrl_streamer_o,
  input  flags_streamer_t                       flags_streamer_i,
  output ctrl_engine_t                          ctrl_engine_o,
  input  flags_engine_t                         flags_engine_i,
  output ctrl_uloop_t                           ctrl_ucode_o,
  input  flags_uloop_t                          flags_ucode_i,
  output ctrl_slave_t                           ctrl_slave_o,
  input  flags_slave_t                          flags_slave_i,
  input  ctrl_regfile_t                         reg_file_i,
  input  ctrl_fsm_t                             ctrl_i
);
  // State signals
  state_fsm_t curr_state, next_state;
  // State computation
  always_ff @(posedge clk_i or negedge rst_ni)
  begin : main_fsm_seq
    if(~rst_ni) begin
      curr_state <= FSM_IDLE;
    end
    else if(clear_i) begin
      curr_state <= FSM_IDLE;
    end
    else begin
      curr_state <= next_state;
    end
  end
  // State declaration
  always_comb
  begin : main_fsm_comb
    /* Custom register file mappings to address generator */
    // Input stream - in1_0 (unrolled, programmable)
    ctrl_streamer_o.in1_0_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_0_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_0_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_0_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_0_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_0_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 0 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_0_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_0_OFFS]);
    ctrl_streamer_o.in1_0_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_0_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_0_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_0_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_1 (unrolled, programmable)
    ctrl_streamer_o.in1_1_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_1_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_1_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_1_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_1_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_1_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 1 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_1_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_1_OFFS]);
    ctrl_streamer_o.in1_1_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_1_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_1_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_1_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_2 (unrolled, programmable)
    ctrl_streamer_o.in1_2_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_2_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_2_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_2_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_2_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_2_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 2 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_2_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_2_OFFS]);
    ctrl_streamer_o.in1_2_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_2_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_2_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_2_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_3 (unrolled, programmable)
    ctrl_streamer_o.in1_3_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_3_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_3_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_3_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_3_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_3_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 3 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_3_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_3_OFFS]);
    ctrl_streamer_o.in1_3_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_3_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_3_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_3_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_4 (unrolled, programmable)
    ctrl_streamer_o.in1_4_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_4_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_4_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_4_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_4_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_4_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 4 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_4_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_4_OFFS]);
    ctrl_streamer_o.in1_4_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_4_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_4_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_4_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_5 (unrolled, programmable)
    ctrl_streamer_o.in1_5_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_5_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_5_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_5_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_5_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_5_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 5 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_5_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_5_OFFS]);
    ctrl_streamer_o.in1_5_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_5_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_5_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_5_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_6 (unrolled, programmable)
    ctrl_streamer_o.in1_6_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_6_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_6_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_6_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_6_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_6_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 6 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_6_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_6_OFFS]);
    ctrl_streamer_o.in1_6_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_6_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_6_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_6_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_7 (unrolled, programmable)
    ctrl_streamer_o.in1_7_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_7_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_7_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_7_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_7_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_7_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 7 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_7_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_7_OFFS]);
    ctrl_streamer_o.in1_7_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_7_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_7_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_7_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_8 (unrolled, programmable)
    ctrl_streamer_o.in1_8_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_8_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_8_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_8_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_8_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_8_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 8 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_8_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_8_OFFS]);
    ctrl_streamer_o.in1_8_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_8_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_8_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_8_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_9 (unrolled, programmable)
    ctrl_streamer_o.in1_9_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_9_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_9_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_9_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_9_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_9_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 9 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_9_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_9_OFFS]);
    ctrl_streamer_o.in1_9_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_9_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_9_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_9_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_10 (unrolled, programmable)
    ctrl_streamer_o.in1_10_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_10_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_10_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_10_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_10_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_10_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 10 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_10_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_10_OFFS]);
    ctrl_streamer_o.in1_10_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_10_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_10_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_10_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_11 (unrolled, programmable)
    ctrl_streamer_o.in1_11_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_11_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_11_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_11_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_11_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_11_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 11 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_11_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_11_OFFS]);
    ctrl_streamer_o.in1_11_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_11_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_11_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_11_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_12 (unrolled, programmable)
    ctrl_streamer_o.in1_12_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_12_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_12_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_12_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_12_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_12_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 12 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_12_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_12_OFFS]);
    ctrl_streamer_o.in1_12_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_12_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_12_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_12_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_13 (unrolled, programmable)
    ctrl_streamer_o.in1_13_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_13_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_13_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_13_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_13_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_13_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 13 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_13_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_13_OFFS]);
    ctrl_streamer_o.in1_13_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_13_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_13_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_13_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_14 (unrolled, programmable)
    ctrl_streamer_o.in1_14_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_14_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_14_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_14_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_14_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_14_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 14 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_14_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_14_OFFS]);
    ctrl_streamer_o.in1_14_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_14_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_14_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_14_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in1_15 (unrolled, programmable)
    ctrl_streamer_o.in1_15_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in1_trans_size;
    ctrl_streamer_o.in1_15_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in1_line_stride;
    ctrl_streamer_o.in1_15_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in1_line_length;
    ctrl_streamer_o.in1_15_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in1_feat_stride;
    ctrl_streamer_o.in1_15_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in1_feat_length;
    ctrl_streamer_o.in1_15_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in1_port_offset * 15 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN1_15_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN1_15_OFFS]);
    ctrl_streamer_o.in1_15_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in1_feat_roll;
    ctrl_streamer_o.in1_15_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in1_loop_outer;
    ctrl_streamer_o.in1_15_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in1_realign_type;
    ctrl_streamer_o.in1_15_source_ctrl.addressgen_ctrl.step            = ctrl_i.in1_step;
    // Input stream - in2_0 (unrolled, programmable)
    ctrl_streamer_o.in2_0_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_0_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_0_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_0_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_0_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_0_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 0 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_0_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_0_OFFS]);
    ctrl_streamer_o.in2_0_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_0_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_0_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_0_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_1 (unrolled, programmable)
    ctrl_streamer_o.in2_1_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_1_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_1_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_1_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_1_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_1_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 1 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_1_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_1_OFFS]);
    ctrl_streamer_o.in2_1_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_1_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_1_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_1_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_2 (unrolled, programmable)
    ctrl_streamer_o.in2_2_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_2_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_2_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_2_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_2_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_2_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 2 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_2_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_2_OFFS]);
    ctrl_streamer_o.in2_2_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_2_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_2_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_2_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_3 (unrolled, programmable)
    ctrl_streamer_o.in2_3_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_3_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_3_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_3_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_3_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_3_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 3 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_3_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_3_OFFS]);
    ctrl_streamer_o.in2_3_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_3_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_3_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_3_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_4 (unrolled, programmable)
    ctrl_streamer_o.in2_4_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_4_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_4_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_4_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_4_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_4_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 4 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_4_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_4_OFFS]);
    ctrl_streamer_o.in2_4_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_4_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_4_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_4_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_5 (unrolled, programmable)
    ctrl_streamer_o.in2_5_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_5_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_5_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_5_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_5_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_5_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 5 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_5_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_5_OFFS]);
    ctrl_streamer_o.in2_5_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_5_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_5_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_5_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_6 (unrolled, programmable)
    ctrl_streamer_o.in2_6_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_6_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_6_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_6_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_6_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_6_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 6 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_6_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_6_OFFS]);
    ctrl_streamer_o.in2_6_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_6_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_6_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_6_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_7 (unrolled, programmable)
    ctrl_streamer_o.in2_7_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_7_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_7_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_7_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_7_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_7_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 7 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_7_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_7_OFFS]);
    ctrl_streamer_o.in2_7_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_7_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_7_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_7_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_8 (unrolled, programmable)
    ctrl_streamer_o.in2_8_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_8_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_8_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_8_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_8_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_8_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 8 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_8_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_8_OFFS]);
    ctrl_streamer_o.in2_8_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_8_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_8_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_8_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_9 (unrolled, programmable)
    ctrl_streamer_o.in2_9_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_9_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_9_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_9_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_9_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_9_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 9 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_9_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_9_OFFS]);
    ctrl_streamer_o.in2_9_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_9_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_9_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_9_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_10 (unrolled, programmable)
    ctrl_streamer_o.in2_10_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_10_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_10_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_10_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_10_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_10_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 10 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_10_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_10_OFFS]);
    ctrl_streamer_o.in2_10_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_10_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_10_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_10_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_11 (unrolled, programmable)
    ctrl_streamer_o.in2_11_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_11_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_11_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_11_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_11_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_11_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 11 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_11_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_11_OFFS]);
    ctrl_streamer_o.in2_11_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_11_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_11_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_11_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_12 (unrolled, programmable)
    ctrl_streamer_o.in2_12_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_12_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_12_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_12_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_12_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_12_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 12 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_12_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_12_OFFS]);
    ctrl_streamer_o.in2_12_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_12_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_12_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_12_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_13 (unrolled, programmable)
    ctrl_streamer_o.in2_13_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_13_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_13_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_13_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_13_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_13_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 13 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_13_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_13_OFFS]);
    ctrl_streamer_o.in2_13_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_13_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_13_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_13_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_14 (unrolled, programmable)
    ctrl_streamer_o.in2_14_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_14_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_14_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_14_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_14_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_14_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 14 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_14_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_14_OFFS]);
    ctrl_streamer_o.in2_14_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_14_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_14_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_14_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Input stream - in2_15 (unrolled, programmable)
    ctrl_streamer_o.in2_15_source_ctrl.addressgen_ctrl.trans_size      = ctrl_i.in2_trans_size;
    ctrl_streamer_o.in2_15_source_ctrl.addressgen_ctrl.line_stride     = ctrl_i.in2_line_stride;
    ctrl_streamer_o.in2_15_source_ctrl.addressgen_ctrl.line_length     = ctrl_i.in2_line_length;
    ctrl_streamer_o.in2_15_source_ctrl.addressgen_ctrl.feat_stride     = ctrl_i.in2_feat_stride;
    ctrl_streamer_o.in2_15_source_ctrl.addressgen_ctrl.feat_length     = ctrl_i.in2_feat_length;
    ctrl_streamer_o.in2_15_source_ctrl.addressgen_ctrl.base_addr       = ctrl_i.in2_port_offset * 15 + reg_file_i.hwpe_params[MMUL_PARALLEL_REG_IN2_15_ADDR] + (flags_ucode_i.offs[MMUL_PARALLEL_UCODE_IN2_15_OFFS]);
    ctrl_streamer_o.in2_15_source_ctrl.addressgen_ctrl.feat_roll       = ctrl_i.in2_feat_roll;
    ctrl_streamer_o.in2_15_source_ctrl.addressgen_ctrl.loop_outer      = ctrl_i.in2_loop_outer;
    ctrl_streamer_o.in2_15_source_ctrl.addressgen_ctrl.realign_type    = ctrl_i.in2_realign_type;
    ctrl_streamer_o.in2_15_source_ctrl.addressgen_ctrl.step            = ctrl_i.in2_step;
    // Output stream - out_r (hardwired)
    ctrl_streamer_o.out_r_source_ctrl.addressgen_ctrl.trans_size      = /* TO-BE-DONE */
    ctrl_streamer_o.out_r_source_ctrl.addressgen_ctrl.line_stride     = /* TO-BE-DONE */
    ctrl_streamer_o.out_r_source_ctrl.addressgen_ctrl.line_length     = /* TO-BE-DONE */
    ctrl_streamer_o.out_r_source_ctrl.addressgen_ctrl.feat_stride     = /* TO-BE-DONE */
    ctrl_streamer_o.out_r_source_ctrl.addressgen_ctrl.feat_length     = /* TO-BE-DONE */
    ctrl_streamer_o.out_r_source_ctrl.addressgen_ctrl.base_addr       = /* TO-BE-DONE */
    ctrl_streamer_o.out_r_source_ctrl.addressgen_ctrl.feat_roll       = /* TO-BE-DONE */
    ctrl_streamer_o.out_r_source_ctrl.addressgen_ctrl.loop_outer      = /* TO-BE-DONE */
    ctrl_streamer_o.out_r_source_ctrl.addressgen_ctrl.realign_type    = /* TO-BE-DONE */
    // engine
    ctrl_engine_o.clear      = '1;
    ctrl_engine_o.enable     = '1;
    ctrl_engine_o.start      = '0;
    ctrl_engine_o.simple_mul = ctrl_i.simple_mul;
    ctrl_engine_o.shift      = ctrl_i.shift;
    ctrl_engine_o.len        = ctrl_i.len;
    // slave
    ctrl_slave_o.done = '0;
    ctrl_slave_o.evt  = '0;
    // real finite-state machine
    next_state   = curr_state;
    ctrl_streamer_o.in1_source_ctrl.req_start    = '0;
    ctrl_streamer_o.in2_source_ctrl.req_start    = '0;
    ctrl_streamer_o.in2_sink_ctrl.req_start      = '0;
    ctrl_ucode_o.enable                        = '0;
    ctrl_ucode_o.clear                         = '0;
    //
    // STATES
    //
    case(curr_state)
      FSM_IDLE: begin
        // wait for a start signal
        ctrl_ucode_o.clear = '1;
        if(flags_slave_i.start) begin
          next_state = FSM_START;
        end
      end
      FSM_START: begin
        // update the indeces, then load the first feature
        if(
           flags_streamer_i.in1_source_flags.ready_start &
           flags_streamer_i.in2_source_flags.ready_start &
           flags_streamer_i.out_r_sink_flags.ready_start)  begin
          next_state  = FSM_COMPUTE;
          ctrl_engine_o.start  = 1'b1;
          ctrl_engine_o.clear  = 1'b0;
          ctrl_engine_o.enable = 1'b1;
          ctrl_streamer_o.in1_source_ctrl.req_start = 1'b1;
          ctrl_streamer_o.in2_source_ctrl.req_start = 1'b1;
          ctrl_streamer_o.out_r_sink_ctrl.req_start = 1'b1;
        end
        else begin
          next_state = FSM_WAIT;
        end
      end
      FSM_COMPUTE: begin
        ctrl_engine_o.clear  = 1'b0;
        //if((flags_engine_i.cnt == ctrl_i.len) & flags_engine_i.acc_valid)
          //next_state = FSM_UPDATEIDX;
        if (flags_engine_i.cnt == ctrl_i.len)
          next_state = FSM_TERMINATE;
        if(flags_engine_i.ready) begin
          ctrl_engine_o.start  = 1'b1;
          ctrl_engine_o.clear  = 1'b0;
          ctrl_engine_o.enable = 1'b1;
        end
      end
      FSM_UPDATEIDX: begin
        // update the indeces, then go back to load or idle
        if(flags_ucode_i.valid == 1'b0) begin
          ctrl_ucode_o.enable = 1'b1;
        end
        else if(flags_ucode_i.done) begin
        // else if(flags_engine_i.cnt == ctrl_i.len) begin // interface with Vivado HLS --> finished filtering input data?
        // if(flags_engine_i.cnt == ctrl_i.len) begin
          next_state = FSM_TERMINATE;
        end
        else if(
                flags_streamer_i.in1_source_flags.ready_start &
                flags_streamer_i.in2_source_flags.ready_start &
                flags_streamer_i.out_r_sink_flags.ready_start)  begin
          next_state = FSM_COMPUTE;
          ctrl_engine_o.start  = 1'b1;
          ctrl_engine_o.clear  = 1'b0;
          ctrl_engine_o.enable = 1'b1;
          ctrl_streamer_o.in1_source_ctrl.req_start = 1'b1;
          ctrl_streamer_o.in2_source_ctrl.req_start = 1'b1;
          ctrl_streamer_o.out_r_sink_ctrl.req_start = 1'b1;
        end
        else begin
          next_state = FSM_WAIT;
        end
      end
      FSM_WAIT: begin
        // wait for the flags to be ok then go back to load
        ctrl_engine_o.clear  = 1'b0;
        ctrl_engine_o.enable = 1'b0;
        ctrl_ucode_o.enable  = 1'b0;
        if(
           flags_streamer_i.in1_source_flags.ready_start &
           flags_streamer_i.in2_source_flags.ready_start &
           flags_streamer_i.out_r_sink_flags.ready_start)  begin
          next_state = FSM_COMPUTE;
          ctrl_engine_o.start = 1'b1;
          ctrl_engine_o.enable = 1'b1;
          ctrl_streamer_o.in1_source_ctrl.req_start = 1'b1;
          ctrl_streamer_o.in2_source_ctrl.req_start = 1'b1;
          ctrl_streamer_o.out_r_sink_ctrl.req_start = 1'b1;
        end
      end
      FSM_TERMINATE: begin
        // wait for the flags to be ok then go back to idle
        ctrl_engine_o.clear  = 1'b0;
        ctrl_engine_o.enable = 1'b0;
        if(
           flags_streamer_i.in1_source_flags.ready_start &
           flags_streamer_i.in2_source_flags.ready_start &
           flags_streamer_i.out_r_sink_flags.ready_start)  begin
          next_state = FSM_IDLE;
          ctrl_slave_o.done = 1'b1;
        end
      end
    endcase // curr_state
  end
endmodule // fir_fsm