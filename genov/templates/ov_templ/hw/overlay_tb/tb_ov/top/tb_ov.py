########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from python.collector import collector

# HW testbench overlay
class tb_ov(collector):
    def top(self):
        return self.get_template()

    
