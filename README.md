# Getting Started

This is the first attempt to create a repository for `dotfiles` and an
install script to make all the necesary changes.


## Features

So far this script is able to `symlink` files and folders under some
specific lists and special cases (`.config/` folder).

This script accepts options for install (`-i`, `--install`) and for
listing the posible files to modify (`-l`, `--list`). If the file
already exists it complains through `ln`, otherwise the links are
created.

## Wishlist

It should be possible to create a way to syncronize and install `git`
repositories such as `.oh-my-zsh/`.
