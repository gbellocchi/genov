########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from classes import collector

# HAL HWPE
class hal_hwpe(collector):
    def top(self):
        return self.get_template()

    
