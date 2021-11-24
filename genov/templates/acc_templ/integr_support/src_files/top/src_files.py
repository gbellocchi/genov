########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from collector import collector

# src_files
class src_files(collector):
    def top(self):
        return self.get_template()

    
