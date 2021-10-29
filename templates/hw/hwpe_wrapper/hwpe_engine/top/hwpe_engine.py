########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from classes import collector

# HWPE top
class hwpe_engine(collector):
    def top(self):
        return self.get_template()