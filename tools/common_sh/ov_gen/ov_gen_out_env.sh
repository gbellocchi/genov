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

readonly dir_out_ov=$1
readonly dir_dev_ov=$2
readonly dir_static=$3

# ======================================== #
# Create filesystem for generated hardware #
# ======================================== #

echo -e ">> Creating filesystem for generated overlay hardware"

mkdir ${dir_out_ov}/hw

# ========================================================= #
# Create filesystem for generated integration support files #
# ========================================================= #

echo -e ">> Creating filesystem for generated integration support files"

mkdir ${dir_out_ov}/integr_support

# ======================================== #
# Create filesystem for generated software #
# ======================================== #

echo -e ">> Creating filesystem for generated accelerator software"

mkdir ${dir_out_ov}/sw

# Overlay testbench
mkdir ${dir_out_ov}/sw/hwpe_ov_tb

# Included files
mkdir ${dir_out_ov}/sw/hwpe_ov_tb/inc

# HWPE library
mkdir ${dir_out_ov}/sw/hwpe_ov_tb/inc/hwpe_lib

# ============================================================================= #
# Retrieve static software components 
#
# - Description -
# Move static software files to their target positions. The term 'static' is used 
# to denote files that are not targets of the rendering phase, but are either 
# defined within the repository, or cloned as external sources. 
# ============================================================================= #

echo -e ">> Retrieving static software components"

# Copy TB generator for compilation support files for software TB
cp -rf ${dir_static}/static_tb/hwpe_ov_tb/* ${dir_out_ov}/sw/hwpe_ov_tb
