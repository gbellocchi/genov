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
readonly target_ov=$3

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

echo -e ""
echo -e "# ============================================= #"
echo -e "# Deployment of generated overlay configuration #"
echo -e "# ============================================= #\n"

# define src and dst
src=$dir_out_ov
dst="$dir_ov_cfg/$target_ov"

# # Check dir_ov_cfg
# if [ -d "$dir_ov_cfg" ]; then
# 	# Take action if it exists. #
# 	echo -e "[sh] >> Destination path has been found -> $dst"
# 	echo -e "\n[sh] >> Is it a correct path? [ans=1,2,3]"

# 	select yn in "yes" "no" "help"; do
# 		case $yn in
# 			yes ) 	echo -e ""
# 					break;;
# 			no ) 	error_exit "[sh] >> Erroneous path. Aborting.";;
# 			help ) 	echo -e "\n[sh] >> Content of destination path:\n" 
# 					ls -1 $dst
# 					echo -e "\n[sh] >> Is it a correct path?";;
# 		esac
# 	done
# else
# 	# Take action if it does not exist. #
# 	error_exit "[sh] >> No destination path has been found. Be sure to properly setup your environment."
# fi

# Add generated overlay configuration to overlay design environment
if [ ! -d "$src" ]; then
    error_exit "[sh] >> Overlay configuration not found."
elif [ ! -d "$dst" ]; then
	echo "[sh] >> Exporting generated files."
    cp -rf $src $dst
else
	echo "[sh] >> Overlay configuration already exists. Overwriting previously generated files."
	# rm -rf $dst
    cp -rf $src $dst
fi