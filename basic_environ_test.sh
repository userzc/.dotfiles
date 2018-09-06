#!/bin/sh

# Nota: Este archivo siempre será la versión en prueba más reciente,
# en la que se pueden probar nuevas configuraciones, por lo que puede
# no ser estable y diferir de 'basic_environ.sh'.

# Este script tiene la finalidad de configurar un ambiente interactivo
# útil en una instalación de un SO nuevo.
#
# Las configuraciones realizadas por este script requieren que se
# ejecuten por el usuario 'sudoer' para que su ambiente se modifique
# de manera apropiada.

if [ `uname` = 'Darwin' ]; then
    export OS_TYPE='mac'
    export INSTALL_COMMAND='brew install'
elif [ `uname` = 'Linux' ]; then
    if [ -f /etc/redhat-release ]; then
        export OS_TYPE='redhat'
        export INSTALL_COMMAND='yum -y install'
    elif [ -n `lsb_release` ]; then
        distributor_id=$(lsb_release -is)
        export OS_TYPE='debian'
        if [ $distributor_id = 'Ubuntu' ]; then
            # Ubuntu
            export EMACS_VERSION='emacs'
            echo 'Ubuntu detected'
        else
            # Debian
            export EMACS_VERSION='emacs25'
            echo 'Debian detected'
        fi
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
`sudo $INSTALL_COMMAND $EMACS_VERSION`
`sudo $INSTALL_COMMAND speedometer`
`sudo $INSTALL_COMMAND silversearcher-ag`
`sudo $INSTALL_COMMAND htop`
`sudo $INSTALL_COMMAND zsh`
`sudo $INSTALL_COMMAND tmux`
`sudo $INSTALL_COMMAND xclip`
`sudo $INSTALL_COMMAND aptitude`
`sudo $INSTALL_COMMAND curl`
`sudo $INSTALL_COMMAND fonts-monoid`
`sudo $INSTALL_COMMAND fonts-powerline`
`sudo $INSTALL_COMMAND fonts-inconsolata`
`sudo $INSTALL_COMMAND fonts-hack`
`sudo $INSTALL_COMMAND fonts-font-awesome`
`sudo $INSTALL_COMMAND fonts-octicons`
`sudo $INSTALL_COMMAND python-pip`
`sudo $INSTALL_COMMAND python3-pip`
`sudo $INSTALL_COMMAND virtualenvwrapper`

echo "==== Installing oh-my-zsh ===="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    cd $HOME
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

    # Respaldo de .zshrc existente
    if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
        mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh;
    fi
else
    echo "===== oh-my-sh already installed"
fi

`sudo pip install tmuxp`
`sudo pip install yamllint`

echo "==== Installing Dotfiles ===="
if [ ! -d "$HOME/.dotfiles" ]; then
    /usr/bin/env git clone --depth 1 --no-single-branch https://github.com/userzc/.dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles
    git submodule sync
    git submodule update --init --recursive
    ./dotfiles_sync -i
    cd $HOME
fi

echo "==== To change default shell ===="
echo "==== type: chsh -s /bin/zsh ==="
echo "==== or:  edit /etc/passwd  ==="
exit 0
