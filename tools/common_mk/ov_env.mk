# =====================================================================
# Project:      Makefile
# Title:        ov_env.mk
# Description: 	Recipes to check overlay environment. 
#				Variables are fed by the root Makefile.
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

test_ov_env: common_sh check_ov_env
ifndef ENV_IS_CHECKED
	@bash ${SCRIPTS_OV_DEPLOY}/secure_paths.sh ${OVERLAY_SRC} ${OVERLAY_DEPS} ${OVERLAY_TEST}
endif

check_ov_env:
ifndef HERO_OV_HW_EXPORT
	$(error HERO_OV_HW_EXPORT is undefined)
endif