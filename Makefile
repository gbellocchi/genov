########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

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

HWPE_TARGET				:= conv_mdc

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# -------------------- #
#  GENACC ENVIRONMENT  #
# -------------------- #

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
OUT_OV_INTEGR			:= ${OUT_DIR}/ov_integr

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

OVERLAY_HW_REPO			:= ${HERO_OV_HW_EXPORT}
OVERLAY_SRC				:= ${HERO_OV_HW_EXPORT}/src
OVERLAY_DEPS			:= ${HERO_OV_HW_EXPORT}/deps
OVERLAY_TEST			:= ${HERO_OV_HW_EXPORT}/test
OVERLAY_CLUSTER			:= ${OVERLAY_DEPS}/overlay_cluster/rtl

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

.PHONY: all

all: clean_gen run_gen

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ---------------------------------- #
#  SYSTEM-LEVEL INTEGRATION (v-git)  #
# ---------------------------------- #

hwpe_git_deploy:
	@cp -r ${OUT_HW_DIR}/hwpe-${HWPE_TARGET}-wrapper/* ${OVERLAY_DEPS}/hwpe-gen-app/
	@cp -r ${OUT_SW_DIR} ${OVERLAY_DEPS}/hwpe-gen-app/
	@cp ${OUT_OV_INTEGR}/Bender.yml ${OVERLAY_DEPS}/hwpe-gen-app/

hwpe_git_branch:
	git checkout -b ov_${HWPE_TARGET}

init_hwpe_git:
	git clone git@iis-git.ee.ethz.ch:gianluca.bellocchi/hwpe-gen-app.git

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# -------------------------- #
#  SYSTEM-LEVEL INTEGRATION  #
# -------------------------- #

overlay_integration: clean_ov_env overlay_src overlay_deps

hwpe_gen_app: test_ov_env overlay_src clean_hwpe_gen_app
	@echo -e ">> Connecting 'hwpe-${HWPE_TARGET}-wrapper' to the overlay."
	@cp -r ${OUT_HW_DIR}/hwpe-${HWPE_TARGET}-wrapper/* ${OVERLAY_DEPS}/hwpe-gen-app/
	@cp -r ${OUT_SW_DIR} ${OVERLAY_DEPS}/hwpe-gen-app/
	@cp ${OUT_OV_INTEGR}/Bender.yml ${OVERLAY_DEPS}/hwpe-gen-app/

overlay_deps: test_ov_env overlay_src
	@echo -e ">> Connecting 'hwpe-${HWPE_TARGET}-wrapper' to the overlay."
	@cp -r ${OUT_HW_DIR}/hwpe-${HWPE_TARGET}-wrapper ${OVERLAY_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@cp -r ${OUT_SW_DIR} ${OVERLAY_DEPS}/hwpe-${HWPE_TARGET}-wrapper/

overlay_src: check_ov_env
	@echo -e ">> Exporting accelerator package to perform system-level optimization."
	@cp ${OUT_OV_INTEGR}/ov_acc_pkg.sv ${OVERLAY_SRC}/
	@echo -e ">> Exporting accelerator interface to perform system-level integration."
	@cp ${OUT_OV_INTEGR}/ov_acc_intf.sv ${OVERLAY_CLUSTER}/
	@echo -e ">> Exporting Modelsim wave script to perform system-level testing."
	@cp ${OUT_OV_INTEGR}/pulp_tb.wave.do ${OVERLAY_TEST}/

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------- #
#  HARDWARE WRAPPER VERIFICATION  #
# ------------------------------- #

verif_hwpe_build_hw: check_ov_env
	@cd ${VERIF_HWPE} && make -s update-ips build-hw

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ----------------------------- #
#  HARDWARE WRAPPER GENERATION  #
# ----------------------------- #

run_gen: check_ov_env clean_gen engine_dev #static_rtl
	@bash ${SCRIPTS_GEN}/run_gen.sh ${PY_VENV} ${OUT_DIR}

# static_rtl: check_ov_env
# @ls -R ${STATIC_STREAM} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/stream_list.log
# @ls -R ${STATIC_CTRL} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/ctrl_list.log 
	
engine_dev: check_ov_env acc_lib
	@ls ${ENG_DEV_RTL} >> ${HW_MNGT_DIR}/rtl_list/engine_list.log

acc_lib: check_ov_env
	@cd ${GENACC_ROOT}/acc_lib && make -s clean all TARGET=${HWPE_TARGET} TEMPLATES=${TEMPLATES} ENG_DEV=${ENG_DEV}

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# --------------------- #
#  OVERLAY ENVIRONMENT  #
# --------------------- #

clean_ov_env: test_ov_env clean_hwpe_gen_app
	@rm -rf ${OVERLAY_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@rm -f ${OVERLAY_SRC}/ov_acc_pkg.sv
	@rm -f ${OVERLAY_CLUSTER}/ov_acc_intf.sv

clean_hwpe_gen_app: test_ov_env
	@rm -rf ${OVERLAY_DEPS}/hwpe-gen-app/rtl
	@rm -rf ${OVERLAY_DEPS}/hwpe-gen-app/sw
	@rm -rf ${OVERLAY_DEPS}/hwpe-gen-app/Bender.yml

test_ov_env: check_ov_env
ifndef ENV_IS_CHECKED
	@bash ${SCRIPTS_SYS_INTEGR}/secure_paths.sh ${OVERLAY_SRC} ${OVERLAY_DEPS} ${OVERLAY_TEST}
endif

check_ov_env:
ifndef HERO_OV_HW_EXPORT
	$(error HERO_OV_HW_EXPORT is undefined)
endif

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ----------------------- #
#  GENERATOR ENVIRONMENT  #
# ----------------------- #

clean_gen: check_ov_env
	@bash ${SCRIPTS_GEN}/clean_gen.sh $(ENG_DEV) $(PY_ENV_DIR) ${HW_MNGT_DIR}

init_gen:
	@bash ${SCRIPTS_GEN}/init_gen.sh

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ----------------- #
#  Version Control  #
# ----------------- #

flat_temp_list: bender
	./bender script flist 

# vsim/compile.tcl: bender
# 	echo 'set ROOT [file normalize [file dirname [info script]]/..]' > $@
# 	./bender script vsim \
# 		--vlog-arg="$(VLOG_ARGS)" \
# 		-t rtl -t test \
# 		| grep -v "set ROOT" >> $@

bender: Makefile
	curl --proto '=https' --tlsv1.2 -sSf https://fabianschuiki.github.io/bender/init | sh -s 0.21.0
	touch bender

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# -------------------- #
#  PYTHON ENVIRONMENT  #
# -------------------- #

clean_py_env: test_py_env
	@rm -rf ${PY_VENV}

init_py_env:
	@bash ${SCRIPTS_PY_ENV}/init_py_env.sh ${PY_VENV}

update_reqs_py_env:
	@bash ${SCRIPTS_PY_ENV}/update_reqs.sh ${PY_ENV_DIR}

test_py_env:
	@bash ${SCRIPTS_PY_ENV}/secure_paths.sh ${PY_ENV_DIR}

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #
