## Author: Gianluca Bellocchi
## Email: gianluca.bellocchi@unimore.it

ROOT 				:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# Templates
TEMPLATES 			:= ./../templates
HW_DIR				:= ${TEMPLATES}/hw
HW_MNGT_DIR			:= ${TEMPLATES}/hw_management
SW_DIR				:= ${TEMPLATES}/sw

SPECS				:= ${HW_DIR}/hwpe_specs

# Engine to-be-wrapped
ENG_DEV 		:= ./../engine_dev

RM_F 				:= @rm -f

.PHONY: all clean
all:
	@cp ${TARGET}/rtl/* ${ENG_DEV}/
	@cp ${TARGET}/specs/* ${SPECS}/

clean:
	@${RM_F} ${HLS_DEVICE}/*.v
	@${RM_F} ${SPECS}/*.py
	
