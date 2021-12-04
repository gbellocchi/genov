# =====================================================================
# Project:      Overlay source library
# Description: 	Recipes to extract overlay source specifications to
#				guide system-level design and exploration of 
#				accelerator-rich architectures.
#
# $Date:        24.11.2021
#
# =====================================================================
#
# Copyright (C) 2021 University of Modena and Reggio Emilia.
#
# Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
#
# =====================================================================

ROOT 				:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

.PHONY: all clean
all:
	@cp -rf ${TARGET_OV} ${DEV_DIR}/ov_dev
clean:
	@rm -rf ${DEV_DIR}/ov_dev
	
