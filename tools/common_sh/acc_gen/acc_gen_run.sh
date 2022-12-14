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

readonly target_acc=$1
readonly dir_py_venv=$2
readonly dir_out_acc=$3

# Activate environment
source $dir_py_venv/bin/activate

# Launch python generator
cd genov 
python generate_wrapper.py $dir_out_acc
python generate_wrapper_test.py $dir_out_acc

# Deactivate environment
deactivate