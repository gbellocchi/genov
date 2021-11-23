# =====================================================================
# Project:      Makefile
# Title:        ov_env.mk
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

clean_ov_env: test_ov_env clean_hwpe_gen_app
	@rm -rf ${OVERLAY_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@rm -f ${OVERLAY_SRC}/ov_acc_pkg.sv
	@rm -f ${OVERLAY_CLUSTER}/ov_acc_intf.sv

clean_hwpe_gen_app: test_ov_env
	@rm -rf ${OVERLAY_DEPS}/hwpe-gen-app/rtl
	@rm -rf ${OVERLAY_DEPS}/hwpe-gen-app/wrap
	@rm -rf ${OVERLAY_DEPS}/hwpe-gen-app/sw
	@rm -rf ${OVERLAY_DEPS}/hwpe-gen-app/Bender.yml

test_ov_env: common_sh check_ov_env
ifndef ENV_IS_CHECKED
	@bash ${SCRIPTS_OV_DEPLOY}/secure_paths.sh ${OVERLAY_SRC} ${OVERLAY_DEPS} ${OVERLAY_TEST}
endif

check_ov_env:
ifndef HERO_OV_HW_EXPORT
	$(error HERO_OV_HW_EXPORT is undefined)
endif