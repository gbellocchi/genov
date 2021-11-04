########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from classes import collector

# Overlay accelerator interface
class ov_acc_intf(collector):
    def top(self):
        return self.get_template()