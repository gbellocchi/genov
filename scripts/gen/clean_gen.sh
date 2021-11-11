
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

echo -e ">> Cleaning generated files."

readonly dir_eng_dev="$1"
readonly dir_py_env="$2"
readonly dir_templ_integr_support="$3"

# Cleaning repo
rm -rf ${dir_eng_dev}/*
find . -type d -name '__pycache__' -not -path "${dir_py_env}" -exec rm -rf {} +
find . -name "*.pyc" -type f -delete
rm -rf ${dir_templ_integr_support}/rtl_list/*.log

if [ -L "out_hw" ]; then
    rm -rf out_hw/hwpe_standalone_tb/*
    rm -rf out_hw/hwpe_wrapper/*
    rm -rf out_hw/overlay/*
    unlink out_hw
fi

if [ -L "out_sw" ]; then
    rm -rf out_sw/hwpe_ov_tb/*
    rm -rf out_sw/hwpe_standalone_tb/*
    unlink out_sw
fi

if [ -L "out_integr_support" ]; then
    rm -rf out_integr_support/*
    unlink out_integr_support
fi