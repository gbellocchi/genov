########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from collector import collector

# HWPE package
class hwpe_package(collector):
    def top(self):
        return self.get_template()