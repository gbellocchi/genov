# =====================================================================
# Project:      Makefile
# Title:        gen.mk
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

acc_gen_run: check_ov_env acc_gen_clean acc_gen_get_engine #static_rtl
	@bash ${SCRIPTS_GEN}/$@.sh ${PY_VENV} ${OUT_DIR}
	
acc_gen_get_engine: check_ov_env acc_gen_lib
	@ls ${ENG_DEV_RTL} >> ${HW_MNGT_DIR}/rtl_list/engine_list.log

acc_gen_lib: check_ov_env
	@cd ${GENACC_ROOT}/acc_lib && make -s clean all TARGET=${HWPE_TARGET} TEMPLATES=${TEMPLATES} ENG_DEV=${ENG_DEV}

acc_gen_init:
	@bash ${SCRIPTS_GEN}/$@.sh

acc_gen_clean: check_ov_env
	@bash ${SCRIPTS_GEN}/$@.sh $(ENG_DEV) $(PY_ENV_DIR) ${HW_MNGT_DIR} ${OUT_DIR}