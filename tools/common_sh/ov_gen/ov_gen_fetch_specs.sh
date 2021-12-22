# =====================================================================
# Project:      Scripts - Generation environment
# Title:        ov_gen_fetch_specs.sh
# Description:  Fetching overlay input specifications.
#
# $Date:        22.12.2021
#
# =====================================================================
#
# Copyright (C) 2021 University of Modena and Reggio Emilia.
#
# Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
#
# =====================================================================

#!/bin/bash

readonly dir_ov_src=$1
readonly dir_dev=$2
readonly ov_target=$3

cd ${dir_ov_src} && make -s clean all DEV_DIR=${dir_dev} TARGET_OV=${ov_target}