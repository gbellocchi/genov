########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
from templates.hw_management.bender.bender import bender

# HWPE overlay
class hw_management:
    def __init__(self, hwpe_specs):
        self.author = hwpe_specs.author
        self.email = hwpe_specs.email

    def bender(self, hwpe_specs):
        o = bender(hwpe_specs)
        return o.gen()



