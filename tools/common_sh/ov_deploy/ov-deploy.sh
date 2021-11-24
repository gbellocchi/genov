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

# read output directory
readonly OUT_DIR=$1

# read overlay directories
readonly OVERLAY_SRC=$2
readonly OVERLAY_CLUSTER=$3
readonly OVERLAY_TEST=$4

echo -e ">> Exporting accelerator package to perform system-level optimization."
cp ${OUT_DIR}/hw/overlay/ov_acc_pkg.sv ${OVERLAY_SRC}/

echo -e ">> Exporting accelerator interface to perform system-level integration."
cp ${OUT_DIR}/hw/overlay/ov_acc_intf.sv ${OVERLAY_CLUSTER}/

echo -e ">> Exporting Modelsim wave script to perform system-level testing."
cp ${OUT_DIR}/integr_support/pulp_tb.wave.do ${OVERLAY_TEST}/