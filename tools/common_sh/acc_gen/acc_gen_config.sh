# =====================================================================
# Project:      Scripts - Generation environment
# Title:        acc_gen_config.sh
# Description:  Read accelerator-rich configuration.
#
# $Date:        3.12.2021
#
# =====================================================================
#
# Copyright (C) 2021 University of Modena and Reggio Emilia.
#
# Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
#
# =====================================================================

#!/bin/bash

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

# ========= #
# Functions #
# ========= #

fetch_acc_specs()
{
    echo -e ""
    echo "# ========================================= #"
    echo "# Fetching accelerator input specifications #" 
    echo "# ========================================= #"
    echo -e ""

    # Cleaning generated accelerators
    cd $dir_root
    make --silent acc_gen_clean

    # Fetch accelerator specifications
    cd $dir_acc_src
    for (( c=1; c<=$n_acc; c++ ))
    do  
        echo ">> Fetching target #$c -> $target_acc"
        make --silent clean all ACC_DEV_DIR=$dir_acc_dev TARGET_ACC=$target_acc 
    done

    # Make accelerator specifications accessible by Python import system
    touch $dir_acc_dev/__init__.py
}

gen_configs()
{
    # Generate targets
    cd $dir_root
    for (( c=1; c<=$n_acc; c++ ))
    do  
        echo -e ""
        echo "# ========================================= #"
        echo "# Generating target #$c -> $target_acc #"
        echo "# ========================================= #"
        echo -e ""

        make --silent acc_gen_get_engine TARGET_ACC=$target_acc
        make --silent acc_gen_out_env TARGET_ACC=$target_acc
        make --silent acc_gen_run TARGET_ACC=$target_acc
    done
}

# ======= #
# Program #
# ======= #

echo -e ""
echo "# ========================================= #"
echo "# Generating accelerator-rich configuration #"
echo "# ========================================= #"
echo -e ""

# Read Makefile arguments
readonly dir_root=$1
readonly dir_devs=$2
readonly dir_py_venv=$3
readonly dir_acc_src=$4

readonly dir_ov_dev=$dir_devs/ov_dev
readonly dir_acc_dev=$dir_devs/acc_dev

# Activate environment
source $dir_py_venv/bin/activate

# Read user-defined configuration file
CONFIG_FILE=$dir_ov_dev/acc_config.cfg

# ======================================= #
# Generate accelerator-rich configuration #
# ======================================= #

if [ -f ${CONFIG_FILE} ] && grep -q __N_ACC__ ${CONFIG_FILE}; then
    # Get accelerators configuration
    eval n_acc=$(grep __N_ACC__ ${CONFIG_FILE} | sed 's/.*=//' | tr -d '"')

    echo -e ">> Reading accelerator configuration:"
    echo -e "\t- Number of accelerators -> $n_acc"

    target_acc=traffic_gen

    echo -e "\t- Number of accelerators -> $target_acc"

    # Check data correctness
    q_correctness

    # Fetch accelerator specifications
    fetch_acc_specs

    # Generate accelerator wrappers
    gen_configs

else
    echo "Accelerator configuration -> Not found"
fi

# Deactivate environment
deactivate