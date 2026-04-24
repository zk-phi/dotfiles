# Start sandboxed shell powerd by Apple Seatbelt.

# see also https://www.mizdra.net/entry/2025/12/01/121805

function sb () {
    if [[ "$RESTRICTED_SHELL" == "1" ]]; then
        echo "sb: Sandbox already started."
    else
        RESTRICTED_SHELL=1 sandbox-exec -f "$HOME/.zsh.d/plugins/zsh-sandbox/restricted-shell.sb" -D RSH_ROOT="$(pwd)" -D HOME="$HOME" "$SHELL"
        # Update history
        fc -R
        # Restore current directory
        cd "$(</tmp/rsh-pwd)"
    fi
}

function sbro () {
    if [[ "$RESTRICTED_SHELL" == "1" ]]; then
        echo "sbro: Sandbox already started."
    else
        RESTRICTED_SHELL=1 sandbox-exec -f "$HOME/.zsh.d/plugins/zsh-sandbox/restricted-readonly-shell.sb" -D RSH_ROOT="$(pwd)" -D HOME="$HOME" "$SHELL"
        # Update history
        fc -R
        # Restore current directory
        cd "$(</tmp/rsh-pwd)"
    fi
}

function _exit_sb () {
    if [[ "$RESTRICTED_SHELL" == "1" ]]; then
        pwd > /tmp/rsh-pwd
    fi
}

function sb-log () {
    sudo log stream --predicate 'sender == "Sandbox"' | grep deny
}

autoload -Uz add-zsh-hook
add-zsh-hook zshexit _exit_sb
