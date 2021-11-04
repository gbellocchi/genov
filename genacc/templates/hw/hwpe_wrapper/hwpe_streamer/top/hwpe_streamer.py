########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from collector import collector

# HWPE streamer
class hwpe_streamer(collector):
    def top(self):
        return self.get_template()