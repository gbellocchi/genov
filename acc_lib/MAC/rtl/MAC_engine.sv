/*
 * MAC_engine.sv
 * Author: Francesco Conti <fconti@iis.ee.ethz.ch>
 * Contribute: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
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

module MAC_datapath
(
  // global signals
  input   logic                   clk_i,
  input   logic                   rst_ni,
  input   logic                   start,
  output  logic                   done, 
  output  logic                   idle, 
  output  logic                   ready,
  // input a stream
  hwpe_stream_intf_stream.sink    a_i,
  // input b stream
  hwpe_stream_intf_stream.sink    b_i,
  // input c stream
  hwpe_stream_intf_stream.sink    c_i,
  // output d stream
  hwpe_stream_intf_stream.source  d_o,
  // custom regs
  input logic                     simple_mul,
  input logic [4:0]               shift
);

  logic signed [63:0] c_shifted;
  logic signed [63:0] mult;
  logic signed [63:0] r_mult;
  logic               r_mult_valid;
  logic               r_mult_ready;
  logic signed [64+$clog2(MAC_CNT_LEN)-1:0] r_acc;
  logic                                     r_acc_valid;
  logic                                     r_acc_ready;
  logic signed [64+$clog2(MAC_CNT_LEN)-1:0] d_nonshifted;
  logic                                     d_nonshifted_valid;

  /* MULTIPLIER */

  // multiply a_i by b_i
  always_comb
  begin : mult_a_X_b
    mult = $signed(a_i.data) * $signed(b_i.data);
  end

  // r_mult stores a_i * b_i
  always_ff @(posedge clk_i or negedge rst_ni)
  begin : mult_pipe_data
    if(~rst_ni) begin
      r_mult <= '0;
    end
    else if (start) begin
      // r_mult value is updated if there is a valid handshake at its input
      if (a_i.valid & b_i.valid & a_i.ready & b_i.ready) begin
        r_mult <= mult;
      end
    end
  end

  // r_mult is valid following a valid handshake
  always_ff @(posedge clk_i or negedge rst_ni)
  begin : mult_pipe_valid
    if(~rst_ni) begin
      r_mult_valid <= '0;
    end
    else if (start) begin
      // r_mult_valid is re-evaluated after a valid handshake or in transition to 1
      if ((a_i.valid & b_i.valid) | (r_mult_valid & r_mult_ready)) begin
        r_mult_valid <= a_i.valid & b_i.valid;
      end
    end
  end

  /* SHIFTER */

  // shift c_i by ctrl_i.shift bits to the left
  always_comb
  begin : shift_c
    c_shifted = $signed(c_i.data <<< shift);
  end

  /* ACCUMULATOR */

  always_ff @(posedge clk_i or negedge rst_ni)
  begin : accumulator
    if(~rst_ni) begin
      r_acc <= '0;
    end
    else if (start) begin
      // r_acc value is updated if there are both c_i and r_mult valid handshakes at its input
      if (r_mult_valid & r_mult_ready & c_i.valid & c_i.ready) begin
        r_acc <= $signed(c_shifted + r_mult);
      end
      // r_acc value is updated if there is a c_i valid handshake at its input
      else if (c_i.valid & c_i.ready) begin
        r_acc <= $signed(c_shifted);
      end
      // r_acc value is updated if there is a r_mult valid handshake at its input
      else if (r_mult_valid & r_mult_ready) begin
        r_acc <= $signed(r_acc + r_mult);
      end
    end
  end

  /* RESULT */

  always_comb
  begin : d_nonshifted_comb
    if(simple_mul) begin
      d_nonshifted       = $signed(r_mult);
      d_nonshifted_valid = r_mult_valid;
    end
    else begin
      d_nonshifted       = r_acc;
      d_nonshifted_valid = r_acc_valid;
    end
  end

  always_comb
  begin
    d_o.data  = $signed(d_nonshifted >>> shift); // no saturation/clipping
    d_o.valid = start & d_nonshifted_valid;
    d_o.strb  = '1; 
  end

  /* CONTROL */

  assign done  = r_acc_valid;
  // assign ready = (r_mult_ready & a_i.valid & b_i.valid) | (~a_i.valid & ~b_i.valid);
  // assign idle  = (r_mult_ready & a_i.valid & b_i.valid) | (~a_i.valid & ~b_i.valid);
  assign ready = (r_mult_ready & a_i.ready & b_i.ready);
  assign idle  = (r_mult_ready & a_i.ready & b_i.ready);


  // always_comb
  // begin : ctrl_op
  //   if((~start)&(a_i.ready)) begin
  //     ready = '1;
  //     idle  = '1;
  //   end
  //   else begin
  //     ready = '0;
  //     idle  = '0;
  //   end
  // end

  /* STREAMING PROTOCOL */

  // Ready signals have to be propagated backwards through pipeline stages (combinationally).
  // To avoid deadlocks, the following rules have to be followed:
  //  1) transition of ready CAN depend on the current state of valid
  //  2) transition of valid CANNOT depend on the current state of ready
  //  3) transition 1->0 of valid MUST depend on (previous) ready (i.e., once the valid goes
  //     to 1 it cannot go back to 0 until there is a valid handshake)
  // In the following:
  // R_valid & R_ready denominate the handshake at the *output* (Q port) of pipe register R

  // output accepts new value from accumulator when the output is ready or r_acc is invalid
  assign r_acc_ready  = d_o.ready | ~r_acc_valid;
  // accumulator accepts new value from multiplier when
  //   1) output is ready or r_mult is invalid (if in simple multiplication mode)
  //   2) r_acc is ready or r_mult is invalid (if in scalar product mode)
  assign r_mult_ready = (simple_mul) ? d_o.ready   | ~r_mult_valid
                                            : r_acc_ready | ~r_mult_valid;
  // multiplier accepts new value from a_i/b_i when r_mult is ready and both a_i/b_i are valid, or when both a_i/b_i are invalid
  assign a_i.ready = (r_mult_ready & a_i.valid & b_i.valid) | (~a_i.valid & ~b_i.valid);
  assign b_i.ready = (r_mult_ready & a_i.valid & b_i.valid) | (~a_i.valid & ~b_i.valid);
  // multiplier accepts new value from c_i when r_acc is ready or c_i is invalid
  assign c_i.ready    = r_acc_ready  | ~c_i.valid;

  // The following assertions help in getting the rules on ready & valid right.
  // They are copied from the general stream rules in hwpe_stream_interfaces.sv
  // and adapted to the internal r_acc and r_mult signals.
  `ifndef SYNTHESIS
  `ifndef VERILATOR
    // The data and strb can change their value 1) when valid is deasserted,
    // 2) in the cycle after a valid handshake, even if valid remains asserted.
    // In other words, valid data must remain on the interface until
    // a valid handshake has occurred.
    property r_acc_change_rule;
      @(posedge clk_i)
      ($past(r_acc_valid) & ~($past(r_acc_valid) & $past(r_acc_ready))) |-> (r_acc == $past(r_acc));
    endproperty;
    property r_mult_change_rule;
      @(posedge clk_i)
      ($past(r_mult_valid) & ~($past(r_mult_valid) & $past(r_mult_ready))) |-> (r_mult == $past(r_mult));
    endproperty;
    
    // The deassertion of valid (transition 1í0) can happen only in the cycle
    // after a valid handshake. In other words, valid data produced by a source
    // must be consumed on the sink side before valid is deasserted.
    property r_acc_valid_deassert_rule;
      @(posedge clk_i)
      ($past(r_acc_valid) & ~r_acc_valid) |-> $past(r_acc_valid) & $past(r_acc_ready);
    endproperty;
    property r_mult_valid_deassert_rule;
      @(posedge clk_i)
      ($past(r_mult_valid) & ~r_mult_valid) |-> $past(r_mult_valid) & $past(r_mult_ready);
    endproperty;

    R_ACC_VALUE_CHANGE:    assert property(r_acc_change_rule)
      else $fatal("ASSERTION FAILURE: R_ACC_VALUE_CHANGE", 1);

    R_ACC_VALID_DEASSERT:  assert property(r_acc_valid_deassert_rule)
      else $fatal("ASSERTION FAILURE R_ACC_VALID_DEASSERT", 1);

    R_MULT_VALUE_CHANGE:   assert property(r_mult_change_rule)
      else $fatal("ASSERTION FAILURE: R_MULT_VALUE_CHANGE", 1);

    R_MULT_VALID_DEASSERT: assert property(r_mult_valid_deassert_rule)
      else $fatal("ASSERTION FAILURE R_MULT_VALID_DEASSERT", 1);
  `endif /* VERILATOR */
  `endif /* SYNTHESIS */

endmodule // mac_engine
