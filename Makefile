## Author: Gianluca Bellocchi
## Email: gianluca.bellocchi@unimore.it

ROOT 				:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# Accelerator library
HWPE_TARGET			:= MAC

# Templates
TEMPLATES 			:= ./templates
HW_DIR				:= ${TEMPLATES}/hw
HW_MNGT_DIR			:= ${TEMPLATES}/hw_management
SW_DIR				:= ${TEMPLATES}/sw

# Engine
ENG_DEV 		:= ./engine_dev/

# Static RTL HWPE modules
STATIC_RTL_DIR 		:= ./static_rtl
STATIC_STREAM		:= ${STATIC_RTL_DIR}/hwpe-stream
STATIC_CTRL 		:= ${STATIC_RTL_DIR}/hwpe-ctrl

# Output content
OUT_DIR 			:= ./output
OUT_HW_DIR 			:= ${OUT_DIR}/hw
OUT_SW_DIR 			:= ${OUT_DIR}/sw

# Exporting
HW_DEPS				:= ${ROOT}/../deps

RM_F 				:= @rm -f
RM_DF 				:= @rm -rf

.PHONY: all export gen engine_dev static_rtl acc_lib clean
all: hero_deps

hero_deps: gen
	@echo "Exporting 'hwpe-${HWPE_TARGET}-wrapper' to HERO environment."
	@cp -rf ${OUT_HW_DIR}/hwpe-${HWPE_TARGET}-wrapper ${HW_DEPS}/hwpe-${HWPE_TARGET}-wrapper

gen: engine_dev static_rtl 
	@echo "HWPE wrapper generation."
	@python3 gen.py

engine_dev: acc_lib
	@ls ${ENG_DEV} >> ${HW_MNGT_DIR}/rtl_list/engine_list.log

static_rtl:
	@ls -R ${STATIC_STREAM} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/stream_list.log
	@ls -R ${STATIC_CTRL} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/ctrl_list.log 

acc_lib:
	@cd acc_lib && make -s clean all TARGET=${HWPE_TARGET}

clean:
	@${RM_DF} ${ENG_DEV}/*
	@${RM_DF} ${OUT_HW_DIR}/*
	@${RM_DF} ${HW_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@${RM_F}  ${OUT_HW_MNGT_DIR}/*.yml
	@${RM_F}  ${HW_MNGT_DIR}/rtl_list/*.log
	@find . -type d -name '__pycache__' -exec rm -rf {} +
	
