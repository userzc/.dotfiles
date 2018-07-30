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
`sudo $INSTALL_COMMAND python3`
`sudo $INSTALL_COMMAND python`
`sudo $INSTALL_COMMAND git`
`sudo $INSTALL_COMMAND emacs`
`sudo $INSTALL_COMMAND speedometer`
`sudo $INSTALL_COMMAND silversearcher-ag`
`sudo $INSTALL_COMMAND htop`
`sudo $INSTALL_COMMAND zsh`
`sudo $INSTALL_COMMAND tmux`
`sudo $INSTALL_COMMAND xclip`
`sudo $INSTALL_COMMAND aptitude`
`sudo $INSTALL_COMMAND curl`
`sudo $INSTALL_COMMAND fonts-monoid`
`sudo $INSTALL_COMMAND fonts-inconsolata`
`sudo $INSTALL_COMMAND fonts-font-awesome`
`sudo $INSTALL_COMMAND fonts-octicons`

echo "==== Installing oh-my-zsh ===="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    cd $HOME
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # Esta línea pretende eliminar el archivo zshrc creado por .oh-my-zsh
    rm .zshrc
else
    echo "===== oh-my-sh already installed"
fi

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

echo "==== Installing pip ===="
cd "$HOME"
curl_output=$(curl -O --silent --write-out "%{http_code}\n" https://bootstrap.pypa.io/get-pip.py)
case "$curl_output" in
    404)echo "Not suitable to install";;
    200)echo "Installing"
        `sudo python get-pip.py `
        `git clone --depth 1 https://github.com/powerline/fonts $HOME/.fonts/powerline-fonts`
        cd "$HOME/.fonts/powerline-fonts"
        `./install.sh`
        `pip install --user tmuxp`
        `sudo pip install yamllint`
        `sudo pip install speedtest-cli`
esac

echo "==== Installing Dotfiles ===="
if [ ! -d "$HOME/.dotfiles" ]; then
    /usr/bin/env git clone --depth 1 https://github.com/userzc/.dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles
    git submodule sync
    git submodule update --init --recursive
    ./dotfiles_sync -i
    cd $HOME
fi

echo "==== To change default shell ===="
echo "==== type: chsh -s /bin/zsh ==="
exit 0
