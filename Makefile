## Author: Gianluca Bellocchi
## Email: gianluca.bellocchi@unimore.it

ROOT 					:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

CONFIG = default.config

# Setup
PY_VER					:= 2.7

# Accelerator library
HWPE_TARGET				:= mmul_parallel

# Templates
TEMPLATES 				:= ./templates
HW_DIR					:= ${TEMPLATES}/hw
HW_MNGT_DIR				:= ${TEMPLATES}/hw_management
SW_DIR					:= ${TEMPLATES}/sw

# Engine
ENG_DEV 				:= ./engine_dev/
ENG_DEV_RTL 			:= ${ENG_DEV}/rtl

# Static modules
STATIC 					:= ./static

STATIC_RTL_DIR 			:= ${STATIC}/static_rtl
STATIC_STREAM			:= ${STATIC_RTL_DIR}/hwpe-stream/rtl
STATIC_CTRL 			:= ${STATIC_RTL_DIR}/hwpe-ctrl-fpga

# Output content
OUT_DIR 				:= ./output
OUT_HW_DIR 				:= ${OUT_DIR}/hw
OUT_PULP_INTEGR			:= ${OUT_HW_DIR}/pulp_integration
OUT_SW_DIR 				:= ${OUT_DIR}/sw

# Exporting
PULP_SRC				:= ${ROOT}/../src
HW_TEST					:= ${ROOT}/../test
HW_DEPS					:= ${ROOT}/../deps
HWPE_REPO				:= hwpe-${HWPE_TARGET}-wrapper
PULP_CLUSTER			:= ${HW_DEPS}/overlay_cluster/rtl

.PHONY: all export gen engine_dev static_rtl acc_lib clean
all: gen

hero_deps: pulp-integr
	@echo "Exporting 'hwpe-${HWPE_TARGET}-wrapper' to HERO ecosystem."
	@cp -rf ${OUT_HW_DIR}/hwpe-${HWPE_TARGET}-wrapper ${HW_DEPS}/${HWPE_REPO}
	@cp -rf ${OUT_SW_DIR} ${HW_DEPS}/${HWPE_REPO}/

pulp-integr: clean_overlay gen
	@echo "Exporting HWPE package for PULP cluster."
	@cp ${OUT_PULP_INTEGR}/pulp_cluster_hwpe_pkg.sv ${PULP_SRC}/
	@echo "Exporting PULP HWPE wrapper."
	@cp ${OUT_PULP_INTEGR}/pulp_hwpe_wrap.sv ${PULP_CLUSTER}/
	@echo "Exporting Modelsim wave script."
	@cp ${OUT_PULP_INTEGR}/pulp_tb.wave.do ${HW_TEST}/

gen: clean engine_dev static_rtl 
	@echo "HWPE wrapper generation."
	@python${PY_VER} gen.py

engine_dev: acc_lib
	@ls ${ENG_DEV_RTL} >> ${HW_MNGT_DIR}/rtl_list/engine_list.log

static_rtl:
	@ls -R ${STATIC_STREAM} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/stream_list.log
	@ls -R ${STATIC_CTRL} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/ctrl_list.log 

acc_lib:
	@cd acc_lib && make -s clean all TARGET=${HWPE_TARGET}

init:
	@git submodule update --init --recursive
	@python${PY_VER} setup.py install --user

clean:
	@rm -rf ${ENG_DEV}/*
	@rm -rf ${OUT_HW_DIR}/*
	@rm -rf ${OUT_SW_DIR}/*
	@rm -f ${OUT_HW_MNGT_DIR}/*.yml
	@rm -f ${HW_MNGT_DIR}/rtl_list/*.log
	@find . -type d -name '__pycache__' -exec rm -rf {} +
	@find . -name "*.pyc" -type f -delete

clean_overlay:
	@./scripts/clean_overlay.sh scripts/clean_overlay.sh
# @rm -r ${HW_DEPS}/hwpe-${HWPE_TARGET}-wrapper
# @rm ${PULP_SRC}/pulp_cluster_hwpe_pkg.sv
# @rm ${PULP_CLUSTER}/pulp_hwpe_wrap.sv
	
