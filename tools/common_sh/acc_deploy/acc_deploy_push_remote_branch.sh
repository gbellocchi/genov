# =====================================================================
# Project:      Scripts - Git Deployment
# Title:        acc_deploy_push_remote_branch.sh
# Description:  Set up HWPE application-specific branch and push to remote.
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
echo "# ========================================================== #"
echo "# Set up HWPE application-specific branch and push to remote #"
echo "# ========================================================== #"
echo -e ""

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

# ========= #
# Functions #
# ========= #

update_remote()
{
    remote_info=$1

    echo -e "[sh] >> Updating remote branch. Are the following remote information correct?"
    echo -e "\t- Target accelerator:        ${remote_info[1]}"
    echo -e "\t- Repository:                ${remote_info[2]}"
    echo -e "\t- SSH URL:                   ${remote_info[3]}"
    echo -e "\t- Remote branch:             ${remote_info[4]}"

    select yn in "yes" "no"; do
		case $yn in
			yes ) 	echo -e "Updating the remote:"
                    git checkout -b ${remote_info[1]}
                    git push --force-with-lease origin ${remote_info[1]}
					break;;
			no ) 	break;;
		esac
	done
    # git push
    exit 0
}

q_remote_exists()
{
    remote_info=$1

    echo -e "\n>> Would you like to update this remote?" 
    select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	update_remote remote_info
					break;;
			no ) 	break;;
			help ) 	echo -e "Updating the following remote includes:"
                    echo -e "\t- Commit what differs compared to the content of the remote branch"
                    echo -e "\t- Push the resulting commit to the remote server"
                    echo -e "\n>> Would you like to update this remote?" ;;
		esac
	done
    exit 0
}

# ======= #
# Program #
# ======= #

# Read Makefile arguments
readonly hwpe_target=$1

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

    # Fetch remote branches
    echo -e "[sh] >> Fetch remote branches" 
    git fetch origin

    # declare an array variable
    echo -e "[sh] >> Searching for remote branch: $hwpe_target" 
    declare -a br_arr=($(git branch -a))

    # Loop through the array of branches and 
    # search for remote branches connected to target
    for i in "${br_arr[@]}"
    do
        # Filter on remote branches
        if [[ $i == *"remotes/"* ]]; then
            # Filter on target branches
            if [[ $i == *"$hwpe_target"* ]]; then
                remote_br_name=$i
                is_remote=1
            fi
        fi
    done

    # Wrap gathered information 
    declare -A remote_info
    remote_info[1]=$hwpe_target 
    remote_info[2]=$git_repo_name 
    remote_info[3]=$git_repo_ssh 
    remote_info[4]=$remote_br_name

    # Take action whether remote branch exists or not
    if [[ $is_remote == 1 ]]; then
        echo -e "[sh] >> Remote branch already exists: ${remote_info[4]}"
        q_remote_exists remote_info
    else
        echo "[sh] >> No remote branch has been found, so a new one will be created"
        update_remote remote_info
    fi

    # Get log of pushed commit
    git log

else
    echo "Deployment repository -> Not found"
fi