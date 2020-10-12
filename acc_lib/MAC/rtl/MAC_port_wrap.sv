/* 
 * mac_top.sv
 * Francesco Conti <fconti@iis.ee.ethz.ch>
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
 */

import MAC_package::*;
import hwpe_ctrl_package::*;

module MAC
#(
  parameter int unsigned N_CORES = 2,
  parameter int unsigned MP  = 4,
  parameter int unsigned ID  = 10
)
(

  // global signals
  input   logic                    ap_clk,
  input   logic                    ap_rst_n,
  input   logic                    ap_start,
  output  logic                    ap_done,
  output  logic                    ap_idle,
  output  logic                    ap_ready,

  // input a stream
  input   logic [31:0]             a_i_TDATA,
  input   logic                    a_i_TVALID,
  output  logic                    a_i_TREADY,

  // input b stream
  input   logic [31:0]             b_i_TDATA,
  input   logic                    b_i_TVALID,
  output  logic                    b_i_TREADY,

  // input c stream
  input   logic [31:0]             c_i_TDATA,
  input   logic                    c_i_TVALID,
  output  logic                    c_i_TREADY,

  // output d stream
  output  logic [31:0]             d_o_TDATA,
  output  logic                    d_o_TVALID,
  input   logic                    d_o_TREADY,

  // register wirings
  input logic                      naive_mul_V,
  input logic                      new_shift_V
);

  hwpe_stream_intf_stream #(
    .DATA_WIDTH ( 32 )
  ) a (
    .clk ( ap_clk )
  );

  hwpe_stream_intf_stream #(
    .DATA_WIDTH ( 32 )
  ) b (
    .clk ( ap_clk )
  );

  hwpe_stream_intf_stream #(
    .DATA_WIDTH ( 32 )
  ) c (
    .clk ( ap_clk )
  );

  hwpe_stream_intf_stream #(
    .DATA_WIDTH ( 32 )
  ) d (
    .clk ( ap_clk )
  );

  always_comb
  begin
    a.data     = a_i_TDATA;
    a.valid    = a_i_TVALID;
    a_i_TREADY = a.ready;
    a.strb     = '1;
    //
    b.data     = b_i_TDATA;
    b.valid    = b_i_TVALID;
    b_i_TREADY = b.ready;
    b.strb     = '1;
    //
    c.data     = c_i_TDATA;
    c.valid    = c_i_TVALID;
    c_i_TREADY = c.ready;
    c.strb     = '1;
    //
    d_o_TDATA  = d.data;
    d_o_TVALID = d.valid;
    d.ready    = d_o_TREADY;
    // Strobe signal is shortcircuited to '1 in hwpe_stream_sink!
  end

  MAC_datapath i_datapath (
    .clk_i            ( ap_clk         ),
    .rst_ni           ( ap_rst_n       ),
    .start            ( ap_start       ),
    .done             ( ap_done        ),
    .idle             ( ap_idle        ),
    .ready            ( ap_ready       ),
    .a_i              ( a.sink         ),
    .b_i              ( b.sink         ),
    .c_i              ( c.sink         ),
    .d_o              ( d.source       ),
    .simple_mul       ( naive_mul_V    ),
    .shift            ( new_shift_V    )
  );

endmodule
