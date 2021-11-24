
# =====================================================================
# Project:      Scripts - Python virtual environment
# Title:        update_reqs.sh
# Description:  Update environment requirements.
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

# Update required python packages
echo -e ">> Updating required python packages."
pip freeze > requirements.txt

# Deactivate environment
deactivate