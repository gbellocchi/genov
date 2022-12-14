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

# Cloning git submodules
echo -e "[sh] >> Retrieving external sources"
git submodule update --init --recursive