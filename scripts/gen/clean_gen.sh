
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

echo -e ">> Cleaning generated files."

readonly dir_eng_dev="$1"
readonly dir_py_env="$2"
readonly dir_templ_integr_support="$3"
readonly dir_out="$4"

# Cleaning repo
rm -rf ${dir_eng_dev}/*
find . -type d -name '__pycache__' -not -path "${dir_py_env}" -exec rm -rf {} +
find . -name "*.pyc" -type f -delete
rm -rf ${dir_templ_integr_support}/rtl_list/*.log

# Cleaning generated hardware
rm -rf ${dir_out}/hw/hwpe_standalone_tb/*
rm -rf ${dir_out}/hw/hwpe_wrapper/*
rm -rf ${dir_out}/hw/overlay/*

if [ -L "out_hw" ]; then
    unlink out_hw
fi

# Cleaning generated verification software
rm -rf ${dir_out}/sw/hwpe_ov_tb/*
rm -rf ${dir_out}/sw/hwpe_standalone_tb/*

if [ -L "out_sw" ]; then
    unlink out_sw
fi

# Cleaning generated integration support files
rm -rf ${dir_out}/integr_support/*

if [ -L "out_integr_support" ]; then
    unlink out_integr_support
fi