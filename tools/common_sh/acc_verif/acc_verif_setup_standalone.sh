# =====================================================================
# Project:      Scripts - Verification environment
# Title:        acc_verif_setup_standalone.sh
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

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

readonly dir_out=$1
readonly dir_verif=$2

echo -e ">> VSIM path -> $dir_verif/hw/sim"
export VSIM_PATH=$dir_verif/hw/sim