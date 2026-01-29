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

setopt share_history           # share history across sessions
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
    echo "[.zshrc] colordiff is not installed."
fi
if which diff-highlight > /dev/null; then
    postdiff=diff-highlight
else
    postdiff=cat
    echo "[.zshrc] diff-highlight is not installed."
fi
function diff () { $diffcmd -u $* | $postdiff | less -R }

# less: make less recognize ANSI escape sequences
alias less='less -R'

# jobs
alias jobs='jobs -l'

# git: disable glob expansion (otherwise "reset HEAD^" fails as "no matches found")
alias git='noglob git'

# ------------------------------
# keybinds
# ------------------------------

function my-set-mark-or-exchange () {
    if (( REGION_ACTIVE == 1 )); then
        zle exchange-point-and-mark
    else
        zle set-mark-command
    fi
}
zle -N my-set-mark-or-exchange

function my-unset-mark-or-break () {
    if (( REGION_ACTIVE == 1 )); then
        zle set-mark-command -n -1
    else
        zle send-break
    fi
}
zle -N my-unset-mark-or-break

function my-kill-whole-line-or-region () {
    if (( REGION_ACTIVE == 1 )); then
        zle kill-region
    else
        zle kill-whole-line
    fi
}
zle -N my-kill-whole-line-or-region

function my-open-line () {
    # FIXME: how can i put newline without 'echo'ing ?
    RBUFFER=$(echo "\n$RBUFFER")
}
zle -N my-open-line

function my-newline-between () {
    LBUFFER=$(echo "$LBUFFER\n")
    RBUFFER=$(echo "\n$RBUFFER")
}
zle -N my-newline-between

function my-mark-whole-line () {
    zle beginning-of-line
    zle set-mark-command
    zle end-of-line
}
zle -N my-mark-whole-line

function ignore () {
}
zle -N ignore

# -- C-* keybinds
bindkey '^`' ignore
bindkey '^1' digit-argument
bindkey '^2' digit-argument
bindkey '^3' digit-argument
bindkey '^4' digit-argument
bindkey '^5' digit-argument
bindkey '^6' digit-argument
bindkey '^7' digit-argument
bindkey '^8' digit-argument
bindkey '^9' digit-argument
bindkey '^0' digit-argument
bindkey '^_' undo               # i dont know why but this works as '^-'
bindkey '^=' ignore             # text-scale-increase
bindkey '^q' quoted-insert
bindkey '^w' my-kill-whole-line-or-region
bindkey '^e' end-of-line
bindkey '^r' ignore             # query-replace
bindkey '^t' transpose-words -n -1
bindkey '^y' yank
bindkey '^u' ignore             # scroll-down (configured in iTerm2)
bindkey '^i' expand-or-complete # is TAB
bindkey '^o' my-open-line
bindkey '^p' history-beginning-search-backward # previous-line
# '^[' is ESC
bindkey '^]' my-unset-mark-or-break
bindkey '^a' ignore                              # mc/mark-next-dwim
bindkey '^s' history-incremental-search-backward # isearch
bindkey '^d' delete-char-or-list
bindkey '^f' forward-char
bindkey '^g' my-unset-mark-or-break # keyboard-quit
bindkey '^h' backward-delete-char
bindkey '^j' beginning-of-line
bindkey '^k' kill-line
bindkey '^l' ignore             # recenter
bindkey '^;' ignore             # comment-dwim
# bindkey "^'" ignore -- i dont know why but this line breaks other keybinds
bindkey "^\\" ignore
bindkey '^z' ignore             # suspend-frame (configured in iTerm2)
bindkey '^x' ignore
bindkey '^c' ignore
bindkey '^v' ignore             # scroll-up (configured in iTerm2)
bindkey '^b' backward-char
bindkey '^n' end-of-history     # next-line
bindkey '^m' accept-line
bindkey '^,' select-a-word      # expand-region
# bindkey '^.' ignore             # include-anywhere
# bindkey '^/' ignore
bindkey '^ ' my-set-mark-or-exchange

# -- C-M-* keybinds
bindkey '^[^`' ignore
bindkey '^[^1' digit-argument
bindkey '^[^2' digit-argument
bindkey '^[^3' digit-argument
bindkey '^[^4' digit-argument
bindkey '^[^5' digit-argument
bindkey '^[^6' digit-argument
bindkey '^[^7' digit-argument
bindkey '^[^8' digit-argument
bindkey '^[^9' digit-argument
bindkey '^[^0' digit-argument
bindkey '^[^_' redo              # i dont know why but this works as '^-'
bindkey '^[^=' ignore            # text-scale-decrease
bindkey '^[^q' ignore
bindkey '^[^w' copy-region-as-kill
bindkey '^[^e' end-of-line       # end-of-defun
bindkey '^[^r' ignore            # replace
bindkey '^[^t' ignore            # transpose-lines
bindkey '^[^y' yank              # expand-oneshot-snippet
bindkey '^[^u' ignore            # beginning-of-buffer (configured in iTerm2)
bindkey '^[^i' ignore            # fill-paragraph
bindkey '^[^o' my-newline-between
bindkey '^[^p' history-beginning-search-backward   # previous-blank-line
# '^[^[' is ... ?
bindkey '^[^]' ignore
bindkey '^[^a' ignore                              # mc/mark-all
bindkey '^[^s' history-incremental-search-backward # isearch-backward
bindkey '^[^d' kill-word
bindkey '^[^f' emacs-forward-word
bindkey '^[^g' my-unset-mark-or-break # keyboard-quit
bindkey '^[^h' backward-kill-word
bindkey '^[^j' beginning-of-line # beginning-of-defun
bindkey '^[^k' backward-kill-line
bindkey '^[^l' ignore            # retop
bindkey '^[^;' ignore
# bindkey "^[^'" ignore
bindkey "^[^\\" ignore           # indent-region
bindkey '^[^z' ignore
bindkey '^[^x' ignore            # eval-defun
bindkey '^[^c' ignore            # calc
bindkey '^[^v' ignore            # end-of-buffer (configured in iTerm2)
bindkey '^[^b' backward-word
bindkey '^[^n' end-of-history    # next-blank-line
bindkey '^[^m' vi-open-line-below
bindkey '^[^,' my-mark-whole-line
bindkey '^[^.' ignore            # xref
bindkey '^[^/' ignore            # dabbrev
bindkey '^[^ ' ignore

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

bindkey '^f' forward-char-or-accept-suggested-word

# ------------------------------
# plugin: abbrev-alias
# ------------------------------

# Try to expand abbrev. Then self-insert IFF no abbrevs are expanded.
expand-abbrev-or-self-insert-otherwise () {
    local oldbuffer=$LBUFFER
    zle __abbrev_alias::magic_abbrev_expand
    if [[ $LBUFFER == $oldbuffer ]]; then
        zle self-insert
    fi
}
zle -N expand-abbrev-or-self-insert-otherwise

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

    # others
    abbrev-alias sq='xattr -d com.apple.quarantine ' # skip quarantine

    # filters
    abbrev-alias -g g='| grep '
    abbrev-alias -g gi='| grep -v ' # grep inverse
    abbrev-alias -g l='| less -R '
    abbrev-alias -g c='| cut -d " " -f '
    abbrev-alias -g s='| tr -s " " ' # shrink spaces

    # git options
    abbrev-alias -g n='--no-verify '
    abbrev-alias -g fp='--first-parent '
    abbrev-alias -ge b='$(git symbolic-ref --short HEAD) '

    # yt-dlp options
    abbrev-alias -g cfb='--cookies-from-browser chrome '
    abbrev-alias -g fhd='-S "+height:1080" -f "b*" '

    bindkey " " expand-abbrev-or-self-insert-otherwise
else
    echo "[.zshrc] abbrev-alias is not installed."
fi

if ! which sfw > /dev/null; then
    echo "[.zshrc] sfw is not installed."
fi
