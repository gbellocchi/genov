
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
 * Module: FIR_engine.sv
 *
 */
import FIR_package::*;
module FIR_engine (
  // Global signals
  input  logic          clk_i,
  input  logic          rst_ni,
  input  logic          test_mode_i,
  // Sink ports
  hwpe_stream_intf_stream.sink    a_i,
  // Source ports
  hwpe_stream_intf_stream.source  b_o,
  // Control channel
  input  ctrl_engine_t            ctrl_i,
  output flags_engine_t           flags_o
);
    // Application-specific hardware kernel
FIR i_FIR (
  // Global signals
  .ap_clk             ( clk_i            ),
  .ap_rst_n           ( rst_ni           ),
  // Input data (to-hwpe)
  .x_V_TDATA  ( a_i.data  ), .x_V_TVALID ( a_i.valid ), .x_V_TREADY ( a_i.ready ),
  // Output data (from-hwpe)
  .y_V_TDATA  ( b_o.data  ), .y_V_TVALID ( b_o.valid ), .y_V_TREADY ( b_o.ready ),
  // Algorithm parameters
  .coeff0_V        (  ctrl_i.coeff0_V      ),
  .coeff1_V        (  ctrl_i.coeff1_V      ),
  .coeff2_V        (  ctrl_i.coeff2_V      ),
  .coeff3_V        (  ctrl_i.coeff3_V      ),
  // Control signals
  .ap_start           ( ctrl_i.start     ),
  .ap_done            ( done             ),
  .ap_idle            ( idle             ),
  .ap_ready           ( ready            )
);
endmodule