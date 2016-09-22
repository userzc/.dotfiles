PROMPT='%{$fg_bold[blue]%}[ %{$FG[202]%}%n%{$fg[black]%}\
@%{$fg[magenta]%}%m%{$fg[black]%}:%{$fg[cyan]%}%~\
$(custom_git_info)$(custom_hg_info)%{$fg[yellow]%}$(rvm_prompt_info)%{$fg_bold[yellow]%}\
$(custom_virtualenv_info)%{$fg_bold[blue]%} ]
%{$fg[black]%}➜ %# %{$reset_color%}'

# git theming
function custom_git_info(){
    if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
            ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
}

# mercurial theming
function custom_hg_info() {
    if [ $(in_hg) ]; then
        _DISPLAY=$(hg_get_branch_name)
        echo "$ZSH_THEME_HG_PROMPT_PREFIX$(hg_dirty)$_DISPLAY$ZSH_THEME_HG_PROMPT_SUFFIX"
        unset _DISPLAY
    fi
}

# python virtualenv themeing
function custom_virtualenv_info() {
    [[ -n ${VIRTUAL_ENV} ]] || return
    echo " $(virtualenv_prompt_info)"
}

# for more info check
# ~/.oh-my-zsh/plugins/mercurial/mercurial.plugin.zsh
# ~/.oh-my-zsh/plugins/git/git.plugin.zsh

ZSH_THEME_GIT_PROMPT_PREFIX="$fg_bold[magenta] (git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="$fg_bold[magenta])"
ZSH_THEME_HG_PROMPT_PREFIX="$fg_bold[magenta] (hg:"
ZSH_THEME_HG_PROMPT_SUFFIX="$fg_bold[magenta])"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}"
ZSH_THEME_HG_PROMPT_CLEAN="%{$fg_bold[green]%}"
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg_bold[red]%}"
