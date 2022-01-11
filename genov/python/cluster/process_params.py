'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        process_params.py
 Description:  Processing of cluster design parameters.

 Date:         8.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

# import accelerator wrapper design parameters
from python.wrapper.import_params import import_acc_dev_module

# import overlay design parameters
from dev.ov_dev.specs.ov_specs import ov_specs

'''
  =====================================================================
  Title:        calc_acc_data_ports
  Type:         Function
  Description:  Calculate required number of accelerator data ports.
  =====================================================================
'''

def calc_acc_data_ports(acc_specs):

    standalone_acc_specs = acc_specs.acc_specs()

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
  =====================================================================
  Title:        format_cl_acc_params
  Type:         Function
  Description:  Target a specific interconnection and extract and format
                accelerator design parameters. The output content is 
                formatted in a suitable way for template to be easily
                rendered.
  =====================================================================
'''

def format_cl_acc_params(cl_target_interco):
    total_data_ports    = 0
    acc_names           = []
    acc_protocols       = []
    acc_n_data_ports    = []

    for acc in cl_target_interco:
        # retrieve accelerator name
        acc_names.append(acc[0])
        # retrieve accelerator communication protocol
        acc_protocols.append(acc[1])
        # retrieve number of accelerator data ports
        acc_specs = import_acc_dev_module(acc_names[-1])
        acc_n_data_ports.append(calc_acc_data_ports(acc_specs))
    # calculate total number of data ports
    for n in acc_n_data_ports:
        total_data_ports += n

    return total_data_ports, acc_names, acc_protocols, acc_n_data_ports

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

# '''
#   =====================================================================
#   Title:        cluster_log
#   Type:         Function
#   Description:  Print cluster information.
#   =====================================================================
# '''

# def print_cl_log(ov_specs):
#     print("\t- Number of clusters:", ov_specs.n_clusters)
#     for cl in self.list_clusters:
#         print("\t- Cluster #", self.list_clusters.index(cl), ":")
#         print("\t\tInterconnect topology:", cl[0])
#         print("\t\tAccelerator names:", cl[2])
#         print("\t\tAccelerator protocols:", cl[4])
#         print("\t\tAccelerator data ports:", cl[3])
#         print("\t\tAccelerator data ports (total):", cl[1])