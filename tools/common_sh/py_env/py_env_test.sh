# =====================================================================
# Project:      Scripts - Python virtual environment
# Title:        secure_paths.sh
# Description:  Check environment to prevent unwanted errors.
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

echo -e ">> Checking python virtual environment."

readonly dir_py_venv=$1

source tools/common_sh/common.sh

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# --------------------------------------------- #
#  Check if python virtual environment exists.  #
# --------------------------------------------- #

echo -e "|-----------------------------------------|"
echo -e "| GENERATOR - PYTHON VIRTUAL ENVIRONMENT. |"
echo -e "|-----------------------------------------|\n"

if [ -d "$dir_py_venv" ]; then
  # Take action if it exists. #
  echo -e ">> A py-venv path has been found -> $dir_py_venv"
  echo -e ">> This location should correespond to the local python virtual environment for the generator."
  echo -e "\n>> Is it a correct path?"

  select yn in "yes" "no" "help"; do
    case $yn in
        yes )   echo -e "\n"
					      break;;
        no )    error_exit ">> Erroneous path for python virtual environment! Aborting.";;
        help )  echo -e "\n>> Content of $dir_py_venv:\n" 
                ls -1 $dir_py_venv
                echo -e "\n>> Is it a correct path?";;
    esac
  done
else
  # Take action if it does not exist. 
  error_exit ">> No py-venv path has been found. Be sure to initialize it with 'make init_venv'."
fi

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

echo -e ">> Completed checking the python virtual environment."

# ------------------------------ #
#  Completed environment check.  #
# ------------------------------ #