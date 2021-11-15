
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

: '
  Collection of shell functions used by the tool scripts.
'

error_exit()
{
  echo -e "\n$1\n" 1>&2
  exit 1
}