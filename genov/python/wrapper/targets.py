'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        targets.py
 Description:  Functions for accelerator wrapper targets.

 Date:         8.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

# import python functions
from python.cluster.process_params import format_cl_acc_params

'''
  =====================================================================
  Title:        derive_wrapper_targets
  Type:         Function
  Description:  This function derives the distinct target applications 
                that need an accelerator wrapper to be generated. Examples 
                of such use can be found both in the generation of the
                accelerator interface between the wrapper and the support
                interconnection, as well as in that of the clsuter source
                management scripts (Bender).
  =====================================================================
'''

def derive_wrapper_targets(ov_specs):

    # list of distinct targsts to be derived
    hwpe_gen_list = []

    cl_list = ov_specs.get_cl_targets_list()

    for cl_target in cl_list:

        # derived formatted design parameters as are read by templates
        cl_lic_total_data_ports, cl_lic_acc_names, cl_lic_acc_protocols, cl_lic_acc_n_data_ports = format_cl_acc_params(cl_target().list_lic)
        cl_hci_total_data_ports, cl_hci_acc_names, cl_hci_acc_protocols, cl_hci_acc_n_data_ports = format_cl_acc_params(cl_target().list_hci)

        # Count number of wrappers
        n_acc_cl_lic = len(cl_lic_acc_names)
        n_acc_cl_hci = len(cl_hci_acc_names)

        # Define accelerator list to keep track of generated 
        # accelerator interfaces and avoid duplicated definitions
        is_hwpe_duplicate = False

        # check accelerators connected to LIC interconnect
        for i in range(n_acc_cl_lic):

            # Search for duplicates
            for hwpe_gen in hwpe_gen_list:
                if (cl_lic_acc_names[i]==hwpe_gen):
                    is_hwpe_duplicate = True 

            # If no duplicates are found, then insert 
            # the accelerator interface that will be 
            # soon generated in the list
            if (is_hwpe_duplicate==False):
                if (cl_lic_acc_protocols[i] == "hwpe"):
                    hwpe_gen_list.append(cl_lic_acc_names[i])

            is_hwpe_duplicate = False

        # check accelerators connected to HCI interconnect

        for i in range(n_acc_cl_hci):

            # Search for duplicates

            for hwpe_gen in hwpe_gen_list:
                if (cl_hci_acc_names[i]==hwpe_gen):
                    is_hwpe_duplicate = True 

            # If no duplicates are found, then insert 
            # the accelerator interface that will be 
            # soon generated in the list

            if (is_hwpe_duplicate==False):
                if (cl_hci_acc_protocols[i] == "hwpe"):
                    hwpe_gen_list.append(cl_hci_acc_names[i])

            is_hwpe_duplicate = False

    return hwpe_gen_list