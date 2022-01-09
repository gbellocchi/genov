'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        generate_cluster.py
 Description:  Generation of accelerator-rich overlay components.

 Date:         23.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

import sys

'''
    Import custom functions
'''
from python.cluster.generator import gen_cl_comps

'''
    Import emitter
'''
from python.emitter import emit_ov

'''
    Import design parameters
'''
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Import cluster templates
'''
from templates.ov_templ.hw.cluster.cluster import Cluster

'''
    Read input arguments
'''
dir_out_ov = sys.argv[1]

'''
    Instantiate emitter item
'''
emitter = emit_ov(dir_out_ov)

'''
    =====================================================================
    Component:      Cluster

    Description:    Generation of components for accelerator-rich clusters.
    ===================================================================== */
'''

'''
    Instantiate cluster template item
''' 
cluster = Cluster()

'''
    Retrieve cluster design parameters
''' 
ov_specs = ov_specs()

'''
    Iterate on user-defined cluster methods, then 
    generate one-by-one all necessary cluster components
''' 
cl_list = ov_specs.get_cl_targets_list()

for cl_target in cl_list:

    cl_offset = cl_list.index(cl_target)

    '''
        Generate design components ~ Cluster package
    ''' 
    gen_cl_comps(
        cluster.ClPkg(),
        emitter,
        ['cl', str(cl_offset) + '_pkg', ['hw', 'rtl']],
        emitter.ov_gen_cl,
        cl_target,
        cl_offset
    )

    # '''
    #     Generate design components ~ Accelerator regions
    # '''

    # if (opt_ov_specs.cl_interco[cl_offset] == 'shared_lic'):

    #     gen_cl_comps(
    #         cluster.SharedLicAccRegion(),
    #         ['cl', str(cl_offset) + '_shared_lic_acc_region', ['hw', 'rtl']],
    #         emitter.ov_gen_cl,
    #         cl_offset
    #     )

    # elif (opt_ov_specs.cl_interco[cl_offset] == 'private_lic'):

    #     gen_cl_comps(
    #         cluster.PrivateLicAccRegion(),
    #         ['cl', str(cl_offset) + '_private_lic_acc_region', ['hw', 'rtl']],
    #         emitter.ov_gen_cl,
    #         cl_offset
    #     )

    # # elif (opt_ov_specs.cl_interco[cl_offset] == 'shared_hci'):

    # '''
    #     Generate design components ~ Accelerator interface
    # ''' 
    # gen_cl_comps(
    #     cluster.AccIntf(),
    #     ['cl', str(cl_offset) + '_acc_intf', ['hw', 'rtl']],
    #     emitter.ov_gen_cl,
    #     cl_offset
    # )