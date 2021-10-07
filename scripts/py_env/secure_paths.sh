########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/bin/bash

error_exit()
{
  echo -e "\n$1\n" 1>&2
  exit 1
}

echo -e "\nChecking Python virtual environment..."

readonly GEN_VENV=$1

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# --------------------------- #
#  Check if GEN_VENV exists.  #
# --------------------------- #

if [ -d "$GEN_VENV" ]; then
  # Take action if it exists. #
  echo -e "\n...\n"
  echo -e "A py-venv path has been found -> $GEN_VENV"
  echo -e "This location should correespond to the local Python virtual environment for the generator."
  echo -e "\nIs it a correct path?"
fi

select yn in "yes" "no" "help"; do
	case $yn in
    	yes ) break;;
    	no ) error_exit "Erroneous path for Python virtual environmen! Aborting.";;
		help ) echo -e "\nContent of $GEN_VENV:\n" 
			ls -1 $GEN_VENV
			echo -e "\n";;
	esac
done

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------ #
#  Completed environment check.  #
# ------------------------------ #