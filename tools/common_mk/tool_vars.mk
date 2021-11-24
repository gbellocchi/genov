# =====================================================================
# Project:      Makefile
# Title:        tool_vars.mk
# Description: 	Makefile variables shared by all recipes.
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

GEN_ROOT					:= ${ROOT}/genov

# Sources

SRC_DIR 					:= ${GEN_ROOT}/src
SRC_ACC 					:= ${SRC_DIR}/accelerators
SRC_OV 						:= ${SRC_DIR}/overlays

# Device (extracted from source)

DEV_DIR 					:= ${GEN_ROOT}/dev

# Templates

TEMPL 						:= ${GEN_ROOT}/templates

TEMPL_ACC					:= ${TEMPL}/acc_templ
TEMPL_ACC_HW_DIR			:= ${TEMPL_ACC}/hw
TEMPL_ACC_SW_DIR			:= ${TEMPL_ACC}/sw
TEMPL_ACC_HW_MNGT_DIR		:= ${TEMPL_ACC}/integr_support

TEMPL_OV					:= ${TEMPL}/ov_templ
TEMPL_OV_HW_DIR				:= ${TEMPL_OV}/hw
TEMPL_OV_SW_DIR				:= ${TEMPL_OV}/sw
TEMPL_OV_HW_MNGT_DIR		:= ${TEMPL_OV}/integr_support

# Static modules

STATIC 						:= ${GEN_ROOT}/static

# Verification

VERIF 						:= ${GEN_ROOT}/verif
VERIF_HWPE 					:= ${VERIF}/hwpe-tb

# Output content

OUT_DIR 					:= ${GEN_ROOT}/output

OUT_ACC_GEN					:= ${OUT_DIR}/acc_gen
OUT_ACC_GEN_HW_DIR 			:= ${OUT_ACC_GEN}/hw
OUT_ACC_GEN_SW_DIR 			:= ${OUT_ACC_GEN}/sw
OUT_ACC_GEN_DEPLOY			:= ${OUT_ACC_GEN}/acc_deploy

OUT_OV_GEN					:= ${OUT_DIR}/ov_gen
OUT_OV_GEN_HW_DIR 			:= ${OUT_OV_GEN}/ov_gen/hw
OUT_OV_GEN_SW_DIR 			:= ${OUT_OV_GEN}/ov_gen/sw
OUT_OV_GEN_INTEGR_SUPPORT	:= ${OUT_OV_GEN}/ov_gen/integr_support

# Tools

TOOLS_DIR					:= ${ROOT}/tools

# Scripts

SCRIPTS_DIR					:= ${TOOLS_DIR}/common_sh
SCRIPTS_ACC_GEN				:= ${SCRIPTS_DIR}/acc_gen
SCRIPTS_ACC_DEPLOY			:= ${SCRIPTS_DIR}/acc_deploy
SCRIPTS_OV_GEN				:= ${SCRIPTS_DIR}/ov_gen
SCRIPTS_OV_DEPLOY			:= ${SCRIPTS_DIR}/ov_deploy
SCRIPTS_PY_ENV				:= ${SCRIPTS_DIR}/py_env
SCRIPTS_VERIF				:= ${SCRIPTS_DIR}/verif

# Python virtual environment

PY_VENV 					:= local_py_env
PY_VENV_DIR					:= ${ROOT}/${PY_VENV}

# System-level integration

OVERLAY_HW_REPO				:= ${HERO_OV_HW_EXPORT}
OVERLAY_SRC					:= ${HERO_OV_HW_EXPORT}/src
OVERLAY_DEPS				:= ${HERO_OV_HW_EXPORT}/deps
OVERLAY_TEST				:= ${HERO_OV_HW_EXPORT}/test
OVERLAY_CLUSTER				:= ${OVERLAY_DEPS}/overlay_cluster/rtl