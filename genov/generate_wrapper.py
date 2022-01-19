'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator (AROG)
 Title:        generate_wrapper.py
 Description:  Generator of accelerator wrapper.

 Date:         23.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

import sys
import os

'''
    Import custom functions
'''
from python.wrapper.process_params import wrapper_params_formatted
from python.wrapper.process_params import print_wrapper_log
from python.wrapper.generator import gen_acc_comps
from python.wrapper.import_params import import_acc_dev_module

'''
    Import emitter
'''
from python.wrapper.emitter import EmitWrapper

'''
    Import accelerator wrapper templates (HW)
'''
from templates.acc_templ.hw.hwpe_wrapper.hwpe_wrapper import hwpe_wrapper

'''
    Import accelerator wrapper templates (integration support)
'''
from templates.acc_templ.integr_support.integr_support import integr_support

'''
    Import accelerator wrapper templates (TB)
'''
from templates.acc_templ.hw.hwpe_standalone_tb.hwpe_standalone_tb import hwpe_standalone_tb as hwpe_standalone_tb_hw
from templates.acc_templ.sw.hwpe_standalone_tb.hwpe_standalone_tb import hwpe_standalone_tb as hwpe_standalone_tb_sw

'''
    Read input arguments
'''
dir_out_acc = sys.argv[1]

'''
    Retrieve design parameters
'''
target_acc = os.environ['TARGET_ACC']
acc_specs = import_acc_dev_module(target_acc)

'''
    Format design parameters
'''

design_params = wrapper_params_formatted(acc_specs.acc_specs)

'''
    Instantiate emitter item
'''
emitter = EmitWrapper(design_params, dir_out_acc)

'''
    Print wrapper log
''' 

print_wrapper_log(design_params)

'''
    =====================================================================
    Component:      Hardware wrapper (HWPE-based)

    Description:    Generation of components for hardware wrapper. The 
                    latter is an interface for application-specific 
                    accelerators that want to interface to the overlay 
                    system.
    ===================================================================== */
'''

'''
    Instantiate HWPE wrapper item
'''
hwpe_wrapper = hwpe_wrapper()

'''
    Generate design components ~ Top wrapper
'''
gen_acc_comps(
    hwpe_wrapper.top_wrapper(),
    design_params,
    emitter,
    ['hwpe', 'top_wrapper', ['hw', 'rtl']],
    emitter.hwpe_gen_wrap
)

'''
    Generate design components ~ Top
'''
gen_acc_comps(
    hwpe_wrapper.top(),
    design_params,
    emitter,
    ['hwpe', 'top', ['hw', 'rtl']],
    emitter.hwpe_gen_rtl
)

'''
    Generate design components ~ Engine
'''
gen_acc_comps(
    hwpe_wrapper.engine(),
    design_params,
    emitter,
    ['hwpe', 'engine', ['hw', 'rtl']],
    emitter.hwpe_gen_rtl
)

'''
    Generate design components ~ Kernel adapter
'''
gen_acc_comps(
    hwpe_wrapper.kernel_adapter(),
    design_params,
    emitter,
    ['hwpe', 'kernel_adapter', ['hw', 'rtl']],
    emitter.hwpe_gen_rtl
)

'''
    Generate design components ~ Streamer
'''
gen_acc_comps(
    hwpe_wrapper.streamer(),
    design_params,
    emitter,
    ['hwpe', 'streamer', ['hw', 'rtl']],
    emitter.hwpe_gen_rtl
)

'''
    Generate design components ~ Controller
'''
gen_acc_comps(
    hwpe_wrapper.ctrl(),
    design_params,
    emitter,
    ['hwpe', 'ctrl', ['hw', 'rtl']],
    emitter.hwpe_gen_rtl
)

'''
    Generate design components ~ FSM
'''
gen_acc_comps(
    hwpe_wrapper.fsm(),
    design_params,
    emitter,
    ['hwpe', 'fsm', ['hw', 'rtl']],
    emitter.hwpe_gen_rtl
)

'''
    Generate design components ~ Package
'''
gen_acc_comps(
    hwpe_wrapper.package(),
    design_params,
    emitter,
    ['hwpe', 'package', ['hw', 'rtl']],
    emitter.hwpe_gen_rtl
)

'''
    =====================================================================
    Component:      Integration support

    Description:    Generation of integration support components, such as
                    scripts for source management tools, simulations, etc.
    ===================================================================== */
'''

'''
    Instantiate integration support item
''' 
integr_support = integr_support()

'''
    Generate design components ~ Bender
''' 
gen_acc_comps(
    integr_support.bender(),
    design_params,
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.out_hwpe
)

'''
    Generate design components ~ List of IP modules
''' 
gen_acc_comps(
    integr_support.src_files(),
    design_params,
    emitter,
    ['tb', 'src_files', ['integr_support', 'yml']],
    emitter.out_hwpe
)

'''
    Generate design components ~ List of IP dependencies
''' 
gen_acc_comps(
    integr_support.ips_list(),
    design_params,
    emitter,
    ['tb', 'ips_list', ['integr_support', 'yml']],
    emitter.out_hwpe
)

'''
    Generate design components ~ QuestaSim waves
''' 
gen_acc_comps(
    integr_support.vsim_wave(),
    design_params,
    emitter,
    ['integr_support', 'vsim_wave', ['integr_support', 'vsim_wave']],
    emitter.out_hwpe
)

'''
    =====================================================================
    Component:      HWPE standalone testbench - Hardware

    Description:    Generation of hardware components for standalone 
                    testbench of the hardware wrapper. 
    ===================================================================== */
'''

'''
    Instantiate HW testbench item
''' 
hwpe_standalone_tb_hw = hwpe_standalone_tb_hw()

'''
    Generate design components ~ hardware testbench
    Basic standalone testbench that instantiates the DUT
    (generated accelerator), a RISC-V processor and some
    dummy memories to implement instruction, stack and data
    memories.
''' 
gen_acc_comps(
    hwpe_standalone_tb_hw.tb_hwpe(),
    design_params,
    emitter,
    ['tb', 'tb_hwpe', ['hw', 'rtl']],
    emitter.hwpe_gen_test
)

'''
    =====================================================================
    Component:      HWPE standalone testbench - Software

    Description:    Generation of software components for standalone 
                    testbench of the hardware wrapper. 
    ===================================================================== */
'''

'''
    Instantiate SW testbench item
''' 
hwpe_standalone_tb_sw = hwpe_standalone_tb_sw()

'''
    Generate design components ~ archi
    Retrieve memory-mapped hardware accelerator registers.
''' 
gen_acc_comps(
    hwpe_standalone_tb_sw.archi_hwpe(),
    design_params,
    emitter,
    ['sw', 'archi_hwpe', ['sw', 'archi']],
    emitter.hwpe_gen_test_hwpe_lib
)

'''
    Generate design components ~ hardware abstraction layer (HAL)
    Retrieve Hardware Abstraction Layer with functions that permit 
    to create an interaction between the RISC-V processor and the 
    hardware accelerator.
''' 
gen_acc_comps(
    hwpe_standalone_tb_sw.hal_hwpe(),
    design_params,
    emitter,
    ['sw', 'hal_hwpe', ['sw', 'hal']],
    emitter.hwpe_gen_test_hwpe_lib
)

'''
    Generate design components ~ software testbench 
    Retrieve software testbench to assess HWPE functionality. This 
    is a pure baremetal test running on the riscv proxy core comprised 
    in the standalone HWPE testbench. This tb can be used to assess the
    functionality of the generated wrapper before to integrate it at 
    system-level.
''' 
gen_acc_comps(
    hwpe_standalone_tb_sw.tb_hwpe(),
    design_params,
    emitter,
    ['sw', 'tb_hwpe', ['sw', 'tb']],
    emitter.hwpe_gen_test_sw
)
