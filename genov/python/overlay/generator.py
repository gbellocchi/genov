'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        generator.py
 Description:  Generator of overlay components.

 Date:         8.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from mako.template import Template
import re

'''
    Overlay generator
'''

class Generator:
    '''
        The overlay generator class is the main responsible for rendering
        the collected cluster templates using the input user specification. 
         
        During the rendering phase. design parameters are read and fed to the Python rendering
        core to process the input templates. This is possible exploiting the 'render' method of 
        the 'Template' class defined in the Mako python package.

        The rendered output is a string.
    '''
        
    def render(self, design_params, template, extra_params=[]):
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
    Overlay components generator
    ============================
'''

def gen_ov_comps(temp_obj, design_params, emitter, descr, out_dir, extra_params=[None for _ in range(3)]):
    template = temp_obj
    out_target = Generator().render(design_params, template, extra_params)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)