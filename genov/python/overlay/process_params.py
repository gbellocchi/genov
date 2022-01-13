'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        process_params.py
 Description:  Processing overlay design parameters.

 Date:         8.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

from python.wrapper.import_params import import_acc_dev_module
from python.wrapper.process_params import wrapper_params_formatted

'''
  =====================================================================
  Title:        overlay_params_formatted
  Type:         Class
  Description:  Format overlay design parameters. The output content is
                formatted in a suitable way for template to be easily
                rendered.
  =====================================================================
'''

class overlay_params_formatted:

    def __init__(self, ov_specs):
        self.format_overlay_author(ov_specs().author)
        self.format_overlay_system(ov_specs().system)
        self.format_overlay_cluster(ov_specs())

    '''
        Format author information.
    '''

    def format_overlay_author(self, ov_specs):
        self.author                             = ov_specs().author
        self.email                              = ov_specs().email
        return self

    '''
        Format system information.
    '''

    def format_overlay_system(self, ov_specs):
        self.ov_config                          = ov_specs().ov_config
        self.n_clusters                         = get_n_cl(ov_specs())
        return self

    '''
        Format cluster information.
    '''

    def format_overlay_cluster(self, ov_specs):
        self.list_cl_lic = []
        self.list_cl_hci = []
        cl_list = get_cl_targets_list(ov_specs)
        for cl_target in cl_list:
            self.list_cl_lic.append(format_cl_acc_params(cl_target().list_lic))
            self.list_cl_hci.append(format_cl_acc_params(cl_target().list_hci))
        return self

'''
  =====================================================================
  Title:        get_cl_targets_list
  Type:         Function
  Description:  Extract cluster methods.
  =====================================================================
'''

def get_cl_targets_list(ov_specs):
    attribute_list = []
    targets_list = []
    for attribute in dir(ov_specs):
        if attribute not in attribute_list:
            if "cluster_" in attribute:
                attribute_list.append(attribute)
                method = getattr(ov_specs, attribute)
                targets_list.append(method)
    return targets_list

'''
  =====================================================================
  Title:        get_n_cl
  Type:         Function
  Description:  Derive number of clusters.
  =====================================================================
'''

def get_n_cl(ov_specs):
    return len(get_cl_targets_list(ov_specs))

'''
  =====================================================================
  Title:        get_acc_info
  Type:         Function
  Description:  Derive information about the accelerator wrapper
                generation process.
  =====================================================================
'''

def get_acc_info(ov_specs):
    target_cl = get_cl_targets_list(ov_specs)
    target_acc = []
    n_acc = 0
    for m in target_cl:
        for acc in m().list_lic:
            acc_name = acc[0]
            if (acc_name not in target_acc):
                n_acc += 1
                target_acc.append(acc_name)
        for acc in m().list_hci:
            acc_name = acc[0]
            if (acc_name not in target_acc):
                n_acc += 1
                target_acc.append(acc_name)
    return [target_acc, n_acc]

'''
  =====================================================================
  Title:        calc_cl_acc_data_ports
  Type:         Function
  Description:  Calculate required number of accelerator data ports.
  =====================================================================
'''

def calc_cl_acc_data_ports(wrapper_params):

    # get list of sink/source data ports
    n_sink = wrapper_params.n_sink
    n_source = wrapper_params.n_source

    # calculate number of required data ports
    n_data_ports = 0

    # scan sink ports
    for s in range(n_sink):
        if wrapper_params.is_parallel_in[s] is True:
            n_data_ports += wrapper_params.in_parallelism_factor[s]
        else:
            n_data_ports += 1

    # scan source ports
    for s in range(n_source):
        if wrapper_params.is_parallel_out[s] is True:
            n_data_ports += wrapper_params.out_parallelism_factor[s]
        else:
            n_data_ports += 1

    return n_data_ports

'''
  =====================================================================
  Title:        get_acc_targets
  Type:         Function
  Description:  This function derives the distinct target applications
                that need an accelerator wrapper to be generated. Examples
                of such use can be found both in the generation of the
                accelerator interface between the wrapper and the support
                interconnection, as well as in that of the clsuter source
                management scripts (Bender).
  =====================================================================
'''

def get_acc_targets(overlay_params):

    # list of distinct targsts to be derived
    hwpe_gen_list = []

    for i in range(overlay_params.n_clusters):

        cl_lic_acc_names = overlay_params.list_cl_lic[i][1]
        cl_hci_acc_names = overlay_params.list_cl_hci[i][1]

        cl_lic_acc_protocols = overlay_params.list_cl_lic[i][2]
        cl_hci_acc_protocols = overlay_params.list_cl_hci[i][2]

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
        # format accelerator wrapper design parameters
        wrapper_params = wrapper_params_formatted(acc_specs.acc_specs)
        # extract data ports
        acc_n_data_ports.append(calc_cl_acc_data_ports(wrapper_params))
    # calculate total number of data ports
    for n in acc_n_data_ports:
        total_data_ports += n

    return total_data_ports, acc_names, acc_protocols, acc_n_data_ports

'''
  =====================================================================
  Title:        print_ov_log
  Type:         Function
  Description:  Print overlay information.
  =====================================================================
'''

def print_ov_log(overlay_params):

    print("\n# ====================================== #")
    print("# Generation of Accelerator-Rich Overlay #")
    print("# ====================================== #\n")

    print("[py] >> User-defined overlay specification:")

    print("\n\tOverlay configuration:", overlay_params.ov_config)

'''
  =====================================================================
  Title:        print_ov_test_log
  Type:         Function
  Description:  Print overlay test information.
  =====================================================================
'''

def print_ov_test_log(overlay_params):

    print("\n# ========================================== #")
    print("# Generation of System-Level Simulation Test #")
    print("# ========================================== #\n")

    print("[py] >> User-defined overlay specification:")

    print("\n\tOverlay configuration:", overlay_params.ov_config)