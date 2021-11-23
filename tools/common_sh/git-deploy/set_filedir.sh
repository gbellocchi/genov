
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

readonly OUT_DIR=$1

readonly REPO_NAME='hwpe-gen-app'

# File directory for Git deployment
echo -e ">> Creating file directory for Git deployment"
cp -r ${OUT_DIR}/hw/hwpe_wrapper ${OUT_DIR}/git-deploy/${REPO_NAME}
cp -r ${OUT_DIR}/sw ${OUT_DIR}/git-deploy/${REPO_NAME}/
cp ${OUT_DIR}/hw/hwpe_wrapper/Bender.yml ${OUT_DIR}/git-deploy/${REPO_NAME}

# Creating symbolic links to output
echo -e ">> Creating symbolic links to output"
ln -s ${OUT_DIR}/git-deploy out_git_repo