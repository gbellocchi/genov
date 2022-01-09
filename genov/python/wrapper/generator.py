'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        generator.py
 Description:  Generator of accelerator wrapper components.

 Date:         8.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

# Packages - Template
from mako.template import Template
import re
import pickle
import os.path
import sys

# import python functions
from python.wrapper.import_params import import_acc_dev_module

'''
    Import and instantiate design parameters
'''
target_acc = os.environ['TARGET_ACC']
acc_specs = import_acc_dev_module(target_acc)

'''
    Accelerator wrapper generator
'''

class Generator(acc_specs.acc_specs):
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
    Wrapper components generator
    ============================

    Differently from the generic generator, this alternative 
    version passes also a "cluster_offset" to target the 
    generation of components for a specific cluster
'''

def gen_acc_comps(temp_obj, emitter, descr, out_dir):
    template = temp_obj
    out_target = Generator().render(template)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)