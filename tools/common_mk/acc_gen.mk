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

acc_gen_run: acc_gen_get_engine acc_gen_out_env
	@bash ${SCRIPTS_ACC_GEN}/$@.sh ${PY_VENV} ${OUT_ACC_GEN}
	
acc_gen_out_env:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh ${OUT_ACC_GEN} ${DEV_DIR} ${STATIC}
	
acc_gen_get_engine: acc_gen_lib
	@ls ${DEV_DIR}/acc_dev/rtl >> ${TEMPL_ACC_HW_MNGT_DIR}/rtl_list/engine_list.log

acc_gen_lib:
	@cd ${SRC_ACC} && make -s clean all TARGET_ACC=${TARGET_ACC} DEV_DIR=${DEV_DIR}

acc_gen_init:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh ${PY_VENV}

acc_gen_clean: check_ov_env
	@bash ${SCRIPTS_ACC_GEN}/$@.sh ${DEV_DIR} ${PY_VENV_DIR} ${TEMPL_ACC} ${OUT_ACC_GEN}