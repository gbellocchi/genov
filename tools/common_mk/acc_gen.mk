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

acc_gen:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh \
		${ROOT} \
		${DEV_DIR} \
		${PY_VENV_DIR} \
		${SRC_ACC} \
		${OUT_ACC_GEN}

acc_gen_run:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh \
		${TARGET_ACC} \
		${PY_VENV} \
		${OUT_ACC_GEN}
	
acc_gen_out_env:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh \
		${TARGET_ACC} \
		${DEV_DIR}/acc_dev \
		${STATIC} \
		${OUT_ACC_GEN}

acc_gen_init:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh \
		${PY_VENV}

acc_gen_get_engine:
	@ls ${DEV_DIR}/acc_dev/${TARGET_ACC}/rtl >> ${TEMPL_ACC_HW_MNGT_DIR}/rtl_list/engine_list.log

acc_gen_clean: check_ov_env
	@bash ${SCRIPTS_ACC_GEN}/$@.sh \
		${DEV_DIR}/acc_dev \
		${PY_VENV_DIR} \
		${TEMPL_ACC} \
		${OUT_ACC_GEN}