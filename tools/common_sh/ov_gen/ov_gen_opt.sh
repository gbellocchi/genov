# =====================================================================
# Project:      Scripts - Generation environment
# Title:        ov_gen_opt.sh
# Description:  Optimize overlay specification with application-specific informations.
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
cd genov && python optimizer.py

# Deactivate environment
deactivate