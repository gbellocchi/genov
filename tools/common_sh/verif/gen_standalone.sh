# =====================================================================
# Project:      Scripts - Verification environment
# Title:        gen_standalone.sh
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

# update hw dut
cp -rf $dir_out/hw/hwpe_wrapper $dir_verif/hw/ips/

# update hw tb
cp -rf $dir_out/hw/hwpe_standalone_tb/* $dir_verif/hw/rtl/

# update sw app
cp -rf $dir_out/sw/hwpe_standalone_tb/* $dir_verif/sw/