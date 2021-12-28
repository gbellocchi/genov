# =====================================================================
# Project:      Scripts - Common
# Title:        common.sh
# Description:  Collection of shell variables and functions shared by 
#               the tool scripts.
#
# $Date:        23.11.2021
#
# =====================================================================
#
# Copyright (C) 2021 University of Modena and Reggio Emilia.
#
# Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
#
# =====================================================================

#!/bin/bash

: '
  Shell variables
'

hwpe_target=$1

: '
  Shell functions
'

error_exit()
{
  echo -e "\n$1\n" 1>&2
  exit 1
}

q_correctness()
{
    remote_info=$1

    echo -e "\n>> Are these information correct?" 
    select yn in "yes" "no"; do
      case $yn in
        yes ) 	break;;
        no ) 	  error_exit "[sh] >> Environment error!";;
      esac
    done
}

check_env_var()
{
    variable_name=$1
    variable_value=$2

    if [[ -z "$variable_value" ]]; then
      error_exit "[sh] >> $variable_name is not defined yet. Please correct this!\n"
    else
      echo "[sh] >> $variable_name defined at $variable_value"
    fi
}