
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
 * Module: MMUL_PARALLEL_engine.sv
 *
 */
import MMUL_PARALLEL_package::*;
module kernel_wrapper (
  // Global signals
  input  logic          clk_i,
  input  logic          rst_ni,
  input  logic          test_mode_i,
  // Sink ports
  hwpe_stream_intf_stream.sink    i_in1,
  hwpe_stream_intf_stream.sink    i_in2,
  // Source ports
  hwpe_stream_intf_stream.source  o_out_r,
  // Control signals
  input  logic          start,
  input  logic          clear,
  // FIXME: Clear is not used in ap_ctrl (used at engine level).
  //        Instantiate interface in a way that clear port gets used (or not) on the basis of is_intf.
  // Counters
  // FIXME: They could be wrapped in a custom typedef or just kept here and the
  // on the iteration loop could be done at the FSM side counting the number of
  // received done signals
  // % if is_dflow is True:
  //   % for j in range (n_source):
  // output logic [($clog2(MMUL_PARALLEL_CNT_LEN)+1):0] cnt_out_r,
  //   % endfor
  // % endif
  // Flag signals
  output logic          done,
  output logic          idle,
  output logic          ready
  // FIXME: Use flags and ctrl typedef instead of single signals.
  // Why? If more i/o are going to be used (unrolling, ..), it would
  // be more elegant to parametrize the typedefs, instead of discrete ports.
);
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* MMUL_PARALLEL control signals. */
  logic local_start;
  /* MMUL_PARALLEL flag signals. */
  // FIXME: This won't scale up with large interfaces (unrolling, and so on).
  // SOL: Use array or custom typedef.
  // Input signal flags
  logic local_ready_in_0;
  logic local_done_in_0; //FIXEME: to be removed
  logic local_ready_in_1;
  logic local_done_in_1; //FIXEME: to be removed
  // Output signal flags
  logic local_done_out_0;
  logic set_idle;
  logic local_idle;
  /* Counters. */
  logic unsigned [($clog2(MMUL_PARALLEL_CNT_LEN)+1):0] local_cnt_in1;
  logic unsigned [($clog2(MMUL_PARALLEL_CNT_LEN)+1):0] local_cnt_in2;
  logic unsigned [($clog2(MMUL_PARALLEL_CNT_LEN)+1):0] local_cnt_out_r;
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* MMUL_PARALLEL hardware kernel. */
  MMUL_PARALLEL i_MMUL_PARALLEL (
    // Global signals.
    .ap_clk             ( clk_i            ),
    .ap_rst_n           ( rst_ni           ),
    // Input data (to-hwpe)
    .in1_TDATA  ( i_in1.data  ),     .in1_TVALID ( i_in1.valid ),     .in1_TREADY ( i_in1.ready ),     .in2_TDATA  ( i_in2.data  ),     .in2_TVALID ( i_in2.valid ),     .in2_TREADY ( i_in2.ready ),
    // Output data (from-hwpe)
    .out_r_TDATA  ( out_r_o.data  ),     .out_r_TVALID ( out_r_o.valid ),     .out_r_TREADY ( out_r_o.ready ),
  );
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* MMUL_PARALLEL control signals. */
  // Start is not always high. For each ready (~(engine_ready | engine_idle)) that is
  // delivered to the FSM, a new Start signal is set high
  // and received by the kernel wrapper.
  assign local_start = start;
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* Done. */
  // A done is generated for each output. These are counted and
  // delivered to the FSM that decides when to update the address
  // on the basis of the state of the line processing (see HWPE-docs).
  // FIXME: This temporarily works synch-outputs.
  // EX: What if Out_0 is provided at each input and Out_1 once per 10 inputs?
  assign done = local_done_out_0;
  always_ff @(posedge clk_i or negedge rst_ni)
  begin: fsm_done_0
    if(~rst_ni)
      local_done_out_0 = 1'b0;
    else if((o_out_r.valid)&(o_out_r.ready))
      local_done_out_0 = 1'b1;
    else
      local_done_out_0 = 1'b0;
  end
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* Ready. */
  /* This is used in the hwpe-engine to set flags_o.ready.
     The latter triggers the START of accelerator. (see FSM_COMPUTE). */
  /* Driven using input counters. */
  assign ready = (local_done_in_0) & (local_done_in_1);
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* Idle. */
  /* This is used in the hwpe-engine to set flags_o.ready.
     The latter triggers the START of accelerator. (see FSM_COMPUTE). */
  /* For more infos refer to UG902. */
  assign idle = local_idle;
  /* The Idle signal indicates when the design is idle and not operating. */
  always_ff @(posedge clk_i or negedge rst_ni)
  begin: fsm_idle
		if(~rst_ni) begin
      local_idle = 1'b0;
    end
    else if(local_start) begin
      /* Idle goes Low immediately after Start to indicate the design is no longer idle. */
      /* If the Start signal is High when Ready is High, the design continues to operate,
          and the Idle signal remains Low. */
			local_idle = 1'b0;
    end
    else if((!local_start) & (ready)) begin
      if( local_done_out_0 ) begin
        /* If the Start signal is Low when Ready is High, the design stops operation, and
            the ap_idle signal goes High one cycle after ap_done.*/
        local_idle = 1'b1;
      end
    end
    else begin
			local_idle = local_idle;
    end
  end
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* MMUL_PARALLEL input counters. Ready. */
  always_ff @(posedge clk_i or negedge rst_ni)
  begin: engine_cnt_in1
    if((~rst_ni) | clear) begin
      local_cnt_in1 = 32'b0;
    end
    else if(local_start) begin
      local_cnt_in1 = 32'b0;
    end
    else if ((i_in1.valid) & (i_in1.ready)) begin
      local_cnt_in1 = local_cnt_in1 + 1;
    end
    else begin
      local_cnt_in1 = local_cnt_in1;
    end
  end
  // FIXME: Now local_done_in goes High every time an input enters the acc.
  // This should be generalized. Even though the wrapper looper is designed to
  // on counting the ouputs, the number of inputs needed to generate an ouput
  // are usually > 1.
  // SOL: Add to ctrl_i also the information about max_input.
  assign local_done_in_0 = (local_cnt_in1==1) ? 1 : 0;
  always_ff @(posedge clk_i or negedge rst_ni)
  begin: engine_cnt_in2
    if((~rst_ni) | clear) begin
      local_cnt_in2 = 32'b0;
    end
    else if(local_start) begin
      local_cnt_in2 = 32'b0;
    end
    else if ((i_in2.valid) & (i_in2.ready)) begin
      local_cnt_in2 = local_cnt_in2 + 1;
    end
    else begin
      local_cnt_in2 = local_cnt_in2;
    end
  end
  // FIXME: Now local_done_in goes High every time an input enters the acc.
  // This should be generalized. Even though the wrapper looper is designed to
  // on counting the ouputs, the number of inputs needed to generate an ouput
  // are usually > 1.
  // SOL: Add to ctrl_i also the information about max_input.
  assign local_done_in_1 = (local_cnt_in2==1) ? 1 : 0;
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* MMUL_PARALLEL output counters. */
  // Suggested design:
  //      ap_done = done_out0 & ... & done_outM;
  //      done_outM = cnt_out,i == ctrl_i.max_out,i; (for i=1,..,N)
  // However, loop ctrl is already implemented in micro-code looper that sits
  // in the hwpe-ctrl. Thus, the done information provided by this stage should
  // concern a single output element, not a tile (block,..).
  // FIXME: At this point, cnt_out is not essential here and could be removed.
  always_ff @(posedge clk_i or negedge rst_ni)
  begin: engine_cnt_out_r
    if((~rst_ni) | clear)
      local_cnt_out_r = 32'b0;
    else if(!local_idle) begin
      if((out_r_o.valid)&(out_r_o.ready))
        local_cnt_out_r = local_cnt_out_r + 1;
      else
        local_cnt_out_r = local_cnt_out_r;
    end
  end
  assign cnt_out_r = local_cnt_out_r;
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
  /* MMUL_PARALLEL streaming interface control. */
  // At the moment output strobe is always '1
  // All bytes of output streams are written
  // to TCDM
  always_comb
  begin
    out_r_o.strb = '1;
  end
  /* ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ */
endmodule