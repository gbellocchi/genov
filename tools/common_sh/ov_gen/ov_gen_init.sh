# =====================================================================
# Project:      Scripts - Generation environment
# Title:        ov_gen_init.sh
# Description:  Initialize generation environment.
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

# Cloning git submodules
echo -e ">> Cloning git submodules that will come in useful"
git submodule update --init --recursive

# Deactivate environment
deactivate