'''
 =====================================================================
 Project:       Bender 
 Title:         bender.py
 Description:   Bender is a dependency management tool for hardware 
                design projects. It provides a way to define dependencies 
                among IPs, execute unit tests, and verify that the source 
                files are valid input for various simulation and synthesis 
                tools. 
                For more information about it:
                    - https://github.com/fabianschuiki/bender

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from python.collector import collector

class Bender(collector):
    def top(self):
        return self.get_template()

    
