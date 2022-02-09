############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
############################################################
open_project proj_fir_128_mdc
set_top fir_128_mdc
add_files src/fir.cpp
add_files -tb src/fir_test_app.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1"
set_part {xczu9eg-ffvb1156-2-e}
create_clock -period 3 -name default
#source "./proj_fir_128_mdc/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
