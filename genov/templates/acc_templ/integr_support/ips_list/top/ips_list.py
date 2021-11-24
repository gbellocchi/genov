########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from collector import collector

# ips_list
class ips_list(collector):
    def top(self):
        return self.get_template()

    
