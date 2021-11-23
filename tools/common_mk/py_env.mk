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

clean_py_env: test_py_env
	@rm -rf ${PY_VENV}

init_py_env:
	@bash ${SCRIPTS_PY_ENV}/init_py_env.sh ${PY_VENV}

update_reqs_py_env:
	@bash ${SCRIPTS_PY_ENV}/update_reqs.sh ${PY_ENV_DIR}

test_py_env: common_sh
	@bash ${SCRIPTS_PY_ENV}/secure_paths.sh ${PY_ENV_DIR}