# Very minimal per-directory-history implementation
# Based on https://github.com/ericfreese/zsh-cwd-history ((C) Eric Freese / MIT)

HISTORY_BASEDIR="$HOME/.zsh_directory_history"

_zsh_cwd_history_histfile_name() {
    echo "$HISTORY_BASEDIR/$(echo "${PWD:A}" | md5 -q)"
}

# Switch to a new history file, writing to the old one
_zsh_cwd_history_switch_histfile() {
    local new_histfile=$1

    # Write old histfile
    fc -P

    # Read new histfile
    fc -p "$new_histfile"
}

# Load history for current working directory when changing dirs
_zsh_cwd_history_cwd_changed() {
    _zsh_cwd_history_switch_histfile $(_zsh_cwd_history_histfile_name)
}

mkdir -p "$HISTORY_BASEDIR"
_zsh_cwd_history_cwd_changed

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _zsh_cwd_history_cwd_changed
