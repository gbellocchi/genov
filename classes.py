########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
import numpy as np
import sys
import struct
import shutil
import getpass
import os
from os import listdir
from os.path import isfile, join
from pathlib import Path
from modulefinder import ModuleFinder

# Packages - Template
from mako.template import Template
import math
import re

# Design specification package
from engine_dev.specs.hwpe_specs import hwpe_specs

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ----------------- #
#  Generator class  #
# ----------------- #

class genacc(hwpe_specs):
    def gen(self, template):
        target = Template(template)
        # rendering phase
        string = target.render(
            # author
            author                  = self.author,
            email                   = self.email,
            # kernel
            target                  = self.target,
            design_type             = self.design_type,
            is_ap_ctrl_hs           = self.is_ap_ctrl_hs,
            is_mdc_dataflow         = self.is_mdc_dataflow,
            # streaming
            n_sink                  = self.n_sink, 
            n_source                = self.n_source,
            stream_in               = self.list_sink_stream,
            stream_out              = self.list_source_stream,
            is_parallel_in          = self.is_parallel_in,
            is_parallel_out         = self.is_parallel_out,
            in_parallelism_factor   = self.in_parallelism_factor,
            out_parallelism_factor  = self.out_parallelism_factor,
            # regfile
            std_reg_num             = self.std_reg_num,
            custom_reg_name         = self.custom_reg_name, 
            custom_reg_dtype        = self.custom_reg_dtype,
            custom_reg_dim          = self.custom_reg_dim,
            custom_reg_isport       = self.custom_reg_isport, 
            custom_reg_num          = self.custom_reg_num,
            # addressgen
            addr_gen_in_isprogr     = self.addr_gen_in_isprogr,
            addr_gen_out_isprogr    = self.addr_gen_out_isprogr,
        )
        s = re.sub(r'\s+$', '', string, flags=re.M)
        return s

    def struct_mod(self):
        finder = ModuleFinder()
        finder.run_script(Path(__file__).name)
        f = open("struct_mod.txt", "a")
        for name, mod in finder.modules.items():
            if "templates." in name: 
                s = name.replace(".", "/")
                # s = name
                f.write(s)
                f.write('\n')
        f.close()

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ----------------- #
#  Collector class  #
# ----------------- #

class collector:
    def __init__(self, temp_type, temp_top, temp_modules, path_common):
        # input
        self.temp_type      = temp_type
        self.temp_top       = temp_top
        self.temp_modules   = temp_modules
        self.path_common    = path_common
    
    def get_path_all(self):
        # merge paths
        path_all = self.get_path_t_common() + self.get_path_t_modules()
        path_all += self.get_path_t_top()
        return path_all

    def get_path_t_top(self):
        # calculate path ~ template top
        path_top            = [self.temp_type + 'top/' + self.temp_top]
        return path_top

    def get_path_t_modules(self):
        # calculate path ~ template modules
        path_modules        = []
        for mods in self.temp_modules:
            path_modules.append(self.temp_type + 'modules/' + mods)
        return path_modules

    def get_path_t_common(self):
        # calculate path ~ template common
        path_common         = self.path_common
        # search for templates at the common path
        temp_common = []
        for f in listdir(self.path_common):
            if isfile(join(self.path_common, f)):
                if ".template_" in f:
                    temp_common.append(f)
        # construct paths to common templates
        tmp = [path_common + t for t in temp_common]
        path_common = tmp
        return path_common

    def get_template(self):
        s = ''
        for paths in self.get_path_all():
            print('Retrieving template at path: ', paths)
            with open(paths, 'r') as f:
                s += f.read()
                f.close()
        return s

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# --------------- #
#  Emitter class  #
# --------------- #

class emitter(hwpe_specs):
    def __init__(self):
        # inherit
        super().__init__()
        # define output environment
        self.out_dir = 'output'
        # define output environment ~ HWPE wrapper
        self.out_hw_outdir = self.out_dir + '/hw'
        self.out_hw_hwpe = self.out_hw_outdir + '/hwpe-' + self.target + '-wrapper'
        self.out_hw_hwpe_rtl = self.out_hw_hwpe + '/rtl'
        self.out_hw_hwpe_engine = self.out_hw_hwpe_rtl + '/hwpe-engine'
        self.out_hw_hwpe_streamer = self.out_hw_hwpe_rtl + '/hwpe-stream'
        self.out_hw_hwpe_ctrl = self.out_hw_hwpe_rtl + '/hwpe-ctrl'
        # define output environment ~ software
        self.out_sw_outdir = self.out_dir + '/sw'
        self.out_sw_inc = self.out_sw_outdir + '/inc'
        self.out_sw_test_lib = self.out_sw_inc + '/test_lib'
        self.out_sw_common = self.out_sw_inc + '/common'
        self.out_sw_eu_lib = self.out_sw_inc + '/eu_lib'
        self.out_sw_stim = self.out_sw_inc + '/stim'
        self.out_sw_hwpe_lib = self.out_sw_inc + '/hwpe_lib'
        self.out_sw_bigpulp = self.out_sw_inc + '/bigpulp'
        # define output environment ~ overlay integration
        self.out_ov_integr = self.out_dir + '/ov_integr'

    def output(self, out_target, filepath, filedir):
        with open(filepath, "w") as f:
            f.write(out_target)
            try:
                source = filepath
                destination = filedir
                shutil.move(source, destination)
            except:
                val = getpass.getpass(">> Trying to move generated components to output, but older versions have been found. Would you like to clean your environment? (y/path) ")
                while((val != "y") and (val != "n")):
                    val = input(">> Trying to move generated components to output, but older versions have been found. Would you like to clean your environment? (y/path) ")
                if (val=="y"):
                    os.system('make clean >/dev/null 2>&1')
                    source = filepath
                    destination = filedir
                    shutil.move(source, destination)

    def create_out_hw_env(self):
        # create output directories
        os.mkdir(self.out_hw_hwpe)
        os.mkdir(self.out_hw_hwpe_rtl)
        os.mkdir(self.out_hw_hwpe_engine)

    def create_out_sw_env(self):
        # create output directories
        os.mkdir(self.out_sw_inc)
        os.mkdir(self.out_sw_hwpe_lib)

    def create_out_ov_integr_env(self):
        pass

    def get_file_name(self, target):
        # #
        design_name = target[0]
        design_type = target[1]
        design_comp = target[2]
        # get file extension
        file_ext = self.get_dict_file_ext(design_type, design_comp)
        # construct file name
        file_name = self.target + '_' + design_name + file_ext
        return file_name

    def get_dict_file_ext(self, design_type, design_comp):
        # dictionary for file extensions
        dict_file_ext = {
            'hw'            : { "rtl": ".sv" } , 
            'hw_management' : { "bender": ".yml" } ,
            'sw'            : { "archi": ".h", "hal": ".h", "tb": ".c" }
        }
        return dict_file_ext[design_type][design_comp]