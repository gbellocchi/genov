'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        process_params.py
 Description:  Processing SoC design parameters.

 Date:         8.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

'''
  =====================================================================
  Title:        print_soc_log
  Type:         Function
  Description:  Print SoC information.
  =====================================================================
'''

def print_soc_log(overlay_params):

    print("\n# ============================ #")
    print("# Generation of SoC components #")
    print("# ============================ #\n")

    print("[py] >> User-defined overlay specification:")

    print("\n\tOverlay configuration:", overlay_params.ov_config)
