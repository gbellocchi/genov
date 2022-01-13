'''
 =====================================================================
 Project:       Overlay class
 Title:         overlay.py
 Description:   The Overlay class recalls all the the templates 
                compliant with the generation of the overlay top hierarchy.
                This is mainly meant for source management scripts.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.hw.overlay.bender.top.bender import Bender
from templates.ov_templ.hw.overlay.bender_lock.top.bender_lock import BenderLock

class Overlay:
    def __init__(self):
        self.path_common = 'templates/ov_templ/hw/common/'

    def Bender(self):
        print("\n[py] >> Overlay ~ Bender")
        return Bender(
            temp_type = 'templates/ov_templ/hw/overlay/bender/',
            temp_top = 'bender.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def BenderLock(self):
        print("\n[py] >> Overlay ~ Bender lock")
        return BenderLock(
            temp_type = 'templates/ov_templ/hw/overlay/bender_lock/',
            temp_top = 'bender_lock.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()