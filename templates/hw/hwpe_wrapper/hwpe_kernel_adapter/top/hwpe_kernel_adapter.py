########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from classes import collector

# HWPE kernel adapter
class hwpe_kernel_adapter(collector):
    def top(self):
        return self.get_template()