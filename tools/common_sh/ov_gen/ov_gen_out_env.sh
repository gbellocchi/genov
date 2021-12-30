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
    echo -e "[sh] >> Creating repository for target overlay configuration <$target_ov>"

    mkdir $dir_out_ov

    echo -e "\n\t- Location -> $dir_out_ov\n"

    # ========================================= #
    # Create directories for generated hardware #
    # ========================================= #

    mkdir $dir_out_ov/clusters

    # ========================================== #
    # Create directories for test and validation #
    # ========================================== #

    mkdir $dir_out_ov/test

    # System testbench
    mkdir $dir_out_ov/test/overlay_tb
    mkdir $dir_out_ov/test/overlay_tb/sw
    mkdir $dir_out_ov/test/overlay_tb/sw/inc 
    mkdir $dir_out_ov/test/overlay_tb/sw/inc/hwpe_lib

    # ============================================================================= #
    # Retrieve static software components 
    #
    # - Description -
    # Move static software files to their target positions. The term 'static' is used 
    # to denote files that are not targets of the rendering phase, but are either 
    # defined within the repository, or cloned as external sources. 
    # ============================================================================= #

    echo -e "[sh] >> Retrieving static software components"

    # Copy TB generator for compilation support files for software TB
    dest=$dir_out_ov/test/overlay_tb/sw/inc
    if [ -d "$dest" ]; then
        cp -rf ${dir_static}/static_tb/hwpe_ov_tb/inc $dest
    else
        error_exit "[sh] >> Directory not found -> $dest"
    fi
    
fi