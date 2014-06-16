#! /bin/sh
# Script to get all the PPA installed on a system
echo ---------------------
echo List of repositories:
echo ---------------------
for APT in `find /etc/apt/ -name \*.list`; do
    grep -Po "(?<=^deb\s).*?(?=#|$)" $APT | while read ENTRY ; do
        HOST=`echo $ENTRY | cut -d/ -f3`
        USER=`echo $ENTRY | cut -d/ -f4`
        PPA=`echo $ENTRY | cut -d/ -f5`
        # originally this was supposed to generate a script to add
        # repositories, hence the echos with sudo. At the moment I'm
        # not interested in that but seems a good idea to keep in mind
        if [ "ppa.launchpad.net" = "$HOST" ]; then
            # echo sudo apt-add-repository ppa:$USER/$PPA
            echo ppa:$USER/$PPA
        else
            # echo sudo apt-add-repository \'${ENTRY}\'
            echo \'${ENTRY}\'
        fi
    done
done
