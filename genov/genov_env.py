'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator (AROG)
 Title:        out_env.py
 Description:  Construct output environment for overlay.

 Date:         23.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

from emitter import emitter

'''
    Emitter
    =======

    Instantiate export item
'''
emitter = emitter()

'''
    Output environment
    ==================

    Create output environment
'''

emitter.create_out_system_tb()

'''
    Static
    ======

    Export static components
'''

emitter.out_sw_static_system_tb()