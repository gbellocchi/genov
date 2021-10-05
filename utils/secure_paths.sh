#!/bin/bash

error_exit()
{
  echo -e "\n$1\n" 1>&2
  exit 1
}

echo -e "\nChecking overlay hardware subsystem..."

readonly OVERLAY_SRC=$1
readonly OVERLAY_DEPS=$2
readonly OVERLAY_TEST=$3

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------ #
#  Check if OVERLAY_SRC exists.  #
# ------------------------------ #

if [ -d "$OVERLAY_SRC" ]; then
  # Take action if it exists. #
  echo -e "\n...\n"
  echo -e "A src/ directory has been found -> $OVERLAY_SRC"
  echo -e "This location should comprise SystemVerilog source files to parametrize the PULP-based overlay system."
  echo -e "\nIs it a correct path?"
fi

select yn in "Yes" "No" "help"; do
	case $yn in
    	Yes ) break;;
    	No ) error_exit "Erroneous path for system-level integration! Aborting.";;
		help ) echo -e "\nContent of $OVERLAY_SRC:\n" 
			ls -1 $OVERLAY_SRC
			echo -e "\n";;
	esac
done

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------- #
#  Check if OVERLAY_DEPS exists.  #
# ------------------------------- #

if [ -d "$OVERLAY_DEPS" ]; then
  # Take action if it exists. #
  echo -e "\n...\n"
  echo -e "A deps/ directory has been found -> $OVERLAY_DEPS"
  echo -e "This location should comprise SystemVerilog dependencies. Basically, the overlay IPs (RISC-V core, DMA, HWPE accelerators, etc.)."
  echo -e "\nIs it a correct path?"
fi

select yn in "Yes" "No" "help"; do
	case $yn in
    	Yes ) break;;
    	No ) error_exit "Erroneous path for system-level integration! Aborting.";;
		help ) echo -e "\nContent of $OVERLAY_DEPS:\n" 
			ls -1 $OVERLAY_DEPS
			echo -e "\n";;
	esac
done

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------- #
#  Check if OVERLAY_TEST exists.  #
# ------------------------------- #

if [ -d "$OVERLAY_TEST" ]; then
  # Take action if it exists. #
  echo -e "\n...\n"
  echo -e "A test/ directory has been found -> $OVERLAY_TEST"
  echo -e "This location comprises a SystemVerilog testbench to simulate the hardware behavior."
  echo -e "\nIs it a correct path?"
fi

select yn in "Yes" "No" "help"; do
	case $yn in
    	Yes ) break;;
    	No ) error_exit "Erroneous path for system-level integration! Aborting.";;
		help ) echo -e "\nContent of $OVERLAY_TEST:\n" 
			ls -1 $OVERLAY_TEST
			echo -e "\n";;
	esac
done

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------ #
#  Completed environment check.  #
# ------------------------------ #