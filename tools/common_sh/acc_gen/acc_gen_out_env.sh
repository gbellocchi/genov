# =====================================================================
# Project:      Scripts - Generation environment
# Title:        acc_gen_out_env.sh
# Description:  Create output environment for generated accelerator wrapper.
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

readonly dir_out_acc=$1
readonly dir_dev_acc=$2
readonly dir_static=$3

# ======================================== #
# Create filesystem for generated hardware #
# ======================================== #

echo -e ">> Creating filesystem for generated accelerator hardware"

mkdir ${dir_out_acc}/hw

# Accelerator wrapper
mkdir ${dir_out_acc}/hw/hwpe_wrapper
mkdir ${dir_out_acc}/hw/hwpe_wrapper/wrap
mkdir ${dir_out_acc}/hw/hwpe_wrapper/rtl
mkdir ${dir_out_acc}/hw/hwpe_wrapper/rtl/acc_kernel

# Standalone testbench
mkdir ${dir_out_acc}/hw/hwpe_standalone_tb

# Git accelerator depoyment
mkdir ${dir_out_acc}/acc_deploy

# ======================================== #
# Create filesystem for generated software #
# ======================================== #

echo -e ">> Creating filesystem for generated accelerator software"

mkdir ${dir_out_acc}/sw

# IStandalone testbench
mkdir ${dir_out_acc}/sw/hwpe_standalone_tb

# Included files
mkdir ${dir_out_acc}/sw/hwpe_standalone_tb/inc

# HWPE library
mkdir ${dir_out_acc}/sw/hwpe_standalone_tb/inc/hwpe_lib

# ============================================================================= #
# Retrieve RTL of acceleration kernel 
#
# - Description -
# This piece of hardware is compliant with the hardware-mapped application that has 
# to be integrated in the overlay. It is necessary for it to be described as RTL, but 
# to derive the latter the proposed design methodology is flexible. To this end, the 
# user can exploit both HLS-compiled and hand-crafted HDL modules.
# ============================================================================= #

echo -e ">> Retrieving RTL of acceleration kernel"

cp -f ${dir_dev_acc}/acc_dev/rtl/* ${dir_out_acc}/hw/hwpe_wrapper/rtl/acc_kernel

# ============================================================================= #
# Retrieve reference software-mapped application and stimuli/golden results generator
#
# - Description -
# The 'ref_sw' is an user-defined software-mapped version of the application kernel
# that the user expects to deploy as an hardware accelerator inside the overlay.
# This is used to generate input stimuli and ouput golden results to validate the 
# generated hardware acceleration wrapper. Generate stimuli and golden results will
# be automatically moved in a "stim" sub-directory. More information is to be found
# in the documentation pertaining to verification (in 'doc/how-to/verif.md').
# ============================================================================= #

echo -e ">> Retrieving reference software-mapped application and stimuli/golden results generator"

# Copy TB generator for input stimuli and golden results
cp -rf ${dir_dev_acc}/acc_dev/sw/ref_sw ${dir_out_acc}/sw/inc
cp -rf ${dir_dev_acc}/acc_dev/sw/stim ${dir_out_acc}/sw/inc

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
cp -rf ${dir_static}/static_tb/hwpe_standalone_tb/* ${dir_out_acc}/sw/hwpe_standalone_tb
