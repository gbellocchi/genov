# =====================================================================
# Project:      Scripts - Git Deployment
# Title:        git_set_local_hwpe.sh
# Description:  Set up local HWPE repository.
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

readonly OUT_DIR=$1
repo_name='hwpe-gen-app'

# File directory for Git deployment
echo -e ">> Creating local repository for Git deployment"
cp -r ${OUT_DIR}/hw/hwpe_wrapper ${OUT_DIR}/git-deploy/${repo_name}
cp -r ${OUT_DIR}/sw ${OUT_DIR}/git-deploy/${repo_name}/
cp ${OUT_DIR}/hw/hwpe_wrapper/Bender.yml ${OUT_DIR}/git-deploy/${repo_name}

# Creating symbolic links to output
echo -e ">> Creating symbolic links to HWPE local"
ln -s ${OUT_DIR}/git-deploy git_repo_hwpe