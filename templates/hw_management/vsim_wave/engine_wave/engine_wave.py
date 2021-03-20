########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Kernel wrapper
class hwpe_engine_waves:
    def __init__(self, hwpe_specs):
        self.author = hwpe_specs.author
        self.email = hwpe_specs.email
        self.common = ''

    def gen(self):
        self.engine_waves()
        return self.common

    def engine_waves(self):
        with open('templates/hw_management/vsim_wave/engine_wave/engine.template_wave_do', 'r') as f:
            self.common += f.read()
            self.common += '\n'
            f.close()




