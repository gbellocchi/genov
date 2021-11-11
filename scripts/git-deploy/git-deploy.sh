
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

error_exit()
{
  echo -e "\n$1\n" 1>&2
  exit 1
}

readonly GEN_VENV=$1
readonly OUT_DIR=$2

# Activate environment
source $GEN_VENV/bin/activate

# Run generator
echo -e ">> Deployment of hardware accelerator to Git."
cd scripts/git-deploy && python git-deploy.py $OUT_DIR

# Deactivate environment
deactivate