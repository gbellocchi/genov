# =====================================================================
# Project:      Scripts - Generation environment
# Title:        acc_gen_run.sh
# Description:  Generate target accelerator wrapper.
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

readonly dir_py_env=$1
readonly dir_out=$2

# Activate environment
source $dir_py_env/bin/activate

# Get source components (see Makefile recipe deps)
echo -e ">> Retrieving target engine from accelerator library"

# Run generator
echo -e ">> Generation of accelerator wrapper"
cd genov && python genacc.py

# Creating symbolic links to output
echo -e "\n>> Creating symbolic links to output"
cd ../
ln -s ${dir_out}/hw acc_gen_hw
ln -s ${dir_out}/sw acc_gen_sw

# Deactivate environment
deactivate