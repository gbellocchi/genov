########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from collector import collector

# Bender
class bender(collector):
    def top(self):
        return self.get_template()

    