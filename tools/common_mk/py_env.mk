# =====================================================================
# Project:      Makefile
# Title:        py_env.mk
# Description: 	Recipes to set up python environment. 
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

py_env: py_env_clean py_env_init

py_env_update_reqs:
	@bash ${SCRIPTS_PY_ENV}/$@.sh ${PY_ENV_DIR}

py_env_init:
	@bash ${SCRIPTS_PY_ENV}/$@.sh ${PY_VENV}

py_env_test: common_sh
	@bash ${SCRIPTS_PY_ENV}/$@.sh ${PY_ENV_DIR}

py_env_clean: py_env_test
	@rm -rf ${PY_VENV}