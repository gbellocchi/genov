########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Cluster interconnect parametrization
class cluster_interco:
    def __init__(self, hwpe_specs):
        self.common = ''

    def gen(self):
        self.module()
        return self.common

    def module(self):
        with open('templates/hw/ov_acc_pkg/modules/cluster_interco/cluster_interco.template_sv', 'r') as f:
            self.common += f.read()
            self.common += '\n'
            f.close()