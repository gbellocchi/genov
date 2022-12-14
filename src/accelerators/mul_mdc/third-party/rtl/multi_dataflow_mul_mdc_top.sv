
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
 * Module: multi_dataflow_mul_mdc_top.sv
 *
 */

import multi_dataflow_mul_mdc_package::*;
import hwpe_ctrl_package::*;

module multi_dataflow_mul_mdc_top
#(
  parameter int unsigned N_CORES = 2,
  parameter int unsigned MP  = 4,
  parameter int unsigned ID  = 10
)
(
  // Global signals
  input  logic          clk_i,
  input  logic          rst_ni,
  input  logic          test_mode_i,

  // Events
  output logic [N_CORES-1:0][REGFILE_N_EVT-1:0] evt_o,

  // TCDM master ports
  hwpe_stream_intf_tcdm.master                  tcdm[MP-1:0],

  // Peripheral slave port
  hwpe_ctrl_intf_periph.slave                   periph
);

  // Signals
  logic enable, clear;
  logic [N_CORES-1:0][REGFILE_N_EVT-1:0] evt;
  ctrl_streamer_multi_dataflow_mul_mdc_t  streamer_ctrl;
  flags_streamer_multi_dataflow_mul_mdc_t streamer_flags;
  ctrl_engine_multi_dataflow_mul_mdc_t    engine_ctrl;
  flags_engine_multi_dataflow_mul_mdc_t   engine_flags;

  // Streamer interfaces
  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) inStream0 ( .clk (clk_i) );

  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) inStream1 ( .clk (clk_i) );

  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) inStream2 ( .clk (clk_i) );

  hwpe_stream_intf_stream #( .DATA_WIDTH(32) ) outStream0 ( .clk (clk_i) );

  // HWPE engine wrapper
  multi_dataflow_mul_mdc_engine i_engine (
    .clk_i            ( clk_i          ),
    .rst_ni           ( rst_ni         ),
    .test_mode_i      ( test_mode_i    ),

    .inStream0_i              ( inStream0.sink       ),
    .inStream1_i              ( inStream1.sink       ),
    .inStream2_i              ( inStream2.sink       ),

    .outStream0_o              ( outStream0.source       ),

    .ctrl_i           ( engine_ctrl    ),
    .flags_o          ( engine_flags   )
  );

  // HWPE streamer wrapper
  multi_dataflow_mul_mdc_streamer #(
    .MP ( MP )
  ) i_streamer (
    .clk_i            ( clk_i          ),
    .rst_ni           ( rst_ni         ),
    .test_mode_i      ( test_mode_i    ),
    .enable_i         ( enable         ),
    .clear_i          ( clear          ),

    .inStream0              ( inStream0.source       ),
    .inStream1              ( inStream1.source       ),
    .inStream2              ( inStream2.source       ),

    .outStream0              ( outStream0.sink       ),

    .tcdm             ( tcdm           ),
    .ctrl_i           ( streamer_ctrl  ),
    .flags_o          ( streamer_flags )
  );

  // HWPE ctrl wrapper
  multi_dataflow_mul_mdc_ctrl #(
    .N_CORES   ( N_CORES  ),
    .N_CONTEXT ( 1  ),

    .N_IO_REGS ( 47 ),

    .ID ( ID )
  ) i_ctrl (
    .clk_i            ( clk_i          ),
    .rst_ni           ( rst_ni         ),
    .test_mode_i      ( test_mode_i    ),
    .clear_o          ( clear          ),
    .evt_o            ( evt_o          ),
    .ctrl_streamer_o  ( streamer_ctrl  ),
    .flags_streamer_i ( streamer_flags ),
    .ctrl_engine_o    ( engine_ctrl    ),
    .flags_engine_i   ( engine_flags   ),
    .periph           ( periph         )
  );

  assign enable = 1'b1;

endmodule
    
