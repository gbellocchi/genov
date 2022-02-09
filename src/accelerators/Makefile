# =====================================================================
# Project:      Accelerator source library
# Description: 	Recipes to extract accelerator source specifications to
#				guide application-level integration of acceleration kernels
#				into target hardware wrappers. The latter are to aid the
#				integration of acceleration kernels inside the target 
#				system architecture.
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
	
all: lib_info
	@echo "[sh] >> Building runtime accelerator device environment"
	@cp -rf ${TARGET_ACC} ${ACC_DEV_DIR}/${TARGET_ACC}
lib_info:
	@echo -e "[sh] >> Runtime accelerator device environment:\n"
	@echo -e "\t- Location -> ${ACC_DEV_DIR}"
	@echo -e "\t- Target device -> ${TARGET_ACC}\n"
clean:
	@echo "[sh] >> Cleaning runtime accelerator device environment"
	@rm -rf ${ACC_DEV_DIR}/${TARGET_ACC}
	
