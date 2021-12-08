# =====================================================================
# Project:      Scripts - Generation environment
# Title:        acc_gen_init.sh
# Description:  Preliminary operation to let the generation process proceed
#               with all the required information about the input specifications.
#
# $Date:        7.12.2021
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

# Run optimizer
cd genov && python initializer.py

# Deactivate environment
deactivate

