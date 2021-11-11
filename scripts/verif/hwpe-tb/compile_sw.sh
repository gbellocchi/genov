
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

error_exit()
{
  echo -e "\n$1\n" 1>&2
  exit 1
}

readonly VERIF_HWPE=$1

# set up pulp-sdk
cd $VERIF_HWPE && source setup_env.sh

# update and compile hw
cd $VERIF_HWPE && make -s clean all