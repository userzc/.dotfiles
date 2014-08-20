#!/bin/sh

echo "=== Installing common tools ==="
sudo apt-get -y install git
sudo apt-get -y install emacs
sudo apt-get -y install zsh

echo "=== Installing oh-my-sh [personal fork] ==="
curl -L https://github.com/userzc/oh-my-zsh/raw/master/tools/install.sh | sh

echo "=== Installing Dotfiles ==="
git clone https://github.com/userzc/.dotfiles.git
cd .dotfiles
git submodule sync
git submodule update --init --recursive
python sync.py -i
cd
