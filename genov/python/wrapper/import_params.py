'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        import_params.py
 Description:  Functions to import and manage accelerator wrapper design 
                parameters.

 Date:         8.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''
from importlib import import_module

'''
  =====================================================================
  Title:        import_acc_dev_module
  Type:         Function
  Description:  Import accelerator module by string.
  =====================================================================
'''

def import_acc_dev_module(target_acc):
    module_name = "dev.acc_dev." + target_acc + ".specs.acc_specs"
    acc_specs = import_module(module_name)
    return acc_specs