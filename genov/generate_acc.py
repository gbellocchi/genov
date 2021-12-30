'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator (AROG)
 Title:        generate_acc.py
 Description:  Generator of accelerator wrapper.

 Date:         23.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

# Packages - Template
from mako.template import Template
from importlib import import_module
import sys
import re
import os

# Import application-specific accelerator specification
target_acc = os.environ['TARGET_ACC']
module_name = "dev.acc_dev." + target_acc + ".specs.acc_specs"
acc_specs = import_module(module_name)

# Packages - Emitter
from emitter import emit_acc

'''
    ================
    Import templates
    ================
'''

# HW packages
from templates.acc_templ.hw.hwpe_wrapper.hwpe_wrapper import hwpe_wrapper
from templates.acc_templ.hw.hwpe_standalone_tb.hwpe_standalone_tb import hwpe_standalone_tb as hwpe_standalone_tb_hw

# Integration support packages
from templates.acc_templ.integr_support.integr_support import integr_support

# SW packages
from templates.acc_templ.sw.hwpe_standalone_tb.hwpe_standalone_tb import hwpe_standalone_tb as hwpe_standalone_tb_sw

'''
    Generator class
    ===============
'''

class generator(acc_specs.acc_specs):
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
            # kernel
            target                  = self.target,
            design_type             = self.design_type,
            is_ap_ctrl_hs           = self.is_ap_ctrl_hs,
            is_mdc_dataflow         = self.is_mdc_dataflow,
            # streaming
            n_sink                  = self.n_sink, 
            n_source                = self.n_source,
            stream_in               = self.stream_in,
            stream_out              = self.stream_out,
            stream_in_dtype         = self.stream_in_dtype,
            stream_out_dtype        = self.stream_out_dtype,
            is_parallel_in          = self.is_parallel_in,
            is_parallel_out         = self.is_parallel_out,
            in_parallelism_factor   = self.in_parallelism_factor,
            out_parallelism_factor  = self.out_parallelism_factor,
            # regfile
            std_reg_num             = self.std_reg_num,
            custom_reg_name         = self.custom_reg_name, 
            custom_reg_dtype        = self.custom_reg_dtype,
            custom_reg_dim          = self.custom_reg_dim,
            custom_reg_isport       = self.custom_reg_isport, 
            custom_reg_num          = self.custom_reg_num,
            # addressgen
            addr_gen_in_isprogr     = self.addr_gen_in_isprogr,
            addr_gen_out_isprogr    = self.addr_gen_out_isprogr,
            # static design components
            engine_devs             = self.get_engine(),
            num_engine_devs         = len(self.get_engine()),
        )
        # Compile a regex to trim trailing whitespaces on lines
        # and multiple consecutive new lines.
        re_trailws = re.compile(r'[ \t\r]+$', re.MULTILINE)
        string = re.sub(r'\n\s*\n', '\n\n', string) 
        string = re_trailws.sub("", string)
        return string

    """
    Methods used to retrieve lists of files to feed the scripts 
    used for version control. For example, the method 'get_engine'
    retrieves a list of the input RTL files that have to be wrapped,
    then these are used to generate the scripts for the 'bender' tool.
    """
    def get_engine(self):
        filename = 'templates/acc_templ/integr_support/rtl_list/engine_list.log'
        l = []
        with open(filename, 'r') as f:
            for s in f.readlines():
                re_trailws = re.compile(r'[ \t\r]+$', re.MULTILINE)
                s = re.sub(r'\n', '', s) 
                s = re_trailws.sub("", s)
                l.append(s)
        f.close()
        return l

'''
    ============================
    Generic components generator 
    ============================
'''

def gen_comps(temp_obj, descr, out_dir):
    template = temp_obj
    out_target = generator.render(template)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)

'''
    =============================
    Accelerator wrapper generator
    =============================

    Instantiate generator item
'''
generator = generator()

'''
    Emitter
    =======

    Instantiate export item
'''
emitter = emit_acc()

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
gen_comps(
    hwpe_wrapper.top_wrapper(),
    ['hwpe', 'top_wrapper', ['hw', 'rtl']],
    emitter.out_hw_hwpe_wrap
)

'''
    Generate design components ~ Top
'''
gen_comps(
    hwpe_wrapper.top(),
    ['hwpe', 'top', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ Engine
'''
gen_comps(
    hwpe_wrapper.engine(),
    ['hwpe', 'engine', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ Kernel adapter
'''
gen_comps(
    hwpe_wrapper.kernel_adapter(),
    ['hwpe', 'kernel_adapter', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ Streamer
'''
gen_comps(
    hwpe_wrapper.streamer(),
    ['hwpe', 'streamer', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ Controller
'''
gen_comps(
    hwpe_wrapper.ctrl(),
    ['hwpe', 'ctrl', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ FSM
'''
gen_comps(
    hwpe_wrapper.fsm(),
    ['hwpe', 'fsm', ['hw', 'rtl']],
    emitter.out_hw_hwpe_rtl
)

'''
    Generate design components ~ Package
'''
gen_comps(
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
gen_comps(
    integr_support.bender(),
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.out_hw_hwpe
)

'''
    Generate design components ~ List of IP modules
''' 
gen_comps(
    integr_support.src_files(),
    ['tb', 'src_files', ['integr_support', 'yml']],
    emitter.out_hw_hwpe
)

'''
    Generate design components ~ List of IP dependencies
''' 
gen_comps(
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
gen_comps(
    hwpe_standalone_tb_hw.tb_hwpe(),
    ['tb', 'tb_hwpe', ['hw', 'rtl']],
    emitter.out_hw_tb_standalone
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
gen_comps(
    hwpe_standalone_tb_sw.archi_hwpe(),
    ['sw', 'archi_hwpe', ['sw', 'archi']],
    emitter.out_sw_tb_standalone_hwpe_lib
)

'''
    Generate design components ~ hardware abstraction layer (HAL)
    Retrieve Hardware Abstraction Layer with functions that permit 
    to create an interaction between the RISC-V processor and the 
    hardware accelerator.
''' 
gen_comps(
    hwpe_standalone_tb_sw.hal_hwpe(),
    ['sw', 'hal_hwpe', ['sw', 'hal']],
    emitter.out_sw_tb_standalone_hwpe_lib
)

'''
    Generate design components ~ software testbench 
    Retrieve software testbench to assess HWPE functionality. This 
    is a pure baremetal test running on the riscv proxy core comprised 
    in the standalone HWPE testbench. This tb can be used to assess the
    functionality of the generated wrapper before to integrate it at 
    system-level.
''' 
gen_comps(
    hwpe_standalone_tb_sw.tb_hwpe(),
    ['sw', 'tb_hwpe', ['sw', 'tb']],
    emitter.out_sw_tb_standalone
)
