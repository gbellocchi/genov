
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash


error_exit()
{
    echo "Error: $1"
    exit 1
}

readonly design_name=$1
readonly out_dir=$2



cmd1='git ls-remote --exit-code --heads git@github.com:gbellocchi/hwpe-gen-app.git $design_name'
cmd2='git ls-remote --exit-code --heads git@github.com:gbellocchi/hwpe-gen-app.git'

# if ! $cmd1; then
#     if ! $cmd2; then
#         echo "error!"
#     fi
# fi

$cmd1
status=$?

# echo "$remote_exists"

# if [ $a == $b ] 

# git clone -b $design_name git@github.com:gbellocchi/hwpe-gen-app.git