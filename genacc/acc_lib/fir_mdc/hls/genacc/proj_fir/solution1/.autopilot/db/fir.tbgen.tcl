set moduleName fir
set isTopModule 1
set isTaskLevelControl 1
set isCombinational 0
set isDatapathOnly 0
set isFreeRunPipelineModule 0
set isPipelined 0
set pipeline_type function
set FunctionProtocol ap_ctrl_none
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {fir}
set C_modelType { void 0 }
set C_modelArgList {
	{ x_V int 32 regular {axi_s 0 volatile  { x_V Data } }  }
	{ coeff_0_V int 32 regular {pointer 0}  }
	{ coeff_1_V int 32 regular {pointer 0}  }
	{ coeff_2_V int 32 regular {pointer 0}  }
	{ coeff_3_V int 32 regular {pointer 0}  }
	{ y_V int 32 regular {axi_s 1 ""  { y_V Data } }  }
}
set C_modelArgMapList {[ 
	{ "Name" : "x_V", "interface" : "axis", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "x.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}]} , 
 	{ "Name" : "coeff_0_V", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "coeff.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 2}]}]}]} , 
 	{ "Name" : "coeff_1_V", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "coeff.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 1,"up" : 1,"step" : 2}]}]}]} , 
 	{ "Name" : "coeff_2_V", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "coeff.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 2,"up" : 2,"step" : 2}]}]}]} , 
 	{ "Name" : "coeff_3_V", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "coeff.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 3,"up" : 3,"step" : 2}]}]}]} , 
 	{ "Name" : "y_V", "interface" : "axis", "bitwidth" : 32, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "y.V","cData": "int32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}]} ]}
# RTL Port declarations: 
set portNum 12
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ x_V_TDATA sc_in sc_lv 32 signal 0 } 
	{ x_V_TVALID sc_in sc_logic 1 invld 0 } 
	{ x_V_TREADY sc_out sc_logic 1 inacc 0 } 
	{ coeff_0_V sc_in sc_lv 32 signal 1 } 
	{ coeff_1_V sc_in sc_lv 32 signal 2 } 
	{ coeff_2_V sc_in sc_lv 32 signal 3 } 
	{ coeff_3_V sc_in sc_lv 32 signal 4 } 
	{ y_V_TDATA sc_out sc_lv 32 signal 5 } 
	{ y_V_TVALID sc_out sc_logic 1 outvld 5 } 
	{ y_V_TREADY sc_in sc_logic 1 outacc 5 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "x_V_TDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x_V", "role": "TDATA" }} , 
 	{ "name": "x_V_TVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "x_V", "role": "TVALID" }} , 
 	{ "name": "x_V_TREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "inacc", "bundle":{"name": "x_V", "role": "TREADY" }} , 
 	{ "name": "coeff_0_V", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "coeff_0_V", "role": "default" }} , 
 	{ "name": "coeff_1_V", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "coeff_1_V", "role": "default" }} , 
 	{ "name": "coeff_2_V", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "coeff_2_V", "role": "default" }} , 
 	{ "name": "coeff_3_V", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "coeff_3_V", "role": "default" }} , 
 	{ "name": "y_V_TDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_V", "role": "TDATA" }} , 
 	{ "name": "y_V_TVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "y_V", "role": "TVALID" }} , 
 	{ "name": "y_V_TREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "outacc", "bundle":{"name": "y_V", "role": "TREADY" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "3", "4", "5", "6", "7"],
		"CDFG" : "fir",
		"Protocol" : "ap_ctrl_none",
		"ControlExist" : "0", "ap_start" : "0", "ap_ready" : "0", "ap_done" : "0", "ap_continue" : "0", "ap_idle" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "4",
		"VariableLatency" : "0", "ExactLatency" : "3", "EstimateLatencyMin" : "3", "EstimateLatencyMax" : "3",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "x_V", "Type" : "Axis", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "x_V_TDATA_blk_n", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_exec_1_fu_105", "Port" : "x_in_V"}]},
			{"Name" : "coeff_0_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "coeff_1_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "coeff_2_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "coeff_3_V", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_V", "Type" : "Axis", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "y_V_TDATA_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "s_x1_V_0", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_exec_1_fu_105", "Port" : "s_x1_V_0"}]},
			{"Name" : "s_x_V_0", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_exec_1_fu_105", "Port" : "s_x_V_0"}]},
			{"Name" : "s_y1_V_0", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_exec_1_fu_105", "Port" : "s_y1_V_0"}]},
			{"Name" : "s_y0_V_0", "Type" : "OVld", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_exec_1_fu_105", "Port" : "s_y0_V_0"}]},
			{"Name" : "s_x_V_1", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_x1_V_1", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_y0_V_1", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_y1_V_1", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_x_V_2", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_x1_V_2", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_y0_V_2", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_y1_V_2", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_x_V_3", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_x1_V_3", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_y0_V_3", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_y1_V_3", "Type" : "OVld", "Direction" : "IO"}],
		"SubInstanceBlock" : [
			{"SubInstance" : "grp_exec_1_fu_105", "SubBlockPort" : ["x_in_V_TDATA_blk_n"]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_exec_1_fu_105", "Parent" : "0", "Child" : ["2"],
		"CDFG" : "exec_1",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "2",
		"VariableLatency" : "0", "ExactLatency" : "1", "EstimateLatencyMin" : "1", "EstimateLatencyMax" : "1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "1",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "x_in_V", "Type" : "Axis", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "x_in_V_TDATA_blk_n", "Type" : "RtlPort"}]},
			{"Name" : "h_0_V_read", "Type" : "None", "Direction" : "I"},
			{"Name" : "s_x1_V_0", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_x_V_0", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_y1_V_0", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "s_y0_V_0", "Type" : "OVld", "Direction" : "IO"}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_exec_1_fu_105.fir_mul_32s_32s_3bkb_U1", "Parent" : "1"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fir_mul_32s_32s_3bkb_U5", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fir_mul_32s_32s_3bkb_U6", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fir_mul_32s_32s_3bkb_U7", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.regslice_both_x_V_U", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.regslice_both_y_V_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	fir {
		x_V {Type I LastRead 1 FirstWrite -1}
		coeff_0_V {Type I LastRead 1 FirstWrite -1}
		coeff_1_V {Type I LastRead 0 FirstWrite -1}
		coeff_2_V {Type I LastRead 1 FirstWrite -1}
		coeff_3_V {Type I LastRead 2 FirstWrite -1}
		y_V {Type O LastRead -1 FirstWrite 2}
		s_x1_V_0 {Type IO LastRead -1 FirstWrite -1}
		s_x_V_0 {Type IO LastRead -1 FirstWrite -1}
		s_y1_V_0 {Type IO LastRead -1 FirstWrite -1}
		s_y0_V_0 {Type IO LastRead -1 FirstWrite -1}
		s_x_V_1 {Type IO LastRead -1 FirstWrite -1}
		s_x1_V_1 {Type IO LastRead -1 FirstWrite -1}
		s_y0_V_1 {Type IO LastRead -1 FirstWrite -1}
		s_y1_V_1 {Type IO LastRead -1 FirstWrite -1}
		s_x_V_2 {Type IO LastRead -1 FirstWrite -1}
		s_x1_V_2 {Type IO LastRead -1 FirstWrite -1}
		s_y0_V_2 {Type IO LastRead -1 FirstWrite -1}
		s_y1_V_2 {Type IO LastRead -1 FirstWrite -1}
		s_x_V_3 {Type IO LastRead -1 FirstWrite -1}
		s_x1_V_3 {Type IO LastRead -1 FirstWrite -1}
		s_y0_V_3 {Type IO LastRead -1 FirstWrite -1}
		s_y1_V_3 {Type IO LastRead -1 FirstWrite -1}}
	exec_1 {
		x_in_V {Type I LastRead 1 FirstWrite -1}
		h_0_V_read {Type I LastRead 0 FirstWrite -1}
		s_x1_V_0 {Type IO LastRead -1 FirstWrite -1}
		s_x_V_0 {Type IO LastRead -1 FirstWrite -1}
		s_y1_V_0 {Type IO LastRead -1 FirstWrite -1}
		s_y0_V_0 {Type IO LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "3", "Max" : "3"}
	, {"Name" : "Interval", "Min" : "4", "Max" : "4"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	x_V { axis {  { x_V_TDATA in_data 0 32 }  { x_V_TVALID in_vld 0 1 }  { x_V_TREADY in_acc 1 1 } } }
	coeff_0_V { ap_none {  { coeff_0_V in_data 0 32 } } }
	coeff_1_V { ap_none {  { coeff_1_V in_data 0 32 } } }
	coeff_2_V { ap_none {  { coeff_2_V in_data 0 32 } } }
	coeff_3_V { ap_none {  { coeff_3_V in_data 0 32 } } }
	y_V { axis {  { y_V_TDATA out_data 1 32 }  { y_V_TVALID out_vld 1 1 }  { y_V_TREADY out_acc 0 1 } } }
}

set busDeadlockParameterList { 
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
