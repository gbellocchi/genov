
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

# Get source components (see Makefile recipe deps)
echo -e ">> Retrieving target engine from accelerator library."

# Run generator
echo -e ">> Generation of accelerator wrapper."
cd genacc && python genacc.py

# Creating symbolic links to output
echo -e "\n>> Creating symbolic links to output."
cd ../
ln -s ${OUT_DIR}/hw out_hw
ln -s ${OUT_DIR}/sw out_sw
ln -s ${OUT_DIR}/ov_integr out_ov_integr

# Deactivate environment
deactivate