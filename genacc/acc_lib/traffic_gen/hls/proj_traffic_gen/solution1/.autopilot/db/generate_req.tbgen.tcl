set moduleName generate_req
set isTopModule 0
set isTaskLevelControl 1
set isCombinational 0
set isDatapathOnly 0
set isFreeRunPipelineModule 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {generate_req}
set C_modelType { void 0 }
set C_modelArgList {
	{ stream_in_V int 32 regular {axi_s 0 volatile  { stream_in_V Data } }  }
	{ stream_out_V int 32 regular {axi_s 1 volatile  { stream_out_V Data } }  }
	{ n_trans int 32 regular  }
}
set C_modelArgMapList {[ 
	{ "Name" : "stream_in_V", "interface" : "axis", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "stream_out_V", "interface" : "axis", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "n_trans", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 13
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ stream_in_V_TDATA sc_in sc_lv 32 signal 0 } 
	{ stream_in_V_TVALID sc_in sc_logic 1 invld 0 } 
	{ stream_in_V_TREADY sc_out sc_logic 1 inacc 0 } 
	{ stream_out_V_TDATA sc_out sc_lv 32 signal 1 } 
	{ stream_out_V_TVALID sc_out sc_logic 1 outvld 1 } 
	{ stream_out_V_TREADY sc_in sc_logic 1 outacc 1 } 
	{ n_trans sc_in sc_lv 32 signal 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "stream_in_V_TDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "stream_in_V", "role": "TDATA" }} , 
 	{ "name": "stream_in_V_TVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "stream_in_V", "role": "TVALID" }} , 
 	{ "name": "stream_in_V_TREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "inacc", "bundle":{"name": "stream_in_V", "role": "TREADY" }} , 
 	{ "name": "stream_out_V_TDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "stream_out_V", "role": "TDATA" }} , 
 	{ "name": "stream_out_V_TVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "stream_out_V", "role": "TVALID" }} , 
 	{ "name": "stream_out_V_TREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "outacc", "bundle":{"name": "stream_out_V", "role": "TREADY" }} , 
 	{ "name": "n_trans", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "n_trans", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "generate_req",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "4", "EstimateLatencyMax" : "2162",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "stream_in_V", "Type" : "Axis", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "stream_in_V_TDATA_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "stream_out_V", "Type" : "Axis", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "stream_out_V_TDATA_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "n_trans", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.local_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	generate_req {
		stream_in_V {Type I LastRead 1 FirstWrite -1}
		stream_out_V {Type O LastRead -1 FirstWrite 4}
		n_trans {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "4", "Max" : "2162"}
	, {"Name" : "Interval", "Min" : "4", "Max" : "2162"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "1", "EnableSignal" : "ap_enable_pp1"}
]}

set Spec2ImplPortList { 
	stream_in_V { axis {  { stream_in_V_TDATA in_data 0 32 }  { stream_in_V_TVALID in_vld 0 1 }  { stream_in_V_TREADY in_acc 1 1 } } }
	stream_out_V { axis {  { stream_out_V_TDATA out_data 1 32 }  { stream_out_V_TVALID out_vld 1 1 }  { stream_out_V_TREADY out_acc 0 1 } } }
	n_trans { ap_none {  { n_trans in_data 0 32 } } }
}
