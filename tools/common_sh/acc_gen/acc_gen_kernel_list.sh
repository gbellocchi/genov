# =====================================================================
# Project:      Scripts - Generation environment
# Title:        acc_gen_kernel_list.sh
# Description:  Retrieve list of RTL modules that implement wrapped 
#               hardware accelerator kernel.
#
# $Date:        25.1.2022
#
# =====================================================================
#
# Copyright (C) 2022 University of Modena and Reggio Emilia.
#
# Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
#
# =====================================================================

#!/bin/bash

readonly dir_acc_dev=$1
readonly target_acc=$2

ls ${dir_acc_dev}/${target_acc}/rtl >> ${dir_acc_dev}/${target_acc}/kernel_list.log
