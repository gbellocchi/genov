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

readonly dir_py_venv=$1

# Create virtual python environment
echo -e "[sh] >> Creating virtual environment to generate a specialized accelerator wrapper."
python3 -m venv $dir_py_venv

# Activate environment
source $dir_py_venv/bin/activate

echo -e "[sh] >> Installing some Python packages that will come in useful."

# Install most updated pip version
python -m pip install --upgrade pip

# Install required python packages
# python setup.py install
python -m pip install -r requirements.txt

# Deactivate environment
deactivate