# ------------------------------
# oh-my-zsh
# ------------------------------

# /path/to/.oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# settings
plugins=(git)                   # plugins (~/.oh-my-zsh/plugins/)
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
# aliases
# ------------------------------

# ls
alias sl=ls
alias sls=ls

# git
alias gti=git
alias g=git
alias igt=git

# fuck
alias fuck='eval $(thefuck $(fc -ln -1))'
alias FUCK='fuck'

# mysql (* set default DB_NAME in .zprofile)
DB_USER=root
function DELETE () { mysql -u $DB_USER -D $DB_NAME -e "SET NAMES utf8; DELETE $*" }
function INSERT () { mysql -u $DB_USER -D $DB_NAME -e "SET NAMES utf8; INSERT $*" }
function SELECT () { mysql -u $DB_USER -D $DB_NAME -e "SET NAMES utf8; SELECT $*" }
function DROP () { mysql -u $DB_USER -D $DB_NAME -e "SET NAMES utf8; DROP $*" }
function EXPLAIN () { mysql -u $DB_USER -D $DB_NAME -e "SET NAMES utf8; EXPLAIN $*" }
alias delete="noglob DELETE"    # use noglob NOT to expand "*"s
alias insert="noglob INSERT"
alias select="noglob SELECT"
alias drop="noglob DROP"
alias explain="noglob EXPLAIN"

# use git-like diff if colordiff is available
if which colordiff > /dev/null; then
    function diff () { colordiff -u $* | less }
else
    echo "[.zshrc] colordiff is unavailable."
fi
