########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from python.collector import collector

# HWPE ctrl
class hwpe_ctrl(collector):
    def top(self):
        return self.get_template()