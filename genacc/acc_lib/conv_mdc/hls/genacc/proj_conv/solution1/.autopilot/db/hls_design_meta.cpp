#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("width", 32, hls_in, 0, "ap_none", "in_data", 1),
	Port_Property("height", 32, hls_in, 1, "ap_none", "in_data", 1),
	Port_Property("src_V_TDATA", 32, hls_in, 2, "axis", "in_data", 1),
	Port_Property("dst_V_TDATA", 32, hls_out, 3, "axis", "out_data", 1),
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst_n", 1, hls_in, -1, "", "", 1),
	Port_Property("src_V_TVALID", 1, hls_in, 2, "axis", "in_vld", 1),
	Port_Property("src_V_TREADY", 1, hls_out, 2, "axis", "in_acc", 1),
	Port_Property("dst_V_TVALID", 1, hls_out, 3, "axis", "out_vld", 1),
	Port_Property("dst_V_TREADY", 1, hls_in, 3, "axis", "out_acc", 1),
};
const char* HLS_Design_Meta::dut_name = "conv_mdc";
