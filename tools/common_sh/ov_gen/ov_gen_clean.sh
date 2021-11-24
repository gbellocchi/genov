# =====================================================================
# Project:      Scripts - Generation environment
# Title:        acc_gen_clean.sh
# Description:  Clean generation environment.
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

echo -e ">> Cleaning generated files"

readonly dir_py_venv="$1"
readonly dir_out="$2"

# Cleaning repo
find . -type d -name '__pycache__' -not -path "${dir_py_venv}" -exec rm -rf {} +
find . -name "*.pyc" -type f -delete

# Cleaning generated hardware
rm -rf ${dir_out}/hw/overlay/*

if [ -L "ov_gen_hw" ]; then
    unlink ov_gen_hw
fi

# Cleaning generated verification software
rm -rf ${dir_out}/sw/hwpe_ov_tb/*

if [ -L "ov_gen_sw" ]; then
    unlink ov_gen_sw
fi

# Cleaning generated integration support files
rm -rf ${dir_out}/integr_support/*

if [ -L "ov_gen_integr" ]; then
    unlink ov_gen_integr
fi
