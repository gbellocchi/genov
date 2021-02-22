// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="MAC,hls_ip_2019_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xczu9eg-ffvb1156-2-e,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=4.436000,HLS_SYN_LAT=1,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=3,HLS_SYN_FF=2,HLS_SYN_LUT=107,HLS_VERSION=2019_2}" *)

module MAC (
        ap_clk,
        ap_rst_n,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        x2_V_TVALID,
        x1_V_TVALID,
        y_mul_V_TREADY,
        y_mac_V_TREADY,
        x1_V_TDATA,
        x1_V_TREADY,
        x2_V_TDATA,
        x2_V_TREADY,
        mac_par_V,
        y_mul_V_TDATA,
        y_mul_V_TVALID,
        y_mac_V_TDATA,
        y_mac_V_TVALID
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst_n;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input   x2_V_TVALID;
input   x1_V_TVALID;
input   y_mul_V_TREADY;
input   y_mac_V_TREADY;
input  [31:0] x1_V_TDATA;
output   x1_V_TREADY;
input  [31:0] x2_V_TDATA;
output   x2_V_TREADY;
input  [31:0] mac_par_V;
output  [31:0] y_mul_V_TDATA;
output   y_mul_V_TVALID;
output  [31:0] y_mac_V_TDATA;
output   y_mac_V_TVALID;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg x1_V_TREADY;
reg x2_V_TREADY;

 reg    ap_rst_n_inv;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
reg    ap_block_state1_pp0_stage0_iter0;
reg    ap_block_state1_io;
wire    regslice_both_y_mul_V_U_apdone_blk;
wire    regslice_both_y_mac_V_U_apdone_blk;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_state2_io;
reg    ap_block_pp0_stage0_11001;
reg    x1_V_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    x2_V_TDATA_blk_n;
reg    y_mul_V_TDATA_blk_n;
reg    y_mac_V_TDATA_blk_n;
wire   [31:0] p_y_mul_V_fu_68_p2;
reg    ap_block_pp0_stage0_subdone;
reg    ap_block_pp0_stage0_01001;
wire  signed [31:0] p_y_mul_V_fu_68_p0;
wire  signed [31:0] p_y_mul_V_fu_68_p1;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to0;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
wire    regslice_both_x1_V_U_apdone_blk;
wire   [31:0] x1_V_TDATA_int;
wire    x1_V_TVALID_int;
reg    x1_V_TREADY_int;
wire    regslice_both_x1_V_U_ack_in;
wire    regslice_both_x2_V_U_apdone_blk;
wire   [31:0] x2_V_TDATA_int;
wire    x2_V_TVALID_int;
reg    x2_V_TREADY_int;
wire    regslice_both_x2_V_U_ack_in;
reg    y_mul_V_TVALID_int;
wire    y_mul_V_TREADY_int;
wire    regslice_both_y_mul_V_U_vld_out;
wire   [31:0] y_mac_V_TDATA_int;
reg    y_mac_V_TVALID_int;
wire    y_mac_V_TREADY_int;
wire    regslice_both_y_mac_V_U_vld_out;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

regslice_both #(
    .DataWidth( 32 ))
regslice_both_x1_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(x1_V_TDATA),
    .vld_in(x1_V_TVALID),
    .ack_in(regslice_both_x1_V_U_ack_in),
    .data_out(x1_V_TDATA_int),
    .vld_out(x1_V_TVALID_int),
    .ack_out(x1_V_TREADY_int),
    .apdone_blk(regslice_both_x1_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 32 ))
regslice_both_x2_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(x2_V_TDATA),
    .vld_in(x2_V_TVALID),
    .ack_in(regslice_both_x2_V_U_ack_in),
    .data_out(x2_V_TDATA_int),
    .vld_out(x2_V_TVALID_int),
    .ack_out(x2_V_TREADY_int),
    .apdone_blk(regslice_both_x2_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 32 ))
regslice_both_y_mul_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(p_y_mul_V_fu_68_p2),
    .vld_in(y_mul_V_TVALID_int),
    .ack_in(y_mul_V_TREADY_int),
    .data_out(y_mul_V_TDATA),
    .vld_out(regslice_both_y_mul_V_U_vld_out),
    .ack_out(y_mul_V_TREADY),
    .apdone_blk(regslice_both_y_mul_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 32 ))
regslice_both_y_mac_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(y_mac_V_TDATA_int),
    .vld_in(y_mac_V_TVALID_int),
    .ack_in(y_mac_V_TREADY_int),
    .data_out(y_mac_V_TDATA),
    .vld_out(regslice_both_y_mac_V_U_vld_out),
    .ack_out(y_mac_V_TREADY),
    .apdone_blk(regslice_both_y_mac_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start;
        end
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((ap_enable_reg_pp0_iter0 == 1'b0)) begin
        ap_idle_pp0_0to0 = 1'b1;
    end else begin
        ap_idle_pp0_0to0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to0 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        x1_V_TDATA_blk_n = x1_V_TVALID_int;
    end else begin
        x1_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((x1_V_TVALID == 1'b1) & (regslice_both_x1_V_U_ack_in == 1'b1))) begin
        x1_V_TREADY = 1'b1;
    end else begin
        x1_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        x1_V_TREADY_int = 1'b1;
    end else begin
        x1_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        x2_V_TDATA_blk_n = x2_V_TVALID_int;
    end else begin
        x2_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((x2_V_TVALID == 1'b1) & (regslice_both_x2_V_U_ack_in == 1'b1))) begin
        x2_V_TREADY = 1'b1;
    end else begin
        x2_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        x2_V_TREADY_int = 1'b1;
    end else begin
        x2_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        y_mac_V_TDATA_blk_n = y_mac_V_TREADY_int;
    end else begin
        y_mac_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        y_mac_V_TVALID_int = 1'b1;
    end else begin
        y_mac_V_TVALID_int = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        y_mul_V_TDATA_blk_n = y_mul_V_TREADY_int;
    end else begin
        y_mul_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        y_mul_V_TVALID_int = 1'b1;
    end else begin
        y_mul_V_TVALID_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & ((regslice_both_y_mac_V_U_apdone_blk == 1'b1) | (regslice_both_y_mul_V_U_apdone_blk == 1'b1))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (x2_V_TVALID_int == 1'b0) | (x1_V_TVALID_int == 1'b0))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & ((regslice_both_y_mac_V_U_apdone_blk == 1'b1) | (regslice_both_y_mul_V_U_apdone_blk == 1'b1) | (1'b1 == ap_block_state2_io))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (x2_V_TVALID_int == 1'b0) | (x1_V_TVALID_int == 1'b0) | (1'b1 == ap_block_state1_io))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & ((regslice_both_y_mac_V_U_apdone_blk == 1'b1) | (regslice_both_y_mul_V_U_apdone_blk == 1'b1) | (1'b1 == ap_block_state2_io))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (x2_V_TVALID_int == 1'b0) | (x1_V_TVALID_int == 1'b0) | (1'b1 == ap_block_state1_io))));
end

always @ (*) begin
    ap_block_state1_io = ((y_mac_V_TREADY_int == 1'b0) | (y_mul_V_TREADY_int == 1'b0));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (x2_V_TVALID_int == 1'b0) | (x1_V_TVALID_int == 1'b0));
end

always @ (*) begin
    ap_block_state2_io = ((y_mac_V_TREADY_int == 1'b0) | (y_mul_V_TREADY_int == 1'b0));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((regslice_both_y_mac_V_U_apdone_blk == 1'b1) | (regslice_both_y_mul_V_U_apdone_blk == 1'b1));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign p_y_mul_V_fu_68_p0 = x1_V_TDATA_int;

assign p_y_mul_V_fu_68_p1 = x2_V_TDATA_int;

assign p_y_mul_V_fu_68_p2 = ($signed(p_y_mul_V_fu_68_p0) * $signed(p_y_mul_V_fu_68_p1));

assign y_mac_V_TDATA_int = (p_y_mul_V_fu_68_p2 + mac_par_V);

assign y_mac_V_TVALID = regslice_both_y_mac_V_U_vld_out;

assign y_mul_V_TVALID = regslice_both_y_mul_V_U_vld_out;

endmodule //MAC
