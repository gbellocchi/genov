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

# import python functions
from python.wrapper.import_params import import_acc_dev_module

'''
  =====================================================================
  Title:        calc_cl_acc_data_ports
  Type:         Function
  Description:  Calculate required number of accelerator data ports.
  =====================================================================
'''

def calc_cl_acc_data_ports(acc_specs):

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
        acc_n_data_ports.append(calc_cl_acc_data_ports(acc_specs))
    # calculate total number of data ports
    for n in acc_n_data_ports:
        total_data_ports += n

    return total_data_ports, acc_names, acc_protocols, acc_n_data_ports

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