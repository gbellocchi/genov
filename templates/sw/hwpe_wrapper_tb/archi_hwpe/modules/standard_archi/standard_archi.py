########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Standard archi
class standard_archi:
    def __init__(self, hwpe_specs):
        self.common = ''

    def gen(self):
        self.module()
        return self.common

    def module(self):
        with open('templates/sw/hwpe_wrapper_tb/archi_hwpe/modules/standard_archi/standard_archi.template_sv', 'r') as f:
            self.common += f.read()
            self.common += '\n'
            f.close()