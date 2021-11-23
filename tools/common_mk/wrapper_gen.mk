# =====================================================================
# Project:      Makefile
# Title:        wrapper_gen.mk
# Description: 	Recipes to guide hardware wrapper generation. 
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

run_gen: check_ov_env clean_gen engine_dev #static_rtl
	@bash ${SCRIPTS_GEN}/run_gen.sh ${PY_VENV} ${OUT_DIR}

# static_rtl: check_ov_env
# @ls -R ${STATIC_STREAM} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/stream_list.log
# @ls -R ${STATIC_CTRL} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/ctrl_list.log 
	
engine_dev: check_ov_env acc_lib
	@ls ${ENG_DEV_RTL} >> ${HW_MNGT_DIR}/rtl_list/engine_list.log

acc_lib: check_ov_env
	@cd ${GENACC_ROOT}/acc_lib && make -s clean all TARGET=${HWPE_TARGET} TEMPLATES=${TEMPLATES} ENG_DEV=${ENG_DEV}