
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

readonly OUT_DIR=$1
readonly VERIF_HWPE=$2

# update hw dut
cp -rf $OUT_DIR/hw/hwpe_wrapper $VERIF_HWPE/hw/ips/

# update hw tb
cp -rf $OUT_DIR/hw/hwpe_standalone_tb/* $VERIF_HWPE/hw/rtl/

# update sw app
cp -rf $OUT_DIR/sw/hwpe_standalone_tb/* $VERIF_HWPE/sw/