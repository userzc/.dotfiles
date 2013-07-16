# Getting Started

This is the first attempt to create a repository for `dotfiles` and an
install script to make all the necesary changes.

To clone this repository, from prompt use:

    git clone https://github.com/userzc/.dotfiles.git

## Instalation

To install the files in this repository use:

    python ~/.dotfiles/sync -i

On Windows the script must be run as administrator.

## Requirements

<!-- BEGIN RECEIVE ORGTBL reqtbl -->
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
<colgroup><col class="left" /><col class="left" /><col class="left" />
</colgroup>
<thead>
<tr><th scope="col" class="left">Software</th><th scope="col" class="left">Windows Version</th><th scope="col" class="left">Unix Version</th></tr>
</thead>
<tbody>
<tr><td class="left">Inconsolata Font</td><td class="left">any</td><td class="left">any</td></tr>
<tr><td class="left">python</td><td class="left">&gt;= 3.2</td><td class="left">&gt;= 2.7</td></tr>
<tr><td class="left">git</td><td class="left">---</td><td class="left">---</td></tr>
<tr><td class="left">quickswitch-i3</td><td class="left">---</td><td class="left">any</td></tr>
</tbody>
</table>
<!-- END RECEIVE ORGTBL reqtbl -->

<!--
#+ORGTBL: SEND reqtbl orgtbl-to-html
| Software         | Windows Version | Unix Version |
|------------------+-----------------+--------------|
| Inconsolata Font | any             | any          |
| python           | >= 3.2          | >= 2.7       |
| git              | any             | any          |
| quickswitch-i3   | ---             | any          |
-->

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
