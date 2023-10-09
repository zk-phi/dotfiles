ZSH=$HOME/.zsh.d

# vuln workaround (see also init.el)

function etags {
    echo "etags in Emacs 28.2 is known to be vulnerable (CVE-2022-48337)"
}
function ctags {
    echo "ctags in Emacs 28.2 is known to be vulnerable (CVE-2022-45939)"
}

# ------------------------------
# load plugins
# ------------------------------

if test -e $ZSH/plugins; then
    for file in $ZSH/plugins/*/*.plugin.zsh; do
        source $file;
    done
fi

# ------------------------------
# fundamental settings
# ------------------------------

export LANG="en_US.UTF-8"
export EDITOR="vim"
export PAGER="less"
export LSCOLORS="Gxfxcxdxbxegedabagacad" # enable colors in "ls"

setopt interactivecomments      # recognize comments in the REPL too
setopt extended_glob            # enable extended glob syntax
setopt auto_cd                  # "cd" with directory names

# ------------------------------
# language-specific settings
# ------------------------------

. $(brew --prefix asdf)/libexec/asdf.sh

# ------------------------------
# prompt
# ------------------------------

setopt prompt_subst

function _errno_face {
    echo " %(?:%f?:%F{red}!) "
}

function _under_gitrepo_p {
    test -d .git || command git rev-parse --git-dir >/dev/null 2>/dev/null
}

function _git_prompt {
    if _under_gitrepo_p; then
        _branch_name=$(git symbolic-ref --short HEAD 2>/dev/null || git show-ref --head -s --abbrev | head -n1)

        if test -n "$(git status --porcelain)"; then
            # _git_status="☁️ "
            _git_status="%f＊"
        else
            # _git_status="✨ "
            _git_status=""
        fi

        if git rev-parse --verify --quiet refs/stash >/dev/null; then
            # _git_stashed=" 📃 "
            _git_stashed="%f＊"
        else
            _git_stashed=""
        fi

        echo " %F{blue}(%F{red}$_branch_name$_git_status%F{blue})$_git_stashed"
    else
        echo ""
    fi
}

function _local_git_user {
    if _under_gitrepo_p; then
        _name=$(git config --local user.name)
        if [[ "$_name" == "" ]]; then
            echo "%S%F{red}UNSET%s"
        else
            echo $_name
        fi
    else
        echo ""
    fi
}

PROMPT='%F{cyan}%c$(_git_prompt)$(_errno_face)%f'
RPROMPT='$(_local_git_user)'

# ------------------------------
# terminal title
# ------------------------------

# Display command line or PWD in the terminal title.

function _title {
    print -Pn "\e]1;$1:q\a" # set tab name
    print -Pn "\e]2;$1:q\a" # set window name
}

function _set_title_pwd {
    _title "%c"
}

function _set_title_procname {
    _title $2
}

precmd_functions+=(_set_title_pwd)
preexec_functions+=(_set_title_procname)

# ------------------------------
# autocompletion
# ------------------------------

autoload -U compinit && compinit -i

ZSH_CACHE_DIR=$ZSH/cache

setopt no_flow_control  # disable flowcontrol
setopt auto_menu        # automatically show completion menu

# add flex matcher (as a fallback to the default oh-my-zsh matchers)
zstyle ':completion:*' matcher-list \
       'm:{a-zA-Z-_}={A-Za-z_-}' \
       'r:|=*' \
       'l:|=* r:|=*' \
       'r:|?=** m:{a-z\-}={A-Z\_}'

# Reference: .oh-my-zsh/lib/completion.zsh
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# ------------------------------
# history
# ------------------------------

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history          # append new commands to the HISTFILE,
setopt hist_ignore_dups        # do not repeat identical entries
setopt hist_ignore_space       # filter commands starts with a space
setopt hist_reduce_blanks      # remove unuseful spaces

# ------------------------------
# built-in commands overrides
# ------------------------------

# grep: colorize, and exclude CSV directories
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

# ls: colorize
alias ls='ls -G'                # mac
# alias ls='ls --color=auto'      # other

# diff: colorize and pagify
if which colordiff > /dev/null; then
    diffcmd=colordiff
else
    diffcmd=diff
fi
if which diff-highlight > /dev/null; then
    postdiff=diff-highlight
else
    postdiff=cat
fi
function diff () { $diffcmd -u $* | $postdiff | less -R }

# less: make less recognize ANSI escape sequences
alias less='less -R'

# jobs
alias jobs='jobs -l'

# git: disable glob expansion (otherwise "reset HEAD^" fails as "no matches found")
alias git='noglob git'

# ------------------------------
# plugin: autosuggestions
# ------------------------------

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=yellow'
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(forward-char-or-accept-suggested-word)

# count [_-/] as word delimters
WORDCHARS='*?.[]~=&;!#$%^(){}<>'

# If CURSOR is at the end of the BUFFER, excluding POSTDISPLAY (which
# zsh-autosuggestions temporarilly adds at the end of the BUFFER),
# invoke forward-word to complete a word. Otherwise just invoke
# forward-char.
function forward-char-or-accept-suggested-word () {
    if (( $CURSOR == $#BUFFER - $#POSTDISPLAY )); then
        zle forward-word
    else
        zle forward-char
    fi
}
zle -N forward-char-or-accept-suggested-word

# ------------------------------
# plugin: abbrev-alias
# ------------------------------

# use "magic_abbrev_expand_or_insert" instead of "magic_abbrev_expand_and_insert"
bindkey " " __abbrev_alias::magic_abbrev_expand_or_insert

# use abbrevs if abbev-alias is available
if whence abbrev-alias > /dev/null; then
    # git
    abbrev-alias ga='git add '
    abbrev-alias gap='git add --patch '
    abbrev-alias gc='git commit '
    abbrev-alias gco='git checkout '
    abbrev-alias gcoo='git fetch origin && git checkout origin/'
    abbrev-alias gb='git branch '
    abbrev-alias gd='git diff --irreversible-delete --ignore-all-space '
    abbrev-alias gds='git diff --staged --irreversible-delete --ignore-all-space '
    abbrev-alias gde='git checkout --detach '
    abbrev-alias gl='git log '
    abbrev-alias glog='git log --oneline --decorate --graph '
    abbrev-alias gr='git reset '
    abbrev-alias gs='git show --find-renames --irreversible-delete --ignore-all-space '
    abbrev-alias gst='git status '
    abbrev-alias gsta='git stash '
    abbrev-alias gstap='git stash pop '
    abbrev-alias gsyn='git submodule sync '
    abbrev-alias gsup='git submodule update --init '
    # [git-stash-merge]
    # apply stash top and drop if succeeded.
    # this works even when there exist unstashed changes.
    abbrev-alias gstam='git diff stash@{0}^ stash@{0} | git apply && git stash drop '
    # [git-undo]
    # undo the last change made to the current branch (keeping the worktree)
    abbrev-alias -e gun='git reset $(git symbolic-ref --short HEAD)@{1} '
    # [git-pull-current]
    # pull current branch with `--ff-only` strategy
    abbrev-alias -e gpu='git pull origin $(git symbolic-ref --short HEAD) --ff-only '
    # [git-pull-current-merge]
    # pull current branch
    abbrev-alias -e gpm='git pull origin $(git symbolic-ref --short HEAD) --rebase=false '

    # typos
    abbrev-alias gti='git '
    abbrev-alias igt='git '
    abbrev-alias sl='ls '
    abbrev-alias sls='ls '

    # ls
    abbrev-alias l='ls '
    abbrev-alias la='ls -a '
    abbrev-alias ll='ls -lh '
    abbrev-alias lla='ls -lah '

    # global aliases
    abbrev-alias -g g='| grep '
    abbrev-alias -g l='| less -R '
    abbrev-alias -g c='| cut -d " " -f '
    abbrev-alias -g s='| tr -s " " '
    abbrev-alias -g n='--no-verify '
    abbrev-alias -g fp='--first-parent '
    abbrev-alias -ge b='$(git symbolic-ref --short HEAD) '
else
    echo "[.zshrc] abbrev-alias is not unavailable."
fi

# ------------------------------
# keybinds
# ------------------------------

# enable emacs keybinds
bindkey -e

# extra keybinds
bindkey '^s' history-incremental-search-backward
bindkey '^p' history-beginning-search-backward
bindkey '^n' end-of-history
bindkey '^f' forward-char-or-accept-suggested-word
