#! /usr/bin/python
#  -*- encoding: utf-8 -*-
"""Se crea un script para respaldar paquetes instalados en systemas
debian con información de cuando fué creado el respaldo
"""

from __future__ import print_function
from argparse import ArgumentParser
import time
import subprocess
from os.path import join, expanduser

PARSER = ArgumentParser(description=
                   "Tool to list and backup Package and repositories information.")

GROUP = PARSER.add_mutually_exclusive_group()
GROUP.add_argument(
    "-r", "--list-repositories", action="store_true",
    help="List the existing repositories to screen."
)
GROUP.add_argument(
    "-p", "--list-packages", action="store_true",
    help="List the existing repositories to screen."
)
PARSER.add_argument("-s", "--save", action="store_true",
                    help="Save the output to a file with appropriate name.")
ARGS = PARSER.parse_args()
USER_HOME = expanduser("~")
INFO_TYPE = "EMPTY"
if ARGS.list_packages:
    INFO_TYPE = "PACKAGES"
    string_text = subprocess.check_output(["dpkg", "--get-selections"])
    print(string_text)
elif ARGS.list_repositories:
    string_text = subprocess.check_output([join(USER_HOME, "lib/list_repos.sh")])
    INFO_TYPE = "REPOS"
    print(string_text)
else:
    PARSER.error("No info type requested, add -q or -s.")
if ARGS.save:
    machine_text = '_'.join(subprocess.check_output(["uname", "-i", "-n"]).split())
    file_name = join(
        expanduser("~/Documents"), "system_backup_info",
        time.strftime(r"%d-%m-%Y[%H:%M:%S]") + INFO_TYPE + '_' +
        machine_text + ".list")
    with open(file_name, 'w') as backup_file:
        backup_file.write(string_text)
    print("Set to save as " + file_name)
