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
import os

# Design specification package
from dev.acc_dev.specs.hwpe_specs import hwpe_specs

'''
    Emitter class
    =============
'''

class emitter(hwpe_specs):
    """
    The emitter class is responsible of creating the ouput environment,
    to assemble the associated repository, as well as its file components.

    The '__init__' method imports the input specification parameters from its
    parent class 'hwpe_specs'. Other than the latter, the paths to the output
    environment are specified. The output directory has the same structure of 
    the template one. However, the former comprises no more templates, but 
    rendered HW/SW items.
    """
    def __init__(self):
        # inherit
        super().__init__()

        '''
            Output environment
        '''
        self.out_dir                        = 'output'

        '''
            Output environment ~ Generated accelerator
        '''
        
        self.acc_gen                        = 'acc_gen'

        self.acc_gen_hw                     = self.out_dir + '/' + self.acc_gen + '/hw'
        self.acc_gen_sw                     = self.out_dir + '/' + self.acc_gen + '/sw'

        # Hardware ~ HWPE wrapper
        self.out_hw_hwpe                    = self.acc_gen_hw + '/hwpe_wrapper'
        self.out_hw_hwpe_wrap               = self.out_hw_hwpe + '/wrap'
        self.out_hw_hwpe_rtl                = self.out_hw_hwpe + '/rtl'
        self.out_hw_hwpe_acc_kernel         = self.out_hw_hwpe_rtl + '/acc_kernel'

        # Hardware ~ HWPE standalone tb (HW)
        self.out_hw_standalone_tb           = self.acc_gen_hw + '/hwpe_standalone_tb'

        # Software ~ HWPE standalone tb (SW)
        self.out_sw_standalone              = self.acc_gen_sw + '/hwpe_standalone_tb'
        self.out_sw_standalone_inc          = self.out_sw_standalone + '/inc'
        self.out_sw_standalone_stim         = self.out_sw_standalone_inc + '/stim'
        self.out_sw_standalone_hwpe_lib     = self.out_sw_standalone_inc + '/hwpe_lib'

        '''
            Output environment ~ Generated overlay
        '''

        self.ov_gen                         = 'ov_gen'

        self.ov_gen_hw                      = self.out_dir + '/' + self.ov_gen + '/hw'
        self.ov_gen_sw                      = self.out_dir + '/' + self.ov_gen + '/sw'
        self.ov_gen_acc_int                 = self.out_dir + '/' + self.ov_gen + '/integr_support'

        # Hardware ~ Overlay
        self.out_hw_ov                      = self.ov_gen_hw + '/overlay'

        # Software ~ HWPE system-level tb (SW)
        self.out_sw_ov                      = self.ov_gen_sw + '/hwpe_ov_tb'
        self.out_sw_ov_inc                  = self.out_sw_ov + '/inc'
        self.out_sw_ov_stim                 = self.out_sw_ov_inc + '/stim'
        self.out_sw_ov_hwpe_lib             = self.out_sw_ov_inc + '/hwpe_lib'

    """
    Check output paths correctness.
    """
    def check_sub_paths(self, top_path, sub_path):
        # check output paths correctness
        out_val = sub_path.startswith(top_path)
        return out_val

    """
    Create environment for hardware wrapper.
    """
    def create_out_hwpe_wrapper(self):
        top_path = self.out_dir

        sub_path = self.out_hw_hwpe_wrap
        if self.check_sub_paths(top_path, sub_path) is True:
            try:
                os.mkdir(sub_path) 
            except:
                pass

        sub_path = self.out_hw_hwpe_rtl
        if self.check_sub_paths(top_path, sub_path) is True:
            try:
                os.mkdir(sub_path) 
            except:
                pass

    """
    Create environment for software testbenches.
    """

    # system-level testbench

    def create_out_system_tb(self):
        top_path = self.out_dir

        sub_path = self.out_sw_ov_inc
        if self.check_sub_paths(top_path, sub_path) is True:
            try:
                os.mkdir(sub_path) 
            except:
                pass

        sub_path = self.out_sw_ov_hwpe_lib
        if self.check_sub_paths(top_path, sub_path) is True:
            try:
                os.mkdir(sub_path) 
            except:
                pass

    # standalone testbench

    def create_out_standalone_tb(self):
        top_path = self.out_dir

        sub_path = self.out_sw_standalone_inc
        if self.check_sub_paths(top_path, sub_path) is True:
            try:
                os.mkdir(sub_path) 
            except:
                pass

        sub_path = self.out_sw_standalone_hwpe_lib
        if self.check_sub_paths(top_path, sub_path) is True:
            try:
                os.mkdir(sub_path) 
            except:
                pass

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
        if(os.path.isdir(filename)):
            source = filename
            destination = filedir
            shutil.copytree(source, destination)
        else:
            with open(filename, "w") as f:
                f.write(out_target)
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
        # create repo for wrapped hardware kernel
        source = 'dev/acc_dev/rtl'
        destination = self.out_hw_hwpe_acc_kernel
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for static component of imported hardware kernel!")

    """
    The 'out_sw_static' methods are in charge of physically setting up the output 
    repository moving static SW files to their target positions. The term 'static'
    is used to denote files that are not targets of the rendering phase, but are
    either defined within the repository, or cloned as external sources. 

    """
    def out_sw_static_system_tb(self):
        # static components (hw, sw, ..)
        static_comps = 'static'
        # ------------------------------------------------ #
        # copy static components (tb-ov)
        source = 'static/static_tb/hwpe_ov_tb_sw'
        destination = self.out_sw_ov
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for static component of imported hardware kernel!")
        # ------------------------------------------------ #
        # copy static components (tb-ov) ~ input stimuli
        source = 'dev/acc_dev/sw/stim'
        destination = self.out_sw_ov_stim
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for input stimuli!")
        # ------------------------------------------------ #

    def out_sw_static_standalone_tb(self):   
        # static components (hw, sw, ..)
        static_comps = 'static'
        # ------------------------------------------------ #
        # copy static components (tb-standalone)
        source = 'static/static_tb/hwpe_standalone_tb'
        destination = self.out_sw_standalone
        try:
            copy_tree(source, destination)
        except:
            print(">> Erroneous path for static component of imported hardware kernel!")
        # ------------------------------------------------ #
        # copy static components (tb-standalone) ~ input stimuli
        source = 'dev/acc_dev/sw/stim'
        destination = self.out_sw_standalone_stim
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
            'tb'              : self.tb_file_name(),
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
    Constructor of file names targeting the testbench.
    '''
    def tb_file_name(self):
        file_name = self.design_name + self.file_ext
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
            'integr_support'    : { "yml": ".yml", "vsim_wave": ".wave.do" } ,
            'sw'                : { "archi": ".h", "hal": ".h", "tb": ".c" }
        }
        return dict_file_ext[self.design_type[0]][self.design_type[1]]