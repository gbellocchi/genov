# =====================================================================
# Project:      Makefile
# Title:        ov_gen.mk
# Description: 	Recipes to guide generation of  accelerator-rich 
#				overlay. Variables are fed by the root Makefile.
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

ov_gen: \
	ov_gen_clean \
	ov_gen_run

ov_gen_run: ov_gen_init
	@bash ${SCRIPTS_OV_GEN}/$@.sh ${PY_VENV} ${OUT_OV_GEN}

ov_gen_init:
	@bash ${SCRIPTS_OV_GEN}/$@.sh ${PY_VENV}

ov_gen_clean: check_ov_env
	@bash ${SCRIPTS_OV_GEN}/$@.sh ${PY_VENV_DIR} ${OUT_OV_GEN}