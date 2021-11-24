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

# Templates

TEMPLATES 					:= ${GEN_ROOT}/templates
HW_DIR						:= ${TEMPLATES}/hw
HW_MNGT_DIR					:= ${TEMPLATES}/integr_support
SW_DIR						:= ${TEMPLATES}/sw

# Engine

ENG_DEV 					:= ${GEN_ROOT}/engine_dev
ENG_DEV_RTL 				:= ${ENG_DEV}/rtl

# Static modules

STATIC 						:= ${GEN_ROOT}/static
# STATIC_RTL_DIR 			:= ${STATIC}/static_rtl
# STATIC_STREAM				:= ${STATIC_RTL_DIR}/hwpe-stream
# STATIC_CTRL 				:= ${STATIC_RTL_DIR}/hwpe-ctrl

# Verification

VERIF 						:= ${GEN_ROOT}/verif
VERIF_HWPE 					:= ${VERIF}/hwpe-tb

# Output content

OUT_DIR 					:= ${GEN_ROOT}/output

OUT_ACC_GEN					:= ${OUT_DIR}/acc_gen
ACC_GEN_HW_DIR 				:= ${OUT_ACC_GEN}/hw
ACC_GEN_SW_DIR 				:= ${OUT_ACC_GEN}/sw
ACC_GEN_DEPLOY				:= ${OUT_ACC_GEN}/acc_deploy

OUT_OV_GEN					:= ${OUT_DIR}/ov_gen
OV_GEN_HW_DIR 				:= ${OUT_OV_GEN}/ov_gen/hw
OV_GEN_SW_DIR 				:= ${OUT_OV_GEN}/ov_gen/sw
OV_GEN_INTEGR_SUPPORT		:= ${OUT_OV_GEN}/ov_gen/integr_support

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
PY_ENV_DIR					:= ${ROOT}/${PY_VENV}

# System-level integration

OVERLAY_HW_REPO				:= ${HERO_OV_HW_EXPORT}
OVERLAY_SRC					:= ${HERO_OV_HW_EXPORT}/src
OVERLAY_DEPS				:= ${HERO_OV_HW_EXPORT}/deps
OVERLAY_TEST				:= ${HERO_OV_HW_EXPORT}/test
OVERLAY_CLUSTER				:= ${OVERLAY_DEPS}/overlay_cluster/rtl