// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module traffic_gen_module (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        stream_in_V_TDATA,
        stream_in_V_TVALID,
        stream_in_V_TREADY,
        stream_out_V_TDATA,
        stream_out_V_TVALID,
        stream_out_V_TREADY,
        n_trans
);

parameter    ap_ST_fsm_state1 = 5'd1;
parameter    ap_ST_fsm_state2 = 5'd2;
parameter    ap_ST_fsm_state3 = 5'd4;
parameter    ap_ST_fsm_pp1_stage0 = 5'd8;
parameter    ap_ST_fsm_state6 = 5'd16;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [31:0] stream_in_V_TDATA;
input   stream_in_V_TVALID;
output   stream_in_V_TREADY;
output  [31:0] stream_out_V_TDATA;
output   stream_out_V_TVALID;
input   stream_out_V_TREADY;
input  [31:0] n_trans;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg stream_in_V_TREADY;
reg stream_out_V_TVALID;

(* fsm_encoding = "none" *) reg   [4:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    stream_in_V_TDATA_blk_n;
wire    ap_CS_fsm_state2;
wire   [0:0] icmp_ln35_fu_83_p2;
reg    stream_out_V_TDATA_blk_n;
wire    ap_CS_fsm_pp1_stage0;
reg    ap_enable_reg_pp1_iter1;
wire    ap_block_pp1_stage0;
reg   [0:0] icmp_ln41_reg_119;
reg   [31:0] tmp_reg_70;
wire   [31:0] ii_fu_88_p2;
reg    ap_block_state2;
wire   [0:0] icmp_ln41_fu_94_p2;
wire    ap_block_state4_pp1_stage0_iter0;
wire    ap_block_state5_pp1_stage0_iter1;
reg    ap_block_state5_io;
reg    ap_block_pp1_stage0_11001;
wire   [31:0] jj_fu_99_p2;
reg   [31:0] jj_reg_123;
reg    ap_enable_reg_pp1_iter0;
wire    ap_CS_fsm_state3;
reg    ap_block_pp1_stage0_subdone;
reg    ap_condition_pp1_exit_iter0_state4;
reg   [31:0] ii_0_reg_59;
reg   [31:0] ap_phi_mux_tmp_phi_fu_75_p4;
wire    ap_block_pp1_stage0_01001;
wire    ap_CS_fsm_state6;
reg   [4:0] ap_NS_fsm;
reg    ap_idle_pp1;
wire    ap_enable_pp1;

// power-on initialization
initial begin
#0 ap_CS_fsm = 5'd1;
#0 ap_enable_reg_pp1_iter1 = 1'b0;
#0 ap_enable_reg_pp1_iter0 = 1'b0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp1_iter0 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp1_stage0_subdone) & (1'b1 == ap_CS_fsm_pp1_stage0) & (1'b1 == ap_condition_pp1_exit_iter0_state4))) begin
            ap_enable_reg_pp1_iter0 <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state3)) begin
            ap_enable_reg_pp1_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp1_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp1_stage0_subdone) & (1'b1 == ap_condition_pp1_exit_iter0_state4))) begin
            ap_enable_reg_pp1_iter1 <= (1'b1 ^ ap_condition_pp1_exit_iter0_state4);
        end else if ((1'b0 == ap_block_pp1_stage0_subdone)) begin
            ap_enable_reg_pp1_iter1 <= ap_enable_reg_pp1_iter0;
        end else if ((1'b1 == ap_CS_fsm_state3)) begin
            ap_enable_reg_pp1_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((~((icmp_ln35_fu_83_p2 == 1'd0) & (stream_in_V_TVALID == 1'b0)) & (icmp_ln35_fu_83_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        ii_0_reg_59 <= ii_fu_88_p2;
    end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
        ii_0_reg_59 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        tmp_reg_70 <= 32'd0;
    end else if (((1'b0 == ap_block_pp1_stage0_11001) & (icmp_ln41_reg_119 == 1'd0) & (ap_enable_reg_pp1_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp1_stage0))) begin
        tmp_reg_70 <= jj_reg_123;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp1_stage0_11001) & (1'b1 == ap_CS_fsm_pp1_stage0))) begin
        icmp_ln41_reg_119 <= icmp_ln41_fu_94_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp1_stage0_11001) & (ap_enable_reg_pp1_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp1_stage0))) begin
        jj_reg_123 <= jj_fu_99_p2;
    end
end

always @ (*) begin
    if ((icmp_ln41_fu_94_p2 == 1'd1)) begin
        ap_condition_pp1_exit_iter0_state4 = 1'b1;
    end else begin
        ap_condition_pp1_exit_iter0_state4 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp1_iter0 == 1'b0) & (ap_enable_reg_pp1_iter1 == 1'b0))) begin
        ap_idle_pp1 = 1'b1;
    end else begin
        ap_idle_pp1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp1_stage0) & (icmp_ln41_reg_119 == 1'd0) & (ap_enable_reg_pp1_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp1_stage0))) begin
        ap_phi_mux_tmp_phi_fu_75_p4 = jj_reg_123;
    end else begin
        ap_phi_mux_tmp_phi_fu_75_p4 = tmp_reg_70;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln35_fu_83_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        stream_in_V_TDATA_blk_n = stream_in_V_TVALID;
    end else begin
        stream_in_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((icmp_ln35_fu_83_p2 == 1'd0) & (stream_in_V_TVALID == 1'b0)) & (icmp_ln35_fu_83_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        stream_in_V_TREADY = 1'b1;
    end else begin
        stream_in_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp1_stage0) & (icmp_ln41_reg_119 == 1'd0) & (ap_enable_reg_pp1_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp1_stage0))) begin
        stream_out_V_TDATA_blk_n = stream_out_V_TREADY;
    end else begin
        stream_out_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp1_stage0_11001) & (icmp_ln41_reg_119 == 1'd0) & (ap_enable_reg_pp1_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp1_stage0))) begin
        stream_out_V_TVALID = 1'b1;
    end else begin
        stream_out_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if ((~((icmp_ln35_fu_83_p2 == 1'd0) & (stream_in_V_TVALID == 1'b0)) & (icmp_ln35_fu_83_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else if ((~((icmp_ln35_fu_83_p2 == 1'd0) & (stream_in_V_TVALID == 1'b0)) & (icmp_ln35_fu_83_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_pp1_stage0;
        end
        ap_ST_fsm_pp1_stage0 : begin
            if (~((1'b0 == ap_block_pp1_stage0_subdone) & (icmp_ln41_fu_94_p2 == 1'd1) & (ap_enable_reg_pp1_iter0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_pp1_stage0;
            end else if (((1'b0 == ap_block_pp1_stage0_subdone) & (icmp_ln41_fu_94_p2 == 1'd1) & (ap_enable_reg_pp1_iter0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp1_stage0;
            end
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp1_stage0 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state6 = ap_CS_fsm[32'd4];

assign ap_block_pp1_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp1_stage0_01001 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp1_stage0_11001 = ((ap_enable_reg_pp1_iter1 == 1'b1) & (1'b1 == ap_block_state5_io));
end

always @ (*) begin
    ap_block_pp1_stage0_subdone = ((ap_enable_reg_pp1_iter1 == 1'b1) & (1'b1 == ap_block_state5_io));
end

always @ (*) begin
    ap_block_state2 = ((icmp_ln35_fu_83_p2 == 1'd0) & (stream_in_V_TVALID == 1'b0));
end

assign ap_block_state4_pp1_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state5_io = ((icmp_ln41_reg_119 == 1'd0) & (stream_out_V_TREADY == 1'b0));
end

assign ap_block_state5_pp1_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp1 = (ap_idle_pp1 ^ 1'b1);

assign icmp_ln35_fu_83_p2 = ((ii_0_reg_59 == n_trans) ? 1'b1 : 1'b0);

assign icmp_ln41_fu_94_p2 = ((ap_phi_mux_tmp_phi_fu_75_p4 == n_trans) ? 1'b1 : 1'b0);

assign ii_fu_88_p2 = (ii_0_reg_59 + 32'd1);

assign jj_fu_99_p2 = (ap_phi_mux_tmp_phi_fu_75_p4 + 32'd1);

assign stream_out_V_TDATA = tmp_reg_70;

endmodule //traffic_gen_module