#!/bin/sh

if [ `uname` = 'Linux' ]; then
    if [ -f /etc/redhat-release ]; then
        export OS_TYPE='redhat'
        export INSTALL_COMMAND='yum -y install'
    elif [ -n `lsb_release` ]; then
        export OS_TYPE='debian'
        export INSTALL_COMMAND='apt-get -y install'
    fi
else
    echo "No *nix OS detected"
    exit 1
fi

if [ "$OS_TYPE" ] &&  [ "$INSTALL_COMMAND" ]
then
    echo "Install command is: $INSTALL_COMMAND"
    echo "OS is: $OS_TYPE"
fi

echo "==== Installing common tools ===="
`sudo $INSTALL_COMMAND i3`
`sudo $INSTALL_COMMAND pavucontrol`
`sudo $INSTALL_COMMAND j4-dmenu-desktop`
`sudo $INSTALL_COMMAND rofi`
`sudo $INSTALL_COMMAND compton`
`sudo $INSTALL_COMMAND feh`
`sudo $INSTALL_COMMAND playerctl`
`sudo $INSTALL_COMMAND maim`
`sudo $INSTALL_COMMAND xdotool`
`sudo $INSTALL_COMMAND ranger`

echo "==== Installing pip tools ===="
cd "$HOME"
`sudo pip3 install i3-py`
`sudo pip3 install quickswitch-i3`
`sudo pip3 install virtualenvwrapper`

echo "==== Ready to restart  ===="
exit 0
