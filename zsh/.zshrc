# ------------------------------
# oh-my-zsh
# ------------------------------

# /path/to/.oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# settings
plugins=()                      # load no plugins on startup
HYPHEN_INSENSITIVE="true"       # 'hoge-' also completes 'hoge_'
ZSH_THEME="robbyrussell"

# install
source $ZSH/oh-my-zsh.sh

# ------------------------------
# directories
# ------------------------------

export PATH="$HOME/perl5/bin:$HOME/.ndenv/bin:$HOME/.plenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PGDATA="/usr/local/var/postgres"

# ------------------------------
# language-specific settings
# ------------------------------

# perl
eval "$(plenv init -)"
export PERL_CPANM_OPT="--local-lib=$HOME/perl5"
export PERL5LIB=$HOME/perl5/lib/perl5:$PERL5LIB

# ruby
eval "$(rbenv init -)"

# node
eval "$(ndenv init -)"

# ------------------------------
# commandline
# ------------------------------

# autocorrect
setopt correct

# history
setopt hist_ignore_all_dups # remove dups except for the newest one
setopt hist_verify          # verify before executing history commands
setopt hist_reduce_blanks   # remove unuseful spaces
setopt hist_expand          # use history completions
setopt hist_ignore_space    # do not save commands starts with a space

# keybinds
bindkey '\e' vi-cmd-mode
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# prompt
setopt prompt_subst
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$fg[blue]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="☁️"
ZSH_THEME_GIT_PROMPT_CLEAN="✨"
ZSH_THEME_GIT_PROMPT_STASHED="📃 "
local ret_status="%(?:%{$fg[white]%}（*'-'）? :%{$fg[red]%}（\`;w;）! )"
SPROMPT="%{$fg[green]%}%{$suggest%}(*'~'%)? < %B%r%b %{$fg[green]%}かな? [n,y,a,e]:${reset_color} "
PROMPT='%{$fg_bold[cyan]%}%c%{$reset_color%} $(git_prompt_info)$(git_prompt_status)${ret_status}%{$reset_color%}'

# ------------------------------
# git checkout completion
# ------------------------------

# Redefine "_git_checkout" (originally defined in
# /usr/local/share/zsh/functions/git-completion.bash) NOT to complete
# remote branches on checkout.

# Dummy function which immediately undefines itself and loads the real
# definition of "_git", then replace "_git_checkout" defined in "_git"
# with the new definition. FIXME: Remote branches are also completed
# at the very first invokation of git-completion, since "autoload -X"
# does not just load the function but also execute it. "autoload +X"
# may avoid execution, but internal functions are defined during
# execution, thus "_git_checkout" is not defined yet this case.
_git () {
    unfunction _git
    autoload -X
    _git_checkout () {
        __git_has_doubledash && return
        case "$cur" in
            --conflict=*)
                __gitcomp "diff3 merge" "" "${cur##--conflict=}"
                ;;
            --*)
                __gitcomp "
            --quiet --ours --theirs --track --no-track --merge
            --conflict= --orphan --patch
            "
                ;;
            *)
                __gitcomp_nl "$(__git_heads)"
                ;;
        esac
    }
}

# ------------------------------
# aliases
# ------------------------------

# git
alias ga='git add'
alias gco='git chegckout'
alias gb='git branch'
alias gd='git diff'
alias gs='git diff --staged'
alias gl='git log'
alias glog='git log --oneline --decorate --graph'
alias gst='git status'

# typos
alias gti=git
alias igt=git
alias sl=ls
alias sls=ls

# use git-like diff if colordiff is available
if which colordiff > /dev/null; then
    function diff () { colordiff -u $* | less }
else
    echo "[.zshrc] colordiff is unavailable."
fi
