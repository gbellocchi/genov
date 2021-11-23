# =====================================================================
# Project:      Scripts - Generation environment
# Title:        run_gen.sh
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

readonly GEN_VENV=$1
readonly OUT_DIR=$2

# Activate environment
source $GEN_VENV/bin/activate

# Get source components (see Makefile recipe deps)
echo -e ">> Retrieving target engine from accelerator library."

# Run generator
echo -e ">> Generation of accelerator wrapper."
cd genacc && python genacc.py

# Creating symbolic links to output
echo -e "\n>> Creating symbolic links to output."
cd ../
ln -s ${OUT_DIR}/hw out_hw
ln -s ${OUT_DIR}/sw out_sw
ln -s ${OUT_DIR}/integr_support out_integr_support

# Deactivate environment
deactivate