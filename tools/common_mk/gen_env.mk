# =====================================================================
# Project:      Makefile
# Title:        gen_env.mk
# Description: 	Recipes to set up overlay environment. 
#              	Variables are fed by the root Makefile.
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

clean_gen: check_ov_env
	@bash ${SCRIPTS_GEN}/clean_gen.sh $(ENG_DEV) $(PY_ENV_DIR) ${HW_MNGT_DIR} ${OUT_DIR}

init_gen:
	@bash ${SCRIPTS_GEN}/init_gen.sh