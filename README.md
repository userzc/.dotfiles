# Getting Started

This is the first attempt to create a repository for `dotfiles` and an
install script to make all the necesary changes.

## Requirements

python
git
quickswitch-i3

## Features

So far this script is able to `symlink` files and folders under some
specific lists and special cases (`.config/` folder).

This script accepts options for install (`-i`, `--install`), listing
the posible files to modify (`-l`, `--list`) and for removal of the
existing links or files (`-r`, `--remove`). The script is installing
files through python, so it should also be portable to windows.

## Wishlist

It should be possible to create a way to syncronize and install `git`
repositories such as `.oh-my-zsh/`.
