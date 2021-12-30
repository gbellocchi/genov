# =====================================================================
# Project:      Makefile
# Title:        ov_deploy.mk
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

ov_deploy: ov_deploy_src

# # overlay_integration: clean_ov_env overlay_src overlay_deps

# # hwpe_gen_app: test_ov_env overlay_src clean_hwpe_gen_app
# # 	@echo -e ">> Connecting HWPE wrapper to the overlay."
# # 	@cp -r ${OV_GEN_HW_DIR}/hwpe_wrapper/* ${OVERLAY_DEPS}/hwpe-gen-app/
# # 	@cp -r ${OV_GEN_SW_DIR} ${OVERLAY_DEPS}/hwpe-gen-app/
# # 	@cp ${OV_GEN_HW_DIR}/hwpe_wrapper/Bender.yml ${OVERLAY_DEPS}/hwpe-gen-app/

# overlay_deps: test_ov_env overlay_src
# 	@echo -e ">> Connecting HWPE wrapper to the overlay."
# 	@cp -r ${OV_GEN_HW_DIR}/hwpe_wrapper ${OVERLAY_DEPS}/hwpe_${HWPE_TARGET}
# 	@cp -r ${OV_GEN_SW_DIR} ${OVERLAY_DEPS}/hwpe_${HWPE_TARGET}/

ov_deploy_src: ov_deploy_test
	@bash ${SCRIPTS_OV_DEPLOY}/$@.sh ${OUT_OV_GEN} ${OVERLAY_SRC} ${OVERLAY_CLUSTER} ${OVERLAY_TEST}

ov_deploy_cfg: ov_deploy_test
	@bash ${SCRIPTS_OV_DEPLOY}/$@.sh ${OUT_OV_GEN} ${OVERLAY_CFG}

# clean_ov_env: test_ov_env clean_hwpe_gen_app
# 	@rm -rf ${OVERLAY_DEPS}/hwpe-${HWPE_TARGET}-wrapper
# 	@rm -f ${OVERLAY_SRC}/ov_acc_pkg.sv
# 	@rm -f ${OVERLAY_CLUSTER}/ov_acc_intf.sv

# # clean_hwpe_gen_app: test_ov_env
# # 	@rm -rf ${OVERLAY_DEPS}/hwpe-gen-app/rtl
# # 	@rm -rf ${OVERLAY_DEPS}/hwpe-gen-app/wrap
# # 	@rm -rf ${OVERLAY_DEPS}/hwpe-gen-app/sw
# # 	@rm -rf ${OVERLAY_DEPS}/hwpe-gen-app/Bender.yml

ov_deploy_test: common_sh
	@bash ${SCRIPTS_OV_DEPLOY}/$@.sh ${OVERLAY_SRC} ${OVERLAY_CLUSTER} ${OVERLAY_TEST}

# ov_deploy_clean: ov_deploy_test
# 	@bash ${SCRIPTS_OV_DEPLOY}/$@.sh ${OVERLAY_SRC} ${OVERLAY_CLUSTER} ${OVERLAY_TEST}