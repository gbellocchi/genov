# =====================================================================
# Project:      Scripts - Verification environment
# Title:        setup_standalone.sh
# Description:  Set up standalone verification environment.
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

error_exit()
{
  echo -e "\n$1\n" 1>&2
  exit 1
}

readonly dir_out=$1
readonly dir_verif=$2