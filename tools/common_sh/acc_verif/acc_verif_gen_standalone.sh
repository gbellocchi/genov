# =====================================================================
# Project:      Scripts - Verification environment
# Title:        acc_verif_gen_standalone.sh
# Description:  Generate standalone verification environment.
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

readonly dir_out=$1
readonly dir_verif=$2

# Get source components (see Makefile recipe deps)
echo -e ">> Retrieving generated TB components to validate accelerator wrapper"

# update hw tb
cp -rf $dir_out/hw/hwpe_standalone_tb/tb_hwpe.sv $dir_verif/hw/rtl/

# update sw tb
cp -rf $dir_out/sw/hwpe_standalone_tb/* $dir_verif/sw/