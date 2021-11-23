# =====================================================================
# Project:      Scripts - Git Deployment
# Title:        git_set_repo_hwpe.sv
# Description:  Add remote HWPE repository.
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

repo_name='hwpe-gen-app'
repo_ssh='git@github.com:gbellocchi/hwpe-gen-app.git'

# Move to local
cd git_repo_hwpe/$repo_name

# Initialize repository
echo -e ">> Initializing git repository -> $repo_name"
git init
git add .
git commit -m 'Initial commit'

# Add remote origin
echo -e ">> Adding remote origin"
git remote add origin $repo_ssh
echo -e ">> Origin set at -> $(git config --get remote.origin.url)"