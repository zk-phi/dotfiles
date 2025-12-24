# Very minimal per-directory-history implementation
# Based on https://github.com/ericfreese/zsh-cwd-history ((C) Eric Freese / MIT)
#
# This implementation just switches and loads HIST_FILE on `cd`,
# and does nothing further. This avoids reimplementation of
# history-management mechanism and leaves most of the work to the zsh.
#
# Limitation: no global/local toggle feature.

HISTORY_BASEDIR="$HOME/.zsh_directory_history"

_zsh_directory_history_file_name () {
    echo "$HISTORY_BASEDIR/$(echo "${PWD:A}" | md5 -q)"
}

# Switch to a new history file, writing to the old one
_zsh_directory_history_switch_histfile () {
    local new_histfile=$1

    # Write old histfile
    fc -P

    # Read new histfile
    fc -p "$new_histfile"
}

# Load history for current working directory when changing dirs
_zsh_directory_history_directory_changed () {
    _zsh_directory_history_switch_histfile $(_zsh_directory_history_file_name)
}

# Simulate initial chpwd (this runs just once per a session)
_zsh_directory_history_initialize () {
    _zsh_directory_history_directory_changed
    add-zsh-hook -d precmd _zsh_directory_history_initialize
}

mkdir -p "$HISTORY_BASEDIR"

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _zsh_directory_history_directory_changed
add-zsh-hook precmd _zsh_directory_history_initialize
