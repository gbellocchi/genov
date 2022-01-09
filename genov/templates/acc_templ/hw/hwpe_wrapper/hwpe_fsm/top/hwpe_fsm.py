########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from python.collector import collector

# HWPE fsm
class hwpe_fsm(collector):
    def top(self):
        return self.get_template()