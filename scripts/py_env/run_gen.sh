
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

readonly GEN_VENV=$1

# Activate environment
source $GEN_VENV/bin/activate

# Run generator
echo -e ">> Accelerator wrapper specialization...\n"
python run_gen.py
echo -e "                                     ...done!"

# Deactivate environment
deactivate