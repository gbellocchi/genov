########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
from mako.template import Template
import math
import re
import sys

from templates.hw.common.hwpe_common import hwpe_common

# HWPE engine
class hwpe_fsm:
    def __init__(self, specs):
        
        # Engineer(-s)
        self.author                 = specs.author
        self.email                  = specs.email

        # Environment
        self.destdir                = specs.dest_dir
        self.module                 = "hwpe_fsm/hwpe_fsm"

        # Generic
        self.hwpe_target            = specs.hwpe_target

        # HWPE engine
        self.list_sink_stream   = [item[0] for item in specs.list_sink_stream]
        self.list_source_stream = [item[0] for item in specs.list_source_stream]
        self.n_sink             = specs.n_sink
        self.n_source           = specs.n_source

        # HWPE standard regfiles
        self.std_reg_num            = specs.std_reg_num  

        # HWPE custom regfiles
        self.custom_reg_name        = [item[0] for item in specs.custom_reg]
        self.custom_reg_dtype       = [item[1] for item in specs.custom_reg]
        self.custom_reg_dim         = [item[2] for item in specs.custom_reg]
        self.custom_reg_isport      = [item[3] for item in specs.custom_reg]
        self.custom_reg_num         = specs.custom_reg_num

        # Common template elements
        self.common                 = hwpe_common(specs).gen()

        # Template
        self.template               = self.get_template()

    def gen(self):
        s = self.common + self.template
        pulp_template = Template(s)
        string = pulp_template.render(
            author                  = self.author,
            email                   = self.email,
            target                  = self.hwpe_target,
            n_sink                  = self.n_sink, 
            n_source                = self.n_source,
            stream_in               = self.list_sink_stream,
            stream_out              = self.list_source_stream,
            std_reg_num             = self.std_reg_num,
            custom_reg_name         = self.custom_reg_name, 
            custom_reg_dim          = self.custom_reg_dim, 
            custom_reg_num          = self.custom_reg_num,
        )
        s = re.sub(r'\s+$', '', string, flags=re.M)
        return s

    def get_template(self):
        with open('templates/hw/'+self.module+'.template_sv', 'r') as f:
            s = f.read()
            f.close()
            return s