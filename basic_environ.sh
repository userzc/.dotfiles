#!/bin/sh

if [ `uname` = 'Darwin' ]; then
    export OS_TYPE='mac'
    export INSTALL_COMMAND='brew install'
elif [ `uname` = 'Linux' ]; then
    if [ -f /etc/redhat-release ]; then
        export OS_TYPE='redhat'
        export INSTALL_COMMAND='yum -y install'
    elif [ -n `lsb_release` ]; then
        export OS_TYPE='debian'
        export INSTALL_COMMAND='apt-get -y install'
    fi
else
    echo "No *nix OS detected"
fi

if [ "$OS_TYPE" ] &&  [ "$INSTALL_COMMAND" ]
then
    echo "Install command is: $INSTALL_COMMAND"
    echo "OS is: $OS_TYPE"
fi

echo "==== Installing common tools ===="
`sudo $INSTALL_COMMAND git`
`sudo $INSTALL_COMMAND emacs`
`sudo $INSTALL_COMMAND zsh`
`sudo $INSTALL_COMMAND tmux`
`sudo $INSTALL_COMMAND curl`
`sudo $INSTALL_COMMAND fonts-inconsolata`

echo "==== Installing oh-my-zsh [personal fork] ===="
if [ ! -d "~/.oh-my-zsh" ] ; then
    cd ~
    curl -L https://github.com/userzc/oh-my-zsh/raw/master/tools/install.sh | sh
    # Esta línea pretende eliminar el archivo zshrc creado por .oh-my-zsh
    rm .zshrc
else
    echo "===== oh-my-sh [personal fork] already installed"
fi

echo "==== Installing pip ===="
curl_output=$(curl -O --silent --write-out "%{http_code}\n" https://bootstrap.pypa.io/get-pip.py)
case "$curl_output" in
    404)echo "Not suitable to install";;
    200)echo "Installing"
        `sudo python get-pip.py `
        `git clone https://github.com/powerline/fonts ~/.fonts/powerline-fonts`
        cd "~/.fonts/powerline-fonts"
        `./install.sh`
	echo "==== Installing powerline ===="
	`git clone https://github.com/powerline/powerline`
	`pip install -U --user ~/powerline`
esac



echo "==== Installing Dotfiles ===="
if [ ! -d "~/.dotfiles" ]; then
    /usr/bin/env git clone https://github.com/userzc/.dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    git submodule sync
    git submodule update --init --recursive
    python sync.py -i
    cd ~
fi

echo "==== To change default shell ===="
echo "==== type: chsh -s /bin/zsh ==="
