# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias e="emacsclient"
alias enw="emacsclient -nw"
alias enwq="emacs -nw -Q"
alias enwd="emacs -nw -q --no-splash -l ~/.emacs.d/default-nw.el"

# NOTA: Se esta probando la sugerencia de poner las cosas en scripts,
# de momento

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while
# waiting for completion COMPLETION_WAITING_DOTS="true"

# Inicialization of the editor en linea
bindkey -e

# Esta parte es añadida para conseguir que Emacs sea el editor por default
# En las pruebas está hecho parece estar funcionando de manera adecuada

export EDITOR="enwd"
export ALTERNATE_EDITOR="enwq"
export VISUAL="emacsclient"
# export EDITOR="emacsclient -nw -a emacs -nw -q -l ~/.emacs.d/default-nw.el"
# Sin embargo hay que considerar casos en los que no se tiene una
# sesión de servidor emacs iniciada, por lo que se debe investigar
# alternativas como la propuesta en
# http://unix.stackexchange.com/questions/52471/how-to-add-system-alias

# Sin embargo, al parecer tengo que poner un script en algún lugar que
# no parece ser universar, tengo que investigar como modificar el
# $PATH para diferentes shells.

# to define a browser in case non is defined
if [[ $BROWSER == '' ]] then;
    export BROWSER=google-chrome
    fi

# An attempt to get TRAMP working inside Emacs, seems to be working
# just fine, so posible scripts based on this will be created in the
# future
# prompts
if [[ $TERM == "dumb" ]]; then	# in emacs
    PS1='%(?..[%?])%!:%~%# '
    # for tramp to not hang, need the following. cf:
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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Interesting themes: themes, pip
plugins=(git git-extras history pip themes virtualenv)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/lib/lightdm/lightdm
export PATH=$PATH:"/usr/local/sbin"
export PATH=$PATH:"/usr/local/bin"
export PATH=$PATH:"/usr/sbin"
export PATH=$PATH:"/usr/bin"
export PATH=$PATH:"/sbin"
export PATH=$PATH:"/bin"
export PATH=$PATH:"/usr/games"
export PATH=$PATH:"$HOME/bin"

export PYTHONPATH="/home/rene/Documents"
export PYTHONPATH=$PYTHONPATH:"/home/rene/Documents/Semestre 3/PDE/Proyecto/SegundoReporte/BurgersComputedSolutions/FLIC_Boost"
export PYTHONPATH=$PYTHONPATH:"/home/rene/Documents/Semestre 4/PruebaGeneral2D/BoostCode/"
export PYTHONPATH=$PYTHONPATH:"/home/rene/Documents/Semestre 4/PruebaGeneral2D/PythonCode/"
export PYTHONPATH=$PYTHONPATH:"/home/rene/Documents/FORCE_md/"

if [[ -d $HOME/.virtualenvs ]]; then
    export WORKON_HOME="$HOME/.virtualenvs"
else
    echo "\033[0;31m"'virtualenv not active'"\033[0;31m"
fi

if [[ -e /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
else
    echo "\033[0;31m"'virtualenvwrapper not active'"\033[0;31m"
fi
