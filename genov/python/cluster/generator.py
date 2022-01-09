'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        generator.py
 Description:  Generator of cluster components.

 Date:         8.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

# Packages - Template
from mako.template import Template
import re
import pickle
import os.path
import sys

# import python functions
from python.cluster.process_params import format_cl_acc_params

# import overlay design parameters
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Cluster generator
'''

class Generator(ov_specs):
    '''
        The overlay generator class is the main responsible for rendering
        the collected templates using the input user specification. 
        
        Technically speaking, the generator is derived (child class) from 'ov_specs'. 
        The latter comprises the input user parameters to guide the rendering phase. 
        The generator adds up to the functionality of its parent class methods to render
        the input templates. This is possible exploiting the 'render' method of the 'Template' 
        class defined in the Mako python package.

        The method 'gen' takes a 'template' input. This comprises all the template components 
        (top, modules, common) pertaining to a specific design components.

        The rendered output is a string.
    '''
        
    def render(self, template, cl_target=None, cl_offset=0):
        # format design parameters
        cl_lic_total_data_ports, cl_lic_acc_names, cl_lic_acc_protocols, cl_lic_acc_n_data_ports = format_cl_acc_params(cl_target().list_lic)
        cl_hci_total_data_ports, cl_hci_acc_names, cl_hci_acc_protocols, cl_hci_acc_n_data_ports = format_cl_acc_params(cl_target().list_hci)
        
        # prepare input template
        target = Template(template)
        # rendering phase
        string = target.render(
            # author
            author                          = self.author,
            email                           = self.email,
            # number of clusters
            n_clusters                      = self.get_n_cl(),
            # cluster offset
            cl_offset                       = cl_offset,
            # logarithmic interconnect (LIC)
            cl_lic_total_data_ports         = cl_lic_total_data_ports, 
            cl_lic_acc_names                = cl_lic_acc_names,
            cl_lic_acc_protocols            = cl_lic_acc_protocols,
            cl_lic_acc_n_data_ports         = cl_lic_acc_n_data_ports,
            # heterogeneous interconnect (HCI)
            cl_hci_total_data_ports         = cl_hci_total_data_ports, 
            cl_hci_acc_names                = cl_hci_acc_names,
            cl_hci_acc_protocols            = cl_hci_acc_protocols,
            cl_hci_acc_n_data_ports         = cl_hci_acc_n_data_ports,
        )
        # Compile a regex to trim trailing whitespaces on lines
        # and multiple consecutive new lines.
        re_trailws = re.compile(r'[ \t\r]+$', re.MULTILINE)
        string = re.sub(r'\n\s*\n', '\n\n', string) 
        string = re_trailws.sub("", string)
        return string
        return ""
        
'''
    ========================================
    Retrieve optimized overlay specification
    ========================================
'''

def get_opt_cluster_params(filename):
    if os.path.isfile(filename):
        print("[py] >> Retrieving optimizer state")
        with open(filename, 'rb') as inp:
            obj_opt = pickle.load(inp)
        return obj_opt
    else:
        print("[py] >> No optimizer has been retrieved")
        sys.exit(1)

'''
    ============================
    Cluster components generator
    ============================

    Differently from the generic generator, this alternative 
    version passes also a "cluster_offset" to target the 
    generation of components for a specific cluster
'''

def gen_cl_comps(temp_obj, emitter, descr, out_dir, cl_target, cl_offset):
    template = temp_obj
    out_target = Generator().render(template, cl_target=cl_target, cl_offset=cl_offset)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)