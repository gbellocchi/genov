'''
 =====================================================================
 Project:      GenOv
 Title:        main.py
 Description:  Top process. Move here all processes defined in shell 
               scripts. It will make easier the management of design
               parameters.

 Date:         15.2.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

import sys
import os

'''
    Import custom functions
'''
from python.overlay.process_params import overlay_params_formatted
from python.overlay.process_params import get_acc_targets
from python.overlay.process_params import print_ov_log
from python.overlay.generator import gen_ov_comps

from dev.ov_dev.specs.ov_specs import ov_specs

def main():

    # Retrieve design parameters
    design_params = overlay_params_formatted(ov_specs)

if __name__ == "__main__":
    main()