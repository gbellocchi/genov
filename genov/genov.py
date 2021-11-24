'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator (AROG)
 Title:        genov.py
 Description:  Generation of accelerator-rich overlay components.

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
from templates.ov_templ.hw.overlay.overlay import overlay

# Integration support packages
from templates.ov_templ.integr_support.integr_support import integr_support

# SW packages
from templates.ov_templ.sw.hwpe_ov_tb.hwpe_ov_tb import hwpe_ov_tb as hwpe_ov_tb_sw

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
    Generator
    =========

    Instantiate generator item
'''
generator = generator()

'''
    =======
    Emitter
    =======

    Instantiate export item
'''
emitter = emitter()

'''
    =====================================================================
    Component:      Accelerator-rich overlay

    Description:    Generation of components for the accelerator-rich
                    overlay. These permit the agile specification and 
                    optimization of architectural components to support
                    the operations of hardware accelerators.
    ===================================================================== */
'''

'''
    Instantiate overlay item
''' 
overlay = overlay()

'''
    Generate design components ~ Overlay accelerator package
''' 
gencomps(
    overlay.acc_pkg(),
    ['ov', 'acc_pkg', ['hw', 'rtl']],
    emitter.out_hw_ov
)

'''
    Generate design components ~ Overlay accelerator interface
''' 
gencomps(
    overlay.acc_intf(),
    ['ov', 'acc_intf', ['hw', 'rtl']],
    emitter.out_hw_ov
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
    Generate design components ~ QuestaSim waves
''' 
gencomps(
    integr_support.vsim_wave(),
    ['integr_support', 'pulp_tb', ['integr_support', 'vsim_wave']],
    emitter.ov_gen_acc_int
)

'''
    =====================================================================
    Component:      HWPE system-level testbench - Software

    Description:    Generation of software components for system-level 
                    testbench of the hardware wrapper. 
    ===================================================================== */
'''

'''
    Instantiate SW testbench item
''' 
hwpe_ov_tb_sw = hwpe_ov_tb_sw()

'''
    Generate design components ~ archi
    Retrieve memory-mapped hardware accelerator registers.
''' 
gencomps(
    hwpe_ov_tb_sw.archi_hwpe(),
    ['sw', 'archi_hwpe', ['sw', 'archi']],
    emitter.out_sw_ov_hwpe_lib
)

'''
    Generate design components ~ hardware abstraction layer (HAL)
    Retrieve Hardware Abstraction Layer with functions that permit 
    to create an interaction between the RISC-V processor and the 
    hardware accelerator.
''' 
gencomps(
    hwpe_ov_tb_sw.hal_hwpe(),
    ['sw', 'hal_hwpe', ['sw', 'hal']],
    emitter.out_sw_ov_hwpe_lib
)

'''
    Generate design components ~ software testbench 
    Retrieve software testbench to assess HWPE functionality. This 
    is a pure baremetal test running on the riscv proxy core comprised 
    in the overlay system. This tb can be used as a starting point for 
    additional platform testing.
''' 
gencomps(
    hwpe_ov_tb_sw.tb_hwpe(),
    ['sw', 'tb_hwpe', ['sw', 'tb']],
    emitter.out_sw_ov
)