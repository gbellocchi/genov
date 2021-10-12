########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------- #
#  SETUP  #
# ------- #

ROOT 					:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
REPO 					:= genacc

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------- #
#  APPLICATION  #
# ------------- #

# Choose target on those available in the application library (e.g. mmul_parallel)

HWPE_TARGET				:= mmul_opt

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

ENG_DEV 				:= ${ROOT}/engine_dev
ENG_DEV_RTL 			:= ${ENG_DEV}/rtl

# Static modules

STATIC 					:= ${ROOT}/static
STATIC_RTL_DIR 			:= ${STATIC}/static_rtl
STATIC_STREAM			:= ${STATIC_RTL_DIR}/hwpe-stream
STATIC_CTRL 			:= ${STATIC_RTL_DIR}/hwpe-ctrl

# Output content

OUT_DIR 				:= ${ROOT}/output
OUT_HW_DIR 				:= ${OUT_DIR}/hw
OUT_OVERLAY_INTEGR		:= ${OUT_HW_DIR}/overlay_integration
OUT_SW_DIR 				:= ${OUT_DIR}/sw

# Scripts

SCRIPTS_DIR				:= ${ROOT}/scripts
SCRIPTS_GEN				:= ${SCRIPTS_DIR}/gen
SCRIPTS_PY_ENV			:= ${SCRIPTS_DIR}/py_env
SCRIPTS_SYS_INTEGR		:= ${SCRIPTS_DIR}/sys_integr

# Python virtual environment
PY_VENV 				:= ${REPO}_py_env
PY_ENV_DIR				:= ${ROOT}/${PY_VENV}

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

.PHONY: all

all: clean_gen run_gen

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# -------------------------- #
#  SYSTEM-LEVEL INTEGRATION  #
# -------------------------- #

overlay_integration: clean_ov_env overlay_src overlay_deps

overlay_deps: check_ov_env overlay_src
	@echo -e ">> Connecting 'hwpe-${HWPE_TARGET}-wrapper' to the overlay..."
	@cp -r ${OUT_HW_DIR}/hwpe-${HWPE_TARGET}-wrapper ${OVERLAY_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@cp -r ${OUT_SW_DIR} ${OVERLAY_DEPS}/hwpe-${HWPE_TARGET}-wrapper/
	@echo -e "								...All done!"

overlay_src: check_ov_env
	@echo -e ">> Exporting accelerator package to perform system-level optimization."
	@cp ${OUT_OVERLAY_INTEGR}/ov_acc_pkg.sv ${OVERLAY_SRC}/
	@echo -e ">> Exporting accelerator interface to perform system-level integration."
	@cp ${OUT_OVERLAY_INTEGR}/ov_acc_intf.sv ${OVERLAY_CLUSTER}/
	@echo -e ">> Exporting Modelsim wave script to perform system-level testing."
	@cp ${OUT_OVERLAY_INTEGR}/pulp_tb.wave.do ${OVERLAY_TEST}/

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ----------------------------- #
#  HARDWARE WRAPPER GENERATION  #
# ----------------------------- #

run_gen: check_ov_env clean_gen engine_dev static_rtl
	@${SCRIPTS_GEN}/run_gen.sh ${PY_VENV} ${OUT_DIR}

static_rtl: check_ov_env
	@ls -R ${STATIC_STREAM} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/stream_list.log
	@ls -R ${STATIC_CTRL} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/ctrl_list.log 
	
engine_dev: check_ov_env acc_lib
	@ls ${ENG_DEV_RTL} >> ${HW_MNGT_DIR}/rtl_list/engine_list.log

acc_lib: check_ov_env
	@cd acc_lib && make -s clean all TARGET=${HWPE_TARGET} TEMPLATES=${TEMPLATES} ENG_DEV=${ENG_DEV}

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# --------------------- #
#  OVERLAY ENVIRONMENT  #
# --------------------- #

clean_ov_env: test_ov_env
	@rm -rf ${OVERLAY_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@rm -f ${OVERLAY_SRC}/pulp_cluster_hwpe_pkg.sv
	@rm -f ${OVERLAY_CLUSTER}/pulp_hwpe_wrap.sv

test_ov_env: check_ov_env
ifndef ENV_IS_CHECKED
	@${SCRIPTS_SYS_INTEGR}/secure_paths.sh ${OVERLAY_SRC} ${OVERLAY_DEPS} ${OVERLAY_TEST}
endif

check_ov_env:
ifndef OVERLAY_HW_EXPORT
	$(error OVERLAY_HW_EXPORT is undefined)
endif

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ----------------------- #
#  GENERATOR ENVIRONMENT  #
# ----------------------- #

clean_gen: check_ov_env
	@rm -rf ${ENG_DEV}/*
	@rm -rf ${OUT_HW_DIR}/*
	@rm -rf ${OUT_SW_DIR}/*
	@find . -type d -name '__pycache__' -not -path "${PY_ENV_DIR}" -exec rm -rf {} +
	@find . -name "*.pyc" -type f -delete
	@rm -rf ${HW_MNGT_DIR}/rtl_list/*.log
	@rm -rf ${ROOT}/struct_mod.txt

init_gen:
	@${SCRIPTS_GEN}/init_gen.sh

bender: 
	@curl --proto '=https' --tlsv1.2 -sSf https://fabianschuiki.github.io/bender/init | sh -s 0.21.0
	@touch bender

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# -------------------- #
#  PYTHON ENVIRONMENT  #
# -------------------- #

clean_py_env: test_py_env
	@rm -rf ${PY_VENV}

init_py_env:
	@${SCRIPTS_PY_ENV}/init_py_env.sh ${PY_VENV}

update_reqs_py_env:
	@${SCRIPTS_PY_ENV}/update_reqs.sh ${PY_ENV_DIR}

test_py_env:
	@${SCRIPTS_PY_ENV}/secure_paths.sh ${PY_ENV_DIR}

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #