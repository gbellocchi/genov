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

readonly dir_py_venv=$1
readonly dir_out=$2

# Activate environment
source $dir_py_venv/bin/activate

# Run generator
cd genov && python genov.py

# Deactivate environment
deactivate