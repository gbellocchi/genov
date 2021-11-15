
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash                                                                       

readonly GEN_VENV=$1

# Activate environment
source $GEN_VENV/bin/activate

# Update required python packages
echo -e ">> Updating required python packages."
pip freeze > requirements.txt

# Deactivate environment
deactivate