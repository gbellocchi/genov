# =====================================================================
# Project:      Scripts - Python virtual environment
# Title:        init_py_env.sh
# Description:  Initialize python environment
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

# Create virtual python environment
echo -e ">> Creating virtual environment to generate a specialized accelerator wrapper."
python3 -m venv $GEN_VENV

# Activate environment
source $GEN_VENV/bin/activate

echo -e ">> Installing some Python packages that will come in useful."

# Install most updated pip version
python -m pip install --upgrade pip

# Install required python packages
# python setup.py install
python -m pip install -r requirements.txt

# Deactivate environment
deactivate