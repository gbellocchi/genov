#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst_n", 1, hls_in, -1, "", "", 1),
	Port_Property("x_V_TDATA", 32, hls_in, 0, "axis", "in_data", 1),
	Port_Property("x_V_TVALID", 1, hls_in, 0, "axis", "in_vld", 1),
	Port_Property("x_V_TREADY", 1, hls_out, 0, "axis", "in_acc", 1),
	Port_Property("coeff_0_V", 32, hls_in, 1, "ap_none", "in_data", 1),
	Port_Property("coeff_1_V", 32, hls_in, 2, "ap_none", "in_data", 1),
	Port_Property("coeff_2_V", 32, hls_in, 3, "ap_none", "in_data", 1),
	Port_Property("coeff_3_V", 32, hls_in, 4, "ap_none", "in_data", 1),
	Port_Property("y_V_TDATA", 32, hls_out, 5, "axis", "out_data", 1),
	Port_Property("y_V_TVALID", 1, hls_out, 5, "axis", "out_vld", 1),
	Port_Property("y_V_TREADY", 1, hls_in, 5, "axis", "out_acc", 1),
};
const char* HLS_Design_Meta::dut_name = "fir";
