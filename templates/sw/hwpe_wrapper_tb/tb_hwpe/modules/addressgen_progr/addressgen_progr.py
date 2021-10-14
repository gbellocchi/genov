########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Runtime calls for address generator programming
class addressgen_progr:
    def __init__(self, hwpe_specs):
        self.c = ''

    def gen(self):
        self.module()
        return self.c

    def module(self):
        with open('templates/sw/hwpe_wrapper_tb/tb_hwpe/modules/addressgen_progr/addressgen_progr.template_sv', 'r') as f:
            self.c += f.read()
            self.c += '\n'
            f.close()