# =====================================================================
# Project:      Scripts - Generation environment
# Title:        ov_gen_out_env.sh
# Description:  Create output environment for generated overlay configuration.
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

readonly dir_py_venv=$1

# Activate environment
source $dir_py_venv/bin/activate

# Creating output environment
echo -e ">> Creating output environment for accelerator-rich overlay"
cd genov && python genov_env.py

# Deactivate environment
deactivate