/* =====================================================================
 * Project:      HWPE kernel adapter
 * Title:        hwpe_kernel_adapter.sv
 * Description:  Interface between hardware wrapper and accelerated kernel.
 *
 * ===================================================================== */
/*
 * Copyright (C) 2021 University of Modena and Reggio Emilia..
 *
 * Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
 *
 */

import multi_dataflow_mul_mdc_package::*;

module multi_dataflow_mul_mdc_kernel_adapter (
  // Global signals
  input  logic          clk_i,
  input  logic          rst_ni,
  input  logic          test_mode_i,

  // Sink ports
  hwpe_stream_intf_stream.sink    inStream0_i,
  hwpe_stream_intf_stream.sink    inStream1_i,
  hwpe_stream_intf_stream.sink    inStream2_i,

  // Source ports
  hwpe_stream_intf_stream.source    outStream0_o,

  // Kernel parameters
  input logic [31:0] reg_simple_mul,
  input logic [31:0] reg_shift,
  input logic [31:0] reg_len,
  
  // Control signals
  input  ctrl_kernel_adapter_multi_dataflow_mul_mdc_t           ctrl_i,

  // Flag signals
  output  flags_kernel_adapter_multi_dataflow_mul_mdc_t           flags_o

  );

  /* multi_dataflow_mul_mdc control signals. */

  logic kernel_start;

  // START is not always high. For each READY (~(engine_ready | engine_idle)) that is
  // delivered to the FSM, a new START signal is set high and iaaued to the kernel.

  assign kernel_start = ctrl_i.start;

  /* multi_dataflow_mul_mdc flag signals. */

  //logic kernel_ready_inStream0;  //FIXEME: to be removed
  logic kernel_done_inStream0;
  //logic kernel_ready_inStream1;  //FIXEME: to be removed
  logic kernel_done_inStream1;
  //logic kernel_ready_inStream2;  //FIXEME: to be removed
  logic kernel_done_inStream2;

  logic kernel_done_outStream0;

  logic kernel_idle;
  // logic kernel_ready;

  /* Done. */
  // A done is generated for each output. These are counted and
  // delivered to the FSM that decides when to update the address
  // on the basis of the state of the line processing (see HWPE-docs).

  // FIXME: This temporarily works synch-outputs.
  // EX: What if Out_0 is provided at each input and Out_1 once per 10 inputs?
  assign flags_o.done =  (kernel_done_outStream0) ;

  always_ff @(posedge clk_i or negedge rst_ni)
    begin: fsm_done_outStream0
  	if(~rst_ni)
  	  kernel_done_outStream0 = 1'b0;
  	else if((outStream0_o.valid)&(outStream0_o.ready))
  	  kernel_done_outStream0 = 1'b1;
  	else
  	  kernel_done_outStream0 = 1'b0;
    end

  /* Ready. */
  /* This is used in the hwpe-engine to set flags_o.ready.
     The latter triggers the START of accelerator. (see FSM_COMPUTE). */
  /* Driven using input counters. */

  assign flags_o.ready =  (kernel_done_inStream0)  &  (kernel_done_inStream1)  &  (kernel_done_inStream2) ;

  /* Idle. */
  /* This is used in the hwpe-engine to set flags_o.ready.
     The latter triggers the START of accelerator. (see FSM_COMPUTE). */
  /* For more infos refer to UG902. */

  assign flags_o.idle = kernel_idle;

  /* The Idle signal indicates when the design is idle and not operating. */
  always_ff @(posedge clk_i or negedge rst_ni)
  begin: fsm_idle
		if(~rst_ni) begin
      kernel_idle = 1'b0;
    end
    else if(kernel_start) begin
      /* Idle goes Low immediately after Start to indicate the design is no longer idle. */
      /* If the Start signal is High when Ready is High, the design continues to operate,
          and the Idle signal remains Low. */
			kernel_idle = 1'b0;
    end
      else if(!kernel_start) begin
        // else if((!kernel_start) & (ready)) begin # removed ready signal
      if( (kernel_done_outStream0) ) begin
        /* If the Start signal is Low when Ready is High, the design stops operation, and
            the ap_idle signal goes High one cycle after ap_done.*/
        kernel_idle = 1'b1;
      end
    end
    else begin
			kernel_idle = kernel_idle;
    end
  end

  /* multi_dataflow_mul_mdc input counters. Ready. */

  logic unsigned [($clog2(MULTI_DATAFLOW_MUL_MDC_CNT_LEN)+1):0] kernel_cnt_inStream0;
  always_ff @(posedge clk_i or negedge rst_ni)
    begin: engine_cnt_inStream0
    if((~rst_ni) | kernel_start) begin
      kernel_cnt_inStream0 = 32'b0;
    end
    else if(kernel_start) begin
      kernel_cnt_inStream0 = 32'b0;
    end
    else if ((inStream0_i.valid) & (inStream0_i.ready)) begin
  	kernel_cnt_inStream0 = kernel_cnt_inStream0 + 1;
    end
    else begin
      kernel_cnt_inStream0 = kernel_cnt_inStream0;
    end
  end

  // FIXME: Now kernel_done_in goes High every time an input enters the acc.
  // This should be generalized. Even though the wrapper looper is designed to
  // on counting the ouputs, the number of inputs needed to generate an ouput
  // are usually > 1.
  // SOL: Add to ctrl_i also the information about max_input.
  assign kernel_done_inStream0 = (kernel_cnt_inStream0==1) ? 1 : 0;
  logic unsigned [($clog2(MULTI_DATAFLOW_MUL_MDC_CNT_LEN)+1):0] kernel_cnt_inStream1;
  always_ff @(posedge clk_i or negedge rst_ni)
    begin: engine_cnt_inStream1
    if((~rst_ni) | kernel_start) begin
      kernel_cnt_inStream1 = 32'b0;
    end
    else if(kernel_start) begin
      kernel_cnt_inStream1 = 32'b0;
    end
    else if ((inStream1_i.valid) & (inStream1_i.ready)) begin
  	kernel_cnt_inStream1 = kernel_cnt_inStream1 + 1;
    end
    else begin
      kernel_cnt_inStream1 = kernel_cnt_inStream1;
    end
  end

  // FIXME: Now kernel_done_in goes High every time an input enters the acc.
  // This should be generalized. Even though the wrapper looper is designed to
  // on counting the ouputs, the number of inputs needed to generate an ouput
  // are usually > 1.
  // SOL: Add to ctrl_i also the information about max_input.
  assign kernel_done_inStream1 = (kernel_cnt_inStream1==1) ? 1 : 0;
  logic unsigned [($clog2(MULTI_DATAFLOW_MUL_MDC_CNT_LEN)+1):0] kernel_cnt_inStream2;
  always_ff @(posedge clk_i or negedge rst_ni)
    begin: engine_cnt_inStream2
    if((~rst_ni) | kernel_start) begin
      kernel_cnt_inStream2 = 32'b0;
    end
    else if(kernel_start) begin
      kernel_cnt_inStream2 = 32'b0;
    end
    else if ((inStream2_i.valid) & (inStream2_i.ready)) begin
  	kernel_cnt_inStream2 = kernel_cnt_inStream2 + 1;
    end
    else begin
      kernel_cnt_inStream2 = kernel_cnt_inStream2;
    end
  end

  // FIXME: Now kernel_done_in goes High every time an input enters the acc.
  // This should be generalized. Even though the wrapper looper is designed to
  // on counting the ouputs, the number of inputs needed to generate an ouput
  // are usually > 1.
  // SOL: Add to ctrl_i also the information about max_input.
  assign kernel_done_inStream2 = (kernel_cnt_inStream2==1) ? 1 : 0;

  /* multi_dataflow_mul_mdc output counters. */

  logic unsigned [($clog2(MULTI_DATAFLOW_MUL_MDC_CNT_LEN)+1):0] kernel_cnt_outStream0;

  // Suggested design:
  //      ap_done = done_out0 & ... & done_outM;
  //      done_outM = cnt_out,i == ctrl_i.max_out,i; (for i=1,..,N)
  // However, loop ctrl is already implemented in micro-code looper that sits
  // in the hwpe-ctrl. Thus, the done information provided by this stage should
  // concern a single output element, not a tile (block,..).
  // FIXME: At this point, cnt_out is not essential here and could be removed.

  always_ff @(posedge clk_i or negedge rst_ni)
  begin: engine_cnt_outStream0
    if((~rst_ni) | kernel_start)
      kernel_cnt_outStream0 = 32'b0;
    else if(!kernel_idle) begin
      if((outStream0_o.valid)&(outStream0_o.ready))
        kernel_cnt_outStream0 = kernel_cnt_outStream0 + 1;
      else
        kernel_cnt_outStream0 = kernel_cnt_outStream0;
    end
  end

  assign cnt_outStream0 = kernel_cnt_outStream0;

  /* multi_dataflow_mul_mdc kernel interface. */  

  multi_dataflow_mul_mdc_reconf_datapath_top i_multi_dataflow_mul_mdc_reconf_datapath_top (
    // Input data (to-hwpe)
    .inStream0	( inStream0_i	),
    .inStream1	( inStream1_i	),
    .inStream2	( inStream2_i	),
    // Output data (from-hwpe)
    .outStream0	( outStream0_o	),
    // Algorithm parameters
    .reg_simple_mul	( reg_simple_mul ),
    .reg_shift	( reg_shift ),
    .reg_len	( reg_len ),
          // Global signals.
      .clk_i             ( clk_i            ),
      .rst_ni           ( rst_ni           )
    );
endmodule
