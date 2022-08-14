function list-dir-repos-url() {
    # This function lists the urls of all subdirectories of the target directory
    if [[ $# == 1 ]]; then
	current_directory=$(pwd)
        target_directory=$1
        for elem in $(ls -bd -- $target_directory/*(/)); do
            if [[ -d "$elem/.hg" ]]; then
                cd "$elem"
                echo "[hg] $elem"
                echo "$(hg paths)"
                cd $current_directory
            elif [[ -d "$elem/.git" ]]; then
                cd "$elem"
                echo "[git] $elem"
                for remote in $(git remote show); do
                    echo "$remote = $(git config --get remote.$remote.url)"
                done
                cd $current_directory
            fi
        done
	cd "$current_directory"
    else
	echo "usage: list-dir-repos-url directory-path"
	echo "       Prints all the VCS urls registered on the subdirectories of directory-path, useful for reference and search"
    fi
}

function sck() {
    # This function shows the layer reference for the current corne keyboard in the local repo
    if [[ $# == 1 ]]; then
        grep -B 1 -A 10 " \[$1\] " ~/instalados-localmente/qmk_firmware/keyboards/crkbd/keymaps/userzc/keymap.c
    else
        echo "usage: sck layer"
        echo "       Show Current Keymap for layer as reference for the current userzc keymap in the local repo"
        echo "layers: 0 -- Default"
        echo "        1 -- Lower"
        echo "        2 -- Raise"
        echo "        3 -- Adjust"
    fi
}
