
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

readonly GEN_VENV=$1
readonly OUT_DIR=$2

# Activate environment
source $GEN_VENV/bin/activate

# Run generator
echo -e ">> Deployment of hardware accelerator to Git."
cd genacc && python git-deploy.py $OUT_DIR

# Deactivate environment
deactivate