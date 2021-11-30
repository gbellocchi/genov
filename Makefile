# =====================================================================
# Project:      Makefile
# Title:        Makefile
# Description: 	Root Makefile. 
#
#				Recipes are read from sub-mk-files to:
#
#					>> Set up the tool environment;
#					>> Generate accelerator HW/SW components;
#					>> Generate overlay HW/SW components;
#					>> Guide system-level integration.
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

ROOT 			:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
REPO 			:= genacc

# =====================================================================
# Description:  Choose a target accelerator configuration to be generated.
#
# Source: 		Specification files are kept under genov/src/accelerators.
#
# Extensions	To add new versions, create a new configuration, insert
#				among the sources and target it using this Makefile. 
#				Configuration examples have been included to guide the 
#				user through this.
# =====================================================================

TARGET_ACC		:= conv_mdc

# =====================================================================
# Description:  Choose a target overlay configuration to be generated.
#
# Source: 		Specification files are kept under genov/src/overlays.
#
# Extensions	To add new versions, create a new configuration, insert
#				among the sources and target it using this Makefile. 
#				Configuration examples have been included to guide the 
#				user through this.
# =====================================================================

TARGET_OV		:= ov_a

# =====================================================================
# Description:  Basic recipes and inclusion of sub-mk-files.
# =====================================================================

-include tools/common_mk/*.mk

.PHONY: all clean

all: acc_gen ov_gen

clean: py_env_clean acc_gen_clean acc_deploy_clean ov_gen_clean