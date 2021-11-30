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

readonly dir_eng_dev="$1"
readonly dir_py_venv="$2"
readonly dir_templ_acc="$3"
readonly dir_out_acc="$4"

# Cleaning repo
rm -rf ${dir_eng_dev}/*
find . -type d -name '__pycache__' -not -path "${dir_py_venv}" -exec rm -rf {} +
find . -name "*.pyc" -type f -delete
rm -rf ${dir_templ_acc}/integr_support/rtl_list/*.log

# Cleaning generated hardware
rm -rf ${dir_out_acc}/hw/hwpe_standalone_tb/*
rm -rf ${dir_out_acc}/hw/hwpe_wrapper/*

# if [ -L "acc_gen_hw" ]; then
#     unlink acc_gen_hw
# fi

# Cleaning generated verification software
rm -rf ${dir_out_acc}/sw/hwpe_standalone_tb/*

# if [ -L "acc_gen_sw" ]; then
#     unlink acc_gen_sw
# fi
