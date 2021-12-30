'''
 =====================================================================
 Project:       QuestaSim waves
 Title:         vsim_wave.py
 Description:   QuestaSim waves to simplify validation phase.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from collector import collector

class vsim_wave(collector):
    def top(self):
        return self.get_template()