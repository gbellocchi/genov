'''
 =====================================================================
 Project:       Accelerator-Rich Overlay Generator (AROG)
 Title:         ov_specs.py
 Description:   Specification file to guide the generation of HW/SW
	            components for accelerator-rich overlays.

 Date:          24.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

class ov_specs:

    '''
        ==========
        User knobs
        ==========
    '''

    '''
        Author information
    '''

    def author_k(self):
        self.author                             = 'Gianluca Bellocchi'    
        self.email                              = '<gianluca.bellocchi@unimore.it>'
        return self

    '''
        System
    '''

    def system_k(self):
        self.ov_config                          = 'ov_a'
        return self

    '''
        Cluster #0
    '''

    def cluster_0(self):
        self.cl_offset                          = 0
        self.list_lic                           = [ [ 'traffic_gen' , 'hwpe'] , 
                                                    [ 'traffic_gen' , 'hwpe'] , 
                                                    [ 'traffic_gen' , 'hwpe'] ]
        self.list_hci                           = [ [ 'traffic_gen' , 'hwpe'] ]
        return self

    '''
        Cluster #1
    '''

    def cluster_1(self):
        self.cl_offset                          = 1
        self.list_lic                           = [ [ 'traffic_gen' , 'hwpe'] ]
        self.list_hci                           = [ [ 'conv_mdc' , 'hwpe'] ]
        return self

    '''
        Cluster #2
    '''

    def cluster_2(self):
        self.cl_offset                          = 1
        self.list_lic                           = [ [ 'traffic_gen' , 'hwpe'] ]
        self.list_hci                           = [ [ 'traffic_gen' , 'hwpe'] ]                      
        return self

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    '''
        Extract cluster methods
    '''

    def get_cl_targets_list(self):
        attribute_list = []
        targets_list = []
        for attribute in dir(ov_specs):
            if attribute not in attribute_list:
                if "cluster_" in attribute:
                    attribute_list.append(attribute)
                    method = getattr(self, attribute)
                    targets_list.append(method)
        return targets_list

    '''
        Derive number of clusters
    '''

    def get_n_cl(self):
        return len(self.get_cl_targets_list())

    '''
        Derive information about the accelerator wrapper generation process
    '''

    def get_acc_info(self):
        target_cl = self.get_cl_targets_list()
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
        Format user-defined parameters in a simplified form to ease the templating stage. Do not modify this part.
    '''

    '''
        Format accelerators information.
    '''

    # def accelerators_formatted(self):
    #     # methods
    #     acc_methods = self.get_targets_list()
    #     # extract parameters from methods
    #     self.n_acc = len(acc_methods)
    #     self.acc_names = []
    #     self.acc_protocol = []
    #     self.acc_connection = []
    #     for t in acc_methods:
    #         self.acc_names.append(t().target)
    #         self.acc_protocol.append(t().protocol_type)
    #         self.acc_connection.append(t().connection_type)

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    def __init__(self):
        # user-defined
        self.author_k()
        self.system_k()
        # formatted
        self.get_cl_targets_list()
        # self.get_n_cl()
        # self.get_acc_info()
        # self.accelerators_formatted()

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

