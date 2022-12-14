# =====================================================================
# Project:      Scripts - Generation environment
# Title:        acc_gen_clean.sh
# Description:  Clean generation environment.
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

readonly dir_ov_dev="$1"
readonly dir_py_venv="$2"
readonly dir_out_ov="$3"

# Cleaning repo
rm -rf ${dir_ov_dev}
mkdir ${dir_ov_dev}
find . -type d -name '__pycache__' -not -path "${dir_py_venv}" -exec rm -rf {} +
find . -name "*.pyc" -type f -delete

# Cleaning generated overlay
rm -rf ${dir_out_ov}
