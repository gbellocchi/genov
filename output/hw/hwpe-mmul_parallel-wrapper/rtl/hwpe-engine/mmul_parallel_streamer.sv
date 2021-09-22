
//
/*
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
 * Module: mmul_parallel_streamer.sv
 *
 */
import mmul_parallel_package::*;
import hwpe_stream_package::*;
module mmul_parallel_streamer
#(
  parameter int unsigned MP  = 3, // number of master ports
  parameter int unsigned FD  = 2 // FIFO depth
)
(
  // Global signals
  input  logic          clk_i,
  input  logic          rst_ni,
  input  logic          test_mode_i,
  // Local enable & clear
  input  logic          enable_i,
  input  logic          clear_i,
  // TCDM interface
  hwpe_stream_intf_tcdm.master tcdm [MP-1:0],
  // Streaming interfaces
  hwpe_stream_intf_stream.source in1_0,
  hwpe_stream_intf_stream.source in1_1,
  hwpe_stream_intf_stream.source in1_2,
  hwpe_stream_intf_stream.source in1_3,
  hwpe_stream_intf_stream.source in1_4,
  hwpe_stream_intf_stream.source in1_5,
  hwpe_stream_intf_stream.source in1_6,
  hwpe_stream_intf_stream.source in1_7,
  hwpe_stream_intf_stream.source in1_8,
  hwpe_stream_intf_stream.source in1_9,
  hwpe_stream_intf_stream.source in1_10,
  hwpe_stream_intf_stream.source in1_11,
  hwpe_stream_intf_stream.source in1_12,
  hwpe_stream_intf_stream.source in1_13,
  hwpe_stream_intf_stream.source in1_14,
  hwpe_stream_intf_stream.source in1_15,
  hwpe_stream_intf_stream.source in2_0,
  hwpe_stream_intf_stream.source in2_1,
  hwpe_stream_intf_stream.source in2_2,
  hwpe_stream_intf_stream.source in2_3,
  hwpe_stream_intf_stream.source in2_4,
  hwpe_stream_intf_stream.source in2_5,
  hwpe_stream_intf_stream.source in2_6,
  hwpe_stream_intf_stream.source in2_7,
  hwpe_stream_intf_stream.source in2_8,
  hwpe_stream_intf_stream.source in2_9,
  hwpe_stream_intf_stream.source in2_10,
  hwpe_stream_intf_stream.source in2_11,
  hwpe_stream_intf_stream.source in2_12,
  hwpe_stream_intf_stream.source in2_13,
  hwpe_stream_intf_stream.source in2_14,
  hwpe_stream_intf_stream.source in2_15,
  hwpe_stream_intf_stream.source out_r,
  // control channel
  input  ctrl_streamer_t  ctrl_i,
  output flags_streamer_t flags_o
);
  // Source modules (TCDM -> HWPE)
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_0_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_1_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_2_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_3_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_4_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_5_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_6_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_7_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_8_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_9_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_10_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_11_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_12_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_13_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_14_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in1_15_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_0            ),
    .stream             ( in1_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in1_source_ctrl   ),
    .flags_o            ( flags_o.in1_source_flags ),
    .tcdm_fifo_ready_o  ( in1_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_0_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_1_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_2_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_3_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_4_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_5_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_6_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_7_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_8_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_9_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_10_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_11_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_12_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_13_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_14_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  hwpe_stream_source #(
    .DATA_WIDTH   ( 32 ),
    .DECOUPLED    ( 1  )
  ) i_in2_15_source (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_1            ),
    .stream             ( in2_prefifo.source       ),
    .ctrl_i             ( ctrl_i.in2_source_ctrl   ),
    .flags_o            ( flags_o.in2_source_flags ),
    .tcdm_fifo_ready_o  ( in2_tcdm_fifo_ready      )
  );
  //
  // Sink modules (TCDM <- HWPE)
  hwpe_stream_sink #(
    .DATA_WIDTH ( 32 )
    // .NB_TCDM_PORTS (    )
  ) i_out_r_sink (
    .clk_i              ( clk_i                  ),
    .rst_ni             ( rst_ni                 ),
    .test_mode_i        ( test_mode_i            ),
    .clear_i            ( clear_i                ),
    .tcdm               ( tcdm_fifo_2            ),
    .stream             ( out_r_postfifo.sink       ),
    .ctrl_i             ( ctrl_i.out_r_sink_ctrl   ),
    .flags_o            ( flags_o.out_r_sink_flags )
  );
  // FIFO ready signals
  logic in1_0_tcdm_fifo_ready;
  logic in1_1_tcdm_fifo_ready;
  logic in1_2_tcdm_fifo_ready;
  logic in1_3_tcdm_fifo_ready;
  logic in1_4_tcdm_fifo_ready;
  logic in1_5_tcdm_fifo_ready;
  logic in1_6_tcdm_fifo_ready;
  logic in1_7_tcdm_fifo_ready;
  logic in1_8_tcdm_fifo_ready;
  logic in1_9_tcdm_fifo_ready;
  logic in1_10_tcdm_fifo_ready;
  logic in1_11_tcdm_fifo_ready;
  logic in1_12_tcdm_fifo_ready;
  logic in1_13_tcdm_fifo_ready;
  logic in1_14_tcdm_fifo_ready;
  logic in1_15_tcdm_fifo_ready;
  logic in2_0_tcdm_fifo_ready;
  logic in2_1_tcdm_fifo_ready;
  logic in2_2_tcdm_fifo_ready;
  logic in2_3_tcdm_fifo_ready;
  logic in2_4_tcdm_fifo_ready;
  logic in2_5_tcdm_fifo_ready;
  logic in2_6_tcdm_fifo_ready;
  logic in2_7_tcdm_fifo_ready;
  logic in2_8_tcdm_fifo_ready;
  logic in2_9_tcdm_fifo_ready;
  logic in2_10_tcdm_fifo_ready;
  logic in2_11_tcdm_fifo_ready;
  logic in2_12_tcdm_fifo_ready;
  logic in2_13_tcdm_fifo_ready;
  logic in2_14_tcdm_fifo_ready;
  logic in2_15_tcdm_fifo_ready;
  // FIFO interfaces
  hwpe_stream_intf_tcdm tcdm_fifo [MP-1:0] ( .clk ( clk_i ) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_0 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_1 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_2 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_3 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_4 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_5 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_6 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_7 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_8 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_9 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_10 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_11 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_12 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_13 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_14 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in1_15 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_0 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_1 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_2 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_3 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_4 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_5 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_6 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_7 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_8 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_9 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_10 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_11 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_12 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_13 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_14 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_in2_15 [31:0] ( .clk (clk_i) );
  hwpe_stream_intf_tcdm tcdm_fifo_out_r [31:0] ( .clk (clk_i) );
  // Pre-FIFO streamer interfaces (TCDM-side)
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_0_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_1_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_2_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_3_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_4_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_5_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_6_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_7_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_8_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_9_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_10_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_11_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_12_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_13_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_14_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in1_15_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_0_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_1_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_2_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_3_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_4_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_5_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_6_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_7_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_8_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_9_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_10_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_11_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_12_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_13_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_14_prefifo ( .clk (clk_i) );
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) in2_15_prefifo ( .clk (clk_i) );
  // TCDM-side FIFOs (TCDM -> HWPE)
  hwpe_stream_tcdm_fifo_load #(
    .FIFO_DEPTH ( 4 )
  ) i_in1_tcdm_fifo_load (
    .clk_i       ( clk_i             ),
    .rst_ni      ( rst_ni            ),
    .clear_i     ( clear_i           ),
    .flags_o     (                   ),
    .ready_i     ( in1_tcdm_fifo_ready ),
    .tcdm_slave  ( tcdm_fifo_0[0]    ),
    .tcdm_master ( tcdm      [0]     )
  );
  hwpe_stream_tcdm_fifo_load #(
    .FIFO_DEPTH ( 4 )
  ) i_in2_tcdm_fifo_load (
    .clk_i       ( clk_i             ),
    .rst_ni      ( rst_ni            ),
    .clear_i     ( clear_i           ),
    .flags_o     (                   ),
    .ready_i     ( in2_tcdm_fifo_ready ),
    .tcdm_slave  ( tcdm_fifo_1[0]    ),
    .tcdm_master ( tcdm      [1]     )
  );
  // TCDM-side FIFOs (TCDM <- HWPE)
  hwpe_stream_tcdm_fifo_store #(
    .FIFO_DEPTH ( 4 )
  ) i_out_r_tcdm_fifo_store (
    .clk_i       ( clk_i          ),
    .rst_ni      ( rst_ni         ),
    .clear_i     ( clear_i        ),
    .flags_o     (                ),
    .tcdm_slave  ( tcdm_fifo_2[0] ),
    .tcdm_master ( tcdm       [2] )
  );
  // Post-FIFO streamer interfaces (TCDM-side)
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) out_r_postfifo ( .clk (clk_i) );
  // Engine-side FIFOs (TCDM -> HWPE)
  hwpe_stream_fifo #(
    .DATA_WIDTH( 32 ),
    .FIFO_DEPTH( 2  ),
    .LATCH_FIFO( 0  )
  ) i_in1_fifo (
    .clk_i   ( clk_i          ),
    .rst_ni  ( rst_ni         ),
    .clear_i ( clear_i        ),
    .push_i  ( in1_prefifo.sink ),
    .pop_o   ( in1_o            ),
    .flags_o (                )
  );
  hwpe_stream_fifo #(
    .DATA_WIDTH( 32 ),
    .FIFO_DEPTH( 2  ),
    .LATCH_FIFO( 0  )
  ) i_in2_fifo (
    .clk_i   ( clk_i          ),
    .rst_ni  ( rst_ni         ),
    .clear_i ( clear_i        ),
    .push_i  ( in2_prefifo.sink ),
    .pop_o   ( in2_o            ),
    .flags_o (                )
  );
  // Engine-side FIFOs (TCDM <- HWPE)
  hwpe_stream_fifo #(
    .DATA_WIDTH( 32 ),
    .FIFO_DEPTH( 2  ),
    .LATCH_FIFO( 0  )
  ) i_out_r_fifo (
    .clk_i   ( clk_i             ),
    .rst_ni  ( rst_ni            ),
    .clear_i ( clear_i           ),
    .push_i  ( out_r_i               ),
    .pop_o   ( out_r_postfifo.source ),
    .flags_o (                   )
  );
endmodule