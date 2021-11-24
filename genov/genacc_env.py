'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator (AROG)
 Title:        genacc_env.py
 Description:  Construct output environment for hardware wrapper.

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

emitter.create_out_hwpe_wrapper()
emitter.create_out_standalone_tb()

'''
    Static
    ======

    Export static components
'''

emitter.out_hw_static() 
emitter.out_sw_static_standalone_tb()