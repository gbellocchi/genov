########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from classes import collector

# QuestaSim waves
class vsim_wave(collector):
    def top(self):
        return self.get_template()