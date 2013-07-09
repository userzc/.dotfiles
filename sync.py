#!/usr/bin/python
# -*- encoding: utf-8 -*-
"""
Se intenta hacer un script para realizar una instalación de archivos
en github de manera automática, similar a
https://github.com/rmm5t/dotfiles/blob/master/install.rb
"""



import platform
from os import listdir
from os.path import join, dirname, abspath, expanduser
from subprocess import call
from argparse import ArgumentParser

PARSER = ArgumentParser()
GROUP = PARSER.add_mutually_exclusive_group()
GROUP.add_argument("-l", "--list", action="store_true",
                   help="List the files to syncronize.")
GROUP.add_argument("-i", "--install", action="store_true",
                   help="Install the files to syncronize.")
GROUP.add_argument("-r", "--remove", action="store_true",
                   help="Remove the files to syncronize.")
ARGS = PARSER.parse_args()

DIR_ACTUAL = dirname(abspath(__file__))
ARCHIVOS_DIR_ACTUAL = listdir(DIR_ACTUAL)
USER_HOME = expanduser("~/")
IGNORED_ITEMS = [
    'config', # TODO: consider using tuples indicating depth for directories
    'README.md',
    'sync.py',
    'list_dir.py',
]

# TODO: consider what to do in case there already is a file in that location
if platform.system() == 'Linux':
    if not ARGS.remove:
        LINKER = 'ln'
        OPTION1 = '-n'
        OPTION2 = '-s'
    else:
        LINKER = 'rm'
        OPTION1 = ''
        OPTION2 = ''
    # TODO: consider what options are equivalent in Windows to the Linux.
elif platform.system() == 'Windows':
    if not ARGS.remove:
        LINKER = 'MKLINK'
        OPTION1 = '-n'
        OPTION2 = '-s'
    else:
        LINKER = 'rm'
        OPTION1 = ''
        OPTION2 = ''

def listing_function(from_here, to_here):
    """This is the function used to list the possible files to install.

    Arguments:
    - `from_here`:
    - `to_here`:
    """
    print 'origin:', from_here, '=>', to_here

def installing_function(from_here, to_here):
    """This is the function used to install the files.

    Arguments:
    - `from_here`:
    - `to_here`:
    """
    global LINKER
    global OPTION1
    global OPTION2
    if OPTION1 == '' or OPTION2 == '':
        arg_comando = [LINKER, OPTION1, OPTION2, from_here, to_here].remove('')
    else:
        arg_comando = [LINKER, OPTION1, OPTION2, from_here, to_here]
    call(arg_comando)

def removing_function(from_here, to_here):
    """This is the function used to install the files.

    Arguments:
    - `from_here`:
    - `to_here`:
    """
    global LINKER
    global OPTION1
    global OPTION2
    if OPTION1 == '' or OPTION2 == '':
        # print "Antes de remocion:", [LINKER, OPTION1, OPTION2, to_here]
        arg_comando = [LINKER, to_here]
        # print "Después de remocion:", [LINKER, OPTION1, OPTION2, to_here].remove('')
    else:
        arg_comando = [LINKER, OPTION1, OPTION2, to_here]
    print "A remover:", to_here
    print "argumentos: ", arg_comando
    call(arg_comando)

if ARGS.list:
    MESSEGE_STRING = "--- Listing: ---"
    EXEC_FUNCTION = listing_function
elif ARGS.install:
    MESSEGE_STRING = "--- Installing: ---"
    EXEC_FUNCTION = installing_function
elif ARGS.remove:
    MESSEGE_STRING = "--- Removing: ---"
    EXEC_FUNCTION = removing_function


print "ARGS.install", ARGS.install
print "ARGS.list", ARGS.list
print "ARGS.remove", ARGS.remove

print "LINKER", LINKER
print "OPTION1", OPTION1
print "OPTION2", OPTION2

print MESSEGE_STRING
for element in ARCHIVOS_DIR_ACTUAL:
    if not element in IGNORED_ITEMS and element[0] != '.':
        target = USER_HOME + "." + element
        origin = join(DIR_ACTUAL, element)
        EXEC_FUNCTION(origin, target)

if platform.system() == 'Linux':
    for element in listdir(join(DIR_ACTUAL,'config')):
        if not element in IGNORED_ITEMS and element[0] != '.':
            target = USER_HOME + ".config/" + element
            origin = join(DIR_ACTUAL, "config", element)
            EXEC_FUNCTION(origin, target)
