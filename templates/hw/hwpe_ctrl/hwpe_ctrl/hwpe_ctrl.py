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

# HWPE ctrl
class hwpe_ctrl:
    def __init__(self, specs):
        
        # Engineer(-s)
        self.author             = specs.author
        self.email              = specs.email

        # Environment
        self.destdir            = specs.dest_dir
        self.module             = "hwpe_ctrl/hwpe_ctrl/hwpe_ctrl"

        # Generic
        self.hwpe_target        = specs.hwpe_target

        # HWPE custom regfiles
        self.custom_reg_name    = [item[0] for item in specs.custom_reg]
        self.custom_reg_dtype   = [item[1] for item in specs.custom_reg]
        self.custom_reg_dim     = [item[2] for item in specs.custom_reg]
        self.custom_reg_isport  = [item[3] for item in specs.custom_reg]
        self.custom_reg_num     = specs.custom_reg_num

        # Common template elements
        self.common             = hwpe_common(specs).gen()

        # Template
        self.template           = self.get_template()

    def gen(self):
        s = self.common + self.template
        pulp_template = Template(s)
        string = pulp_template.render(
            author              = self.author,
            email               = self.email,
            target              = self.hwpe_target,
            custom_reg_name     = self.custom_reg_name, 
            custom_reg_dim      = self.custom_reg_dim, 
            custom_reg_num      = self.custom_reg_num,
        )
        s = re.sub(r'\s+$', '', string, flags=re.M)
        return s

    def get_template(self):
        with open('templates/hw/'+self.module+'.template_sv', 'r') as f:
            s = f.read()
            f.close()
            return s

# # HWPE ctrl package
# class hwpe_ctrl_package:
#     def __init__(self, specs):
        
#         # Engineer(-s)
#         self.author     = specs.author
#         self.email      = specs.email

#         # Environment
#         self.destdir    = specs.dest_dir
#         self.module     = "hwpe_ctrl/hwpe_ctrl/hwpe_ctrl"

#         # Generic
#         self.hwpe_target = specs.hwpe_target

#         # HWPE regfiles
#         self.reg_name   = specs.reg_name
#         self.reg_dim    = specs.reg_dim
#         self.reg_num    = specs.reg_num

#     def gen(self):
#         pulp_template = Template(filename=('templates/'+self.module+'.template_sv'))
#         string = pulp_template.render(
#             author      = self.author,
#             email       = self.email,
#             target      = self.hwpe_target,
#             reg_name    = self.reg_name, 
#             reg_dim     = self.reg_dim, 
#             reg_num     = self.reg_num,
#         )
#         s = re.sub(r'\s+$', '', string, flags=re.M)
#         return s
