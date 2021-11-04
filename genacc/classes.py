########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
import numpy as np
import sys
import struct
import shutil
from distutils.dir_util import copy_tree
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
    '''
    The accelerator generator class is the main responsible for rendering
    the collected templates using the input user specification. 
    
    Technically speaking, the generator is derived (child class) from 'hwpe_specs'. 
    The latter comprises the input user parameters to guide the rendering phase. 
    The generator adds up to the functionality of its parent class methods to render
    the input templates. This is possible exploiting the 'render' method of the 'Template' 
    class defined in the Mako python package.

    The method 'gen' takes a 'template' input. This comprises all the template components 
    (top, modules, common) pertaining to a specific design components.

    The rendered output is a string.
    '''
    def gen(self, template):
        # prepare input template
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
            stream_in               = self.stream_in,
            stream_out              = self.stream_out,
            stream_in_dtype         = self.stream_in_dtype,
            stream_out_dtype        = self.stream_out_dtype,
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
            # static design components
            engine_devs             = self.get_engine(),
            num_engine_devs         = len(self.get_engine()),
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

    """
    Methods used to retrieve lists of files to feed the scripts 
    used for version control. For example, the method 'get_engine'
    retrieves a list of the input RTL files that have to be wrapped,
    then these are used to generate the scripts for the 'bender' tool.
    """
    def get_engine(self):
        filename = 'templates/integr_support/rtl_list/engine_list.log'
        with open(filename, 'r') as f:
            s = f.readlines()
            f.close()
            return s

    def get_stream(self):
        filename = 'templates/integr_support/rtl_list/stream_list.log'
        with open(filename, 'r') as f:
            s = f.readlines()
            f.close()
            return s

    def get_ctrl(self):
        filename = 'templates/integr_support/rtl_list/ctrl_list.log'
        with open(filename, 'r') as f:
            s = f.readlines()
            f.close()
            return s

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ----------------- #
#  Collector class  #
# ----------------- #

class collector:
    """
    The collector class is responsible of collecting the template files from the
    template library for the generator. Templates are divided in three categories:

    - Top ~ A top template is the main target of the rendering phase. It is the entry point 
    where the rendering for a particular rendering target begins. It is comparable to an entry
    point in a typical programming language (e.g. a 'main' function). A top template may comprise
    parametrized components and template APIs to recall template modules (or template blocks using 
    the Mako syntax). Furthermore, the Mako runtime environment is exploitable to ease the instantiation
    of different template components and modules within the top template itself. The Python interpreter 
    can thus be invoked within the body of the template to define parameters, use conditional statements 
    and for loops. A top template comes with a python support file that permits to collect all the template 
    components needed during the rendering phase.

    - Modules ~ A module is a template block that can be instantiated by a top template. This solution permits
    to simplify the construction of highly modular templates having lot of alternative implementation solutions
    that can be re-targeted exploting conditional assignements guided by input user needs and re-calling
    template modules through template APIs. It is worth to know that input user parameters (those defined through
    the 'hwpe_specs class) have not to be specified as input API arguments since these are globally applied to 
    during the rendering phase to an intermediate template component that comprises the top template together 
    with its modules and common components. A module has the same features of a top template, thus it may comprise
    parametrize components, as well as recall other modules. The latter can happen both at the same hierarchy level, 
    or at lower thus possibly making it a top template for other template modules.

    - Common ~ Common template components shared by all templates on the basis of their nature (HW, SW).

    The '__init__' method imports information about the templates to be collected:

    - temp_type ~ relative path from 'templates/' to the top directory of the target template type;
    - temp_top ~ name (with template extension) of top template;
    - temp_modules ~ list of names (with template extension) of template modules;
    - path_common ~ relative path from 'templates/' to the top directory of the common templates.
    """
    def __init__(self, temp_type, temp_top, temp_modules, path_common):
        # input
        self.temp_type      = temp_type
        self.temp_top       = temp_top
        self.temp_modules   = temp_modules
        self.path_common    = path_common
    
    """
    Get path for all template components (top, modules, common)
    """
    def get_path_all(self):
        # merge paths
        path_all = self.get_path_t_common() + self.get_path_t_modules()
        path_all += self.get_path_t_top()
        return path_all

    """
    Get path for top template.
    """
    def get_path_t_top(self):
        # calculate path ~ template top
        path_top            = [self.temp_type + 'top/' + self.temp_top]
        return path_top

    """
    Get path for template modules.
    """
    def get_path_t_modules(self):
        # calculate path ~ template modules
        path_modules        = []
        for mods in self.temp_modules:
            path_modules.append(self.temp_type + 'modules/' + mods)
        return path_modules

    """
    Get path for common template components.
    """
    def get_path_t_common(self):
        # calculate path ~ template common
        path_common         = self.path_common
        # search for templates at the common path
        temp_common = []
        try:
            for f in listdir(self.path_common):
                if isfile(join(self.path_common, f)):
                    if ".template_" in f:
                        temp_common.append(f)
            # construct paths to common templates
            tmp = [path_common + t for t in temp_common]
            path_common = tmp
        except:
            path_common = []
        return path_common

    """
    Given the paths collected using the 'get_path_all' method,
    read the content of all templates. This method is used by
    the python support file comprised in the same directory of 
    a top template.
    """
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
    """
    The emitter class is responsible of creating the ouput environment,
    to assemble the associated repository, as well as its file components.

    The '__init__' method imports the input specification parameters from its
    parent class 'hwpe_specs' and defines a set of directory names.
    """
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
        self.out_hw_hwpe_engine_dev = self.out_hw_hwpe_engine + '/engine_dev'
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

    """
    Create environment for hardware.
    """
    def create_out_hw_env(self):
        # create output directories
        os.mkdir(self.out_hw_hwpe)
        os.mkdir(self.out_hw_hwpe_rtl)
        os.mkdir(self.out_hw_hwpe_engine)

    """
    Create environment for software.
    """
    def create_out_sw_env(self):
        # create output directories
        os.mkdir(self.out_sw_inc)
        os.mkdir(self.out_sw_hwpe_lib)

    """
    Create environment for overlay integration.
    """
    def create_out_ov_integr_env(self):
        pass

    """
    The 'out_gen' method is in charge of physically setting up the output 
    repository moving generated files to their target positions. The term 
    'gen' is used to denote files that are the targets of the rendering phase.
    The input arguments are:

    - 'out_target' ~ Generated design component. Typically an output string from 
    an emitter item.

    - 'filename' ~ Name of generated design component. Typically an output string from 
    a generator item.

    - 'filedir' ~ Target directory. Either a custom string or one of those defined 
    in the emitter constructor.
    """
    def out_gen(self, out_target, filename, filedir):
        print("\nExporting generated item (", filename, ") to target destination (", filedir, ")")
        with open(filename, "w") as f:
            f.write(out_target)
            try:
                source = filename
                destination = filedir
                shutil.move(source, destination)
            except:
                val = ""
                while((val != "y") and (val != "n")):
                    val = input(">> Trying to move generated components to output, but older versions have been found. Would you like to clean your environment? (y/n) ")
                if (val=="y"):
                    os.system('make clean >/dev/null 2>&1')
                    source = filename
                    destination = filedir
                    shutil.move(source, destination)

    """
    The 'out_hw_static' method is in charge of physically setting up the output 
    repository moving static HW files to their target positions. The term 'static'
    is used to denote files that are not targets of the rendering phase, but are
    either defined withing the repository, or cloned as external sources.
    """
    def out_hw_static(self):
        # static components (hw, sw, ..)
        static_comps = 'static'
        # ------------------------------------------------ #
        # copy static components ~ streamer
        source = static_comps + '/static_rtl/hwpe-stream/rtl'
        destination = self.out_hw_hwpe_streamer
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for static component of streamer!")
        # ------------------------------------------------ #
        # copy static components ~ controller
        source = static_comps + '/static_rtl/hwpe-ctrl/rtl'
        destination = self.out_hw_hwpe_ctrl
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for static component of controller!")
        # ------------------------------------------------ #
        # create repo for wrapped hardware kernel
        source = 'engine_dev/rtl'
        destination = self.out_hw_hwpe_engine_dev
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for static component of imported hardware kernel!")
        # ------------------------------------------------ #

    """
    The 'out_sw_static' method is in charge of physically setting up the output 
    repository moving static SW files to their target positions. The term 'static'
    is used to denote files that are not targets of the rendering phase, but are
    either defined within the repository, or cloned as external sources. 

    """
    def out_sw_static(self):
        # static components (hw, sw, ..)
        static_comps = 'static'
        # ------------------------------------------------ #
        # copy static components
        source = 'static/static_tb'
        destination = self.out_sw_outdir
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for static component of imported hardware kernel!")
        # ------------------------------------------------ #
        # copy static components ~ input stimuli
        source = 'engine_dev/sw'
        destination = self.out_sw_stim
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for input stimuli!")

    """
    The 'get_file_name' method gets information about the features of the
    generated IP, support file, SW component, etc. and constructs the name
    of the export file with the aid of the following methods:

    - 'construct_file_name' ~ it offers a dictionary that associates the supported
    device types (HWPE, overlay, etc.) with a particular file_name constructor;

    - 'hwpe_file_name' ~ an exemplary file_name constructor targeting HWPE devices;

    - 'get_dict_file_ext' ~ it offers a dictionary to derive the file_name extension.

    The input 'target' argument is a list of information about the target whose name
    has to be obtained. The input list is constructed in the following way:

    - Item 0 = Device type ~ the first list item aims at defining the type of the device
    the generated component is devoted to (HWPE? Overlay? QuestaSim? Bender?). Each device
    has its rules about filename construction, so a particular filename constructor is needed
    in most of cases. Thus, this input parameter changes the way the file_name is constructed. 
    For more information, take a look at the method 'construct_file_name' and the python
    dictionary that is used to choose the proper constructor.

    - Item 1 = Design name ~ this item defines the the name of the generated design item in the
    filename. Thus, this defines the use the generated file is used for.

    - Item 2 = Design type ~ this item is a sub-list that is employed to solve the choice of the 
    proper file extension. For more information about how file extensions are retrieved, see 
    method 'get_dict_file_ext'. The latter defines two nested dictionaries to associate the 
    design type information with a proper file extension.
    """
    def get_file_name(self, target):
        # #
        self.device_type = target[0] 
        self.design_name = target[1] 
        self.design_type = target[2] 
        # get file extension
        self.file_ext = self.get_dict_file_ext()
        # construct file name
        return self.construct_file_name()

    '''
    Defines a dictionary that associates the supported device types (HWPE, overlay, etc.) 
    with a particular file_name constructor.
    '''
    def construct_file_name(self):
        # dictionary for file extensions
        dict_file_ext = {
            'hwpe'            : self.hwpe_file_name(),
            'ov'              : self.ov_file_name(),
            'integr_support'  : self.integr_support_file_name(),
            'sw'              : self.sw_file_name()
        }
        return dict_file_ext[self.device_type]

    '''
    Constructor of file names targeting HWPE devices.
    '''
    def hwpe_file_name(self):
        file_name = self.target + '_' + self.design_name + self.file_ext
        return file_name

    '''
    Constructor of file names targeting the overlay.
    '''
    def ov_file_name(self):
        file_name = 'ov_' + self.design_name + self.file_ext
        return file_name

    '''
    Constructor of file names for support during integration.
    '''
    def integr_support_file_name(self):
        file_name = self.design_name + self.file_ext
        return file_name

    '''
    Constructor of file names for softare testbench.
    '''
    def sw_file_name(self):
        file_name = self.design_name + self.file_ext
        return file_name

    '''
    Retrieve file extension.
    '''
    def get_dict_file_ext(self):
        # dictionary for file extensions
        dict_file_ext = {
            'hw'                : { "rtl": ".sv" } , 
            'integr_support'    : { "bender": ".yml", "vsim_wave": ".wave.do" } ,
            'sw'                : { "archi": ".h", "hal": ".h", "tb": ".c" }
        }
        return dict_file_ext[self.design_type[0]][self.design_type[1]]