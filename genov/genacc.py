'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator (AROG)
 Title:        genacc.py
 Description:  Generation of hardware wrapper for application-specific
               accelerator.

 Date:         23.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

from generator import generator
from emitter import emitter

'''
    ================
    Import templates
    ================
'''

# HW packages
from templates.hw.hwpe_wrapper.hwpe_wrapper import hwpe_wrapper
from templates.hw.hwpe_standalone_tb.hwpe_standalone_tb import hwpe_standalone_tb as hwpe_standalone_tb_hw

# Integration support packages
from templates.integr_support.integr_support import integr_support

# SW packages
from templates.sw.hwpe_standalone_tb.hwpe_standalone_tb import hwpe_standalone_tb as hwpe_standalone_tb_sw

'''
    ====================
    Components generator
    ====================
'''

def gencomps(temp_obj, descr, out_dir):
    template = temp_obj
    out_target = generator.render(template)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)

'''
    =========
    Generator
    =========

    Instantiate generator item
'''
generator = generator()

'''
    Emitter
    =======

    Instantiate export item
'''
emitter = emitter()

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
gencomps(
    hwpe_wrapper.top_wrapper(),
    ['hwpe', 'top_wrapper', ['hw', 'rtl']],
    emitter.out_hw_hwpe_wrap
)

'''
    Generate design components ~ Top
'''
gencomps(
    hwpe_wrapper.top(),
    ['hwpe', 'top', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ Engine
'''
gencomps(
    hwpe_wrapper.engine(),
    ['hwpe', 'engine', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ Kernel adapter
'''
gencomps(
    hwpe_wrapper.kernel_adapter(),
    ['hwpe', 'kernel_adapter', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ Streamer
'''
gencomps(
    hwpe_wrapper.streamer(),
    ['hwpe', 'streamer', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ Controller
'''
gencomps(
    hwpe_wrapper.ctrl(),
    ['hwpe', 'ctrl', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ FSM
'''
gencomps(
    hwpe_wrapper.fsm(),
    ['hwpe', 'fsm', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ Package
'''
gencomps(
    hwpe_wrapper.package(),
    ['hwpe', 'package', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    =====================================================================
    Component:      Hardware support

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
gencomps(
    integr_support.bender(),
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.out_hw_hwpe
)

'''
    Generate design components ~ List of IP modules
''' 
gencomps(
    integr_support.src_files(),
    ['tb', 'src_files', ['integr_support', 'yml']],
    emitter.out_hw_hwpe
)

'''
    Generate design components ~ List of IP dependencies
''' 
gencomps(
    integr_support.ips_list(),
    ['tb', 'ips_list', ['integr_support', 'yml']],
    emitter.out_hw_hwpe
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
gencomps(
    hwpe_standalone_tb_hw.tb_hwpe(),
    ['tb', 'tb_hwpe', ['hw', 'rtl']],
    emitter.out_hw_standalone_tb
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
gencomps(
    hwpe_standalone_tb_sw.archi_hwpe(),
    ['sw', 'archi_hwpe', ['sw', 'archi']],
    emitter.out_sw_standalone_hwpe_lib
)

'''
    Generate design components ~ hardware abstraction layer (HAL)
    Retrieve Hardware Abstraction Layer with functions that permit 
    to create an interaction between the RISC-V processor and the 
    hardware accelerator.
''' 
gencomps(
    hwpe_standalone_tb_sw.hal_hwpe(),
    ['sw', 'hal_hwpe', ['sw', 'hal']],
    emitter.out_sw_standalone_hwpe_lib
)

'''
    Generate design components ~ software testbench 
    Retrieve software testbench to assess HWPE functionality. This 
    is a pure baremetal test running on the riscv proxy core comprised 
    in the standalone HWPE testbench. This tb can be used to assess the
    functionality of the generated wrapper before to integrate it at 
    system-level.
''' 
gencomps(
    hwpe_standalone_tb_sw.tb_hwpe(),
    ['sw', 'tb_hwpe', ['sw', 'tb']],
    emitter.out_sw_standalone
)
