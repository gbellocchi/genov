# =====================================================================
# Project:      Makefile
# Title:        ov_integr.mk
# Description: 	Recipes to guide integration of hardware accelerators 
#				at system-level. Variables are fed by the root Makefile.
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

overlay_integration: clean_ov_env overlay_src overlay_deps

hwpe_gen_app: test_ov_env overlay_src clean_hwpe_gen_app
	@echo -e ">> Connecting HWPE wrapper to the overlay."
	@cp -r ${OUT_HW_DIR}/hwpe_wrapper/* ${OVERLAY_DEPS}/hwpe-gen-app/
	@cp -r ${OUT_SW_DIR} ${OVERLAY_DEPS}/hwpe-gen-app/
	@cp ${OUT_HW_DIR}/hwpe_wrapper/Bender.yml ${OVERLAY_DEPS}/hwpe-gen-app/

overlay_deps: test_ov_env overlay_src
	@echo -e ">> Connecting HWPE wrapper to the overlay."
	@cp -r ${OUT_HW_DIR}/hwpe_wrapper ${OVERLAY_DEPS}/hwpe_${HWPE_TARGET}
	@cp -r ${OUT_SW_DIR} ${OVERLAY_DEPS}/hwpe_${HWPE_TARGET}/

overlay_src: check_ov_env
	@bash ${SCRIPTS_OV_DEPLOY}/ov-deploy.sh ${OUT_DIR} ${OVERLAY_SRC} ${OVERLAY_CLUSTER} ${OVERLAY_TEST}