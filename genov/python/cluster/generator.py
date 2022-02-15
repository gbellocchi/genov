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

from mako.template import Template
import re

'''
    Cluster generator
'''

class Generator:
    '''
        The generator class is the main responsible for rendering
        the collected templates using the input user specification.
         
        During the rendering phase. design parameters are read and fed to the Python rendering
        core to process the input templates. This is possible exploiting the 'render' method of 
        the 'Template' class defined in the Mako python package.

        The rendered output is a string.
    '''
        
    def render(self, design_params, template, cl_offset=0, extra_params=[]):
        # prepare input template
        target = Template(template)
        # rendering phase
        string = target.render(
            # author
            author                          = design_params.author,
            email                           = design_params.email,
            # system
            ov_config                       = design_params.ov_config,
            # number of clusters
            n_clusters                      = design_params.n_clusters,
            # cluster offset
            cl_offset                       = cl_offset,
            # cluster cores
            cl_core_name                    = design_params.list_cl_cores[cl_offset][0],
            cl_n_cores                      = design_params.list_cl_cores[cl_offset][1],
            # cluster data memory
            cl_n_tcdm_banks                 = design_params.list_cl_tcdm[cl_offset][0],
            cl_tcdm_size                    = design_params.list_cl_tcdm[cl_offset][1],
            # logarithmic interconnect (LIC)
            cl_lic_total_data_ports         = design_params.list_cl_lic[cl_offset][0],
            cl_lic_acc_names                = design_params.list_cl_lic[cl_offset][1],
            cl_lic_acc_protocols            = design_params.list_cl_lic[cl_offset][2],
            cl_lic_acc_n_data_ports         = design_params.list_cl_lic[cl_offset][3],
            # heterogeneous interconnect (HCI)
            cl_hci_total_data_ports         = design_params.list_cl_hci[cl_offset][0],
            cl_hci_acc_names                = design_params.list_cl_hci[cl_offset][1],
            cl_hci_acc_protocols            = design_params.list_cl_hci[cl_offset][2],
            cl_hci_acc_n_data_ports         = design_params.list_cl_hci[cl_offset][3],
            # additional params
            extra_param_0                   = extra_params[0],
            extra_param_1                   = extra_params[1],
            extra_param_2                   = extra_params[2],
        )
        # Compile a regex to trim trailing whitespaces on lines
        # and multiple consecutive new lines.
        re_trailws = re.compile(r'[ \t\r]+$', re.MULTILINE)
        string = re.sub(r'\n\s*\n', '\n\n', string) 
        string = re_trailws.sub("", string)
        return string

'''
    ============================
    Cluster components generator
    ============================
'''

def gen_cl_comps(temp_obj, design_params, emitter, descr, out_dir, cl_offset=0, extra_params=[None for _ in range(3)]):
    template = temp_obj
    out_target = Generator().render(design_params, template, cl_offset, extra_params)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)