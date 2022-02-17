/* =====================================================================
 * Project:      Traffic generator
 * Title:        traffic_gen.sv
 * Description:  Top module of traffic generator.
 *
 * $Date:        16.2.2022
 *
 * ===================================================================== */
/*
 * Copyright (C) 2022 University of Modena and Reggio Emilia.
 *
 * Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
 *
 */

module traffic_gen #(
  parameter int unsigned WORD_WIDTH = 32
) (
  // global signals
  input  logic                                      ap_clk,
  input  logic                                      ap_rst_n,

  // input a stream
  input logic                                       r_reqs_TVALID,
  output logic                                      r_reqs_TREADY,
  input logic [32-1:0]                              r_reqs_TDATA,
  // hwpe_stream_intf_stream.sink                      r_reqs,

  // output d stream
  output logic                                      w_reqs_TVALID,
  input logic                                       w_reqs_TREADY,
  output logic [WORD_WIDTH-1:0]                     w_reqs_TDATA,
  // hwpe_stream_intf_stream.source                    w_reqs,

  // // control channel (custom registers)
  input logic unsigned [WORD_WIDTH-1:0]             n_reqs,
  input logic unsigned [WORD_WIDTH-1:0]             pwm_period,
  input logic unsigned [WORD_WIDTH-1:0]             pwm_duty_cycle,

  // Control signals
  input logic                                       ap_start,
  output logic                                      ap_done,
  output logic                                      ap_idle,
  output logic                                      ap_ready

  // input  ctrl_engine_t                              ctrl_i, 
  // output flags_engine_t                             flags_o
);

  // ctrl
  logic ap_start_dly;
  logic edge_start;

  // registered output
  logic [WORD_WIDTH-1:0] out;
  logic [WORD_WIDTH-1:0] r_out;
  logic r_out_valid;
  logic r_out_ready;

  // counter signals
  logic unsigned [WORD_WIDTH-1:0] cnt;
  logic unsigned [WORD_WIDTH-1:0] r_cnt;

  // PWM signals
  logic [WORD_WIDTH-1:0] local_pwm_period; // PWM period
  logic [WORD_WIDTH-1:0] local_pwm_pulse; // PWM pulse duration
  logic local_pwm_size; // PWM pulse size
  logic local_pwm_enable; // PWM enable
  logic local_pwm_out;

  ////////////////////////////////////////////////////////////////////////////////////////////

  // < PWM CONTROL ON INPUT READY / OUTPUT VALID >

  // wait for start, then enable PWM controller
  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin: pwm_ctrl_enable
    if(~ap_rst_n) begin
      local_pwm_enable <= '0;
    end
    else if ((r_cnt>0)&&(r_cnt == n_reqs-1)) begin
      local_pwm_enable <= '0;
    end
    else if (edge_start) begin
      local_pwm_enable <= '1;
    end
  end

  // init of PWM signals
  always_comb
  begin: pwm_ctrl_values
    if(local_pwm_enable=='0) begin
      local_pwm_size         = '0;
      local_pwm_period       = '0;
      local_pwm_pulse        = '0;
    end
    else begin
      local_pwm_size         = '1;
      local_pwm_period       = pwm_period;
      local_pwm_pulse        = local_pwm_period / (100/pwm_duty_cycle);
    end
  end

  // PWM controller
  PWM_ctrl #(
    .WORD_WIDTH     ( 32                )
  ) PWM_ctrl_i (
    .CLK            ( ap_clk            ),
    .RSTN           ( ap_rst_n          ),
    .PWM_PERIOD     ( local_pwm_period  ), 
    .PWM_PULSE      ( local_pwm_pulse   ), 
    .PWM_SIZE       ( local_pwm_size    ),  
    .PWM_ENABLE     ( local_pwm_enable  ), 
    .PWM_OUT        ( local_pwm_out     )
  );

  ////////////////////////////////////////////////////////////////////////////////////////////

  // < COUNT INPUTS >

  always_comb
  begin
    cnt = r_cnt + 1;
  end

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin
    if(~ap_rst_n) begin // reset counter
      r_cnt <= '0;
    end
    else if((r_cnt>0)&&(r_cnt == n_reqs-1)) begin // reset counter
      r_cnt <= '0;
    end
    else if(ap_start) begin // if job
      if ((r_cnt < n_reqs) && (r_reqs_TVALID & r_reqs_TREADY == 1'b1)) begin // update counter
        r_cnt <= cnt;
      end
    end
  end

  ////////////////////////////////////////////////////////////////////////////////////////////

  // < EDGE DETECTOR AP_START >

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin: ap_start_delay
    ap_start_dly <= ap_start;
  end

  assign edge_start = (r_cnt==0) ? (ap_start & ~ap_start_dly) : '0;

  // < PILOT DONE SIGNAL >

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin: fsm_flags_done
    if(~ap_rst_n) begin
      ap_done <= 1'b0;
    end
    else if((r_cnt>0)&&(r_cnt == n_reqs-1)) begin
      ap_done <= 1'b1;
    end
    else begin
      ap_done <= 1'b0;
    end
  end

  // // < PILOT IDLE/READY SIGNAL >

  // TO-DO; Need to re-think the generated control interface for handcrafted accelerators.
  // The signals should be standardized and a clear technical guide on how to use them
  // should be written.

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin: fsm_flags_status
    if(~ap_rst_n) begin
      ap_ready <= 1'b0;
      ap_idle  <= 1'b0;
    end
    else if(ap_start) begin
      ap_ready <= 1'b1;
      ap_idle  <= 1'b1;
    end
    else if(ap_done) begin
      ap_ready <= 1'b0;
      ap_idle  <= 1'b0;
    end
  end

  ////////////////////////////////////////////////////////////////////////////////////////////

  // < REGISTER OUTPUT VALUES >

  always_comb
  begin
    out = r_reqs_TDATA;
  end

  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin : mult_pipe_data
    if(~ap_rst_n) begin
      r_out <= '0;
    end
    else if (ap_done) begin
      r_out <= '0;
    end
    else if(ap_start) begin // if job
      // r_out value is updated if there is a valid handshake at its input
      if (r_reqs_TVALID & r_reqs_TREADY) begin
        r_out <= out;
      end
    end
  end

  // r_out is valid following a valid handshake
  always_ff @(posedge ap_clk or negedge ap_rst_n)
  begin : out_pipe_valid
    if(~ap_rst_n) begin
      r_out_valid <= '0;
    end
    else if ((r_reqs_TVALID) | (r_out_valid & r_out_ready)) begin
      r_out_valid <= r_reqs_TVALID & local_pwm_out;
    end
  end

  assign r_out_ready = w_reqs_TREADY;

  ////////////////////////////////////////////////////////////////////////////////////////////

  // < DRIVE INPUT READS >

  always_comb
  begin
    r_reqs_TREADY = local_pwm_out;  // drive using PWM
  end

  ////////////////////////////////////////////////////////////////////////////////////////////

  // < DRIVE OUTPUT WRITES >

  always_comb
  begin
    w_reqs_TDATA  = r_out;
    w_reqs_TVALID = r_out_valid; // drive using PWM
  end

  ////////////////////////////////////////////////////////////////////////////////////////////

endmodule // traffic_gen
