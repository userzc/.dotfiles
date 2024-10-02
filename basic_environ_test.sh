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
echo "installing python3" && `sudo $INSTALL_COMMAND python3`
echo "installing git" && `sudo $INSTALL_COMMAND git`
echo "installing $EMACS_VERSION" && `sudo $INSTALL_COMMAND $EMACS_VERSION`
echo "installing speedometer" && `sudo $INSTALL_COMMAND speedometer`
echo "installing silversearcher-ag" && `sudo $INSTALL_COMMAND silversearcher-ag`
echo "installing htop" && `sudo $INSTALL_COMMAND htop`
echo "installing zsh" && `sudo $INSTALL_COMMAND zsh`
echo "installing zsh-syntax-highlighting" && `sudo $INSTALL_COMMAND zsh-syntax-highlighting`
echo "installing rxvt-unicode" && `sudo $INSTALL_COMMAND rxvt-unicode`
echo "installing tmux" && `sudo $INSTALL_COMMAND tmux`
echo "installing xclip" && `sudo $INSTALL_COMMAND xclip`
echo "installing xsel" && `sudo $INSTALL_COMMAND xsel`
echo "installing aptitude" && `sudo $INSTALL_COMMAND aptitude`
echo "installing curl" && `sudo $INSTALL_COMMAND curl`
echo "installing fonts-monoid" && `sudo $INSTALL_COMMAND fonts-monoid`
echo "installing fonts-powerline" && `sudo $INSTALL_COMMAND fonts-powerline`
echo "installing fonts-inconsolata" && `sudo $INSTALL_COMMAND fonts-inconsolata`
echo "installing fonts-hack" && `sudo $INSTALL_COMMAND fonts-hack`
echo "installing fonts-font-awesome" && `sudo $INSTALL_COMMAND fonts-font-awesome`
echo "installing fonts-octicons" && `sudo $INSTALL_COMMAND fonts-octicons`
echo "installing python3-pip" && `sudo $INSTALL_COMMAND python3-pip`
echo "installing virtualenvwrapper" && `sudo $INSTALL_COMMAND virtualenvwrapper`
echo "installing playerctl" && `sudo $INSTALL_COMMAND playerctl`
echo "installing fzf" && `sudo $INSTALL_COMMAND fzf`
echo "installing figlet" && `sudo $INSTALL_COMMAND figlet`
echo "installing jq" && `sudo $INSTALL_COMMAND jq`
echo "installing cargo" && `sudo $INSTALL_COMMAND cargo`
# alacritty ubuntu dependencies
echo "installing cmake" && `sudo $INSTALL_COMMAND cmake`
echo "installing pkg-config" && `sudo $INSTALL_COMMAND pkg-config`
echo "installing libfreetype6-dev" && `sudo $INSTALL_COMMAND libfreetype6-dev`
echo "installing libfontconfig1-dev" && `sudo $INSTALL_COMMAND libfontconfig1-dev`
echo "installing libxcb-xfixes0-dev" && `sudo $INSTALL_COMMAND libxcb-xfixes0-dev`
# ranger video preview dependencies
echo "installing w3m-img" && `sudo $INSTALL_COMMAND w3m-img`
echo "installing ffmpegthumbnailer" && `sudo $INSTALL_COMMAND ffmpegthumbnailer`
# Installing python based utilities
echo "installing tmuxp" && `sudo $INSTALL_COMMAND tmuxp`
echo "installing yamllint" && `sudo $INSTALL_COMMAND yamllint`
echo "installing speedtest-cli" && `sudo $INSTALL_COMMAND speedtest-cli`


echo "==== [Done] Installing common tools ===="

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
echo "==== [Done] Installing oh-my-zsh ===="

# # This block is left as reference, no longer needed on ubuntu
# echo "===== Installing pip3 utilities"
# echo "(pip3) installing tmuxp" && `pip3 install --user tmuxp`
# echo "(pip3) installing yamllint" && `pip3 install --user yamllint`
# echo "(pip3) installing speedtest-cli" && `pip3 install --user speedtest-cli`
# echo "===== [Done] Installing pip3 utilities"

echo "==== Installing Dotfiles ===="
if [ ! -d "$HOME/.dotfiles" ]; then
    /usr/bin/env git clone --depth 1 --no-single-branch https://github.com/userzc/.dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles
    git submodule sync
    git submodule update --init --recursive
    ./dotfiles_sync -i
    cd $HOME
fi
echo "==== [Done] Installing Dotfiles ===="

echo "==== Installing cargo utilities ===="
if comand -v cargo &> /dev/null; then
    echo "(cargo) installing exa" && `cargo install exa`
    echo "(cargo) installing bat" && `cargo install bat`
fi
echo "==== [Done] Installing cargo utilities ===="

echo "==== Creaing folder: instalados-localmente ===="
[ ! -d "$HOME/instalados-localmente" ] && mkdir "$HOME/instalados-localmente"

current_directory=$(pwd)    # this may not be necessary
cd "$HOME/instalados-localmente"
if [ ! -d "$HOME/instalados-localmente/alacritty" ]; then
    echo "  == Installing alacritty from source =="
    # instructions: https://github.com/alacritty/alacritty/blob/master/INSTALL.md
    `git clone https://github.com/alacritty/alacritty.git`
    cd "alacritty"
    # build alacritty
    `cargo build --release`
    # install terminfo
    `sudo tic -xe alacritty,alacritty-direct extra/alacritty.info`
    # create desktop entry
    `sudo cp target/release/alacritty /usr/local/bin`
    `sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg`
    `sudo desktop-file-install extra/linux/Alacritty.desktop`
    `sudo update-desktop-database`
    # install manual page
    `sudo mkdir -p /usr/local/share/man/man1`
    `gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null`
    `gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null`
    # install terminfo
    `sudo tic -xe alacritty,alacritty-direct extra/alacritty.info`
    cd "$HOME/instalados-localmente"
    echo "  == [Done] Installing alacritty from source =="
fi

echo "==== [Done] Creaing folder: instalados-localmente ===="

echo "==== To change default shell ===="
echo "==== type: chsh -s /bin/zsh ==="
echo "==== or:  edit /etc/passwd  ==="
exit 0
