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

# Design specification packages
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Create accelerator configuration file. The latter is processed by shell script
    "genov/tools/common_sh/acc_gen/acc_gen_config.sh" to guide the generation of
    hardware wrappers for target acceleration kernels.
'''

print("[py] >> Creating accelerator configuration file to guide accelerator wrapper generation")

# Invoke overlay specifications
ov_specs = ov_specs()

# Create file
f = open("dev/ov_dev/acc_config.cfg", "w")

# Extract information from overlay specification 

[target_acc, n_acc] = ov_specs.get_acc_info()

# - Number of accelerators
f.write("N_ACC=" + str(n_acc) + "\n")

# - Accelerator targets 
i = 0
for t in target_acc:
    f.write("TARGET_ACC_" + str(i) + "=" + t + "\n")
    i += 1

f.close()
