# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Path to custom definitions (themes and plugins)
export ZSH_CUSTOM="$HOME/.dotfiles/zsh_custom"

# Variable para gcloud zsh plugin
export CLOUDSDK_HOME="/usr/share/google-cloud-sdk/"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# This alias is specific to zsh
alias lsd="ls -d *(/)"

# NOTA: Se esta probando la sugerencia de poner las cosas en scripts,
# dichos scripts se encuentran en `~/bin`

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while
# waiting for completion COMPLETION_WAITING_DOTS="true"

# Ignore leading space commands from history
setopt -g hist_ignore_space

# Inicialization of the editor en linea con emacs keymap
bindkey -e

# Esta parte es añadida para conseguir que Emacs sea el editor por default
# En las pruebas está hecho parece estar funcionando de manera adecuada

export FCEDITOR="enw"
export EDITOR="enwd"
export ALTERNATE_EDITOR="enwq"
export VISUAL="emacsclient -c"
# export EDITOR="emacsclient -nw -a emacs -nw -q -l ~/.emacs.d/default-nw.el"
# Sin embargo hay que considerar casos en los que no se tiene una
# sesión de servidor emacs iniciada, por lo que se debe investigar
# alternativas como la propuesta en
# http://unix.stackexchange.com/questions/52471/how-to-add-system-alias

# Sin embargo, al parecer tengo que poner un script en algún lugar que
# no parece ser universar, tengo que investigar como modificar el
# $PATH para diferentes shells.

# Definiendo most como pager por default
export PAGER="most"

# to define a browser in case non is defined
if [[ $BROWSER == '' ]] ; then
    if (( $+commands[google-chrome] )); then
        export BROWSER=google-chrome
    else
        echo "google-chrome doesn't exist";
        export BROWSER=chromium
    fi
fi

# An attempt to get TRAMP working inside Emacs, seems to be working
# just fine, so posible scripts based on this will be created in the
# future
# prompts
if [[ $TERM == "dumb" ]]; then  # in emacs
    PS1='%(?..[%?])%!:%~%# '
    # for tramp not to hang, need the following. cf:
    # http://www.emacswiki.org/emacs/TrampMode
    unsetopt zle
    unsetopt prompt_cr
    DISABLE_AUTO_TITLE="true"
    unsetopt prompt_subst
    # unfunction precmd
    # unfunction preexec
else
    # Personal(Custom) Stuff

    # Set name of the theme to load.
    # Look in ~/.oh-my-zsh/themes/
    # Optionally, if you set this to "random", it'll load a random theme each
    # time that oh-my-zsh is loaded.
    ZSH_THEME="aussiegeek_mod"

    # intheloop
    # simonoff
    # agnoster; pero necesita de powerline-patched fonts
    # fino-time; hay que cuidarla configuración rvm
    # kardan; checar como hace el rprompt
fi

# Para poder utilizar solarized y otros temas desde terminal
# No parece estar funcionando en lo absoluto
export TERM="xterm-256color"

# Which plugins would you like to load?
# (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Interesting plugins: themes, pip

plugins=(
    docker
    docker-compose
    git
    gitignore
    git-extras
    git-flow
    history
    pip
    themes
    common-aliases
    # ssh-agent # Plugin interfiere con Magit, investigar porque
    # django
    tmux
    npm
    vagrant
    fabric
    mercurial
    personal_functions)



# # suggestion from file ~/.oh-my-zsh/plugins/mvn/mvn.plugin.zsh, but
# # doesn't seem to be working, more tests are required
# alias mvn="mvn-color"

# Customize to your needs...
export PATH=/usr/lib/lightdm/lightdm
export PATH=$PATH:"/usr/local/sbin"
export PATH=$PATH:"/usr/local/bin"
export PATH=$PATH:"/usr/sbin"
export PATH=$PATH:"/usr/bin"
export PATH=$PATH:"/snap/bin"
export PATH=$PATH:"/sbin"
export PATH=$PATH:"/bin"
export PATH=$PATH:"/usr/games"
export PATH=$PATH:"$HOME/bin"
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"$HOME/lib/python_lib/"
export PATH=$PATH:"$HOME/.dotfiles" # access to dotfiles_sync

# Sencha Cmd 6
if [[ -d "$HOME/bin/Sencha/Cmd/6.0.2.14" ]]; then
    export PATH=$PATH:"$HOME/bin/Sencha/Cmd/6.0.2.14"
    export SENCHA_CMD_3_0_0="$HOME/bin/Sencha/Cmd/6.0.2.14"
elif [[ -d "$HOME/bin/Sencha/Cmd/6.0.0.202" ]]; then
    export PATH=$PATH:"$HOME/bin/Sencha/Cmd/6.0.0.202"
    export SENCHA_CMD_3_0_0="$HOME/bin/Sencha/Cmd/6.0.0.202"
elif [[ -d "$HOME/bin/Sencha/Cmd/5.1.3.61" ]]; then
    # Sencha Cmd
    export PATH=$PATH:"$HOME/bin/Sencha/Cmd/5.1.3.61"
    export SENCHA_CMD_3_0_0="$HOME/bin/Sencha/Cmd/5.1.3.61"
fi

# Sencha ExtJS6.1-commercial:
if [[ -d "$HOME/sencha-test/libraries/ext-6.0.1" ]]; then
    export EXTJS6_COMMERCIAL_SDK="$HOME/sencha-test/libraries/ext-6.0.1/"
fi

# Sencha ExtJS6.0-commercial:
if [[ -d "$HOME/sencha-test/libraries/ext-6.0.0" ]]; then
    export EXTJS6_0_COMMERCIAL_SDK="$HOME/sencha-test/libraries/ext-6.0.0/"
fi

# Sencha ExtJS6-premium: libraries/ext-premium-6.0.0-trial/
if [[ -d "$HOME/sencha-test/libraries/ext-premium-6.0.0/ext-6.0.0" ]]; then
    export EXTJS6PREMIUM_TRIAL_SDK="$HOME/sencha-test/libraries/ext-premium-6.0.0/ext-6.0.0/"
fi

# Sencha ExtJS6
if [[ -d "$HOME/sencha-test/libraries/ext-6.0.0-gpl" ]]; then
    export EXTJS6SDK_GPL="$HOME/sencha-test/libraries/ext-6.0.0-gpl/"
fi

# Sencha ExtJS
if [[ -d "$HOME/sencha-test/libraries/ext-5.1.1/" ]]; then
    export EXTJSSDK="$HOME/sencha-test/libraries/ext-5.1.1/"
fi

# Sencha Touch
if [[ -d "$HOME/sencha-test/libraries/touch-2.4.2-gpl/" ]]; then
    export TOUCHJSSDK="$HOME/sencha-test/libraries/touch-2.4.2-gpl/"
fi

# Sencha Touch 2.3
if [[ -d "$HOME/sencha-test/libraries/touch23/2.3.1.410/gpl" ]]; then
    export TOUCHJSSDK23="$HOME/sencha-test/libraries/touch23/2.3.1.410/gpl"
fi

# Bryntum Scheduler 4.0
if [[ -d "$HOME/sencha-test/libraries/scheduler-4.0.0" ]]; then
    export SCHEDULER4="$HOME/sencha-test/libraries/scheduler-4.0.0"
fi

export PYTHONPATH="$HOME/Documents"
export PYTHONPATH=$PYTHONPATH:"$HOME/Documents/Semestre 3/PDE/Proyecto/SegundoReporte/BurgersComputedSolutions/FLIC_Boost"
export PYTHONPATH=$PYTHONPATH:"$HOME/Documents/Semestre 4/PruebaGeneral2D/BoostCode/"
export PYTHONPATH=$PYTHONPATH:"$HOME/Documents/Semestre 4/PruebaGeneral2D/PythonCode/"
export PYTHONPATH=$PYTHONPATH:"$HOME/Documents/FORCE_md/"
export PYTHONPATH=$PYTHONPATH:"$HOME/lib/python_lib/"

# # reference for working with AXS
# PYTHONPATH=$PYTHONPATH:"$HOME/workspace/datyra/repositories/reps":"$HOME/workspace/datyra/repositories/reps/reps"

if [ -x "$( command -v virtualenv)" ]; then
    if [[ ! -d $HOME/.virtualenvs ]]; then
        mkdir $HOME/.virtualenvs
    fi
    export WORKON_HOME="$HOME/.virtualenvs"
    export VIRTUALENV_PYTHON=`which python3`
    plugins+=(virtualenv)
else
    echo "\033[0;31m"'virtualenv not active'"\033[0;31m"
fi

if [[ -e /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
elif [[ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]]; then
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
else
    echo "\033[0;31m"'virtualenvwrapper not active'"\033[0;31m"
fi

# This part seems to be taken care of by installing the
# oracle-java7-set-default package

# # JAVA_HOME, ver
# # http://stackoverflow.com/questions/6477415/how-to-set-java-home-in-ubuntu,
# # también ahí se encuentra una referencia para hacer la variable
# # disponible de manera global
# if [[ ( -e /usr/bin/java) && ( -d /usr/lib/jvm/java-7-oracle) ]]; then
#     export JAVA_HOME=/usr/lib/jvm/java-7-oracle
# else
#     echo "\033[0;31m"'java oracle not active'"\033[0;31m"
# fi

if (( $+commands[mvn] )); then
    # Suponiendo que maven 3 fué instalado del repositorio de ubuntu,
    # parece ser que la nueva el nuevo maven 3 no necesita M2_HOME.
    # En 15.04 se está utilizando un ppa:
    # https://launchpad.net/~vkorenev/+archive/ubuntu/maven3/+packages

    # export M2_HOME=/usr/share/maven
    plugins+=(mvn)
else
    echo "mvn doesn't exist";
fi

# Notes on jython installation:
# The installation procedure is taken from:
# http://stackoverflow.com/questions/5836570/installing-jython-on-ubuntu
# but it failed to create a new virtualenv, so a local installation is
# used:
# installation path: ~/jython2.7b1/
export PATH=$PATH:"$HOME/jython2.7b1/"
# The jython installation is complete, but cannot create a virtualenv
# with it, something about not having a pip package, so far no
# solution has been found, further investigation is requried.

# So far, the get-pip.py already downloaded doesn't work, so perhaps a
# newly downloaded get-pip script or the procedure described in the
# django tutorial movie 2 may work, need confirmation

# Workaround to get gvm working under tmux, taken from:
# https://github.com/gvmtool/gvm/issues/155
if [[ -n $TMUX ]]
then
    unset GVM_INIT
fi

# Add android-sdk binaries and tools to path
if [[ `uname` == 'Linux' ]]; then
    # echo 'In Linux system'
    export ANDROID_SDK='android-sdk-linux'
    if (( $+commands[lsb_release] )); then
        plugins+=(debian)
    fi
elif [[ `uname` == 'Darwin' ]]; then
    # echo 'In Darwin system'
    export ANDROID_SDK='android-sdk-macosx'
fi

export PATH="$HOME/dev-android/$ANDROID_SDK/tools/":$PATH
export PATH="$HOME/dev-android/$ANDROID_SDK/tools/bin/":$PATH
export PATH="$HOME/dev-android/$ANDROID_SDK/platform-tools/":$PATH
export ANDROID_SDK_ROOT="$HOME/dev-android/$ANDROID_SDK/"
# export ANDROID_SDK_ROOT="$HOME/dev-android/$ANDROID_SDK/tools/"

# Add gcloud plugin in case the folder exists
if [[ -d "$CLOUDSDK_HOME" ]]; then
    plugins+=(gcloud)
fi

# This sourcing must happend after all plugins have been declared
source $ZSH/oh-my-zsh.sh

# Cargo (rust and parity)
export PATH="$HOME/.cargo/bin:$PATH"

# source the alias file (override some omz aliases)
source $HOME/.aliases

# Autoload a custom edit-command-line function for $ZSH_VERSION
if [[ $ZSH_VERSION < "5.2" ]]
then
    fpath=("$HOME/lib/" "${fpath[@]}")
    autoload -Uz my-edit-command-line
    zle -N my-edit-command-line
    bindkey -rpM emacs "^X^E"
    bindkey -M emacs "^X^E" my-edit-command-line
fi

# Setup a console edit command line function
fpath=("$HOME/lib/" "${fpath[@]}")
autoload -Uz console-edit-command-line
zle -N console-edit-command-line
bindkey -M emacs "^xe" console-edit-command-line

# # Unalias for the ag searcher(debian plugin)
if (( $+commands[lsb_release] )); then
    alias aug='sudo $apt_pref upgrade'
fi

# To include NODE_PATH, but doesn't seem to work
export NODE_PATH="$NODE_PATH:/usr/lib/node_modules:/usr/local/lib/node_modules"
# export NODE_PATH="/usr/local/shape/npm"

# Cask
export PATH="$HOME/.cask/bin:$PATH"

# GH (github cli) environment variables
# Note: completion file was set on:
# /home/rene/.dotfiles/zsh_custom/plugins/personal_functions
# https://cli.github.com/manual/gh_completion
export GH_PAGER='less -R'

# Activate tmuxp source completion (tmuxp >= 1.5.1)
if $(which tmuxp &> /dev/null) ; then
    eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"
else
    echo "tmuxp not found"
fi

# Inform if sdkman is not active (groovy, scala, maybe vertx)
if [ ! -d $HOME/.sdkman ]
then
    echo "\033[0;31m"'sdkman not active'"\033[0;31m"
else
    export SDKMAN_DIR="$HOME/.sdkman" && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# https://github.com/creationix/nvm/issues/1651
# Se ejecuta:
# nvm unalias default
# nvm install lts/*
# Inform if nvm is not active (node, npm)
if [ ! -d $HOME/.nvm ]
then
    echo "\033[0;31m"'nvm not active'"\033[0;31m"
else
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# fzf from repositories
if $(which fzf &> /dev/null) ; then
    # Append this line to ~/.zshrc to enable fzf keybindings for Zsh:
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    # Append this line to ~/.zshrc to enable fuzzy auto-completion for Zsh:
    source /usr/share/doc/fzf/examples/completion.zsh
else
    echo "fzf not found"
fi


# # AIRFLOW home variable
# export AIRFLOW_HOME="$HOME/workspace/datyra/airflow-1.10.12/airflow"

# Alacritty dynamic title
# https://github.com/alacritty/alacritty/issues/3588#issuecomment-903251346
# Customization: only print name of command
preexec() {
    last_command=$1
    arr=("${(@s/ /)last_command}")
    print -Pn "\e]0;$arr[1]\a"
}

# Add alacritty zsh completion file _alacritty parent directory to fpath
fpath=("~/instalados-localmente/alacritty/extra/completions/" "${fpath[@]}")


# zsh syntax highlighting (requires ubuntu package zsh-syntax-highlighting)
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ ! -d "$HOME/anaconda3" ]; then
    echo "\033[0;31m"'Anaconda not active'"\033[0;31m"
else
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/rene/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/rene/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/home/rene/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/rene/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
fi
