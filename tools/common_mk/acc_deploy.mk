# =====================================================================
# Project:      Makefile
# Title:        ov_integr_git.mk
# Description: 	Recipes to guide git deployment of hardware wrapper. 
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

git_acc_deploy_branch:
	@bash ${SCRIPTS_GIT_DEPLOY}/$@.sh ${HWPE_TARGET}

git_acc_get_remote_repo:
	@bash ${SCRIPTS_GIT_DEPLOY}/$@.sh

git_acc_set_local:
	@bash ${SCRIPTS_GIT_DEPLOY}/$@.sh ${OUT_DIR}

git_acc_clean_repo:
	@bash ${SCRIPTS_GIT_DEPLOY}/$@.sh ${OUT_DIR}