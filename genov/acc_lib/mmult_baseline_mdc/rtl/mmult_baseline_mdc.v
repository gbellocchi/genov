// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="mmult_hw,hls_ip_2019_1_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu9eg-ffvb1156-2-e,HLS_INPUT_CLOCK=6.660000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=4.436000,HLS_SYN_LAT=516,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=3,HLS_SYN_FF=253,HLS_SYN_LUT=310,HLS_VERSION=2019_1_1}" *)

module mmult_baseline_mdc (
        ap_clk,
        ap_rst_n,
        in1_TDATA,
        in1_TVALID,
        in1_TREADY,
        in2_TDATA,
        in2_TVALID,
        in2_TREADY,
        out_r_TDATA,
        out_r_TVALID,
        out_r_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [31:0] in1_TDATA;
input   in1_TVALID;
output   in1_TREADY;
input  [31:0] in2_TDATA;
input   in2_TVALID;
output   in2_TREADY;
output  [31:0] out_r_TDATA;
output   out_r_TVALID;
input   out_r_TREADY;

 reg    ap_rst_n_inv;
reg   [31:0] in1_0_data_out;
wire    in1_0_vld_in;
wire    in1_0_vld_out;
wire    in1_0_ack_in;
reg    in1_0_ack_out;
reg   [31:0] in1_0_payload_A;
reg   [31:0] in1_0_payload_B;
reg    in1_0_sel_rd;
reg    in1_0_sel_wr;
wire    in1_0_sel;
wire    in1_0_load_A;
wire    in1_0_load_B;
reg   [1:0] in1_0_state;
wire    in1_0_state_cmp_full;
reg   [31:0] in2_0_data_out;
wire    in2_0_vld_in;
wire    in2_0_vld_out;
wire    in2_0_ack_in;
reg    in2_0_ack_out;
reg   [31:0] in2_0_payload_A;
reg   [31:0] in2_0_payload_B;
reg    in2_0_sel_rd;
reg    in2_0_sel_wr;
wire    in2_0_sel;
wire    in2_0_load_A;
wire    in2_0_load_B;
reg   [1:0] in2_0_state;
wire    in2_0_state_cmp_full;
reg   [31:0] out_r_1_data_out;
wire    out_r_1_vld_in;
wire    out_r_1_vld_out;
wire    out_r_1_ack_in;
wire    out_r_1_ack_out;
reg   [31:0] out_r_1_payload_A;
reg   [31:0] out_r_1_payload_B;
reg    out_r_1_sel_rd;
reg    out_r_1_sel_wr;
wire    out_r_1_sel;
wire    out_r_1_load_A;
wire    out_r_1_load_B;
reg   [1:0] out_r_1_state;
wire    out_r_1_state_cmp_full;
wire    grp_exec_fu_28_ap_start;
wire    grp_exec_fu_28_ap_done;
wire    grp_exec_fu_28_ap_idle;
wire    grp_exec_fu_28_ap_ready;
wire    grp_exec_fu_28_in1_TVALID;
wire    grp_exec_fu_28_in1_TREADY;
wire    grp_exec_fu_28_in2_TVALID;
wire    grp_exec_fu_28_in2_TREADY;
wire   [31:0] grp_exec_fu_28_out_r_TDATA;
wire    grp_exec_fu_28_out_r_TVALID;
wire    grp_exec_fu_28_out_r_TREADY;
reg    grp_exec_fu_28_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
reg    ap_block_state4;

// power-on initialization
initial begin
#0 in1_0_sel_rd = 1'b0;
#0 in1_0_sel_wr = 1'b0;
#0 in1_0_state = 2'd0;
#0 in2_0_sel_rd = 1'b0;
#0 in2_0_sel_wr = 1'b0;
#0 in2_0_state = 2'd0;
#0 out_r_1_sel_rd = 1'b0;
#0 out_r_1_sel_wr = 1'b0;
#0 out_r_1_state = 2'd0;
#0 grp_exec_fu_28_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

exec grp_exec_fu_28(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_exec_fu_28_ap_start),
    .ap_done(grp_exec_fu_28_ap_done),
    .ap_idle(grp_exec_fu_28_ap_idle),
    .ap_ready(grp_exec_fu_28_ap_ready),
    .in1_TDATA(in1_0_data_out),
    .in1_TVALID(grp_exec_fu_28_in1_TVALID),
    .in1_TREADY(grp_exec_fu_28_in1_TREADY),
    .in2_TDATA(in2_0_data_out),
    .in2_TVALID(grp_exec_fu_28_in2_TVALID),
    .in2_TREADY(grp_exec_fu_28_in2_TREADY),
    .out_r_TDATA(grp_exec_fu_28_out_r_TDATA),
    .out_r_TVALID(grp_exec_fu_28_out_r_TVALID),
    .out_r_TREADY(grp_exec_fu_28_out_r_TREADY)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_exec_fu_28_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_exec_fu_28_ap_start_reg <= 1'b1;
        end else if ((grp_exec_fu_28_ap_ready == 1'b1)) begin
            grp_exec_fu_28_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        in1_0_sel_rd <= 1'b0;
    end else begin
        if (((in1_0_ack_out == 1'b1) & (in1_0_vld_out == 1'b1))) begin
            in1_0_sel_rd <= ~in1_0_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        in1_0_sel_wr <= 1'b0;
    end else begin
        if (((in1_0_ack_in == 1'b1) & (in1_0_vld_in == 1'b1))) begin
            in1_0_sel_wr <= ~in1_0_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        in1_0_state <= 2'd0;
    end else begin
        if ((((in1_0_vld_in == 1'b0) & (in1_0_state == 2'd2)) | ((in1_0_vld_in == 1'b0) & (in1_0_state == 2'd3) & (in1_0_ack_out == 1'b1)))) begin
            in1_0_state <= 2'd2;
        end else if ((((in1_0_ack_out == 1'b0) & (in1_0_state == 2'd1)) | ((in1_0_ack_out == 1'b0) & (in1_0_state == 2'd3) & (in1_0_vld_in == 1'b1)))) begin
            in1_0_state <= 2'd1;
        end else if (((~((in1_0_vld_in == 1'b0) & (in1_0_ack_out == 1'b1)) & ~((in1_0_ack_out == 1'b0) & (in1_0_vld_in == 1'b1)) & (in1_0_state == 2'd3)) | ((in1_0_state == 2'd1) & (in1_0_ack_out == 1'b1)) | ((in1_0_state == 2'd2) & (in1_0_vld_in == 1'b1)))) begin
            in1_0_state <= 2'd3;
        end else begin
            in1_0_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        in2_0_sel_rd <= 1'b0;
    end else begin
        if (((in2_0_ack_out == 1'b1) & (in2_0_vld_out == 1'b1))) begin
            in2_0_sel_rd <= ~in2_0_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        in2_0_sel_wr <= 1'b0;
    end else begin
        if (((in2_0_ack_in == 1'b1) & (in2_0_vld_in == 1'b1))) begin
            in2_0_sel_wr <= ~in2_0_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        in2_0_state <= 2'd0;
    end else begin
        if ((((in2_0_state == 2'd2) & (in2_0_vld_in == 1'b0)) | ((in2_0_state == 2'd3) & (in2_0_vld_in == 1'b0) & (in2_0_ack_out == 1'b1)))) begin
            in2_0_state <= 2'd2;
        end else if ((((in2_0_state == 2'd1) & (in2_0_ack_out == 1'b0)) | ((in2_0_state == 2'd3) & (in2_0_ack_out == 1'b0) & (in2_0_vld_in == 1'b1)))) begin
            in2_0_state <= 2'd1;
        end else if (((~((in2_0_vld_in == 1'b0) & (in2_0_ack_out == 1'b1)) & ~((in2_0_ack_out == 1'b0) & (in2_0_vld_in == 1'b1)) & (in2_0_state == 2'd3)) | ((in2_0_state == 2'd1) & (in2_0_ack_out == 1'b1)) | ((in2_0_state == 2'd2) & (in2_0_vld_in == 1'b1)))) begin
            in2_0_state <= 2'd3;
        end else begin
            in2_0_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        out_r_1_sel_rd <= 1'b0;
    end else begin
        if (((out_r_1_ack_out == 1'b1) & (out_r_1_vld_out == 1'b1))) begin
            out_r_1_sel_rd <= ~out_r_1_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        out_r_1_sel_wr <= 1'b0;
    end else begin
        if (((out_r_1_ack_in == 1'b1) & (out_r_1_vld_in == 1'b1))) begin
            out_r_1_sel_wr <= ~out_r_1_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        out_r_1_state <= 2'd0;
    end else begin
        if ((((out_r_1_state == 2'd2) & (out_r_1_vld_in == 1'b0)) | ((out_r_1_state == 2'd3) & (out_r_1_vld_in == 1'b0) & (out_r_1_ack_out == 1'b1)))) begin
            out_r_1_state <= 2'd2;
        end else if ((((out_r_1_state == 2'd1) & (out_r_TREADY == 1'b0)) | ((out_r_1_state == 2'd3) & (out_r_TREADY == 1'b0) & (out_r_1_vld_in == 1'b1)))) begin
            out_r_1_state <= 2'd1;
        end else if (((~((out_r_1_vld_in == 1'b0) & (out_r_1_ack_out == 1'b1)) & ~((out_r_TREADY == 1'b0) & (out_r_1_vld_in == 1'b1)) & (out_r_1_state == 2'd3)) | ((out_r_1_state == 2'd1) & (out_r_1_ack_out == 1'b1)) | ((out_r_1_state == 2'd2) & (out_r_1_vld_in == 1'b1)))) begin
            out_r_1_state <= 2'd3;
        end else begin
            out_r_1_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((in1_0_load_A == 1'b1)) begin
        in1_0_payload_A <= in1_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if ((in1_0_load_B == 1'b1)) begin
        in1_0_payload_B <= in1_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if ((in2_0_load_A == 1'b1)) begin
        in2_0_payload_A <= in2_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if ((in2_0_load_B == 1'b1)) begin
        in2_0_payload_B <= in2_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if ((out_r_1_load_A == 1'b1)) begin
        out_r_1_payload_A <= grp_exec_fu_28_out_r_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if ((out_r_1_load_B == 1'b1)) begin
        out_r_1_payload_B <= grp_exec_fu_28_out_r_TDATA;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in1_0_ack_out = grp_exec_fu_28_in1_TREADY;
    end else begin
        in1_0_ack_out = 1'b0;
    end
end

always @ (*) begin
    if ((in1_0_sel == 1'b1)) begin
        in1_0_data_out = in1_0_payload_B;
    end else begin
        in1_0_data_out = in1_0_payload_A;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in2_0_ack_out = grp_exec_fu_28_in2_TREADY;
    end else begin
        in2_0_ack_out = 1'b0;
    end
end

always @ (*) begin
    if ((in2_0_sel == 1'b1)) begin
        in2_0_data_out = in2_0_payload_B;
    end else begin
        in2_0_data_out = in2_0_payload_A;
    end
end

always @ (*) begin
    if ((out_r_1_sel == 1'b1)) begin
        out_r_1_data_out = out_r_1_payload_B;
    end else begin
        out_r_1_data_out = out_r_1_payload_A;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_exec_fu_28_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if ((~((out_r_1_state == 2'd1) | ((out_r_1_state == 2'd3) & (out_r_TREADY == 1'b0))) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_block_state4 = ((out_r_1_state == 2'd1) | ((out_r_1_state == 2'd3) & (out_r_TREADY == 1'b0)));
end

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_exec_fu_28_ap_start = grp_exec_fu_28_ap_start_reg;

assign grp_exec_fu_28_in1_TVALID = in1_0_state[1'd0];

assign grp_exec_fu_28_in2_TVALID = in2_0_state[1'd0];

assign grp_exec_fu_28_out_r_TREADY = (out_r_1_ack_in & ap_CS_fsm_state3);

assign in1_0_ack_in = in1_0_state[1'd1];

assign in1_0_load_A = (in1_0_state_cmp_full & ~in1_0_sel_wr);

assign in1_0_load_B = (in1_0_state_cmp_full & in1_0_sel_wr);

assign in1_0_sel = in1_0_sel_rd;

assign in1_0_state_cmp_full = ((in1_0_state != 2'd1) ? 1'b1 : 1'b0);

assign in1_0_vld_in = in1_TVALID;

assign in1_0_vld_out = in1_0_state[1'd0];

assign in1_TREADY = in1_0_state[1'd1];

assign in2_0_ack_in = in2_0_state[1'd1];

assign in2_0_load_A = (in2_0_state_cmp_full & ~in2_0_sel_wr);

assign in2_0_load_B = (in2_0_state_cmp_full & in2_0_sel_wr);

assign in2_0_sel = in2_0_sel_rd;

assign in2_0_state_cmp_full = ((in2_0_state != 2'd1) ? 1'b1 : 1'b0);

assign in2_0_vld_in = in2_TVALID;

assign in2_0_vld_out = in2_0_state[1'd0];

assign in2_TREADY = in2_0_state[1'd1];

assign out_r_1_ack_in = out_r_1_state[1'd1];

assign out_r_1_ack_out = out_r_TREADY;

assign out_r_1_load_A = (out_r_1_state_cmp_full & ~out_r_1_sel_wr);

assign out_r_1_load_B = (out_r_1_state_cmp_full & out_r_1_sel_wr);

assign out_r_1_sel = out_r_1_sel_rd;

assign out_r_1_state_cmp_full = ((out_r_1_state != 2'd1) ? 1'b1 : 1'b0);

assign out_r_1_vld_in = grp_exec_fu_28_out_r_TVALID;

assign out_r_1_vld_out = out_r_1_state[1'd0];

assign out_r_TDATA = out_r_1_data_out;

assign out_r_TVALID = out_r_1_state[1'd0];

endmodule //mmult_hw
