'''
 =====================================================================
 Project:       Bender lock
 Title:         bender_lock.py
 Description:   Bender is a dependency management tool for hardware 
                design projects. It provides a way to define dependencies 
                among IPs, execute unit tests, and verify that the source 
                files are valid input for various simulation and synthesis 
                tools. 
                Reproducible builds can be maintained by means of keeping a  
                lock file. The latter tracks the exact git hash a dependency 
                has been resolved to. This allows the source code of a package 
                to be reliable reconstructed after the fact.
                For more information about it:
                    - https://github.com/fabianschuiki/bender

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from python.collector import collector

class BenderLock(collector):
    def top(self):
        return self.get_template()

    
