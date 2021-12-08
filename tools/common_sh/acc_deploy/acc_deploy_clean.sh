# =====================================================================
# Project:      Scripts - Git Deployment
# Title:        acc_deploy_clean.sh
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

echo -e ""
echo "# ============================== #"
echo "# Cleaning local HWPE repository #"
echo "# ============================== #"
echo -e ""

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

# Read Makefile arguments
readonly dir_acc_deploy=$1

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
    
    # Clean repo
    if [ -d ${dir_git_repo} ]; then
        rm -rf $dir_git_repo/*
    fi
else
    echo "Deployment repository -> Not found"
fi

# Remove link to git accelerator
if [ -L "git_acc" ]; then
    unlink git_acc
else
    echo "Link to deployment repository -> Not found"
fi