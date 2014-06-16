#! /usr/bin/python
#  -*- encoding: utf-8 -*-
"""Se crea un script para respaldar paquetes instalados en systemas
debian con información de cuando fué creado el respaldo
"""

import time
import subprocess
from os.path import join, expanduser

string_text = subprocess.check_output(["dpkg", "--get-selections"])

machine_text = '_'.join(subprocess.check_output(["uname", "-i", "-n"]).split())

file_name = join(
    expanduser("~/Documents"),
    "system_backup_info",
    "Package_" + machine_text +
    time.strftime(r"-%d-%m-%Y[%H:%M:%S]") + ".list")

with open(file_name, 'w') as backup_file:
    backup_file.write(string_text)
