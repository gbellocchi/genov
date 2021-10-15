########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Declaration of address generator parameters
class addressgen_params:
    def __init__(self, hwpe_specs):
        self.c = ''

    def gen(self):
        self.module()
        return self.c

    def module(self):
        with open('templates/sw/hwpe_wrapper_tb/tb_hwpe/modules/addressgen_params/addressgen_params.template_sv', 'r') as f:
            self.c += f.read()
            self.c += '\n'
            f.close()