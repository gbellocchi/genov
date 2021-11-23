# =====================================================================
# Project:      Scripts - Generation environment
# Title:        init_gen.sh
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

echo -e ">> Cloning git submodules that will come in useful."

# Cloning git submodules
git submodule update --init --recursive