#!/bin/sh

if [ `uname` == 'Darwin' ]
then
    export OS_TYPE='mac'
    export INSTALL_COMMAND='brew install'
fi

if [ `uname` == 'Linux']
then
    if [ -f /etc/redhat-release ]
    then
        export OS_TYPE='redhat'
	export INSTALL_COMMAND='yum -y install'
    elif [ -s `lsb_release` ]
    then
	export OS_TYPE='debian'
	export INSTALL_COMMAND='apt-get -y install'
    fi
fi


echo "==== Installing common tools ===="
`sudo $INSTALL_COMMAND git`
`sudo $INSTALL_COMMAND emacs`
`sudo $INSTALL_COMMAND zsh`
`sudo $INSTALL_COMMAND fonts-inconsolata`

echo "==== Installing oh-my-zsh [personal fork] ===="
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
