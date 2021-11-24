# =====================================================================
# Project:      Makefile
# Title:        common.mk
# Description: 	Recipes to invoke shared shell functions or scripts.
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

common_sh:
	@bash ${SCRIPTS_DIR}/common.sh ${HWPE_TARGET}