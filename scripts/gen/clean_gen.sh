
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
    rm -rf out_hw/*
    unlink out_hw
fi

if [ -L "out_sw" ]; then
    rm -rf out_sw/tb-ov/*
    rm -rf out_sw/tb-standalone/*
    unlink out_sw
fi

if [ -L "out_ov_integr" ]; then
    rm -rf out_ov_integr/*
    unlink out_ov_integr
fi