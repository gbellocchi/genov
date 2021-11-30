# =====================================================================
# Project:      Makefile
# Title:        wrapper_verif.mk
# Description: 	Recipes to guide hardware wrapper verification. 
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

acc_verif: acc_verif_clean acc_verif_setup_standalone acc_verif_gen_standalone

acc_verif_gen_standalone:
	@bash ${SCRIPTS_ACC_VERIF}/$@.sh ${OUT_ACC_GEN} ${VERIF_ACC}

acc_verif_setup_standalone:
	@bash ${SCRIPTS_ACC_VERIF}/$@.sh ${OUT_ACC_GEN} ${VERIF_ACC}

acc_verif_clean:
	@bash ${SCRIPTS_ACC_VERIF}/$@.sh ${OUT_ACC_GEN} ${VERIF_ACC}