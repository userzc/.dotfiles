#!/bin/bash

echo "Installing common tools"
sudo yum -y install git
sudo yum -y install zsh
sudo yum -y install centos-release-SCL
sudo yum -y install python27
sudo yum install -y gcc make ncurses-devel
sudo yum install -y giflib-devel libjpeg-devel libtiff-devel
cd /usr/local/src/
sudo wget http://ftp.gnu.org/pub/gnu/emacs/emacs-24.3.tar.gz
sudo tar -xzvf emacs-24.3.tar.gz
cd emacs-24.3
sudo ./configure --without-x
sudo make
sudo make install

echo "==== Installing Dotfiles ===="
if [ ! -d "$HOME/.dotfiles" ]; then
    /usr/bin/env git clone https://github.com/userzc/.dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles
    git submodule sync
    git submodule update --init --recursive
    scl enable python27 'dotfiles_sync -i'
    cd $HOME
fi

echo "==== Installing oh-my-zsh [personal fork] ===="
if [ ! -d "$HOME/.oh-my-zsh" ] ; then
    cd $HOME
    curl -L https://github.com/userzc/oh-my-zsh/raw/master/tools/install.sh | sh
    mv .zshrc.pre-oh-my-zsh .zshrc
else
    echo "===== oh-my-sh [personal fork] already installed"
fi

emacs --batch $HOME/.emacs.d/default-conf.el -l $HOME/.emacs.d/batch_script.el -f save-buffer
emacs --batch -l $HOME/.emacs.d/init.el
