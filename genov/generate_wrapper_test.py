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
from python.wrapper.process_params import print_wrapper_test_log
from python.wrapper.generator import gen_acc_comps
from python.wrapper.import_params import import_acc_dev_module

'''
    Import emitter
'''
from python.wrapper.emitter import EmitWrapper

'''
    Import accelerator wrapper templates (integration support)
'''
from templates.acc_templ.integr_support.integr_support import integr_support

'''
    Import accelerator wrapper templates (TB)
'''
from templates.acc_templ.hw.hwpe_standalone_tb.hwpe_standalone_tb import hwpe_standalone_tb as hwpe_standalone_tb_hw
from templates.acc_templ.sw.hwpe_standalone_tb.hwpe_standalone_tb import hwpe_standalone_tb as hwpe_standalone_tb_sw
from templates.acc_templ.sw.hwpe_system_tb.hwpe_system_tb import hwpe_system_tb as hwpe_system_tb_sw

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
    Print wrapper test log
''' 

print_wrapper_test_log(design_params)

'''
    =====================================================================
    Component:      Wrapper standalone test (Hardware)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
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
    ['tb', 'tb_hwpe', ['hw', 'sv']],
    emitter.hwpe_gen_standalone_test_hw
)

'''
    =====================================================================
    Component:      Wrapper standalone test (Software)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
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
    emitter.hwpe_gen_standalone_test_hwpe_lib
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
    emitter.hwpe_gen_standalone_test_hwpe_lib
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
    emitter.hwpe_gen_standalone_test_sw
)

'''
    =====================================================================
    Component:      Wrapper standalone test (Debug support)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Instantiate integration support item
''' 
integr_support = integr_support()

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
    Component:      Wrapper system test (Software)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Instantiate SW testbench item
''' 
hwpe_system_tb_sw = hwpe_system_tb_sw()

'''
    Generate design components ~ Archi
    Retrieve memory-mapped hardware accelerator registers.
''' 
gen_acc_comps(
    hwpe_system_tb_sw.archi_hwpe(),
    design_params,
    emitter,
    ['sw', 'archi_hwpe', ['sw', 'archi']],
    emitter.hwpe_gen_system_test_hwpe_lib
)

'''
    Generate design components ~ Hardware abstraction layer (HAL)
    Retrieve Hardware Abstraction Layer with functions that permit 
    to create an interaction between the RISC-V processor and the 
    hardware accelerator.
''' 
gen_acc_comps(
    hwpe_system_tb_sw.hal_hwpe(),
    design_params,
    emitter,
    ['sw', 'hal_hwpe', ['sw', 'hal']],
    emitter.hwpe_gen_system_test_hwpe_lib
)

'''
    Generate design components ~ Software testbench 
    Retrieve software testbench to assess HWPE functionality. This 
    is a pure baremetal test running on the riscv proxy core comprised 
    in the overlay system. This tb can be used as a starting point for 
    additional platform testing.
''' 
gen_acc_comps(
    hwpe_system_tb_sw.tb_hwpe(),
    design_params,
    emitter,
    ['sw', 'tb_hwpe', ['sw', 'tb']],
    emitter.hwpe_gen_system_test_hwpe_lib
)
