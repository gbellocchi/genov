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

        # list of clusters
        self.list_clusters = []

        # number of clusters
        self.n_clusters = 0

    def log(self):
        print("Optimizer has derived the following system specifications:")
        print("\t- Number of clusters:", self.n_clusters)
        for cl in self.list_clusters:
            print("\t- Cluster #", self.list_clusters.index(cl), ":")
            print("\t\tInterconnect topology:", cl[0])
            print("\t\tNumber of data ports:", cl[1])

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
        Scan list of clusters in search for shared interconnect topologies.
    '''

    def is_first_shared_cl(self, acc_interco_type):
        for cl in self.list_clusters:
            if(cl[0] == acc_interco_type):
                return [False, cl]
        return [True, '']

    '''
        Calculate required number of accelerator data ports.
    '''

    def calc_data_ports(self, standalone_acc_specs):

        # get list of sink/source data ports
        n_sink = standalone_acc_specs.n_sink                  
        n_source = standalone_acc_specs.n_source

        # calculate number of required data ports
        n_data_ports = 0

        # scan sink ports
        for s in range(n_sink):
            if standalone_acc_specs.is_parallel_in[s] is True:
                n_data_ports += standalone_acc_specs.in_parallelism_factor[s]
            else:
                n_data_ports += 1

        # scan source ports
        for s in range(n_source):
            if standalone_acc_specs.is_parallel_out[s] is True:
                n_data_ports += standalone_acc_specs.out_parallelism_factor[s]
            else:
                n_data_ports += 1

        return n_data_ports

    '''
        Optimize accelerator clustering.
    '''

    def opt_clustering(self, overlay_acc_specs, standalone_acc_specs):

        # extract specifications concerning system-level accelerator interconnection
        acc_interco_type        = overlay_acc_specs.connection_type

        # calculate number of required data ports
        n_data_ports            = self.calc_data_ports(standalone_acc_specs)

        # derive how many clusters are needed

        # 1) shared LIC clusters
        if(acc_interco_type is 'shared_lic'):

            print("[py] >> Interconnection method ~  Shared LIC")
            [is_first, shared_cl] = self.is_first_shared_cl(acc_interco_type)

            if(is_first is False):
                shared_cl[1] += n_data_ports
            else:
                self.list_clusters.append([acc_interco_type, n_data_ports])

        # 2) private LIC clusters
        elif(acc_interco_type is 'private_lic'):

            print("[py] >> Interconnection method ~  Dedicated LIC")
            self.list_clusters.append([acc_interco_type, n_data_ports])

        # 3) shared HCI clusters
        elif(acc_interco_type is 'shared_hci'):

            print("[py] >> Interconnection method ~  Shared HCI")
            [is_first, shared_cl] = self.is_first_shared_cl(acc_interco_type)

            if(is_first is False):
                shared_cl[1] += n_data_ports
            else:
                self.list_clusters.append([acc_interco_type, n_data_ports])

        # 4) unknown topology
        else:

            print("[py] >> Interconnection method ~  NOT KNOWN")

        # count number of clusters
        self.n_clusters = len(self.list_clusters)

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

print("\n[py] >> ACCELERATOR TARGET", obj_optimizer.offset + 1, "OUT OF", acc_number)

print("[py] >> Fetching user-defined wrapper specification")
standalone_acc_specs = acc_specs.acc_specs()

'''
    Obtain system-level accelerator specification.
'''

print("[py] >> Fetching user-defined and partially optimized system specification")
overlay_acc_specs = obj_optimizer.get_acc_specs_method(standalone_acc_specs.target)

'''
    Optimizing accelerator clustering. This optimization phase permits
    to gather:

        1) A list of clusters with attached information about:

            - Interconnect topology
            - Number of data ports (hp: 32b)

        2) Overall number of clusters
'''

obj_optimizer.opt_clustering(overlay_acc_specs, standalone_acc_specs)

'''
    Save optimization checkpoint.
'''

save_checkpoint(filename, obj_optimizer)

'''
    Final log.
'''

if obj_optimizer.offset is (int(acc_number)-1):
    print("\n[py] >> END OF OPTIMIZATION ")
    obj_optimizer.log()