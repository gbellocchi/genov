
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
 * Module: mmul_parallel_engine.sv
 *
 */
import mmul_parallel_package::*;
module mmul_parallel_engine (
  // Global signals
  input  logic          clk_i,
  input  logic          rst_ni,
  input  logic          test_mode_i,
  // Sink ports
  hwpe_stream_intf_stream.sink    in1,
  hwpe_stream_intf_stream.sink    in2,
  // Source ports
  hwpe_stream_intf_stream.source  out_r,
  // Control channel
  input  ctrl_engine_t            ctrl_i,
  output flags_engine_t           flags_o
);
  // mmul_parallel control
  logic engine_clear;
  logic engine_done, engine_idle, engine_ready;
  logic unsigned [($clog2(mmul_parallel_CNT_LEN)+1):0] cnt_done;
  assign engine_clear = ctrl_i.clear;
  assign flags_o.done = engine_done;
  assign flags_o.idle = engine_idle;
  always_ff @(posedge clk_i or negedge rst_ni)
  begin: fsm_ready
    if(~rst_ni)
      flags_o.ready = 1'b0;
    else if(~(engine_ready | engine_idle))
      flags_o.ready = 1'b0;
    else
      flags_o.ready = 1'b1;
  end
  always_ff @(posedge clk_i or negedge rst_ni)
  begin: done_cnt
    if((~rst_ni) | engine_clear)
      cnt_done = 32'b0;
    else if(engine_done)
      cnt_done = cnt_done + 1;
    else
      cnt_done = cnt_done;
  end
  assign flags_o.cnt = cnt_done;
  // Kernel wrapper
  kernel_wrapper i_k_wrap (
    // Global signals
    .clk_i           ( clk_i            ),
    .rst_ni          ( rst_ni           ),
    .test_mode_i     ( test_mode_i      ),
    // Input data (to-hwpe)
    .i_in1 ( in1  ),
    .i_in2 ( in2  ),
    // Output data (from-hwpe)
    .o_out_r ( out_r  ),
    // Algorithm parameters
    // Control signals
    .start           ( ctrl_i.start     ),
    .clear           ( engine_clear     ),
    // Flag signals
    .done            ( engine_done      ),
    .idle            ( engine_idle      ),
    .ready           ( engine_ready     )
  );
endmodule