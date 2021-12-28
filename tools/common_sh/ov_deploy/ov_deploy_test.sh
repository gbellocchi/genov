# =====================================================================
# Project:      Scripts - Overlay environment
# Title:        secure_paths.sh
# Description:  Check environment to prevent unwanted errors.
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

echo -e "[sh] >> Checking overlay environment.\n"

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

readonly OVERLAY_SRC=$1
readonly OVERLAY_DEPS=$2
readonly OVERLAY_TEST=$3

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------------------ #
#  Check user-defined environment variables  #
# ------------------------------------------ #

echo -e "|------------------------|"
echo -e "| Environment variables. |"
echo -e "|------------------------|\n"

check_env_var HERO_HOME_DIR $HERO_HOME_DIR
check_env_var HERO_OV_HW_EXPORT $HERO_OV_HW_EXPORT

echo -e ""

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ----------------------------- #
#  Check if OVERLAY_SRC exists  #
# ----------------------------- #

echo -e "|-----------------------|"
echo -e "| OVERLAY - RTL SOURCES |"
echo -e "|-----------------------|\n"

if [ -d "$OVERLAY_SRC" ]; then
	# Take action if it exists. #
	echo -e "[sh] >> A src/ directory has been found -> $OVERLAY_SRC"
	echo -e "[sh] >> This location should comprise SystemVerilog source files to parametrize the PULP-based overlay system."
	echo -e "\n[sh] >> Is it a correct path? [ans=1,2,3]"

	select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	echo -e ""
					break;;
			no ) 	error_exit "[sh] >> Erroneous path for system-level integration! Aborting.";;
			help ) 	echo -e "\n[sh] >> Content of $OVERLAY_SRC:\n" 
					ls -1 $OVERLAY_SRC
					echo -e "\n"
					echo -e "\n[sh] >> Is it a correct path?";;
		esac
	done
else
	# Take action if it does not exist. #
	error_exit "[sh] >> No src/ directory has been found. Be sure to properly setup your $HERO_OV_HW_EXPORT environment."
fi

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------ #
#  Check if OVERLAY_DEPS exists  #
# ------------------------------ #

echo -e "|----------------------------|"
echo -e "| OVERLAY - RTL DEPENDENCIES |"
echo -e "|----------------------------|\n"

if [ -d "$OVERLAY_DEPS" ]; then
	# Take action if it exists. #
	echo -e "[sh] >> A deps/ directory has been found -> $OVERLAY_DEPS"
	echo -e "[sh] >> This location should comprise SystemVerilog dependencies. Basically, the overlay IPs (RISC-V core, DMA, HWPE accelerators, etc.)."
	echo -e "\n[sh] >> Is it a correct path? [ans=1,2,3]"

	select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	echo -e ""
					break;;
			no ) 	error_exit "[sh] >> Erroneous path for system-level integration! Aborting.";;
			help ) 	echo -e "\n[sh] >> Content of $OVERLAY_DEPS:\n" 
					ls -1 $OVERLAY_DEPS
					echo -e "\n"
					echo -e "\n[sh] >> Is it a correct path?";;
		esac
	done
else
	# Take action if it does not exist. #
	error_exit "[sh] >> No deps/ directory has been found. Be sure to properly setup your $HERO_OV_HW_EXPORT environment."
fi

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------ #
#  Check if OVERLAY_TEST exists  #
# ------------------------------ #

echo -e "|--------------------------|"
echo -e "| OVERLAY - RTL TEST SUITE |"
echo -e "|--------------------------|\n"

if [ -d "$OVERLAY_TEST" ]; then
	# Take action if it exists. #
	echo -e "[sh] >> A test/ directory has been found -> $OVERLAY_TEST"
	echo -e "[sh] >> This location comprises a SystemVerilog testbench to simulate the hardware behavior."
	echo -e "\n[sh] >> Is it a correct path? [ans=1,2,3]"

	select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	echo -e ""
					break;;
			no ) 	error_exit "[sh] >> Erroneous path for system-level integration! Aborting.";;
			help ) 	echo -e "\n[sh] >> Content of $OVERLAY_TEST:\n" 
					ls -1 $OVERLAY_TEST
					echo -e "\n"
					echo -e "\n[sh] >> Is it a correct path?";;
		esac
	done
else
	# Take action if it does not exist. #
	error_exit "[sh] >> No test/ directory has been found. Be sure to properly setup your $HERO_OV_HW_EXPORT environment."
fi

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

echo -e "[sh] >> Completed checking the overlay hardware environment."

# ----------------------------- #
#  Completed environment check  #
# ----------------------------- #