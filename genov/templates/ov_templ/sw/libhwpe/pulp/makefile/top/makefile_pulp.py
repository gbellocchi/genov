'''
 =====================================================================
 Project:       LibHwpe class
 Title:         makefile_pulp.py
 Description:   

 Date:          13.7.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from python.collector import collector

class MakefilePulp(collector):
    def top(self):
        return self.get_template()

    
