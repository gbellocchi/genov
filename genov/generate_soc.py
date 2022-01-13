'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        generate_soc.py
 Description:  Generation of SoC components.

 Date:         23.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

import sys

'''
    Import custom functions
'''
from python.overlay.process_params import overlay_params_formatted
from python.soc.process_params import print_soc_log
from python.soc.generator import gen_soc_comps

'''
    Import emitter
'''
from python.overlay.emitter import EmitOv

'''
    Import design parameters
'''
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Import SoC templates
'''
from templates.ov_templ.hw.soc.soc import Soc

'''
    Read input arguments
'''
dir_out_ov = sys.argv[1]

'''
    Retrieve overlay design parameters
''' 
ov_specs = ov_specs

'''
    Format design parameters
'''
design_params = overlay_params_formatted(ov_specs)

'''
    Print SoC log
''' 
print_soc_log(design_params)

'''
    Instantiate emitter item
'''
emitter = EmitOv(ov_specs, dir_out_ov)

'''
    =====================================================================
    Component:      System-on-Chip - Hardware

    Description:    Generation of hardware components for SoC. 
    ===================================================================== */
'''

'''
    Instantiate SoC template item
''' 
soc = Soc()

'''
    Generate design components ~ HERO AXI mailbox
''' 
gen_soc_comps(
    soc.HeroAxiMailbox(),
    design_params,
    emitter,
    ['soc', 'hero_axi_mailbox', ['hw', 'rtl']],
    emitter.ov_gen_soc
)

'''
    Generate design components ~ L2 memory
''' 
gen_soc_comps(
    soc.L2Mem(),
    design_params,
    emitter,
    ['soc', 'l2_mem', ['hw', 'rtl']],
    emitter.ov_gen_soc
)

'''
    Generate design components ~ PULP
''' 
gen_soc_comps(
    soc.Pulp(),
    design_params,
    emitter,
    ['soc', 'pulp', ['hw', 'rtl']],
    emitter.ov_gen_soc
)

'''
    Generate design components ~ SoC package
''' 
gen_soc_comps(
    soc.SocPackage(),
    design_params,
    emitter,
    ['soc', 'soc_package', ['hw', 'rtl']],
    emitter.ov_gen_soc
)

'''
    Generate design components ~ PULP OOC
''' 
gen_soc_comps(
    soc.PulpOoc(),
    design_params,
    emitter,
    ['soc', 'pulp_ooc', ['hw', 'rtl']],
    emitter.ov_gen_soc
)

'''
    Generate design components ~ SoC bus
''' 
gen_soc_comps(
    soc.SocBus(),
    design_params,
    emitter,
    ['soc', 'soc_bus', ['hw', 'rtl']],
    emitter.ov_gen_soc
)

'''
    Generate design components ~ SoC control registers
''' 
gen_soc_comps(
    soc.SocCtrlRegs(),
    design_params,
    emitter,
    ['soc', 'soc_ctrl_regs', ['hw', 'rtl']],
    emitter.ov_gen_soc
)

'''
    Generate design components ~ SoC peripherals
''' 
gen_soc_comps(
    soc.SocPeripherals(),
    design_params,
    emitter,
    ['soc', 'soc_peripherals', ['hw', 'rtl']],
    emitter.ov_gen_soc
)

'''
    =====================================================================
    Component:      Hardware support

    Description:    Generation of integration support components, such as
                    scripts for source management tools, simulations, etc.
    ===================================================================== */
'''

'''
    Generate design components ~ Bender
''' 
gen_soc_comps(
    soc.Bender(),
    design_params,
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.ov_gen_soc
)