# =====================================================================
# Project:      Scripts - Generation environment
# Title:        ov_gen.sh
# Description:  Generate accelerator-rich overlay.
#
# $Date:        22.12.2021
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

# ========= #
# Functions #
# ========= #

# =====================================================================
# Title:        init_generation
# Description:  Preliminary operation to let the generation process proceed
#               with all the required information about the input specifications.
# =====================================================================

init_generation()
{
    echo -e ""
    echo "# ==================================== #"
    echo "# Initialization of overlay generation #"
    echo "# ==================================== #"
    echo -e ""

    make --silent ov_gen_init
}

# =====================================================================
# Title:        fetch_ov_specs
# Description:  This shell function invokes the 'ov_gen.mk' recipes to
#               fetch the target from the overlay library and mirror
#               it in a runtime device environment. The latter is meant 
#               to hold a high-level description of the output acc-rich 
#               overlay system together with the acceleration kernel 
#               targets. Mirroring also permits avoiding breaking the 
#               accelerator and overlay libraries.
# =====================================================================

fetch_ov_specs()
{
    echo -e ""
    echo "# ===================================== #"
    echo "# Fetching overlay input specifications #" 
    echo "# ===================================== #"
    echo -e ""

    # Cleaning generated overlay
    cd $dir_root
    make --silent ov_gen_clean

    # Fetch accelerator specifications
    echo "[sh] >> Fetching overlay target"
    make --silent ov_gen_fetch_specs
}

# =====================================================================
# Title:        gen_acc_wrappers
# Description:  This shell function invokes the 'acc_gen.mk' recipes to
#               generate accelerator wrappers compliant with the overlay 
#               infrastructure. Furthermore, the procedure derives design 
#               parameters to optimize the generated accelerator-rich overlay 
#               on the basis of the application needs.
# =====================================================================

gen_acc_wrappers()
{
    # Cleaning generated overlay
    cd $dir_root
    make --silent acc_gen
}

# =====================================================================
# Title:        gen_overlay
# Description:  This shell function invokes the 'ov_gen.mk' recipes to
#               generate accelerator wrappers compliant with the overlay 
#               infrastructure. Furthermore, the procedure derives design 
#               parameters to optimize the generated accelerator-rich overlay 
#               on the basis of the application needs.
# =====================================================================

gen_overlay()
{
    echo -e ""
    echo "# ====================================== #"
    echo "# Generation of accelerator-rich overlay #"
    echo "# ====================================== #"
    echo -e ""

    # Generate target overlay
    cd $dir_root
    make --silent ov_gen_out_env
    make --silent ov_gen_run
}

# ======= #
# Program #
# ======= #

# Read Makefile arguments
readonly dir_root=$1
readonly dir_devs=$2
readonly dir_py_venv=$3
readonly dir_ov_src=$4
readonly dir_ov_out=$5

readonly dir_ov_dev=$dir_devs/ov_dev

# Activate environment
source $dir_py_venv/bin/activate

# ================================= #
# Generate accelerator-rich overlay #
# ================================= #

# Initialize generation
init_generation

# Fetch overlay specifications
fetch_ov_specs

# Generate accelerator wrappers
gen_acc_wrappers

# Generate overlay
gen_overlay

# Deactivate environment
deactivate