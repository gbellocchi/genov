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
                    # specs = getattr(t(), t().targets_list[self.offset])
                    # print(t().target)
                    return t

    '''
        Data interface information:

        - 'acc_data_ports' ~ Number of data ports of each hardware accelerator.
        
    '''

    def opt_data_intf(self, ov_acc_specs, standalone_acc_specs):
        if(ov_acc_specs.connection_type is 'shared_lic'):
            print("[py] >> Interconnection method ~  Shared LIC")
            self.list_shared_lic = []
        elif(ov_acc_specs.connection_type is 'dedicated_lic'):
            print("[py] >> Interconnection method ~  Dedicated LIC")
            self.list_dedicated_lic = []
        elif(ov_acc_specs.connection_type is 'shared_hci'):
            print("[py] >> Interconnection method ~  Shared HCI")
            self.list_shared_hci = []

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~  #

'''
    ===================
    Optimizer chekpoint
    ===================
'''

def optimizer_checkpoints(filename):

    if os.path.isfile(filename):

        '''
            Open optimization checkpoint.
        '''

        opt_checkpoint = open(filename, 'rb')

        '''
            Resume optimizer.
        '''

        obj_opt = pickle.load(opt_checkpoint)

    else:
        
        '''
            Invoke optimizer.
        '''

        obj_opt = optimizer()

        '''
            Save optimizer state.
        '''

        opt_checkpoint = open(filename, 'wb') 
        pickle.dump(obj_opt, opt_checkpoint)

    return obj_opt

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~  #

'''
    =========================================
    Application-specific optimization routine
    =========================================
'''

'''
    Obtain accelerator offset.
    'OFFSET_ACC' is a shell variable defined by the script "acc_gen_config.sh".
    it is the pointer to the i-th accelerator in the generation process.
'''

acc_offset = os.environ['OFFSET_ACC']

'''
    File where to save optimizer state.
'''
 
filename = 'state_optimizer.obj'

'''
    Obtain standalone accelerator wrapper specifications.
'''

standalone_acc_specs = acc_specs.acc_specs()

'''
    Initialize or resume optimization from checkpoint.
'''

optimizer = optimizer_checkpoints(filename)

'''
    Update optimizer offset.
'''

optimizer.offset = int(acc_offset)

'''
    Obtain system-level accelerator specification.
'''

overlay_acc_specs = optimizer.get_acc_specs_method(standalone_acc_specs.target)

print(overlay_acc_specs().target)

'''
    Update accelerator interface information.
'''

# optimizer.opt_data_intf(ov_acc_specs, standalone_acc_specs)






