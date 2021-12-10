'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator (AROG)
 Title:        optimizer.py
 Description:  This routine is invoked during generation of application-specific
               accelerators to extract system-level optimization parameters from 
               the kernel specifications. The derived parameters are iteratively 
               saved into an "optimizer" class that gets saved (see use of package
               "pickle") and re-invoked at each routine invocation. Once all
               kernels are investigated, the overlay specification class is updated
               with the derived parameters.

 Date:         7.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

# Packages
from importlib import import_module
import pickle
import os.path

# Design specification packages
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Import application-specific accelerator specification.
    'TARGET_ACC' is a shell variable defined by the script "acc_gen_config.sh".
'''

acc_target = os.environ['TARGET_ACC']
module_name = "dev.acc_dev." + acc_target + ".specs.acc_specs"
acc_specs = import_module(module_name)

'''
    ===============
    Optimizer class
    ===============
'''

class optimizer(ov_specs):

    """
        The optimizer class is responsible of deriving system-level optimization
        parameters on the basis of the accelerator kernel specifications. This
        process is transparent to the user that defines the accelerator and overlay
        specifications themselves. At the end, derived system-level parameters are
        added up to the user-defined ones.

        The '__init__' method imports the input specification parameters from its
        parent class 'ov_specs'.
    """
    def __init__(self):
        super().__init__()

        # kernel offset
        self.offset = 0

        # output parameters
        self.list_shared_lic = []
        self.list_dedicated_lic = []
        self.list_shared_hci = []

    '''
        Obtain user-defined system-level specification concerning the target accelerator kernel.

        - 'acc_target' ~ Name of target accelerator kernel. 
    '''

    def get_acc_specs_method(self, acc_target):
        for t in self.get_targets_list():
            if str(self.offset) in t.__name__:
                if acc_target is t().target:
                    return t()

    '''
        Data interface information:

        - 'acc_data_ports' ~ Number of data ports of each hardware accelerator.
        
    '''

    def opt_data_intf(self, overlay_acc_specs, standalone_acc_specs):
        # extract specifications concerning system-level accelerator interconnection
        acc_interco_type = overlay_acc_specs.connection_type
        # extract specifications concerning accelerator data interface
        acc_n_sink = standalone_acc_specs.n_sink
        acc_n_source = standalone_acc_specs.n_source
        # collect information to guide interconnect design
        if(acc_interco_type is 'shared_lic'):
            print("[py] >> Interconnection method ~  Shared LIC")
            self.list_shared_lic.append([acc_n_sink, acc_n_source])
        elif(acc_interco_type is 'dedicated_lic'):
            print("[py] >> Interconnection method ~  Dedicated LIC")
            self.list_dedicated_lic.append([acc_n_sink, acc_n_source])
        elif(acc_interco_type is 'shared_hci'):
            print("[py] >> Interconnection method ~  Shared HCI")
            self.list_shared_hci.append([acc_n_sink, acc_n_source])

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~  #

'''
    ========================
    Open optimizer chekpoint
    ========================
'''

def get_checkpoint(filename):

    if os.path.isfile(filename):

        '''
            Resume optimizer.
        '''

        print("[py] >> Resuming optimizer state")
        with open(filename, 'rb') as inp:
            obj_opt = pickle.load(inp)

    else:
        
        '''
            Invoke optimizer for the first time.
        '''

        print("[py] >> First invocation of optimizer state")
        obj_opt = optimizer()

    return obj_opt

'''
    ========================
    Save optimizer chekpoint
    ========================
'''

def save_checkpoint(filename, obj_opt):
    
    '''
        Save optimizer state.
    '''

    print("[py] >> Saving optimizer state")
    with open(filename, 'wb') as outp:
        pickle.dump(obj_opt, outp, pickle.HIGHEST_PROTOCOL)

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~  #

'''
    ====================
    Optimization routine
    ====================
'''

'''
    Obtain accelerator offset.
    'OFFSET_ACC' is a shell variable defined by the script "acc_gen_config.sh".
    it is the pointer to the i-th accelerator in the generation process.
'''

acc_offset = os.environ['OFFSET_ACC']
acc_number = os.environ['N_ACC']

'''
    File where to save optimizer state.
'''
 
filename = 'state_optimizer.obj'

'''
    Initialize or resume optimization from checkpoint.
'''

obj_optimizer = get_checkpoint(filename)

'''
    Update optimizer offset.
'''

obj_optimizer.offset = int(acc_offset)

'''
    Obtain accelerator wrapper specification.
'''

print("[py] >> Fetching wrapper specification of target", obj_optimizer.offset + 1, "out of", acc_number)
standalone_acc_specs = acc_specs.acc_specs()

'''
    Obtain system-level accelerator specification.
'''

print("[py] >> Fetching system specification of target", obj_optimizer.offset + 1, "out of", acc_number)
overlay_acc_specs = obj_optimizer.get_acc_specs_method(standalone_acc_specs.target)

'''
    Update accelerator interface information.
'''

obj_optimizer.opt_data_intf(overlay_acc_specs, standalone_acc_specs)

print(obj_optimizer.list_shared_lic)
print(obj_optimizer.list_dedicated_lic)
print(obj_optimizer.list_shared_hci)

'''
    Save optimization checkpoint.
'''

save_checkpoint(filename, obj_optimizer)





