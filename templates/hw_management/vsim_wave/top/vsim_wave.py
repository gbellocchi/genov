########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
from mako.template import Template
import math
import re
import sys

from templates.sw.common.common_c.template_c import template_c

from templates.hw_management.vsim_wave.modules.hwpe_engine_wave.hwpe_engine_wave import hwpe_engine_wave
from templates.hw_management.vsim_wave.modules.kernel_adapter_wave.kernel_adapter_wave import kernel_adapter_wave

# Main function
class vsim_wave:
    def __init__(self, specs):
        
        # Engineer(-s)
        self.author                 = specs.author
        self.email                  = specs.email

        # Environment
        self.destdir                = specs.dest_dir
        self.module                 = "vsim_wave/top/vsim_wave"

        # Generic
        self.hwpe_target            = specs.hwpe_target

        # HWPE streaming interfaces
        self.list_sink_stream       = [item[0] for item in specs.list_sink_stream]
        self.list_sink_dtype        = [item[1] for item in specs.list_sink_stream] 
        self.list_sink_dim          = [item[2] for item in specs.list_sink_stream]
        self.list_source_stream     = [item[0] for item in specs.list_source_stream]
        self.list_source_dtype      = [item[1] for item in specs.list_source_stream] 
        self.list_source_dim        = [item[2] for item in specs.list_source_stream]
        self.n_sink                 = specs.n_sink
        self.n_source               = specs.n_source

        # HWPE custom regfiles
        self.custom_reg_name        = [item[0] for item in specs.custom_reg]
        self.custom_reg_dtype       = [item[1] for item in specs.custom_reg]
        self.custom_reg_dim         = [item[2] for item in specs.custom_reg]
        self.custom_reg_isport      = [item[3] for item in specs.custom_reg]
        self.custom_reg_num         = specs.custom_reg_num

        # Kernel wrapper
        self.is_ap_ctrl             = specs.intf_kernel[0]
        self.is_dflow               = specs.intf_kernel[1]

        self.specs                  = specs

        # Template
        self.template               = self.get_template()

    def gen(self):
        s = self.common(self.specs) + self.modules(self.specs) + self.template
        pulp_template = Template(s)
        string = pulp_template.render(
            author              = self.author,
            email               = self.email,
            target              = self.hwpe_target, 
            is_ap_ctrl          = self.is_ap_ctrl,
            is_dflow            = self.is_dflow,
            n_sink              = self.n_sink, 
            n_source            = self.n_source,
            stream_in           = self.list_sink_stream,
            stream_in_dtype     = self.list_sink_dtype,
            stream_in_dim       = self.list_sink_dim,
            stream_out          = self.list_source_stream,
            stream_out_dtype    = self.list_source_dtype,
            stream_out_dim      = self.list_source_dim,
            custom_reg_name     = self.custom_reg_name, 
            custom_reg_dtype    = self.custom_reg_dtype,
            custom_reg_dim      = self.custom_reg_dim, 
            custom_reg_isport   = self.custom_reg_isport,
            custom_reg_num      = self.custom_reg_num,
        )
        s = re.sub(r'\s+$', '', string, flags=re.M)
        return s
    
    def get_template(self):
        with open('templates/hw_management/'+self.module+'.template_wave_do', 'r') as f:
            s = f.read()
            f.close()
            return s

    def common(self, specs):
        self.c                      = template_c(specs).gen()
        return self.c

    def modules(self, specs):
        self.m                      = ''
        self.m                      += hwpe_engine_wave().gen()
        self.m                      += kernel_adapter_wave().gen()
        return self.m

