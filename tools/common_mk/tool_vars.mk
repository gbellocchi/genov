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

GENACC_ROOT				:= ${ROOT}/genacc

# Templates

TEMPLATES 				:= ${GENACC_ROOT}/templates
HW_DIR					:= ${TEMPLATES}/hw
HW_MNGT_DIR				:= ${TEMPLATES}/integr_support
SW_DIR					:= ${TEMPLATES}/sw

# Engine

ENG_DEV 				:= ${GENACC_ROOT}/engine_dev
ENG_DEV_RTL 			:= ${ENG_DEV}/rtl

# Static modules

STATIC 					:= ${GENACC_ROOT}/static
STATIC_RTL_DIR 			:= ${STATIC}/static_rtl
STATIC_STREAM			:= ${STATIC_RTL_DIR}/hwpe-stream
STATIC_CTRL 			:= ${STATIC_RTL_DIR}/hwpe-ctrl

# Verification

VERIF 					:= ${GENACC_ROOT}/verif
VERIF_HWPE 				:= ${VERIF}/hwpe-tb

# Output content

OUT_DIR 				:= ${GENACC_ROOT}/output
OUT_HW_DIR 				:= ${OUT_DIR}/hw
OUT_SW_DIR 				:= ${OUT_DIR}/sw
OUT_INTEGR_SUPPORT		:= ${OUT_DIR}/integr_support

# Tools

TOOLS_DIR				:= ${ROOT}/tools

# Scripts

SCRIPTS_DIR				:= ${TOOLS_DIR}/common_sh
SCRIPTS_GEN				:= ${SCRIPTS_DIR}/gen
SCRIPTS_VERIF			:= ${SCRIPTS_DIR}/verif
SCRIPTS_PY_ENV			:= ${SCRIPTS_DIR}/py-env
SCRIPTS_OV_DEPLOY		:= ${SCRIPTS_DIR}/ov-deploy
SCRIPTS_GIT_DEPLOY		:= ${SCRIPTS_DIR}/git-deploy

# Python virtual environment
PY_VENV 				:= ${REPO}_py_env
PY_ENV_DIR				:= ${ROOT}/${PY_VENV}

# System-level integration

OVERLAY_HW_REPO			:= ${HERO_OV_HW_EXPORT}
OVERLAY_SRC				:= ${HERO_OV_HW_EXPORT}/src
OVERLAY_DEPS			:= ${HERO_OV_HW_EXPORT}/deps
OVERLAY_TEST			:= ${HERO_OV_HW_EXPORT}/test
OVERLAY_CLUSTER			:= ${OVERLAY_DEPS}/overlay_cluster/rtl