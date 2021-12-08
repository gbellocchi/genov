# =====================================================================
# Project:      Scripts - Git Deployment
# Title:        acc_deploy_get_remote_repo.sv
# Description:  Get remote HWPE repository.
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
echo "# ========================== #"
echo "# Get remote HWPE repository #"
echo "# ========================== #"
echo -e ""

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

# Read user-defined configuration file
CONFIG_FILE=$THIS_DIR/../local.cfg

if [ -f ${CONFIG_FILE} ] && grep -q GIT_REPO_NAME ${CONFIG_FILE} && grep -q GIT_REPO_URL_SSH ${CONFIG_FILE}; then
    # Get repository name
    eval git_repo_name=$(grep GIT_REPO_NAME ${CONFIG_FILE} | sed 's/.*=//' | tr -d '"')

    # Get repository SSH URL
    eval git_repo_ssh=$(grep GIT_REPO_URL_SSH ${CONFIG_FILE} | sed 's/.*=//' | tr -d '"')

    echo -e "[sh] >> Set local repository for accelerator wrapper:"
    echo -e "- Name -> $git_repo_name"
    echo -e "- SSH URL-> $git_repo_ssh"

    # Check data correctness
    q_correctness

    # Move to local
    cd git_acc

    # Initialize repository
    echo -e "[sh] >> Initializing git repository -> $repo_name"
    git init
    git add .
    git commit -m 'Initial commit'

    # Add remote origin
    echo -e "[sh] >> Adding remote origin"
    git remote add origin $git_repo_ssh
    echo -e "[sh] >> Origin set at -> $(git config --get remote.origin.url)"
else
    echo "Deployment repository -> Not found"
fi