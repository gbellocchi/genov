# =====================================================================
# Project:      Scripts - Generation environment
# Title:        ov_gen_out_env.sh
# Description:  Create output environment for generated overlay configuration.
#
# $Date:        23.11.2021
#
# =====================================================================
#
# Copyright (C) 2021 University of Modena and Reggio Emilia.
#
# Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
#
# =====================================================================

#!/bin/bash

# Read Makefile arguments
readonly target_ov=$1
readonly dir_dev_ov=$2
readonly dir_out_ov=$3
readonly dir_static=$4

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

if [ ! -d "$dir_out_ov" ]; then
    echo -e "[sh] >> Creating directory for target overlay configuration <$target_ov>"

    mkdir -p $dir_out_ov

    echo -e "\n\t- Location -> $dir_out_ov\n"

    # ========================================= #
    # Create directories for generated hardware #
    # ========================================= #

    mkdir -p $dir_out_ov/ip

    mkdir -p $dir_out_ov/soc
    mkdir -p $dir_out_ov/soc/packages
    mkdir -p $dir_out_ov/soc/rtl
    mkdir -p $dir_out_ov/soc/rtl/out-of-context

    mkdir -p $dir_out_ov/cluster
    mkdir -p $dir_out_ov/cluster/packages
    mkdir -p $dir_out_ov/cluster/rtl

    # ========================================= #
    # Create directories for software libraries #
    # ========================================= #

    mkdir -p $dir_out_ov/libs

    # LibHWPE
    mkdir -p $dir_out_ov/libs/libhwpe

    # LibAROV
    mkdir -p $dir_out_ov/libs/libarov-target

    # Default structs
    mkdir -p $dir_out_ov/libs/hwpe_structs
    mkdir -p $dir_out_ov/libs/soc_structs

    # ========================================== #
    # Create directories for test and validation #
    # ========================================== #

    mkdir -p $dir_out_ov/test

    # Simulation
    mkdir -p $dir_out_ov/test/waves

    # Software runtime
    mkdir -p $dir_out_ov/test/sw
    mkdir -p $dir_out_ov/test/sw/inc 
    mkdir -p $dir_out_ov/test/sw/inc/wrappers
    
fi