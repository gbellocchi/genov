'''
 =====================================================================
 Project:       HERO AXI mailbox
 Title:         hero_axi_mailbox.py
 Description:   HERO AXI mailbox

 Date:          13.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''
#!/usr/bin/env python3

from python.collector import collector

class HeroAxiMailbox(collector):
    def top(self):
        return self.get_template()