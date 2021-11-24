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

gen_standalone:
	@bash ${SCRIPTS_VERIF}/gen_standalone.sh ${OUT_ACC_GEN} ${VERIF_HWPE}

setup_standalone: common_sh
	@bash ${SCRIPTS_VERIF}/setup_standalone.sh ${OUT_ACC_GEN} ${VERIF_HWPE}