########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from collector import collector

# archi HWPE
class archi_hwpe(collector):
    def top(self):
        return self.get_template()

    
