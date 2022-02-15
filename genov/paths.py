'''
 =====================================================================
 Project:      GenOv
 Title:        main.py
 Description:  Top process. Move here all processes defined in shell 
               scripts. It will make easier the management of design
               parameters.

 Date:         15.2.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

import sys
import os

'''
  =====================================================================
  Title:        create_path
  Type:         Function
  Description:  Create path to filename. Formatting is flexible to OS.
  =====================================================================
'''

def create_path(path_dir, filename):
  if not path_dir:
    path_file = "{}".format(filename)
  else:
    path_file = "{}{}{}".format(path_dir, os.sep, filename)
  return path_file

'''
  =====================================================================
  Title:        get_paths_out_wrapper
  Type:         Function
  Description:  Obtain paths for generated wrapper components.
  =====================================================================
'''

def get_paths_out_wrapper(paths, design_params):

  wrap = {
    "wrap":       create_path("{}{}{}".format(paths["out"]["wr"], design_params.ov_config), "wrap")
  }

  rtl = {
    "wrap":       create_path("{}{}{}".format(paths["out"]["wr"], design_params.ov_config), "rtl"),
    "acc_kernel": create_path("{}{}{}".format(paths["out"]["wr"], design_params.ov_config), "rtl/acc_kernel")
  }

  test = {
    "test":       create_path("{}{}{}".format(paths["out"]["wr"], design_params.ov_config), "test")
  }

  standalone_test = { 
    "hw" : self.hwpe_gen_test + '/hw' create_path("{}{}{}".format(paths["out"]["wr"], design_params.ov_config), "hw")
    "sw" : self.hwpe_gen_test + '/sw'
    "hwpe_lib" : self.hwpe_gen_test + '/sw/inc/hwpe_lib'
  }

  system_test = { 
    system_test_hwpe_lib              = self.out_hwpe + '/../../test/sw/inc/wrappers/' + design_params.target + '/hwpe_lib'
  }

  paths = { "wrap": wrap, 
            "rtl": rtl} 
            # "standalone_test": standalone_test, 
            # "system_test": system_test}

  return paths

'''
  =====================================================================
  Title:        get_paths_out_wrapper
  Type:         Function
  Description:  Obtain paths for Python scripts involved in the 
                generation process.
  =====================================================================
'''

def get_paths(root_dir, design_params):

  top = {
    "src":      create_path(root_dir, "src"),
    "gen":      create_path(root_dir, "genov"),
    "out":      create_path(root_dir, "output"),
  }

  src = {
    "acc":      create_path(top["src_dir"], "accelerators"),
    "ov":       create_path(top["src_dir"], "overlays")
  }

  dev = {
    "acc":      create_path(top["gen_dir"], "dev/acc_dev"),
    "ov":       create_path(top["gen_dir"], "dev/ov_dev")
  }

  tpl = {
    "acc":      create_path(top["gen_dir"], "templates/acc_templ"),
    "acc_hw":   create_path(top["gen_dir"], "templates/acc_templ/hw"),
    "acc_sw":   create_path(top["gen_dir"], "templates/acc_templ/sw"),
    "acc_int":  create_path(top["gen_dir"], "templates/acc_templ/integr_support"),
    "ov":       create_path(top["gen_dir"], "templates/ov_templ/hw"),
  }

  sta = {
    "rtl":      create_path(top["gen_dir"], "static/static_rtl"),
    "tb":       create_path(top["gen_dir"], "static/static_tb")
  }

  out = {
    "ov":       create_path(top["out_dir"], design_params.ov_config),
    "wr":       create_path("{}{}{}".format(top["out_dir"], os.sep, design_params.ov_config), "wrappers")
  }

  paths = { "top": top, 
            "src": src, 
            "dev": dev, 
            "tpl": tpl,
            "sta": sta,
            "out": out}

  return paths