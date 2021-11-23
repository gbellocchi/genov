# =====================================================================
# Project:      Scripts - Git Deployment
# Title:        git_set_branch_hwpe.sh
# Description:  Set up HWPE application-specific branch.
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

update_remote()
{
    remote_info=$1

    echo -e "\n>> Updating remote branch. Are the following information concerning the remote correct?"
    echo -e "\t- HWPE target:       ${remote_info[1]}"
    echo -e "\t- Repository:        ${remote_info[2]}"
    echo -e "\t- SSH URL:           ${remote_info[3]}"
    echo -e "\t- Remote branch:     ${remote_info[4]}"

    select yn in "yes" "no"; do
		case $yn in
			yes ) 	echo -e "\n"
                    echo -e "Updating the remote:"
                    git checkout -b ${remote_info[1]}
                    git push --force-with-lease origin ${remote_info[1]}
					break;;
			no ) 	echo -e "\n"
					break;;
		esac
	done
    # git push
    exit 1
}

q_remote_exists()
{
    remote_info=$1

    echo -e "\n>> Would you like to update this remote?" 
    select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	echo -e "\n"
                    update_remote remote_info
					break;;
			no ) 	echo -e "\n"
					break;;
			help ) 	echo -e "Updating the following remote includes:"
                    echo -e "\t- Commit what differs compared to the content of the remote branch"
                    echo -e "\t- Push the resulting commit to the remote server"
                    echo -e "\n>> Would you like to update this remote?" ;;
		esac
	done
    exit 1
}

readonly hwpe_target=$1
repo_name='hwpe-gen-app'
repo_ssh='git@github.com:gbellocchi/hwpe-gen-app.git'

# Move to local
cd git_repo_hwpe/$repo_name

# Fetch remote branches
echo -e ">> Fetch remote branches" 
git fetch origin

# declare an array variable
echo -e ">> Searching for remote branch: $hwpe_target" 
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
remote_info[2]=$repo_name 
remote_info[3]=$repo_ssh 
remote_info[4]=$remote_br_name

# Take action whether remote branch exists or not
if [[ $is_remote == 1 ]]; then
    echo -e ">> Remote branch already exists: ${remote_info[3]}"
    q_remote_exists remote_info
else
    echo ">> No remote branch has been found, so a new one will be created"
    update_remote remote_info
fi