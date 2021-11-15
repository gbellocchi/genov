// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="traffic_gen,hls_ip_2019_2_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu9eg-ffvb1156-2-e,HLS_INPUT_CLOCK=6.660000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=1.237000,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=4,HLS_SYN_DSP=0,HLS_SYN_FF=46,HLS_SYN_LUT=209,HLS_VERSION=2019_2_1}" *)

module traffic_gen (
        ap_clk,
        ap_rst_n,
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
        n_trans,
        prob_req
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
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
input  [31:0] prob_req;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg stream_in_V_TREADY;

 reg    ap_rst_n_inv;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire    ap_CS_fsm_state2;
wire    grp_generate_req_fu_36_ap_start;
wire    grp_generate_req_fu_36_ap_done;
wire    grp_generate_req_fu_36_ap_idle;
wire    grp_generate_req_fu_36_ap_ready;
wire    grp_generate_req_fu_36_stream_in_V_TREADY;
wire   [31:0] grp_generate_req_fu_36_stream_out_V_TDATA;
wire    grp_generate_req_fu_36_stream_out_V_TVALID;
wire    grp_generate_req_fu_36_stream_out_V_TREADY;
reg    grp_generate_req_fu_36_ap_start_reg;
wire    ap_CS_fsm_state3;
wire    ap_CS_fsm_state4;
wire    regslice_both_stream_out_V_U_apdone_blk;
reg   [3:0] ap_NS_fsm;
wire    regslice_both_stream_in_V_U_apdone_blk;
wire   [31:0] stream_in_V_TDATA_int;
wire    stream_in_V_TVALID_int;
reg    stream_in_V_TREADY_int;
wire    regslice_both_stream_in_V_U_ack_in;
wire    stream_out_V_TREADY_int;
wire    regslice_both_stream_out_V_U_vld_out;

// power-on initialization
initial begin
#0 ap_CS_fsm = 4'd1;
#0 grp_generate_req_fu_36_ap_start_reg = 1'b0;
end

generate_req grp_generate_req_fu_36(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_generate_req_fu_36_ap_start),
    .ap_done(grp_generate_req_fu_36_ap_done),
    .ap_idle(grp_generate_req_fu_36_ap_idle),
    .ap_ready(grp_generate_req_fu_36_ap_ready),
    .stream_in_V_TDATA(stream_in_V_TDATA_int),
    .stream_in_V_TVALID(stream_in_V_TVALID_int),
    .stream_in_V_TREADY(grp_generate_req_fu_36_stream_in_V_TREADY),
    .stream_out_V_TDATA(grp_generate_req_fu_36_stream_out_V_TDATA),
    .stream_out_V_TVALID(grp_generate_req_fu_36_stream_out_V_TVALID),
    .stream_out_V_TREADY(grp_generate_req_fu_36_stream_out_V_TREADY),
    .n_trans(n_trans)
);

regslice_both #(
    .DataWidth( 32 ))
regslice_both_stream_in_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(stream_in_V_TDATA),
    .vld_in(stream_in_V_TVALID),
    .ack_in(regslice_both_stream_in_V_U_ack_in),
    .data_out(stream_in_V_TDATA_int),
    .vld_out(stream_in_V_TVALID_int),
    .ack_out(stream_in_V_TREADY_int),
    .apdone_blk(regslice_both_stream_in_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 32 ))
regslice_both_stream_out_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_generate_req_fu_36_stream_out_V_TDATA),
    .vld_in(grp_generate_req_fu_36_stream_out_V_TVALID),
    .ack_in(stream_out_V_TREADY_int),
    .data_out(stream_out_V_TDATA),
    .vld_out(regslice_both_stream_out_V_U_vld_out),
    .ack_out(stream_out_V_TREADY),
    .apdone_blk(regslice_both_stream_out_V_U_apdone_blk)
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
        grp_generate_req_fu_36_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_generate_req_fu_36_ap_start_reg <= 1'b1;
        end else if ((grp_generate_req_fu_36_ap_ready == 1'b1)) begin
            grp_generate_req_fu_36_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_stream_out_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
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
    if (((regslice_both_stream_out_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((regslice_both_stream_in_V_U_ack_in == 1'b1) & (stream_in_V_TVALID == 1'b1))) begin
        stream_in_V_TREADY = 1'b1;
    end else begin
        stream_in_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        stream_in_V_TREADY_int = grp_generate_req_fu_36_stream_in_V_TREADY;
    end else begin
        stream_in_V_TREADY_int = 1'b0;
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
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_generate_req_fu_36_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_stream_out_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
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

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_generate_req_fu_36_ap_start = grp_generate_req_fu_36_ap_start_reg;

assign grp_generate_req_fu_36_stream_out_V_TREADY = (stream_out_V_TREADY_int & ap_CS_fsm_state3);

assign stream_out_V_TVALID = regslice_both_stream_out_V_U_vld_out;

endmodule //traffic_gen