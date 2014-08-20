#!/bin/sh

echo "==== Installing common tools ===="
sudo apt-get -y install git
sudo apt-get -y install emacs
sudo apt-get -y install zsh
sudo apt-get -y install fonts-inconsolata

echo "==== Installing oh-my-sh [personal fork] ===="
if [ ! -d "~/.oh-my-zsh" ] ; then
    cd ~
    curl -L https://github.com/userzc/oh-my-zsh/raw/master/tools/install.sh | sh
else
    echo "===== oh-my-sh [personal fork] already installed"
fi

echo "==== Installing Dotfiles ===="

if [ ! -d "~/.dotfiles" ]; then
    /usr/bin/env git clone https://github.com/userzc/.dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    git submodule sync
    git submodule update --init --recursive
    python sync.py -i
    cd ~
fi

echo "==== Changing default shell ===="
chsh -s /bin/zsh
