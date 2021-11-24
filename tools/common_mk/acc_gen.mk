# =====================================================================
# Project:      Makefile
# Title:        acc_gen.mk
# Description: 	Recipes to guide generation of hardware wrapper. 
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

acc_gen: \
	acc_gen_clean \
	acc_gen_run

acc_gen_run: acc_gen_get_engine acc_gen_init
	@bash ${SCRIPTS_ACC_GEN}/$@.sh ${PY_VENV} ${OUT_ACC_GEN}
	
acc_gen_get_engine: acc_gen_lib
	@ls ${ENG_DEV_RTL} >> ${TEMPL_ACC_HW_MNGT_DIR}/rtl_list/engine_list.log

acc_gen_lib:
	@cd ${SRC_ACC} && make -s clean all TARGET=${HWPE_TARGET} TEMPLATES=${TEMPL} ENG_DEV=${ENG_DEV}

acc_gen_init:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh ${PY_VENV}

acc_gen_clean: check_ov_env
	@bash ${SCRIPTS_ACC_GEN}/$@.sh ${ENG_DEV} ${PY_VENV_DIR} ${TEMPL_ACC} ${OUT_ACC_GEN}