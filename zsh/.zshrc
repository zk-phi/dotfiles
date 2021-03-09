ZSH=$HOME/.zsh.d

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
setopt multios                  # accept multiple redirections

# ------------------------------
# language-specific settings
# ------------------------------

. /usr/local/opt/asdf/asdf.sh

# ------------------------------
# prompt
# ------------------------------

setopt prompt_subst
autoload -U colors && colors

function _errno_face {
    echo "%(?:%{$reset_color%}（*'-'）? :%{$fg[red]%}（\`;w;）! )"
}

function _pwd {
    if [[ $PWD == $HOME ]]; then
        echo "%{$fg_bold[cyan]%}~"
    else
        echo "%{$fg_bold[cyan]%}$(basename $PWD)"
    fi
}

function _under_gitrepo_p {
    test -d .git || command git rev-parse --git-dir >/dev/null 2>/dev/null
}

function _git_prompt {
    if _under_gitrepo_p; then
        _branch_name=$(git symbolic-ref --short HEAD 2>/dev/null || git show-ref --head -s --abbrev | head -n1)

        if test -n "$(git status --porcelain)"; then
            # _git_status="☁️ "
            _git_status="%{$fg_bold[white]%}＊"
        else
            # _git_status="✨ "
            _git_status=""
        fi

        if git rev-parse --verify --quiet refs/stash >/dev/null; then
            # _git_stashed=" 📃 "
            _git_stashed="%{$fg_bold[white]%}＊"
        else
            _git_stashed=""
        fi

        echo " %{$fg_bold[blue]%}git:(%{$fg_bold[red]%}$_branch_name$_git_status%{$fg_bold[blue]%})$_git_stashed"
    else
        echo ""
    fi
}

# Reference: http://smithje.github.io/bash/2013/07/08/moon-phase-prompt.html
_moon_phase () {
    local lp=2551443
    local now=$(date -ju +"%s")
    local newmoon=592500
    local phase=$((($now - $newmoon) % $lp))
    local phase_number=$(((phase / 86400) + 1))
    local phase_number_biggened=$((phase_number * 100000))

    if   [ $phase_number_biggened -lt 184566 ];  then phase_icon="🌑"  # new
    elif [ $phase_number_biggened -lt 553699 ];  then phase_icon="🌒"  # waxing crescent
    elif [ $phase_number_biggened -lt 922831 ];  then phase_icon="🌓"  # first quarter
    elif [ $phase_number_biggened -lt 1291963 ]; then phase_icon="🌔"  # waxing gibbous
    elif [ $phase_number_biggened -lt 1661096 ]; then phase_icon="🌕"  # full
    elif [ $phase_number_biggened -lt 2030228 ]; then phase_icon="🌖"  # waning gibbous
    elif [ $phase_number_biggened -lt 2399361 ]; then phase_icon="🌗"  # last quarter
    elif [ $phase_number_biggened -lt 2768493 ]; then phase_icon="🌘"  # waning crescent
    else                                              phase_icon="🌑"  # new
    fi

    echo $phase_icon
}

function _local_git_user {
    if _under_gitrepo_p; then
        echo $(git config --local user.name)
    else
        echo ""
    fi
}

# PROMPT='$(_moon_phase)  $(_pwd)$(_git_prompt)$(_errno_face)%{$reset_color%}'
PROMPT='$(_pwd)$(_git_prompt)$(_errno_face)%{$reset_color%}'
RPROMPT='$(_local_git_user)'

# ------------------------------
# terminal title
# ------------------------------

# Display process name or PWD in the terminal title.
# Reference: .oh-my-zsh/lib/termsupport.zsh

function _title {
    emulate -L zsh
    case "$TERM" in
        cygwin|xterm*|putty*|rxvt*|ansi)
            print -Pn "\e]2;$2:q\a" # set window name
            print -Pn "\e]1;$1:q\a" # set tab name
            ;;
        screen*)
            print -Pn "\ek$1:q\e\\" # set screen hardstatus
            ;;
        *)
            if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
                print -Pn "\e]2;$2:q\a" # set window name
                print -Pn "\e]1;$1:q\a" # set tab name
            else
                # Try to use terminfo to set the title
                # If the feature is available set title
                if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
                    echoti tsl
                    print -Pn "$1"
                    echoti fsl
                fi
            fi
            ;;
    esac
}

function _set_title_pwd {
    emulate -L zsh
    _title "%15<..<%~%<<" "%n@%m: %~"
}

function _set_title_procname {
    emulate -L zsh
    local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
    local LINE="${2:gs/%/%%}"
    _title '$CMD' '%100>...>$LINE%<<'
}

precmd_functions+=(_set_title_pwd)
preexec_functions+=(_set_title_procname)

# ------------------------------
# autocompletion
# ------------------------------

autoload -U compinit && compinit -i

ZSH_CACHE_DIR=$ZSH/cache

unsetopt menu_complete  # do not autoselect the first completion
unsetopt flowcontrol    # disable flowcontrol
setopt auto_menu        # automatically show completion menu
setopt complete_in_word # complete at the cursor position
setopt always_to_end    # move cursor to the end after completion

# add flex matcher (as a fallback to the default oh-my-zsh matchers)
zstyle ':completion:*' matcher-list \
       'm:{a-zA-Z-_}={A-Za-z_-}' \
       'r:|=*' \
       'l:|=* r:|=*' \
       'r:|?=** m:{a-z\-}={A-Z\_}'

# Reference: .oh-my-zsh/lib/completion.zsh
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*:*:*:users' ignored-patterns \
       adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
       clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
       gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
       ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
       named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
       operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
       rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
       usbmux uucp vcsa wwwrun xfs '_*'
zstyle '*' single-ignored show

# ------------------------------
# autocorrect
# ------------------------------

setopt correct_all

# list of commands not to enable autocorrection
# Reference: .oh-my-zsh/lib/correction.zsh
alias ebuild='nocorrect ebuild'
alias gist='nocorrect gist'
alias heroku='nocorrect heroku'
alias hpodder='nocorrect hpodder'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias sudo='nocorrect sudo'

# ------------------------------
# history
# ------------------------------

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history          # append new commands to the HISTFILE,
setopt inc_append_history      # -- just after invoking commands
setopt hist_ignore_dups        # do not add duplicate entries
setopt hist_expire_dups_first  # expire duplicate entries first
setopt hist_ignore_space       # filter commands starts with a space
setopt hist_verify             # edit before executing from history
setopt share_history           # share history among the tabs
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

# sudo: please, please do it
alias please='sudo'

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
    abbrev-alias gap='git add -p '
    abbrev-alias gc='git commit '
    abbrev-alias gco='git checkout '
    abbrev-alias gcoo='git fetch origin && git checkout origin/'
    abbrev-alias gb='git branch '
    abbrev-alias gd='git diff '
    abbrev-alias gds='git diff --staged '
    abbrev-alias gl='git log '
    abbrev-alias glog='git log --oneline --decorate --graph '
    abbrev-alias gr='git reset '
    abbrev-alias gs='git show '
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
