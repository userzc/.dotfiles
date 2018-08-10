#!/bin/sh

# Este script tiene la finalidad de configurar un ambiente interactivo
# útil en una instancia en GCE o en un vagrant box.
#
# Las configuraciones realizadas por este script requieren que se
# ejecuten por el usuario para que su ambiente se modifique de manera
# apropiada y no están diseñadas para ser ejecutadas por 'root'.

echo "==== Installing extra fonts for neotree (emacs) ===="
mkdir "$HOME/.fonts/" && cd "$HOME/.fonts/"
if [ ! -f "$HOME/.fonts/weathericons.ttf" ]; then
    curl -LO https://github.com/domtronn/all-the-icons.el/raw/master/fonts/weathericons.ttf
fi
if [ ! -f "$HOME/.fonts/all-the-icons.tt" ]; then
    curl -LO https://github.com/domtronn/all-the-icons.el/raw/master/fonts/all-the-icons.ttf
fi
if [ ! -f "$HOME/.fonts/file-icons.ttf" ]; then
    curl -LO https://github.com/domtronn/all-the-icons.el/raw/master/fonts/file-icons.ttf
fi

`fc-cache -f $HOME/.fonts/`

echo "==== Installing Dotfiles ===="
if [ ! -d "$HOME/.dotfiles" ]; then
    /usr/bin/env git clone --depth 1 --no-single-branch https://github.com/userzc/.dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles
    git submodule sync
    git submodule update --init --recursive
    ./dotfiles_sync -i
    cd $HOME
fi

exit 0
