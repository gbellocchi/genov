// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="FIR,hls_ip_2019_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xczu9eg-ffvb1156-2-e,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=4.436000,HLS_SYN_LAT=3,HLS_SYN_TPT=4,HLS_SYN_MEM=0,HLS_SYN_DSP=12,HLS_SYN_FF=742,HLS_SYN_LUT=264,HLS_VERSION=2019_2}" *)

module FIR (
        ap_clk,
        ap_rst_n,
        x_V_TDATA,
        x_V_TVALID,
        x_V_TREADY,
        coeff0_V,
        coeff1_V,
        coeff2_V,
        coeff3_V,
        y_V_TDATA,
        y_V_TVALID,
        y_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [31:0] x_V_TDATA;
input   x_V_TVALID;
output   x_V_TREADY;
input  [31:0] coeff0_V;
input  [31:0] coeff1_V;
input  [31:0] coeff2_V;
input  [31:0] coeff3_V;
output  [31:0] y_V_TDATA;
output   y_V_TVALID;
input   y_V_TREADY;

reg x_V_TREADY;

 reg    ap_rst_n_inv;
reg   [0:0] guard_variable_for_F;
reg   [31:0] h_V_0;
reg   [31:0] h_V_1;
reg   [31:0] h_V_2;
reg   [31:0] h_V_3;
reg   [31:0] s_x_V_1;
reg   [31:0] s_x1_V_1;
reg   [31:0] s_y0_V_1;
reg   [31:0] s_y1_V_1;
reg   [31:0] s_x_V_2;
reg   [31:0] s_x1_V_2;
reg   [31:0] s_y0_V_2;
reg   [31:0] s_y1_V_2;
reg   [31:0] s_x_V_3;
reg   [31:0] s_x1_V_3;
reg   [31:0] s_y0_V_3;
reg   [31:0] s_y1_V_3;
wire    call_ret_exec_1_fu_117_x_in_V_TDATA_blk_n;
reg    x_V_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state4;
reg    y_V_TDATA_blk_n;
wire    ap_CS_fsm_state3;
wire   [0:0] guard_variable_for_F_1_load_fu_132_p1;
wire    ap_CS_fsm_state1;
reg  signed [31:0] s_x1_V_1_load_reg_349;
wire    ap_CS_fsm_state2;
wire   [31:0] mul_ln68_fu_174_p2;
reg   [31:0] mul_ln68_reg_354;
reg  signed [31:0] s_x1_V_2_load_reg_359;
reg    call_ret_exec_1_fu_117_ap_start;
wire    call_ret_exec_1_fu_117_ap_done;
wire    call_ret_exec_1_fu_117_ap_idle;
wire    call_ret_exec_1_fu_117_ap_ready;
wire    call_ret_exec_1_fu_117_x_in_V_TREADY;
wire   [31:0] call_ret_exec_1_fu_117_ap_return_0;
wire   [31:0] call_ret_exec_1_fu_117_ap_return_1;
reg    call_ret_exec_1_fu_117_ap_ce;
wire    regslice_both_y_V_U_apdone_blk;
reg    ap_block_state4;
wire   [31:0] add_ln68_fu_281_p2;
wire   [31:0] mul_ln68_1_fu_210_p2;
wire   [31:0] add_ln68_1_fu_204_p2;
wire   [31:0] mul_ln68_2_fu_322_p2;
wire   [31:0] add_ln68_2_fu_248_p2;
wire  signed [31:0] mul_ln68_fu_174_p0;
wire  signed [31:0] mul_ln68_fu_174_p1;
wire  signed [31:0] mul_ln68_1_fu_210_p0;
wire  signed [31:0] mul_ln68_1_fu_210_p1;
wire  signed [31:0] mul_ln68_2_fu_322_p0;
wire  signed [31:0] mul_ln68_2_fu_322_p1;
reg   [3:0] ap_NS_fsm;
wire    regslice_both_x_V_U_apdone_blk;
wire   [31:0] x_V_TDATA_int;
wire    x_V_TVALID_int;
reg    x_V_TREADY_int;
wire    regslice_both_x_V_U_ack_in;
reg    y_V_TVALID_int;
wire    y_V_TREADY_int;
wire    regslice_both_y_V_U_vld_out;

// power-on initialization
initial begin
#0 guard_variable_for_F = 1'd0;
#0 h_V_0 = 32'd0;
#0 h_V_1 = 32'd0;
#0 h_V_2 = 32'd0;
#0 h_V_3 = 32'd0;
#0 s_x_V_1 = 32'd0;
#0 s_x1_V_1 = 32'd0;
#0 s_y0_V_1 = 32'd0;
#0 s_y1_V_1 = 32'd0;
#0 s_x_V_2 = 32'd0;
#0 s_x1_V_2 = 32'd0;
#0 s_y0_V_2 = 32'd0;
#0 s_y1_V_2 = 32'd0;
#0 s_x_V_3 = 32'd0;
#0 s_x1_V_3 = 32'd0;
#0 s_y0_V_3 = 32'd0;
#0 s_y1_V_3 = 32'd0;
#0 ap_CS_fsm = 4'd1;
end

exec_1 call_ret_exec_1_fu_117(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(call_ret_exec_1_fu_117_ap_start),
    .ap_done(call_ret_exec_1_fu_117_ap_done),
    .ap_idle(call_ret_exec_1_fu_117_ap_idle),
    .ap_ready(call_ret_exec_1_fu_117_ap_ready),
    .x_in_V_TDATA(x_V_TDATA_int),
    .x_in_V_TVALID(x_V_TVALID_int),
    .x_in_V_TREADY(call_ret_exec_1_fu_117_x_in_V_TREADY),
    .h_0_V_read(h_V_0),
    .ap_return_0(call_ret_exec_1_fu_117_ap_return_0),
    .ap_return_1(call_ret_exec_1_fu_117_ap_return_1),
    .x_in_V_TDATA_blk_n(call_ret_exec_1_fu_117_x_in_V_TDATA_blk_n),
    .ap_ce(call_ret_exec_1_fu_117_ap_ce)
);

regslice_both #(
    .DataWidth( 32 ))
regslice_both_x_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(x_V_TDATA),
    .vld_in(x_V_TVALID),
    .ack_in(regslice_both_x_V_U_ack_in),
    .data_out(x_V_TDATA_int),
    .vld_out(x_V_TVALID_int),
    .ack_out(x_V_TREADY_int),
    .apdone_blk(regslice_both_x_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 32 ))
regslice_both_y_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(s_y1_V_3),
    .vld_in(y_V_TVALID_int),
    .ack_in(y_V_TREADY_int),
    .data_out(y_V_TDATA),
    .vld_out(regslice_both_y_V_U_vld_out),
    .ack_out(y_V_TREADY),
    .apdone_blk(regslice_both_y_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (((guard_variable_for_F_1_load_fu_132_p1 == 1'd0) & (1'b1 == ap_CS_fsm_state1))) begin
        guard_variable_for_F <= 1'd1;
        h_V_0 <= coeff0_V;
        h_V_1 <= coeff1_V;
        h_V_2 <= coeff2_V;
        h_V_3 <= coeff3_V;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        mul_ln68_reg_354 <= mul_ln68_fu_174_p2;
        s_x1_V_1_load_reg_349 <= s_x1_V_1;
    end
end

always @ (posedge ap_clk) begin
    if ((~((call_ret_exec_1_fu_117_x_in_V_TDATA_blk_n == 1'b0) | (y_V_TREADY_int == 1'b0) | (regslice_both_y_V_U_apdone_blk == 1'b1)) & (1'b1 == ap_CS_fsm_state4))) begin
        s_x1_V_1 <= s_x_V_1;
        s_x1_V_3 <= s_x_V_3;
        s_x_V_1 <= call_ret_exec_1_fu_117_ap_return_0;
        s_x_V_3 <= s_x1_V_2_load_reg_359;
        s_y0_V_1 <= mul_ln68_reg_354;
        s_y0_V_3 <= mul_ln68_2_fu_322_p2;
        s_y1_V_1 <= add_ln68_fu_281_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((y_V_TREADY_int == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
        s_x1_V_2 <= s_x_V_2;
        s_x1_V_2_load_reg_359 <= s_x1_V_2;
        s_x_V_2 <= s_x1_V_1_load_reg_349;
        s_y0_V_2 <= mul_ln68_1_fu_210_p2;
        s_y1_V_2 <= add_ln68_1_fu_204_p2;
        s_y1_V_3 <= add_ln68_2_fu_248_p2;
    end
end

always @ (*) begin
    if ((~((y_V_TREADY_int == 1'b0) | (regslice_both_y_V_U_apdone_blk == 1'b1)) & (1'b1 == ap_CS_fsm_state4))) begin
        call_ret_exec_1_fu_117_ap_ce = 1'b1;
    end else begin
        call_ret_exec_1_fu_117_ap_ce = 1'b0;
    end
end

always @ (*) begin
    if ((~((y_V_TREADY_int == 1'b0) | (regslice_both_y_V_U_apdone_blk == 1'b1)) & (1'b1 == ap_CS_fsm_state4))) begin
        call_ret_exec_1_fu_117_ap_start = 1'b1;
    end else begin
        call_ret_exec_1_fu_117_ap_start = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        x_V_TDATA_blk_n = call_ret_exec_1_fu_117_x_in_V_TDATA_blk_n;
    end else begin
        x_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((regslice_both_x_V_U_ack_in == 1'b1) & (x_V_TVALID == 1'b1))) begin
        x_V_TREADY = 1'b1;
    end else begin
        x_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        x_V_TREADY_int = call_ret_exec_1_fu_117_x_in_V_TREADY;
    end else begin
        x_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state3) | (1'b1 == ap_CS_fsm_state4))) begin
        y_V_TDATA_blk_n = y_V_TREADY_int;
    end else begin
        y_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((y_V_TREADY_int == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
        y_V_TVALID_int = 1'b1;
    end else begin
        y_V_TVALID_int = 1'b0;
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
            if (((y_V_TREADY_int == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if ((~((call_ret_exec_1_fu_117_x_in_V_TDATA_blk_n == 1'b0) | (y_V_TREADY_int == 1'b0) | (regslice_both_y_V_U_apdone_blk == 1'b1)) & (1'b1 == ap_CS_fsm_state4))) begin
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

assign add_ln68_1_fu_204_p2 = (s_y0_V_2 + s_y1_V_1);

assign add_ln68_2_fu_248_p2 = (s_y0_V_3 + s_y1_V_2);

assign add_ln68_fu_281_p2 = (s_y0_V_1 + call_ret_exec_1_fu_117_ap_return_1);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_block_state4 = ((call_ret_exec_1_fu_117_x_in_V_TDATA_blk_n == 1'b0) | (regslice_both_y_V_U_apdone_blk == 1'b1));
end

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign guard_variable_for_F_1_load_fu_132_p1 = guard_variable_for_F;

assign mul_ln68_1_fu_210_p0 = s_x1_V_2;

assign mul_ln68_1_fu_210_p1 = h_V_2;

assign mul_ln68_1_fu_210_p2 = ($signed(mul_ln68_1_fu_210_p0) * $signed(mul_ln68_1_fu_210_p1));

assign mul_ln68_2_fu_322_p0 = s_x1_V_3;

assign mul_ln68_2_fu_322_p1 = h_V_3;

assign mul_ln68_2_fu_322_p2 = ($signed(mul_ln68_2_fu_322_p0) * $signed(mul_ln68_2_fu_322_p1));

assign mul_ln68_fu_174_p0 = s_x1_V_1;

assign mul_ln68_fu_174_p1 = h_V_1;

assign mul_ln68_fu_174_p2 = ($signed(mul_ln68_fu_174_p0) * $signed(mul_ln68_fu_174_p1));

assign y_V_TVALID = regslice_both_y_V_U_vld_out;

endmodule //FIR