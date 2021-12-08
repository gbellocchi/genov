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

echo -e ""
echo "# ============================ #"
echo "# Set up local HWPE repository #"
echo "# ============================ #"
echo -e ""

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

# Read Makefile arguments
readonly dir_out_acc=$1
readonly dir_acc_deploy=$2

# Read user-defined configuration file
CONFIG_FILE=$THIS_DIR/../local.cfg

if [ -f ${CONFIG_FILE} ] && grep -q GIT_REPO_NAME ${CONFIG_FILE}; then
    # Get repository name
    eval git_repo_name=$(grep GIT_REPO_NAME ${CONFIG_FILE} | sed 's/.*=//' | tr -d '"')
    readonly dir_git_repo=${dir_acc_deploy}/${git_repo_name}

    echo -e "[sh] >> Set local repository for accelerator wrapper:"
    echo -e "- Name -> $git_repo_name"
    echo -e "- Location-> $dir_git_repo"

    # Check data correctness
    q_correctness
    
    # File directory for Git deployment
    echo -e "[sh] >> Creating local repository for Git deployment"
    cp -r ${dir_out_acc}/hw/hwpe_wrapper/* ${dir_git_repo}/
    cp -r ${dir_out_acc}/sw ${dir_git_repo}/
    cp ${dir_out_acc}/hw/hwpe_wrapper/Bender.yml ${dir_git_repo}/

    # Creating symbolic links to output
    echo -e "[sh] >> Creating symbolic links to HWPE local"
    ln -s ${dir_git_repo} git_acc
else
    echo "Deployment repository -> Not found"
fi
