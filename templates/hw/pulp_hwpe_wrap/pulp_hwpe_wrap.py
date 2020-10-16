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

# PULP HWPE wrapper
class pulp_hwpe_wrap:
    def __init__(self, specs):
        
        # Engineer(-s)
        self.author             = specs.author
        self.email              = specs.email

        # Environment
        self.destdir            = specs.dest_dir
        self.module             = "pulp_hwpe_wrap/pulp_hwpe_wrap"

        # Generic
        self.hwpe_target        = specs.hwpe_target

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
        )
        s = re.sub(r'\s+$', '', string, flags=re.M)
        return s
    
    def get_template(self):
        with open('templates/hw/'+self.module+'.template_sv', 'r') as f:
            s = f.read()
            f.close()
            return s

