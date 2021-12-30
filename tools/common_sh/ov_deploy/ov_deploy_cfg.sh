# =====================================================================
# Project:      Scripts - Overlay environment
# Title:        ov_deploy.sh
# Description:  Deploy components to generate overlay.
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

# Read Makefile arguments
readonly dir_out_ov=$1
readonly dir_ov_cfg=$2

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

# Add generated overlay configuration to overlay design environment
src=$dir_out_ov
dst=$dir_ov_cfg
if [ ! -d "$src" ]; then
    error_exit "[sh] >> Overlay configuration not found"
elif [ ! -d "$dst" ]; then
    ls $dst
    echo $dst
    error_exit "[sh] >> Overlay design environment not found"
else
    cp -rf $src $dst
fi