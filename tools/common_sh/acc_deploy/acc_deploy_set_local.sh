# =====================================================================
# Project:      Scripts - Git Deployment
# Title:        acc_deploy_set_local.sh
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

readonly dir_acc_deploy=$1
repo_name='hwpe-gen-app'

# File directory for Git deployment
echo -e ">> Creating local repository for Git deployment"
cp -r ${OUT_DIR}/hw/hwpe_wrapper ${dir_acc_deploy}/${repo_name}
cp -r ${OUT_DIR}/sw ${dir_acc_deploy}/${repo_name}/
cp ${OUT_DIR}/hw/hwpe_wrapper/Bender.yml ${dir_acc_deploy}/${repo_name}

# Creating symbolic links to output
echo -e ">> Creating symbolic links to HWPE local"
ln -s ${dir_acc_deploy} git_acc