########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from classes import collector

# Overlay accelerator package
class ov_acc_pkg(collector):
    def top(self):
        return self.get_template()