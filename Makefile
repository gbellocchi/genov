########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------- #
#  SETUP  #
# ------- #

ROOT 					:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# Python version

PY_VER					:= 2.7

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------- #
#  APPLICATION  #
# ------------- #

# Choose target on those available in the application library (e.g. mmul_parallel)

HWPE_TARGET				:= conv

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------ #
#  TOOL ENVIRONMENT  #
# ------------------ #

# Templates

TEMPLATES 				:= ${ROOT}/templates
HW_DIR					:= ${TEMPLATES}/hw
HW_MNGT_DIR				:= ${TEMPLATES}/hw_management
SW_DIR					:= ${TEMPLATES}/sw

# Engine

ENG_DEV 				:= ${ROOT}/engine_dev/
ENG_DEV_RTL 			:= ${ENG_DEV}/rtl

# Static modules

STATIC 					:= ${ROOT}/static
STATIC_RTL_DIR 			:= ${STATIC}/static_rtl
STATIC_STREAM			:= ${STATIC_RTL_DIR}/hwpe-stream/rtl
STATIC_CTRL 			:= ${STATIC_RTL_DIR}/hwpe-ctrl-fpga

# Output content

OUT_DIR 				:= ${ROOT}/output
OUT_HW_DIR 				:= ${OUT_DIR}/hw
OUT_PULP_INTEGR			:= ${OUT_HW_DIR}/pulp_integration
OUT_SW_DIR 				:= ${OUT_DIR}/sw

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# --------------------- #
#  OVERLAY ENVIRONMENT  #
# --------------------- #

# System-level integration

OVERLAY_HW_REPO			:= ${OVERLAY_HW_EXPORT}
PULP_SRC				:= ${OVERLAY_HW_EXPORT}/src
HW_TEST					:= ${OVERLAY_HW_EXPORT}/test
HW_DEPS					:= ${OVERLAY_HW_EXPORT}/deps
PULP_CLUSTER			:= ${HW_DEPS}/overlay_cluster/rtl

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

.PHONY: all hero_deps pulp-integr specialization engine_dev static_rtl acc_lib init clean clean_overlay check-env
all: clean specialization

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------------ #
#  PHASE 3 - SYSTEM-LEVEL INTEGRATION  #
# ------------------------------------ #

hero_deps: check-env pulp-integr
	@echo "Exporting 'hwpe-${HWPE_TARGET}-wrapper' to HERO ecosystem."
	@cp -rf ${OUT_HW_DIR}/hwpe-${HWPE_TARGET}-wrapper ${HW_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@cp -rf ${OUT_SW_DIR} ${HW_DEPS}/hwpe-${HWPE_TARGET}-wrapper/

pulp-integr: check-env clean_overlay gen
	@echo "Exporting HWPE package for PULP cluster."
	@cp ${OUT_PULP_INTEGR}/pulp_cluster_hwpe_pkg.sv ${PULP_SRC}/
	@echo "Exporting PULP HWPE wrapper."
	@cp ${OUT_PULP_INTEGR}/pulp_hwpe_wrap.sv ${PULP_CLUSTER}/
	@echo "Exporting Modelsim wave script."
	@cp ${OUT_PULP_INTEGR}/pulp_tb.wave.do ${HW_TEST}/

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ---------------------------------- #
#  PHASE 2 - WRAPPER SPECIALIZATION  #
# ---------------------------------- #

specialization: check-env clean engine_dev static_rtl 
	@echo "HWPE wrapper specialization."
	@python${PY_VER} specialization.py

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# --------------------------------- #
#  PHASE 1 - GET SOURCE COMPONENTS  #
# --------------------------------- #

engine_dev: check-env acc_lib
	@ls ${ENG_DEV_RTL} >> ${HW_MNGT_DIR}/rtl_list/engine_list.log

static_rtl: check-env
	@ls -R ${STATIC_STREAM} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/stream_list.log
	@ls -R ${STATIC_CTRL} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/ctrl_list.log 

acc_lib: check-env
	@cd acc_lib && make -s clean all TARGET=${HWPE_TARGET}

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------- #
#  CLEAN ENVIRONMENT  #
# ------------------- #

clean: check-env
	@rm -rf ${ENG_DEV}/*
	@rm -rf ${OUT_HW_DIR}/*
	@rm -rf ${OUT_SW_DIR}/*
	@rm -f ${OUT_HW_MNGT_DIR}/*.yml
	@rm -f ${HW_MNGT_DIR}/rtl_list/*.log
	@find . -type d -name '__pycache__' -exec rm -rf {} +
	@find . -name "*.pyc" -type f -delete

clean_overlay: check-env
	@rm -r ${HW_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@rm ${PULP_SRC}/pulp_cluster_hwpe_pkg.sv
	@rm ${PULP_CLUSTER}/pulp_hwpe_wrap.sv

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ---------------------------- #
#  ENVIRONMENT INITIALIZATION  #
# ---------------------------- #

init: check-env
	@git submodule update --init --recursive
	@python${PY_VER} setup.py install --user

check-env:
ifndef OVERLAY_HW_EXPORT
	$(error OVERLAY_HW_EXPORT is undefined)
endif

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
	
