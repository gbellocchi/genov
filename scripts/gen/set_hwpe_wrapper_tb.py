import yaml

a_yaml_file = open("custom_regs.yaml")
parsed_yaml_file = yaml.load(a_yaml_file, Loader=yaml.FullLoader)
print(parsed_yaml_file["custom_regs_value"])