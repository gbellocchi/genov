## Author: Gianluca Bellocchi
## Email: gianluca.bellocchi@unimore.it

ROOT 				:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# Templates
TEMPLATES 			:= ./../templates
HW_DIR				:= ${TEMPLATES}/hw
HW_MNGT_DIR			:= ${TEMPLATES}/hw_management
SW_DIR				:= ${TEMPLATES}/sw

HW_SPECS			:= ${HW_DIR}/hwpe_specs

# Engine to-be-wrapped
ENG_DEV 		:= ./../engine_dev

CP_RF				:= @cp -rf

RM_F 				:= @rm -f
RM_DF 				:= @rm -rf

.PHONY: all clean
all:
	@${CP_RF} ${TARGET}/* ${ENG_DEV}/

clean:
	@${RM_DF} ${ENG_DEV}/*
	
