# =====================================================================
# Project:      Makefile
# Title:        acc_deploy.mk
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

acc_deploy: \
	acc_deploy_clean \
	acc_deploy_set_local \
	acc_deploy_get_remote_repo \
	acc_deploy_push_remote_branch

acc_deploy_push_remote_branch: acc_deploy_get_remote_repo
	@bash ${SCRIPTS_ACC_DEPLOY}/$@.sh ${TARGET_ACC}

acc_deploy_get_remote_repo: acc_deploy_set_local
	@bash ${SCRIPTS_ACC_DEPLOY}/$@.sh

acc_deploy_set_local: acc_deploy_clean
	@bash ${SCRIPTS_ACC_DEPLOY}/$@.sh ${OUT_ACC_GEN} ${OUT_ACC_GEN_DEPLOY}

acc_deploy_clean:
	@bash ${SCRIPTS_ACC_DEPLOY}/$@.sh ${OUT_ACC_GEN_DEPLOY}