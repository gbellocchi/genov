'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator (AROG)
 Title:        initalizer.py
 Description:  Preliminary operation to let the generation process proceed
               with all the required information about the input specifications.

 Date:         7.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

'''
    Import design parameters
'''
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Import custom functions
'''
from python.overlay.process_params import get_acc_info

'''
    Create accelerator configuration file. The latter is processed by shell script
    "genov/tools/common_sh/acc_gen/acc_gen_config.sh" to guide the generation of
    hardware wrappers for target acceleration kernels.
'''

acc_cfg_file = "dev/ov_dev/acc_config.cfg"

print("[py] >> Creating accelerator configuration file to guide accelerator wrapper generation")
print("\n\t- Location ->", acc_cfg_file, "\n")

# Invoke overlay specifications
ov_specs = ov_specs()

# Create file
f = open(acc_cfg_file, "w")

# Extract information from overlay specification 

[target_acc, n_acc] = get_acc_info(ov_specs)

# - Number of accelerators
f.write("N_ACC=" + str(n_acc) + "\n")

# - Accelerator targets 
i = 0
for t in target_acc:
    f.write("TARGET_ACC_" + str(i) + "=" + t + "\n")
    i += 1

f.close()
