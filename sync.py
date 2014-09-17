#!/usr/bin/python
# -*- encoding: utf-8 -*-
"""Se intenta hacer un script para realizar una instalación de
archivos desde github de manera automática, similar a
https://github.com/rmm5t/dotfiles/blob/master/install.rb

"""

from __future__ import print_function
import sys
import os
from platform import system
from shutil import rmtree
from os import listdir, symlink, remove, unlink, makedirs
from os.path import join, dirname, abspath, expanduser, isdir, islink, lexists
from argparse import ArgumentParser


PARSER = ArgumentParser(description="Tool to install repository dotfiles.")
GROUP = PARSER.add_mutually_exclusive_group()
GROUP.add_argument("-l", "--list", action="store_true",
                   help="List the files to syncronize. [default]")
GROUP.add_argument("-i", "--install", action="store_true",
                   help="Install the files to syncronize.")
GROUP.add_argument("-r", "--remove", action="store_true",
                   help="Remove the files to syncronize.")
ARGS = PARSER.parse_args()

DIR_ACTUAL = dirname(abspath(__file__))
ARCHIVOS_DIR_ACTUAL = listdir(DIR_ACTUAL)
USER_HOME = expanduser("~")
IGNORED_ITEMS = [
    'config',
    'lib',
    'bin',
    'README.md',
    'README.org',
    'readme_var.md',
    'readme_var.org',
    'sync.py',
    'basic_environ.sh',
    'batch_script.el',
]
SPECIFIC_INSTALL_DIRS = [
    ('config', '.config'),
    ('lib', 'lib'),
    ('bin', 'bin'),
]

def listing_function(from_here, to_here):
    """This is the function used to list the possible files to install.

    Arguments:
    - `from_here`: Source path of file.
    - `to_here`: Target path for the link.
    """
    print('To move:', from_here, '=>', to_here)

def installing_function(from_here, to_here):
    """This is the function used to install the files.

    Arguments:
    - `from_here`: Source path of file.
    - `to_here`: Target path for the link.
    """
    try:
        if not lexists(dirname(to_here)):
            makedirs(dirname(to_here))
        symlink(from_here, to_here)
        print('Installed:', from_here, '=>', to_here)
    except:
        print('Error installing', from_here, ' to ', to_here)

def removing_function(from_here, to_here):
    """This is the function used to install the files.

    Arguments:
    - `from_here`: Source path of file.
    - `to_here`: Target path for the link.
    """
    try:
        if islink(to_here):
            unlink(to_here)
        else:
            rmtree(to_here) if isdir(to_here) else remove(to_here)
        print("Removed: ", to_here)
    except:
        print('Error removing ', to_here, ' to update link: ', from_here)

if ARGS.install:
    MESSAGE_STRING = "--- Installing: ---"
    EXEC_FUNCTION = installing_function
elif ARGS.remove:
    MESSAGE_STRING = "--- Removing: ---"
    EXEC_FUNCTION = removing_function
else:
    MESSAGE_STRING = "--- Listing: ---"
    EXEC_FUNCTION = listing_function

print(MESSAGE_STRING)
for element in ARCHIVOS_DIR_ACTUAL:
    if not element in IGNORED_ITEMS and element[0] != '.':
        target = join(USER_HOME,"." + element)
        origin = join(DIR_ACTUAL, element)
        EXEC_FUNCTION(origin, target)

if system() in ['Darwin', 'Linux']:
    for specific_dir in SPECIFIC_INSTALL_DIRS:
        for element in listdir(join(DIR_ACTUAL, specific_dir[0])):
            if not element in IGNORED_ITEMS and element[0] != '.':
                target = join(USER_HOME, specific_dir[1], element)
                origin = join(DIR_ACTUAL, specific_dir[0], element)
                EXEC_FUNCTION(origin, target)

# TODO: considerar implementar las opciones para submodulos:
# - git submodule sync
# - git submodule update --init --recursive
