function list-dir-repos-url() {
    if [[ $# == 1 ]]; then
	current_directory=$(pwd)
        target_directory=$1
        for elem in $(ls -bd -- $target_directory/*(/)); do
            cd "$elem"
            if [[ -d ".hg" ]]; then
                echo "[hg] $elem"
                echo "$(hg paths)"
            elif [[ -d ".git" ]]; then
                echo "[git] $elem"
                for remote in $(git remote show); do
                    echo "$remote = $(git config --get remote.$remote.url)"
                done
            fi
        done
	cd "$current_directory"
    else
	echo "usage: list-dir-repos-url directory-path"
	echo "       Prints all the VCS urls registered on the subdirectories of directory-path, useful for reference and search"
    fi
}
