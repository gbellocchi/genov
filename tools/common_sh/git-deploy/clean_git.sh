
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

echo -e ">> Cleaning generated files"

readonly OUT_DIR=$1
readonly REPO_NAME='hwpe-gen-app'

rm -rf ${OUT_DIR}/git-deploy/${REPO_NAME}

if [ -L "out_git_repo" ]; then
    unlink out_git_repo
fi