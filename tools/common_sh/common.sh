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
repo_name='hwpe-gen-app'
repo_ssh='git@github.com:gbellocchi/hwpe-gen-app.git'

: '
  Shell functions
'

error_exit()
{
  echo -e "\n$1\n" 1>&2
  exit 1
}