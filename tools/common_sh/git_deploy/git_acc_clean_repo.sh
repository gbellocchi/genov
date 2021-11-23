# =====================================================================
# Project:      Scripts - Git Deployment
# Title:        git_clean_repo_hwpe.sh
# Description:  Clean local HWPE repository.
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

echo -e ">> Cleaning HWPE git"

readonly OUT_DIR=$1
repo_name='hwpe-gen-app'

rm -rf ${OUT_DIR}/git-deploy/${repo_name}

if [ -L "git_repo_hwpe" ]; then
    unlink git_repo_hwpe
fi