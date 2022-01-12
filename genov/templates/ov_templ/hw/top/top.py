'''
 =====================================================================
 Project:       SoC class
 Title:         soc.py
 Description:   The SoC class recalls all the the templates compliant 
                with the generation of the top-level SoC compoenents.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.hw.soc.bender.top.bender import bender

class Soc:
    def __init__(self):
        print("\n[py] >> SoC ~ Retrieving hardware components")
        self.path_common = 'templates/ov_templ/hw/common/'

    def Bender(self):
        print("\n[py] >> Cluster ~ Bender")
        return bender(
            temp_type = 'templates/ov_templ/hw/soc/bender/',
            temp_top = 'bender.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()