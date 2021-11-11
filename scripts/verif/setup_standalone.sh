
########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

error_exit()
{
  echo -e "\n$1\n" 1>&2
  exit 1
}

readonly OUT_DIR=$1
readonly VERIF_HWPE=$2

# # update and compile hw
# cd $VERIF_HWPE && make -s update-ips build-hw

# update dut
cp -rf $OUT_DIR/hw/hwpe_wrapper $VERIF_HWPE/hw/ips/
cp -rf $OUT_DIR/hw/hwpe_standalone_tb/ips_list.yml $VERIF_HWPE/hw/ips/hwpe_wrapper
cp -rf $OUT_DIR/hw/hwpe_standalone_tb/src_files.yml $VERIF_HWPE/hw/ips/hwpe_wrapper

# update tb
# cd $VERIF_HWPE

# update sw app