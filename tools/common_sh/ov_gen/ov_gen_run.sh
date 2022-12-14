# =====================================================================
# Project:      Scripts - Generation environment
# Title:        ov_gen_run.sh
# Description:  Generate target overlay configuration.
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

readonly target_ov=$1
readonly dir_py_venv=$2
readonly dir_out_ov=$3

# Activate environment
source $dir_py_venv/bin/activate

# Launch python generators
cd genov 
python generate_ov.py $dir_out_ov
python generate_ov_libs.py $dir_out_ov
python generate_ov_test.py $dir_out_ov
python generate_soc.py $dir_out_ov
python generate_cluster.py $dir_out_ov

# Deactivate environment
deactivate