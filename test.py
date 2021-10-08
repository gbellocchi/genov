# import sys
# sys.path

# finder = ModuleFinder()
# finder.run_script('run_gen.py')
# f = open("struct_mod.txt", "a")
# for name, mod in finder.modules.items():
#     if "templates." in name: 
#         s = name.replace(".", "/")
#         f.write(s)
#         f.write('\n')
# f.close()

import inspect

from pathlib import Path
print(Path(__file__).stem) #myfile
print(Path(__file__).name) #myfile.py