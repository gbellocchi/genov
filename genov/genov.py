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

#!/usr/bin/env python3

# Packages - Template
from mako.template import Template
import re

# Packages - Emitter
from emitter import emit_ov

# Design specification packages
from dev.ov_dev.specs.ov_specs import ov_specs

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
    Generator class
    ===============
'''

class generator(ov_specs):
    '''
    The accelerator generator class is the main responsible for rendering
    the collected templates using the input user specification. 
    
    Technically speaking, the generator is derived (child class) from 'acc_specs'. 
    The latter comprises the input user parameters to guide the rendering phase. 
    The generator adds up to the functionality of its parent class methods to render
    the input templates. This is possible exploiting the 'render' method of the 'Template' 
    class defined in the Mako python package.

    The method 'gen' takes a 'template' input. This comprises all the template components 
    (top, modules, common) pertaining to a specific design components.

    The rendered output is a string.
    '''
    def render(self, template):
        # prepare input template
        target = Template(template)
        # rendering phase
        string = target.render(
            # author
            author                  = self.author,
            email                   = self.email,
        )
        # Compile a regex to trim trailing whitespaces on lines
        # and multiple consecutive new lines.
        re_trailws = re.compile(r'[ \t\r]+$', re.MULTILINE)
        string = re.sub(r'\n\s*\n', '\n\n', string) 
        string = re_trailws.sub("", string)
        return string

    '''
    
    '''
    def set_genacc(self):
        # create accelerator configuration file
        f = open("dev/ov_dev/acc_config.cfg", "w")
        f.write("__N_ACC__=" + str(self.n_acc))
        f.close()

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

generator.set_genacc()

# '''
#     =======
#     Emitter
#     =======

#     Instantiate export item
# '''
# emitter = emitter()

# '''
#     =====================================================================
#     Component:      Accelerator-rich overlay

#     Description:    Generation of components for the accelerator-rich
#                     overlay. These permit the agile specification and 
#                     optimization of architectural components to support
#                     the operations of hardware accelerators.
#     ===================================================================== */
# '''

# '''
#     Instantiate overlay item
# ''' 
# overlay = overlay()

# '''
#     Generate design components ~ Overlay accelerator package
# ''' 
# gencomps(
#     overlay.acc_pkg(),
#     ['ov', 'acc_pkg', ['hw', 'rtl']],
#     emitter.out_hw_ov
# )

# '''
#     Generate design components ~ Overlay accelerator interface
# ''' 
# gencomps(
#     overlay.acc_intf(),
#     ['ov', 'acc_intf', ['hw', 'rtl']],
#     emitter.out_hw_ov
# )

# '''
#     =====================================================================
#     Component:      Hardware support

#     Description:    Generation of integration support components, such as
#                     scripts for source management tools, simulations, etc.
#     ===================================================================== */
# '''

# '''
#     Instantiate integration support item
# ''' 
# integr_support = integr_support()

# '''
#     Generate design components ~ QuestaSim waves
# ''' 
# gencomps(
#     integr_support.vsim_wave(),
#     ['integr_support', 'pulp_tb', ['integr_support', 'vsim_wave']],
#     emitter.ov_gen_acc_int
# )

# '''
#     =====================================================================
#     Component:      HWPE system-level testbench - Software

#     Description:    Generation of software components for system-level 
#                     testbench of the hardware wrapper. 
#     ===================================================================== */
# '''

# '''
#     Instantiate SW testbench item
# ''' 
# hwpe_ov_tb_sw = hwpe_ov_tb_sw()

# '''
#     Generate design components ~ archi
#     Retrieve memory-mapped hardware accelerator registers.
# ''' 
# gencomps(
#     hwpe_ov_tb_sw.archi_hwpe(),
#     ['sw', 'archi_hwpe', ['sw', 'archi']],
#     emitter.out_sw_ov_hwpe_lib
# )

# '''
#     Generate design components ~ hardware abstraction layer (HAL)
#     Retrieve Hardware Abstraction Layer with functions that permit 
#     to create an interaction between the RISC-V processor and the 
#     hardware accelerator.
# ''' 
# gencomps(
#     hwpe_ov_tb_sw.hal_hwpe(),
#     ['sw', 'hal_hwpe', ['sw', 'hal']],
#     emitter.out_sw_ov_hwpe_lib
# )

# '''
#     Generate design components ~ software testbench 
#     Retrieve software testbench to assess HWPE functionality. This 
#     is a pure baremetal test running on the riscv proxy core comprised 
#     in the overlay system. This tb can be used as a starting point for 
#     additional platform testing.
# ''' 
# gencomps(
#     hwpe_ov_tb_sw.tb_hwpe(),
#     ['sw', 'tb_hwpe', ['sw', 'tb']],
#     emitter.out_sw_ov
# )