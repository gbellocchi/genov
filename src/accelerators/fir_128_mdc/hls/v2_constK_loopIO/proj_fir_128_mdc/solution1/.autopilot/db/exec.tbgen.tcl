set moduleName exec
set isTopModule 0
set isTaskLevelControl 1
set isCombinational 0
set isDatapathOnly 1
set isFreeRunPipelineModule 0
set isPipelined 1
set pipeline_type function
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {exec}
set C_modelType { int 192 }
set C_modelArgList {
	{ systolic_ap_int_32_ap_int_32_ap_int_32_x_V_read int 32 regular  }
	{ systolic_ap_int_32_ap_int_32_ap_int_32_x1_V_read int 32 regular  }
	{ systolic_ap_int_32_ap_int_32_ap_int_32_y0_V_read int 32 regular  }
	{ systolic_ap_int_32_ap_int_32_ap_int_32_y1_V_read int 32 regular  }
	{ x_in_V_read int 32 regular  }
	{ h_V_read int 5 regular  }
	{ y_in_V_read int 32 regular  }
}
set C_modelArgMapList {[ 
	{ "Name" : "systolic_ap_int_32_ap_int_32_ap_int_32_x_V_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "systolic_ap_int_32_ap_int_32_ap_int_32_x1_V_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "systolic_ap_int_32_ap_int_32_ap_int_32_y0_V_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "systolic_ap_int_32_ap_int_32_ap_int_32_y1_V_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "x_in_V_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "h_V_read", "interface" : "wire", "bitwidth" : 5, "direction" : "READONLY"} , 
 	{ "Name" : "y_in_V_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 192} ]}
# RTL Port declarations: 
set portNum 16
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ systolic_ap_int_32_ap_int_32_ap_int_32_x_V_read sc_in sc_lv 32 signal 0 } 
	{ systolic_ap_int_32_ap_int_32_ap_int_32_x1_V_read sc_in sc_lv 32 signal 1 } 
	{ systolic_ap_int_32_ap_int_32_ap_int_32_y0_V_read sc_in sc_lv 32 signal 2 } 
	{ systolic_ap_int_32_ap_int_32_ap_int_32_y1_V_read sc_in sc_lv 32 signal 3 } 
	{ x_in_V_read sc_in sc_lv 32 signal 4 } 
	{ h_V_read sc_in sc_lv 5 signal 5 } 
	{ y_in_V_read sc_in sc_lv 32 signal 6 } 
	{ ap_return_0 sc_out sc_lv 32 signal -1 } 
	{ ap_return_1 sc_out sc_lv 32 signal -1 } 
	{ ap_return_2 sc_out sc_lv 32 signal -1 } 
	{ ap_return_3 sc_out sc_lv 32 signal -1 } 
	{ ap_return_4 sc_out sc_lv 32 signal -1 } 
	{ ap_return_5 sc_out sc_lv 32 signal -1 } 
	{ ap_ce sc_in sc_logic 1 ce -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "systolic_ap_int_32_ap_int_32_ap_int_32_x_V_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "systolic_ap_int_32_ap_int_32_ap_int_32_x_V_read", "role": "default" }} , 
 	{ "name": "systolic_ap_int_32_ap_int_32_ap_int_32_x1_V_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "systolic_ap_int_32_ap_int_32_ap_int_32_x1_V_read", "role": "default" }} , 
 	{ "name": "systolic_ap_int_32_ap_int_32_ap_int_32_y0_V_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "systolic_ap_int_32_ap_int_32_ap_int_32_y0_V_read", "role": "default" }} , 
 	{ "name": "systolic_ap_int_32_ap_int_32_ap_int_32_y1_V_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "systolic_ap_int_32_ap_int_32_ap_int_32_y1_V_read", "role": "default" }} , 
 	{ "name": "x_in_V_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x_in_V_read", "role": "default" }} , 
 	{ "name": "h_V_read", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "h_V_read", "role": "default" }} , 
 	{ "name": "y_in_V_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_in_V_read", "role": "default" }} , 
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }} , 
 	{ "name": "ap_return_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_2", "role": "default" }} , 
 	{ "name": "ap_return_3", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_3", "role": "default" }} , 
 	{ "name": "ap_return_4", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_4", "role": "default" }} , 
 	{ "name": "ap_return_5", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_5", "role": "default" }} , 
 	{ "name": "ap_ce", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "ce", "bundle":{"name": "ap_ce", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "exec",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "0", "ap_start" : "0", "ap_ready" : "0", "ap_done" : "0", "ap_continue" : "0", "ap_idle" : "0",
		"Pipeline" : "Aligned", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "1", "EstimateLatencyMin" : "1", "EstimateLatencyMax" : "1",
		"Combinational" : "0",
		"Datapath" : "1",
		"ClockEnable" : "1",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "systolic_ap_int_32_ap_int_32_ap_int_32_x_V_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "systolic_ap_int_32_ap_int_32_ap_int_32_x1_V_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "systolic_ap_int_32_ap_int_32_ap_int_32_y0_V_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "systolic_ap_int_32_ap_int_32_ap_int_32_y1_V_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "x_in_V_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "h_V_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_in_V_read", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fir_128_mdc_mul_5bkb_U1", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	exec {
		systolic_ap_int_32_ap_int_32_ap_int_32_x_V_read {Type I LastRead 0 FirstWrite -1}
		systolic_ap_int_32_ap_int_32_ap_int_32_x1_V_read {Type I LastRead 0 FirstWrite -1}
		systolic_ap_int_32_ap_int_32_ap_int_32_y0_V_read {Type I LastRead 0 FirstWrite -1}
		systolic_ap_int_32_ap_int_32_ap_int_32_y1_V_read {Type I LastRead 0 FirstWrite -1}
		x_in_V_read {Type I LastRead 0 FirstWrite -1}
		h_V_read {Type I LastRead 0 FirstWrite -1}
		y_in_V_read {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "1"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	systolic_ap_int_32_ap_int_32_ap_int_32_x_V_read { ap_none {  { systolic_ap_int_32_ap_int_32_ap_int_32_x_V_read in_data 0 32 } } }
	systolic_ap_int_32_ap_int_32_ap_int_32_x1_V_read { ap_none {  { systolic_ap_int_32_ap_int_32_ap_int_32_x1_V_read in_data 0 32 } } }
	systolic_ap_int_32_ap_int_32_ap_int_32_y0_V_read { ap_none {  { systolic_ap_int_32_ap_int_32_ap_int_32_y0_V_read in_data 0 32 } } }
	systolic_ap_int_32_ap_int_32_ap_int_32_y1_V_read { ap_none {  { systolic_ap_int_32_ap_int_32_ap_int_32_y1_V_read in_data 0 32 } } }
	x_in_V_read { ap_none {  { x_in_V_read in_data 0 32 } } }
	h_V_read { ap_none {  { h_V_read in_data 0 5 } } }
	y_in_V_read { ap_none {  { y_in_V_read in_data 0 32 } } }
}
