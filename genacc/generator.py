########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages - Template
from mako.template import Template
import re

# Design specification package
from engine_dev.specs.hwpe_specs import hwpe_specs

'''
    Generator class
    ===============
'''

class generator(hwpe_specs):
    '''
    The accelerator generator class is the main responsible for rendering
    the collected templates using the input user specification. 
    
    Technically speaking, the generator is derived (child class) from 'hwpe_specs'. 
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
        s = re.sub(r'\s+$', '', string, flags=re.M)
        f = open("test_tmp.txt", "a")
        f.write(s)
        f.close()
        return s

    """
    Methods used to retrieve lists of files to feed the scripts 
    used for version control. For example, the method 'get_engine'
    retrieves a list of the input RTL files that have to be wrapped,
    then these are used to generate the scripts for the 'bender' tool.
    """
    def get_engine(self):
        filename = 'templates/integr_support/rtl_list/engine_list.log'
        with open(filename, 'r') as f:
            s = f.readlines()
            f.close()
            return s

    def get_stream(self):
        filename = 'templates/integr_support/rtl_list/stream_list.log'
        with open(filename, 'r') as f:
            s = f.readlines()
            f.close()
            return s

    def get_ctrl(self):
        filename = 'templates/integr_support/rtl_list/ctrl_list.log'
        with open(filename, 'r') as f:
            s = f.readlines()
            f.close()
            return s