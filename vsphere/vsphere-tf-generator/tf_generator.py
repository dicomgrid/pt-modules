# Install required packages
import subprocess
import sys

def install_packages():
    packages = "PyYAML", "Jinja2" 
    installed_packages = str(subprocess.check_output([sys.executable, "-m", "pip", "list"]))
    for package in packages:        
        if package not in installed_packages:
            subprocess.check_call([sys.executable, "-m", "pip", "install", package])
            print(package + " was has been installed")
        else:
            print(package + " was already installed")

install_packages()

import yaml
import jinja2
import os
import datetime
from ipaddress import IPv4Address
import shutil

### File References ###

__location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))

input_variables = os.path.join(__location__, 'input_vars.yml')
template_variables = os.path.join(__location__, 'template_vars.yml')

### Open variable files ###

with open(input_variables) as f:
    input_vars = yaml.safe_load(f)

with open(template_variables) as f:
    template_vars = yaml.safe_load(f)

### Input variables ###
client_code = input_vars['client_code']
client_size = input_vars['client_size']
client_type = input_vars['client_type']
client_time_zone = input_vars['client_time_zone']
primary_dc = input_vars['primary_dc']
network_base_address = input_vars['network_base_address']
vlan_be = input_vars['vlan_be']
vlan_fe = input_vars['vlan_fe']

### Map dynamic variables ###
if primary_dc == "nas6":
    dcs = ["nas6", "atl2"]
    dc_guest_name = ["nas", "atl"]
elif primary_dc == "atl2":
    dcs = ["atl2", "nas6"]
    dc_guest_name = ["atl", "nas"]
elif primary_dc == "mna":
    dcs = ["mna"]
    dc_guest_name = ["mna"]

if primary_dc != "mna":
    secondary_dc = dcs[1]
port_group_be = client_code + "-be" + "-v" + vlan_be
port_group_fe = client_code + "-fe" + "-v" + vlan_fe
netmask_be = template_vars['cidr']['be']
netmask_fe = template_vars['cidr']['fe']
gw_be = input_vars['network_base_address'] + "1"
gw_fe = input_vars['network_base_address'] + "129"

#for server in (input_vars['vms']):
#    print(server)

### Pass variables to output dictionary ###
dict_out = {}
dict_out['client_code'] = client_code
dict_out['client_size'] = client_size
dict_out['client_time_zone'] = client_time_zone
dict_out['primary_dc'] = primary_dc
if primary_dc != "mna":
    dict_out['secondary_dc'] = secondary_dc
dict_out['network_base_address'] = network_base_address
dict_out['vlan_be'] = vlan_be
dict_out['vlan_fe'] = vlan_fe
dict_out['port_group_be'] = port_group_be
dict_out['port_group_fe'] = port_group_fe
dict_out['dc1'] = {}
dict_out['dc2'] = {}
### VMs dictionatry creation ###

for server in (input_vars['vms']):

    start_address = input_vars['network_base_address'] + str(template_vars[client_type][server]['start_ip'])
    server_total = ((input_vars['vms'][server]['dc1_count']) + (input_vars['vms'][server]['dc2_count']))
    dc1_count = (input_vars['vms'][server]['dc1_count'])
    dc2_count = (input_vars['vms'][server]['dc2_count'])
    counter = 1
    server_code = None
    
    if input_vars['vms'][server]['server_code'] != None:
        server_code = (input_vars['vms'][server]['server_code'])
        code_list = server_code.split("-")
        paging_size = (((int(template_vars['mem'][code_list[1][1]] * 1.5 // 0.88)) + 7) & (-8))
        disks = code_list[2:]
        if server == "depot":
            del disks[-1]
        

    for i in range(0, server_total):
        if ((i % 2 == 0) and (dc2_count > 0)):
            vm_name = client_code + dc_guest_name[0] + server + str(counter)
            paging_count = 1
            dict_out['dc1'][vm_name] = {}
            dict_out['dc1'][vm_name]['name'] = vm_name
            dict_out['dc1'][vm_name]['role'] = server
            dict_out['dc1'][vm_name]['disks'] = {}
            dict_out['dc1'][vm_name]['disks'] = []
            dict_out['dc1'][vm_name]['dc'] = dcs[0]

            dict_out['dc1'][vm_name]['os'] = template_vars[client_type][server]['os']

            if template_vars[client_type][server]['os'] == "linux":
                dict_out['dc1'][vm_name]['host_cluster'] = input_vars['dc1_linux_host_cluster']
                dict_out['dc1'][vm_name]['ds_cluster'] = input_vars['dc1_linux_ds_cluster']
            elif template_vars[client_type][server]['os'] == "windows":
                dict_out['dc1'][vm_name]['host_cluster'] = input_vars['dc1_windows_host_cluster']
                dict_out['dc1'][vm_name]['ds_cluster'] = input_vars['dc1_windows_ds_cluster']

            if server_code != None:
                dict_out['dc1'][vm_name]['cpu'] = template_vars['cpu'][code_list[1][0]]
                dict_out['dc1'][vm_name]['mem'] = template_vars['mem'][code_list[1][1]]
                if template_vars[client_type][server]['os'] == "linux":
                    dict_out['dc1'][vm_name]['disks'] += [1]
                    dict_out['dc1'][vm_name]['disks'] += [16]

                for disk in disks:
                    disk_size = template_vars['disk'][disk[0]]
                    if "x" not in str(disk):
                        dict_out['dc1'][vm_name]['disks'] += [disk_size]
                    else:
                        adds = disk.split("x")[1]
                        for i in range(int(adds)):
                            dict_out['dc1'][vm_name]['disks'] += [disk_size]

                    if (template_vars[client_type][server]['os'] == "windows") and (paging_count >= 1):
                        dict_out['dc1'][vm_name]['disks'] += [paging_size]
                        paging_count -= 1

            else:
                if client_size == "small":
                    dict_out['dc1'][vm_name]['cpu'] = template_vars[client_type][server]['cpu']['small']
                    dict_out['dc1'][vm_name]['mem'] = template_vars[client_type][server]['mem']['small']
                    dict_out['dc1'][vm_name]['disks'] = template_vars[client_type][server]['disks']['small']
                elif client_size == "medium":
                    dict_out['dc1'][vm_name]['cpu'] = template_vars[client_type][server]['cpu']['medium']
                    dict_out['dc1'][vm_name]['mem'] = template_vars[client_type][server]['mem']['medium']
                    dict_out['dc1'][vm_name]['disks'] = template_vars[client_type][server]['disks']['medium']
                elif client_size == "large":
                    dict_out['dc1'][vm_name]['cpu'] = template_vars[client_type][server]['cpu']['large']
                    dict_out['dc1'][vm_name]['mem'] = template_vars[client_type][server]['mem']['large']
                    dict_out['dc1'][vm_name]['disks'] = template_vars[client_type][server]['disks']['large']
                
                
            if template_vars[client_type][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['port_group'] = port_group_be
            elif template_vars[client_type][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['port_group'] = port_group_fe

            dict_out['dc1'][vm_name]['ip'] = str(start_address)
            
            if template_vars[client_type][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['netmask'] = netmask_be
            elif template_vars[client_type][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['netmask'] = netmask_fe
                
            if template_vars[client_type][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['gw'] = gw_be
            elif template_vars[client_type][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['gw'] = gw_fe
            
            counter += 1
            dc1_count -= 1
            start_address = IPv4Address(start_address) + 1
        
        elif ((i % 2 == 1) and (dc2_count > 0)):
            vm_name = client_code + dc_guest_name[1] + server + str(counter)
            paging_count = 1
            dict_out['dc2'][vm_name] = {}
            dict_out['dc2'][vm_name]['name'] = vm_name
            dict_out['dc2'][vm_name]['role'] = server
            dict_out['dc2'][vm_name]['disks'] = {}
            dict_out['dc2'][vm_name]['disks'] = []
            dict_out['dc2'][vm_name]['dc'] = dcs[1]

            dict_out['dc2'][vm_name]['os'] = template_vars[client_type][server]['os']

            if template_vars[client_type][server]['os'] == "linux":
                dict_out['dc2'][vm_name]['host_cluster'] = input_vars['dc2_linux_host_cluster']
                dict_out['dc2'][vm_name]['ds_cluster'] = input_vars['dc2_linux_ds_cluster']
            elif template_vars[client_type][server]['os'] == "windows":
                dict_out['dc2'][vm_name]['host_cluster'] = input_vars['dc2_windows_host_cluster']
                dict_out['dc2'][vm_name]['ds_cluster'] = input_vars['dc2_windows_ds_cluster']

            if server_code != None:
                dict_out['dc2'][vm_name]['cpu'] = template_vars['cpu'][code_list[1][0]]
                dict_out['dc2'][vm_name]['mem'] = template_vars['mem'][code_list[1][1]]
                if template_vars[client_type][server]['os'] == "linux":
                    dict_out['dc2'][vm_name]['disks'] += [1]
                    dict_out['dc2'][vm_name]['disks'] += [16]

                for disk in disks:
                    disk_size = template_vars['disk'][disk[0]]
                    if "x" not in str(disk):
                        dict_out['dc2'][vm_name]['disks'] += [disk_size]
                    else:
                        adds = disk.split("x")[1]
                        for i in range(int(adds)):
                            dict_out['dc2'][vm_name]['disks'] += [disk_size]

                    if (template_vars[client_type][server]['os'] == "windows") and (paging_count >= 1):
                        dict_out['dc2'][vm_name]['disks'] += [paging_size]
                        paging_count -= 1

            else:
                if client_size == "small":
                    dict_out['dc2'][vm_name]['cpu'] = template_vars[client_type][server]['cpu']['small']
                    dict_out['dc2'][vm_name]['mem'] = template_vars[client_type][server]['mem']['small']
                    dict_out['dc2'][vm_name]['disks'] = template_vars[client_type][server]['disks']['small']
                elif client_size == "medium":
                    dict_out['dc2'][vm_name]['cpu'] = template_vars[client_type][server]['cpu']['medium']
                    dict_out['dc2'][vm_name]['mem'] = template_vars[client_type][server]['mem']['medium']
                    dict_out['dc2'][vm_name]['disks'] = template_vars[client_type][server]['disks']['medium']
                elif client_size == "large":
                    dict_out['dc2'][vm_name]['cpu'] = template_vars[client_type][server]['cpu']['large']
                    dict_out['dc2'][vm_name]['mem'] = template_vars[client_type][server]['mem']['large']
                    dict_out['dc2'][vm_name]['disks'] = template_vars[client_type][server]['disks']['large']
                
                
            if template_vars[client_type][server]['server_type'] == "be":
                dict_out['dc2'][vm_name]['port_group'] = port_group_be
            elif template_vars[client_type][server]['server_type'] == "fe":
                dict_out['dc2'][vm_name]['port_group'] = port_group_fe

            dict_out['dc2'][vm_name]['ip'] = str(start_address)
            
            if template_vars[client_type][server]['server_type'] == "be":
                dict_out['dc2'][vm_name]['netmask'] = netmask_be
            elif template_vars[client_type][server]['server_type'] == "fe":
                dict_out['dc2'][vm_name]['netmask'] = netmask_fe

            if template_vars[client_type][server]['server_type'] == "be":
                dict_out['dc2'][vm_name]['gw'] = gw_be
            elif template_vars[client_type][server]['server_type'] == "fe":
                dict_out['dc2'][vm_name]['gw'] = gw_fe
                
            counter += 1
            dc1_count -= 1
            start_address = IPv4Address(start_address) + 1
        else:
            vm_name = client_code + dc_guest_name[0] + server + str(counter)
            paging_count = 1
            dict_out['dc1'][vm_name] = {}
            dict_out['dc1'][vm_name]['name'] = vm_name
            dict_out['dc1'][vm_name]['role'] = server
            dict_out['dc1'][vm_name]['disks'] = {}
            dict_out['dc1'][vm_name]['disks'] = []
            dict_out['dc1'][vm_name]['dc'] = dcs[0]

            dict_out['dc1'][vm_name]['os'] = template_vars[client_type][server]['os']

            if template_vars[client_type][server]['os'] == "linux":
                dict_out['dc1'][vm_name]['host_cluster'] = input_vars['dc1_linux_host_cluster']
                dict_out['dc1'][vm_name]['ds_cluster'] = input_vars['dc1_linux_ds_cluster']
            elif template_vars[client_type][server]['os'] == "windows":
                dict_out['dc1'][vm_name]['host_cluster'] = input_vars['dc1_windows_host_cluster']
                dict_out['dc1'][vm_name]['ds_cluster'] = input_vars['dc1_windows_ds_cluster']

            if server_code != None:
                dict_out['dc1'][vm_name]['cpu'] = template_vars['cpu'][code_list[1][0]]
                dict_out['dc1'][vm_name]['mem'] = template_vars['mem'][code_list[1][1]]
                if template_vars[client_type][server]['os'] == "linux":
                    dict_out['dc1'][vm_name]['disks'] += [1]
                    dict_out['dc1'][vm_name]['disks'] += [16]

                for disk in disks:
                    disk_size = template_vars['disk'][disk[0]]
                    if "x" not in str(disk):
                        dict_out['dc1'][vm_name]['disks'] += [disk_size]
                    else:
                        adds = disk.split("x")[1]
                        for i in range(int(adds)):
                            dict_out['dc1'][vm_name]['disks'] += [disk_size]

                    if (template_vars[client_type][server]['os'] == "windows") and (paging_count >= 1):
                        dict_out['dc1'][vm_name]['disks'] += [paging_size]
                        paging_count -= 1

            else:
                if client_size == "small":
                    dict_out['dc1'][vm_name]['cpu'] = template_vars[client_type][server]['cpu']['small']
                    dict_out['dc1'][vm_name]['mem'] = template_vars[client_type][server]['mem']['small']
                    dict_out['dc1'][vm_name]['disks'] = template_vars[client_type][server]['disks']['small']
                elif client_size == "medium":
                    dict_out['dc1'][vm_name]['cpu'] = template_vars[client_type][server]['cpu']['medium']
                    dict_out['dc1'][vm_name]['mem'] = template_vars[client_type][server]['mem']['medium']
                    dict_out['dc1'][vm_name]['disks'] = template_vars[client_type][server]['disks']['medium']
                elif client_size == "large":
                    dict_out['dc1'][vm_name]['cpu'] = template_vars[client_type][server]['cpu']['large']
                    dict_out['dc1'][vm_name]['mem'] = template_vars[client_type][server]['mem']['large']
                    dict_out['dc1'][vm_name]['disks'] = template_vars[client_type][server]['disks']['large']
                
                
            if template_vars[client_type][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['port_group'] = port_group_be
            elif template_vars[client_type][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['port_group'] = port_group_fe

            dict_out['dc1'][vm_name]['ip'] = str(start_address)
            
            if template_vars[client_type][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['netmask'] = netmask_be
            elif template_vars[client_type][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['netmask'] = netmask_fe

            if template_vars[client_type][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['gw'] = gw_be
            elif template_vars[client_type][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['gw'] = gw_fe
                
            counter += 1
            dc1_count -= 1
            start_address = IPv4Address(start_address) + 1

for server in (input_vars['custom_vms']):

    start_address = input_vars['network_base_address'] + str(input_vars['custom_vms'][server]['start_ip'])
    server_total = ((input_vars['custom_vms'][server]['dc1_count']) + (input_vars['custom_vms'][server]['dc2_count']))
    dc1_count = (input_vars['custom_vms'][server]['dc1_count'])
    dc2_count = (input_vars['custom_vms'][server]['dc2_count'])
    counter = 1
    server_code = None

    if input_vars['custom_vms'][server]['server_code']:
        server_code = (input_vars['custom_vms'][server]['server_code'])
        code_list = server_code.split("-")
        paging_size = (((int(template_vars['mem'][code_list[1][1]] * 1.5 // 0.88)) + 7) & (-8))
        disks = code_list[2:]
        if server == "depot":
            del disks[-1]


    for i in range(0, server_total):
        if ((i % 2 == 0) and (dc2_count > 0)):
            vm_name = client_code + dc_guest_name[0] + server + str(counter)
            paging_count = 1
            dict_out['dc1'][vm_name] = {}
            dict_out['dc1'][vm_name]['name'] = vm_name
            dict_out['dc1'][vm_name]['role'] = server
            dict_out['dc1'][vm_name]['disks'] = {}
            dict_out['dc1'][vm_name]['disks'] = []
            dict_out['dc1'][vm_name]['dc'] = dcs[0]

            dict_out['dc1'][vm_name]['os'] = input_vars['custom_vms'][server]['os']

            if input_vars['custom_vms'][server]['os'] == "linux":
                dict_out['dc1'][vm_name]['host_cluster'] = input_vars['dc1_linux_host_cluster']
                dict_out['dc1'][vm_name]['ds_cluster'] = input_vars['dc1_linux_ds_cluster']
            elif input_vars['custom_vms'][server]['os'] == "windows":
                dict_out['dc1'][vm_name]['host_cluster'] = input_vars['dc1_windows_host_cluster']
                dict_out['dc1'][vm_name]['ds_cluster'] = input_vars['dc1_windows_ds_cluster']
            
            if server_code != None:
                dict_out['dc1'][vm_name]['cpu'] = template_vars['cpu'][code_list[1][0]]
                dict_out['dc1'][vm_name]['mem'] = template_vars['mem'][code_list[1][1]]

                if input_vars['custom_vms'][server]['os'] == "linux":
                    dict_out['dc1'][vm_name]['disks'] += [1]
                    dict_out['dc1'][vm_name]['disks'] += [16]

                for disk in disks:
                    disk_size = template_vars['disk'][disk[0]]
                    if "x" not in str(disk):
                        dict_out['dc1'][vm_name]['disks'] += [disk_size]
                    else:
                        adds = disk.split("x")[1]
                        for i in range(int(adds)):
                            dict_out['dc1'][vm_name]['disks'] += [disk_size]

                    if (input_vars['custom_vms'][server]['os'] == "windows") and (paging_count >= 1):
                        dict_out['dc1'][vm_name]['disks'] += [paging_size]
                        paging_count -= 1

            if input_vars['custom_vms'][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['port_group'] = port_group_be
            elif input_vars['custom_vms'][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['port_group'] = port_group_fe

            dict_out['dc1'][vm_name]['ip'] = str(start_address)
            
            if input_vars['custom_vms'][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['netmask'] = netmask_be
            elif input_vars['custom_vms'][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['netmask'] = netmask_fe
            
            if input_vars['custom_vms'][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['gw'] = gw_be
            elif input_vars['custom_vms'][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['gw'] = gw_fe
                
            counter += 1
            dc1_count -= 1
            start_address = IPv4Address(start_address) + 1
        
        elif ((i % 2 == 1) and (dc2_count > 0)):
            vm_name = client_code + dc_guest_name[1] + server + str(counter)
            paging_count = 1
            dict_out['dc2'][vm_name] = {}
            dict_out['dc2'][vm_name]['name'] = vm_name
            dict_out['dc2'][vm_name]['role'] = server
            dict_out['dc2'][vm_name]['disks'] = {}
            dict_out['dc2'][vm_name]['disks'] = []
            dict_out['dc2'][vm_name]['dc'] = dcs[1]

            dict_out['dc2'][vm_name]['os'] = input_vars['custom_vms'][server]['os']

            if input_vars['custom_vms'][server]['os'] == "linux":
                dict_out['dc2'][vm_name]['host_cluster'] = input_vars['dc2_linux_host_cluster']
                dict_out['dc2'][vm_name]['ds_cluster'] = input_vars['dc2_linux_ds_cluster']
            elif input_vars['custom_vms'][server]['os'] == "windows":
                dict_out['dc2'][vm_name]['host_cluster'] = input_vars['dc2_windows_host_cluster']
                dict_out['dc2'][vm_name]['ds_cluster'] = input_vars['dc2_windows_ds_cluster']
            
            if server_code != None:
                dict_out['dc2'][vm_name]['cpu'] = template_vars['cpu'][code_list[1][0]]
                dict_out['dc2'][vm_name]['mem'] = template_vars['mem'][code_list[1][1]]

                if input_vars['custom_vms'][server]['os'] == "linux":
                    dict_out['dc2'][vm_name]['disks'] += [1]
                    dict_out['dc2'][vm_name]['disks'] += [16]

                for disk in disks:
                    disk_size = template_vars['disk'][disk[0]]
                    if "x" not in str(disk):
                        dict_out['dc2'][vm_name]['disks'] += [disk_size]
                    else:
                        adds = disk.split("x")[1]
                        for i in range(int(adds)):
                            dict_out['dc2'][vm_name]['disks'] += [disk_size]

                    if (input_vars['custom_vms'][server]['os'] == "windows") and (paging_count >= 1):
                        dict_out['dc2'][vm_name]['disks'] += [paging_size]
                        paging_count -= 1

            if input_vars['custom_vms'][server]['server_type'] == "be":
                dict_out['dc2'][vm_name]['port_group'] = port_group_be
            elif input_vars['custom_vms'][server]['server_type'] == "fe":
                dict_out['dc2'][vm_name]['port_group'] = port_group_fe

            dict_out['dc2'][vm_name]['ip'] = str(start_address)
            
            if input_vars['custom_vms'][server]['server_type'] == "be":
                dict_out['dc2'][vm_name]['netmask'] = netmask_be
            elif input_vars['custom_vms'][server]['server_type'] == "fe":
                dict_out['dc2'][vm_name]['netmask'] = netmask_fe

            if input_vars['custom_vms'][server]['server_type'] == "be":
                dict_out['dc2'][vm_name]['gw'] = gw_be
            elif input_vars['custom_vms'][server]['server_type'] == "fe":
                dict_out['dc2'][vm_name]['gw'] = gw_fe
                
            counter += 1
            dc1_count -= 1
            start_address = IPv4Address(start_address) + 1
        else:
            vm_name = client_code + dc_guest_name[0] + server + str(counter)
            paging_count = 1
            dict_out['dc1'][vm_name] = {}
            dict_out['dc1'][vm_name]['name'] = vm_name
            dict_out['dc1'][vm_name]['role'] = server
            dict_out['dc1'][vm_name]['disks'] = {}
            dict_out['dc1'][vm_name]['disks'] = []
            dict_out['dc1'][vm_name]['dc'] = dcs[0]

            dict_out['dc1'][vm_name]['os'] = input_vars['custom_vms'][server]['os']

            if input_vars['custom_vms'][server]['os'] == "linux":
                dict_out['dc1'][vm_name]['host_cluster'] = input_vars['dc1_linux_host_cluster']
                dict_out['dc1'][vm_name]['ds_cluster'] = input_vars['dc1_linux_ds_cluster']
            elif input_vars['custom_vms'][server]['os'] == "windows":
                dict_out['dc1'][vm_name]['host_cluster'] = input_vars['dc1_windows_host_cluster']
                dict_out['dc1'][vm_name]['ds_cluster'] = input_vars['dc1_windows_ds_cluster']
            
            if server_code != None:
                dict_out['dc1'][vm_name]['cpu'] = template_vars['cpu'][code_list[1][0]]
                dict_out['dc1'][vm_name]['mem'] = template_vars['mem'][code_list[1][1]]

                if input_vars['custom_vms'][server]['os'] == "linux":
                    dict_out['dc1'][vm_name]['disks'] += [1]
                    dict_out['dc1'][vm_name]['disks'] += [16]

                for disk in disks:
                    disk_size = template_vars['disk'][disk[0]]
                    if "x" not in str(disk):
                        dict_out['dc1'][vm_name]['disks'] += [disk_size]
                    else:
                        adds = disk.split("x")[1]
                        for i in range(int(adds)):
                            dict_out['dc1'][vm_name]['disks'] += [disk_size]
                    if (input_vars['custom_vms'][server]['os'] == "windows") and (paging_count >= 1):
                        dict_out['dc1'][vm_name]['disks'] += [paging_size]
                        paging_count -= 1
                    

            if input_vars['custom_vms'][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['port_group'] = port_group_be
            elif input_vars['custom_vms'][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['port_group'] = port_group_fe

            dict_out['dc1'][vm_name]['ip'] = str(start_address)
            
            if input_vars['custom_vms'][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['netmask'] = netmask_be
            elif input_vars['custom_vms'][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['netmask'] = netmask_fe

            if input_vars['custom_vms'][server]['server_type'] == "be":
                dict_out['dc1'][vm_name]['gw'] = gw_be
            elif input_vars['custom_vms'][server]['server_type'] == "fe":
                dict_out['dc1'][vm_name]['gw'] = gw_fe
                
            counter += 1
            dc1_count -= 1
            start_address = IPv4Address(start_address) + 1

print("VMs dictonary has been created")

def create_vsphere_comp_tf(source_prefix, source_dir, jinja_tpl, jinja_var_in):
    jinja_file = os.path.join(__location__, 'templates', jinja_tpl)
    output_tf_file = os.path.join(__location__, '..//', source_dir, source_prefix + '.tf')
    with open(jinja_file) as f:
        tf_template = f.read()
    tf_template = jinja2.Template(tf_template)
    tf_out = tf_template.render(jinja_var=jinja_var_in)
    with open(output_tf_file, "w") as f:    
        f.write(tf_out)
    print(source_prefix + " module files have been updated")

if not os.path.exists('../vsphere-distributed-port-group'):
    os.mkdir('../vsphere-distributed-port-group')
    create_vsphere_comp_tf('providers', 'vsphere-distributed-port-group', 'providers-pg.j2', dict_out)
    shutil.copyfile('./templates/variables-pg.tf', '../vsphere-distributed-port-group/variables.tf')
if not os.path.exists('../vsphere-virtual-machine'):
    os.mkdir('../vsphere-virtual-machine')
    create_vsphere_comp_tf('providers', 'vsphere-virtual-machine', 'providers-vm.j2', dict_out)

create_vsphere_comp_tf('vsphere-folder', 'vsphere-virtual-machine', 'vsphere-folder.j2', dcs)
create_vsphere_comp_tf('vsphere-tag', 'vsphere-virtual-machine', 'vsphere-tag.j2', dcs)
create_vsphere_comp_tf('variables', 'vsphere-virtual-machine', 'variables.j2', dict_out)
create_vsphere_comp_tf('vsphere-distributed-port-group', 'vsphere-distributed-port-group', 'vsphere-distributed-port-group.j2', dict_out)

def create_vm_tf(dc_dict):
    for guest, guest_dict in (dc_dict.items()):
        jinja_file = os.path.join(__location__, 'templates', 'virtual-machines.j2')
        output_tf_file = os.path.join(__location__, '..//', 'vsphere-virtual-machine', 'vm-' + guest + '.tf')
        with open(jinja_file) as f:
            tf_template = f.read()
        tf_template = jinja2.Template(tf_template)
        tf_out = tf_template.render(guest_dict=guest_dict)
        with open(output_tf_file, "w") as f:    
            f.write(tf_out)
        print(guest + " module files have been updated")

create_vm_tf(dict_out['dc1'])
create_vm_tf(dict_out['dc2'])

#dict_p = yaml.dump(dict_out, width=50, indent=4)
#print(dict_p)