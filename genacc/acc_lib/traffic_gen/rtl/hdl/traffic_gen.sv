/* =====================================================================
 * Project:      Traffic Generator
 * Title:        traffic_gen.sv
 * Description:  Implementation of a generic accelerated kernel for DSE purposes.
 *
 * $Date:        12.11.2021
 * ===================================================================== */
/*
 * Copyright (C) 2021 University of Modena and Reggio Emilia..
 *
 * Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
 *
 */

package local_mac_package;
    parameter int unsigned DATA_WIDTH    = 32,
    parameter int unsigned ADDRESS_WIDTH = 12,
    parameter int unsigned RANDOM_BE     = 0,        // Set to 1 for random byte enable
    parameter int unsigned RANDOM_RW     = 0,        // Set to 1 for random read/write sequences
    parameter int unsigned RANDOM_SEED   = 1337      // Seed for random generators
endpackage

module sim_traffic_generator 
( 
    // global signals
	input  logic                        clk_i,
	input  logic                        rst_ni,
	
	//Streaming interface towards memory
  hwpe_stream_intf_stream.sink        stream_in,

  //Streaming interface towards memory
  hwpe_stream_intf_stream.source      stream_out,

  // hci_core_intf.master  mem,

	//Control signals
	input  logic [15:0]                 n_trans_i,    // How many requests shall be triggered
	input  logic                        we_i,         // R/W -> 0 to write, 1 to read
	input  logic [9:0]                  prob_req_i,   // Probability of emitting a request (1000 -> 100%)
	input  logic                        start_i,      // Set high for a cycle to start the engine
	input  logic                        stop_i,       // Set high to force stop after current transaction
	output logic                        done_o	      // Set when all transactions are completed

  // Control signals
  input  ctrl_engine_t                              ctrl_i,

  // Flag signals 
  output flags_engine_t                             flags_o
);

  localparam N_DWORDS_DATA = $ceil(DATA_WIDTH/32);

  //Internal signals
	enum {FSM_IDLE, FSM_PAUSE, FSM_COMPUTE, FSM_WAIT_FOR_GNT} next_state, current_state; 
  logic [9:0]                 prob_req_int_s;
  logic [15:0]                req_ctr_s;
  logic [ADDRESS_WIDTH-1:0]   add_rand_s;
  logic [DATA_WIDTH-1:0]      data_rand_s;
  logic [N_DWORDS_DATA*4-1:0] be_s; 
	logic [15:0]                n_trans_s;
	logic                       we_inp_s;
	logic                       we_rand_s;
	logic                       we_s;
	logic [9:0]                 prob_req_s;


  /* Traffic generator FSM */
  
	always_ff @(posedge clk_i or negedge reset_ni)
	begin  
		if(~reset_ni) begin
			current_state <= FSM_IDLE;
		end
		else begin
			current_state <= next_state;
		end
	end
  
  always_comb
	begin
		next_state = current_state;

		case (current_state)

			FSM_IDLE:
			begin
				if (start_i)
					next_state = FSM_PAUSE;
			end
      
			FSM_PAUSE:
			begin
				if (prob_req_int_s < prob_req_s)
					next_state = FSM_COMPUTE;
			end

			FSM_COMPUTE: 
			begin
				if (~mem.gnt)
          next_state = FSM_WAIT_FOR_GNT;
				else if ((req_ctr_s >= n_trans_s) || stop_i)
					next_state = FSM_IDLE;
        else if (prob_req_int_s >= prob_req_s)
					next_state = FSM_PAUSE;
      end
      
			FSM_WAIT_FOR_GNT: 
			begin
				if (mem.gnt) 
        begin
          if ((req_ctr_s >= n_trans_s) || stop_i)
            next_state = FSM_IDLE;
          else if (prob_req_int_s >= prob_req_s)
            next_state = FSM_PAUSE;
					else
            next_state = FSM_COMPUTE;
				end
			end

		endcase
	end
  
  //Done output
  assign done_o = (current_state == FSM_IDLE);

  //Mem interface creates requests while in FSM_COMPUTE state
	always_ff @(posedge clk_i or negedge reset_ni)
	begin
		if (~reset_ni) 
    begin
			mem.boffs  <= '0;
      mem.lrdy   <= '1;
      mem.req    <= '0;
      mem.add  <= '0;
      mem.be   <= '0;
      mem.wen  <= '0;
      mem.data <= '0;
		end
		else
    begin
      case (next_state)
        FSM_IDLE, FSM_PAUSE:
        begin
          //No request at the interface this cycle -> idle state
          mem.req  <= '0;
          mem.add  <= '0;
          mem.be   <= '0;
          mem.wen  <= '0;
          mem.data <= '0;
        end
        
        FSM_COMPUTE:
        begin
          //Initiate next transaction
          mem.req  <= '1;
          mem.add  <= add_rand_s;
          mem.be   <= be_s;
          mem.wen  <= we_s;
          if (we_s)
            // 1 -> read
            mem.data <= '0;
          else
            // 0 -> write
            mem.data <= data_rand_s;
        end
        
        FSM_WAIT_FOR_GNT:
        begin
          //Wait for sth to happen...
          // -> Leave everything as is
        end
      endcase      
		end
	end
  
  //Configuration inputs buffering
	always_ff @(posedge clk_i)
	begin
		if ((current_state == FSM_IDLE) & start_i)
    begin
      n_trans_s <= n_trans_i;
      we_inp_s <= we_i;
      prob_req_s <= prob_req_i;
    end
	end

  //Random signals for memory interface
	always_ff @(posedge clk_i or negedge reset_ni)
	begin
    if (~reset_ni)
      void'($urandom(RANDOM_SEED));
    else
    begin
      //Address
      add_rand_s <= $urandom();
      
      //Byte enable
      if (RANDOM_BE)
        be_s <= $urandom();
      else
        be_s <= '1;
      
      //Write enable
      we_rand_s <= $urandom();
        
      //Probability of next request generation
      prob_req_int_s <= $urandom_range(0, 999);

      //Data for write accesses
     for(int i = 0; i < N_DWORDS_DATA; i++)
       data_rand_s[32*i +: 32] <= $urandom();
    end
	end
  
  assign we_s = (RANDOM_RW == 0) ? we_inp_s : we_rand_s;
  
  //Request counter
	always_ff @(posedge clk_i or negedge reset_ni)
	begin
		if (~reset_ni)
			req_ctr_s <= '0;
		else if (next_state == FSM_COMPUTE)
			req_ctr_s <= req_ctr_s + 1;
	end


  
endmodule
