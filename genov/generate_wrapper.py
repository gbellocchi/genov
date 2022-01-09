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
from python.wrapper.generator import gen_acc_comps

'''
    Import emitter
'''
from python.emitter import emit_acc

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
    Instantiate emitter item
'''
emitter = emit_acc(dir_out_acc)

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
    emitter,
    ['hwpe', 'top_wrapper', ['hw', 'rtl']],
    emitter.out_hwpe_wrap
)

'''
    Generate design components ~ Top
'''
gen_acc_comps(
    hwpe_wrapper.top(),
    emitter,
    ['hwpe', 'top', ['hw', 'rtl']],
    emitter.out_hwpe_rtl
)

'''
    Generate design components ~ Engine
'''
gen_acc_comps(
    hwpe_wrapper.engine(),
    emitter,
    ['hwpe', 'engine', ['hw', 'rtl']],
    emitter.out_hwpe_rtl
)

'''
    Generate design components ~ Kernel adapter
'''
gen_acc_comps(
    hwpe_wrapper.kernel_adapter(),
    emitter,
    ['hwpe', 'kernel_adapter', ['hw', 'rtl']],
    emitter.out_hwpe_rtl
)

'''
    Generate design components ~ Streamer
'''
gen_acc_comps(
    hwpe_wrapper.streamer(),
    emitter,
    ['hwpe', 'streamer', ['hw', 'rtl']],
    emitter.out_hwpe_rtl
)

'''
    Generate design components ~ Controller
'''
gen_acc_comps(
    hwpe_wrapper.ctrl(),
    emitter,
    ['hwpe', 'ctrl', ['hw', 'rtl']],
    emitter.out_hwpe_rtl
)

'''
    Generate design components ~ FSM
'''
gen_acc_comps(
    hwpe_wrapper.fsm(),
    emitter,
    ['hwpe', 'fsm', ['hw', 'rtl']],
    emitter.out_hwpe_rtl
)

'''
    Generate design components ~ Package
'''
gen_acc_comps(
    hwpe_wrapper.package(),
    emitter,
    ['hwpe', 'package', ['hw', 'rtl']],
    emitter.out_hwpe_rtl
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
gen_acc_comps(
    integr_support.bender(),
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.out_hwpe
)

'''
    Generate design components ~ List of IP modules
''' 
gen_acc_comps(
    integr_support.src_files(),
    emitter,
    ['tb', 'src_files', ['integr_support', 'yml']],
    emitter.out_hwpe
)

'''
    Generate design components ~ List of IP dependencies
''' 
gen_acc_comps(
    integr_support.ips_list(),
    emitter,
    ['tb', 'ips_list', ['integr_support', 'yml']],
    emitter.out_hwpe
)

'''
    Generate design components ~ QuestaSim waves
''' 
gen_acc_comps(
    integr_support.vsim_wave(),
    emitter,
    ['integr_support', 'hwpe_standalone_tb_waves', ['integr_support', 'vsim_wave']],
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
    emitter,
    ['tb', 'tb_hwpe', ['hw', 'rtl']],
    emitter.out_hwpe_tb
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
    emitter,
    ['sw', 'archi_hwpe', ['sw', 'archi']],
    emitter.out_hwpe_tb_hwpe_lib
)

'''
    Generate design components ~ hardware abstraction layer (HAL)
    Retrieve Hardware Abstraction Layer with functions that permit 
    to create an interaction between the RISC-V processor and the 
    hardware accelerator.
''' 
gen_acc_comps(
    hwpe_standalone_tb_sw.hal_hwpe(),
    emitter,
    ['sw', 'hal_hwpe', ['sw', 'hal']],
    emitter.out_hwpe_tb_hwpe_lib
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
    emitter,
    ['sw', 'tb_hwpe', ['sw', 'tb']],
    emitter.out_hwpe_tb_sw
)
