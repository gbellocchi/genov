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

HWPE_TARGET				:= mmul_parallel

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
OUT_OVERLAY_INTEGR		:= ${OUT_HW_DIR}/overlay_integration
OUT_SW_DIR 				:= ${OUT_DIR}/sw

# Scripts

UTILS_DIR				:= ${ROOT}/utils

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# --------------------- #
#  OVERLAY ENVIRONMENT  #
# --------------------- #

# System-level integration

OVERLAY_HW_REPO			:= ${OVERLAY_HW_EXPORT}
OVERLAY_SRC				:= ${OVERLAY_HW_EXPORT}/src
OVERLAY_DEPS			:= ${OVERLAY_HW_EXPORT}/deps
OVERLAY_TEST			:= ${OVERLAY_HW_EXPORT}/test
OVERLAY_CLUSTER			:= ${OVERLAY_DEPS}/overlay_cluster/rtl

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

.PHONY: all overlay_integration overlay_deps overlay_src specialization engine_dev static_rtl acc_lib init clean clean_overlay test_env check_env
all: clean specialization

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------------ #
#  PHASE 3 - SYSTEM-LEVEL INTEGRATION  #
# ------------------------------------ #

overlay_integration: clean_overlay overlay_src overlay_deps

overlay_deps: check_env overlay_src
	@echo -e "Connecting 'hwpe-${HWPE_TARGET}-wrapper' to the overlay..."
	@cp -r ${OUT_HW_DIR}/hwpe-${HWPE_TARGET}-wrapper ${OVERLAY_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@cp -r ${OUT_SW_DIR} ${OVERLAY_DEPS}/hwpe-${HWPE_TARGET}-wrapper/
	@echo -e "								...All done!"

overlay_src: check_env specialization
	@echo -e "Exporting accelerator package to perform system-level optimization."
	@cp ${OUT_OVERLAY_INTEGR}/ov_acc_pkg.sv ${OVERLAY_SRC}/
	@echo -e "Exporting accelerator interface to perform system-level integration."
	@cp ${OUT_OVERLAY_INTEGR}/ov_acc_intf.sv ${OVERLAY_CLUSTER}/
	@echo -e "Exporting Modelsim wave script to perform system-level testing."
	@cp ${OUT_OVERLAY_INTEGR}/pulp_tb.wave.do ${OVERLAY_TEST}/

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ---------------------------------- #
#  PHASE 2 - WRAPPER SPECIALIZATION  #
# ---------------------------------- #

specialization: check_env clean engine_dev static_rtl 
	@echo "HWPE wrapper specialization."
	@python${PY_VER} specialization.py

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# --------------------------------- #
#  PHASE 1 - GET SOURCE COMPONENTS  #
# --------------------------------- #

engine_dev: check_env acc_lib
	@ls ${ENG_DEV_RTL} >> ${HW_MNGT_DIR}/rtl_list/engine_list.log

static_rtl: check_env
	@ls -R ${STATIC_STREAM} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/stream_list.log
	@ls -R ${STATIC_CTRL} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/ctrl_list.log 

acc_lib: check_env
	@cd acc_lib && make -s clean all TARGET=${HWPE_TARGET}

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------- #
#  CLEAN ENVIRONMENT  #
# ------------------- #

clean: check_env
	@rm -rf ${ENG_DEV}/*
	@rm -rf ${OUT_HW_DIR}/*
	@rm -rf ${OUT_SW_DIR}/*
	@rm -f ${OUT_HW_MNGT_DIR}/*.yml
	@rm -f ${HW_MNGT_DIR}/rtl_list/*.log
	@find . -type d -name '__pycache__' -exec rm -rf {} +
	@find . -name "*.pyc" -type f -delete

clean_overlay: test_env
	@rm -rf ${OVERLAY_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@rm -f ${OVERLAY_SRC}/pulp_cluster_hwpe_pkg.sv
	@rm -f ${OVERLAY_CLUSTER}/pulp_hwpe_wrap.sv

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ---------------------------- #
#  ENVIRONMENT INITIALIZATION  #
# ---------------------------- #

test:
	@rm -f struct_mod.txt
	@python3 struct_mod.py
	@code struct_mod.txt

init: test_env
	@git submodule update --init --recursive
	@python${PY_VER} setup.py install --user

test_env: check_env
ifndef ENV_IS_CHECKED
	@${UTILS_DIR}/secure_paths.sh ${OVERLAY_SRC} ${OVERLAY_DEPS} ${OVERLAY_TEST}
endif

check_env:
ifndef OVERLAY_HW_EXPORT
	$(error OVERLAY_HW_EXPORT is undefined)
endif

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
	
