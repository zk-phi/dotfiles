# see also https://github.com/antfu-collective/ni ((C) Anthony Fu / MIT)
# see also https://github.com/azu/ni.zsh ((C) azu / MIT)

function _ni_get_firewall_cmd () {
    if which sfw > /dev/null; then
        echo "sfw "
    else
        echo ""
    fi
}

function _ni_detect_package_manager () {
    local cwd=${1:-$(pwd)}

    if [ -f "${cwd}/deno.lock" ] || [ -f "${cwd}/deno.json" ]; then
        echo "deno"
    elif [ -f "${cwd}/pnpm-lock.yaml" ]; then
        echo "pnpm"
    elif [ -f "${cwd}/bun.lock" ] || [ -f "${cwd}/bun.lockb" ]; then
        # choose bun if both bun.lockb and yarn.lock exist
        # bun generate yarn.lock and bun.lockb when print=yarn is set
        # https://bun.sh/docs/install/lockfile
        echo "bun"
    elif [ -f "${cwd}/yarn.lock" ]; then
        echo "yarn"
    elif [ -f "${cwd}/package-lock.json" ]; then
        echo "npm"
    else
        # search parents recursively
        local parentDir=$(dirname "$cwd")
        if [[ "$parentDir" == "/" ]]; then
            # use npm as default
            echo "npm"
            return
        fi
        echo $(_ni_detect_package_manager "$parentDir")
    fi
}

function _ni_ni () {
    local manager=$(_ni_detect_package_manager)
    case $manager in
        npm)
            echo "$(_ni_get_firewall_cmd)npm install "
            ;;
        yarn)
            echo "$(_ni_get_firewall_cmd)yarn install "
            ;;
        pnpm)
            echo "$(_ni_get_firewall_cmd)pnpm install "
            ;;
        bun)
            echo "$(_ni_get_firewall_cmd)bun install "
            ;;
        deno)
            echo "$(_ni_get_firewall_cmd)deno install "
            ;;
    esac
}

function _ni_na () {
    local manager=$(_ni_detect_package_manager)
    case $manager in
        npm)
            echo "$(_ni_get_firewall_cmd)npm install "
            ;;
        yarn)
            echo "$(_ni_get_firewall_cmd)yarn add "
            ;;
        pnpm)
            echo "$(_ni_get_firewall_cmd)pnpm add "
            ;;
        bun)
            echo "$(_ni_get_firewall_cmd)bun add "
            ;;
        deno)
            echo "$(_ni_get_firewall_cmd)deno add npm:"
            ;;
    esac
}

function _ni_nad () {
    local manager=$(_ni_detect_package_manager)
    case $manager in
        npm)
            echo "$(_ni_get_firewall_cmd)npm install -D "
            ;;
        yarn)
            echo "$(_ni_get_firewall_cmd)yarn add -D "
            ;;
        pnpm)
            echo "$(_ni_get_firewall_cmd)pnpm add -D "
            ;;
        bun)
            echo "$(_ni_get_firewall_cmd)bun add -d "
            ;;
        deno)
            echo "$(_ni_get_firewall_cmd)deno add -D npm:"
            ;;
    esac
}

function _ni_nr () {
    echo "$(_ni_detect_package_manager) run "
}

function _ni_nup () {
    local manager=$(_ni_detect_package_manager)
    case $manager in
        npm)
            echo "$(_ni_get_firewall_cmd)npm upgrade "
            ;;
        yarn)
            echo "$(_ni_get_firewall_cmd)yarn upgrade "
            ;;
        pnpm)
            echo "$(_ni_get_firewall_cmd)pnpm update "
            ;;
        bun)
            echo "$(_ni_get_firewall_cmd)bun update "
            ;;
        deno)
            echo "$(_ni_get_firewall_cmd)deno outdated --update "
            ;;
    esac
}

function _ni_nu () {
    local manager=$(_ni_detect_package_manager)
    case $manager in
        npm)
            echo "npm uninstall "
            ;;
        yarn)
            echo "yarn remove "
            ;;
        pnpm)
            echo "pnpm remove "
            ;;
        bun)
            echo "bun remove "
            ;;
        deno)
            echo "deno uninstall npm:"
            ;;
    esac
}

function _ni_ne () {
    local manager=$(_ni_detect_package_manager)
    case $manager in
        npm)
            echo "npm exec "
            ;;
        yarn)
            echo "yarn exec "
            ;;
        pnpm)
            echo "pnpm exec "
            ;;
        bun)
            echo "bunx "
            ;;
        deno)
            echo "ne "
            ;;
    esac
}

function _ni_nx () {
    local manager=$(_ni_detect_package_manager)
    case $manager in
        npm)
            echo "npx "
            ;;
        yarn)
            echo "yarn dlx "
            ;;
        pnpm)
            echo "pnpm dlx "
            ;;
        bun)
            echo "bunx "
            ;;
        deno)
            echo "nx "
            ;;
    esac
}

function _ni_nd () {
    local manager=$(_ni_detect_package_manager)
    case $manager in
        npm)
            echo "npm dedupe "
            ;;
        yarn)
            echo "yarn dedupe "
            ;;
        pnpm)
            echo "pnpm dedupe "
            ;;
        bun)
            echo "nd "
            ;;
        deno)
            echo "nd "
            ;;
    esac
}

function _ni_nci () {
    local manager=$(_ni_detect_package_manager)
    case $manager in
        npm)
            echo "npm ci "
            ;;
        yarn)
            echo "yarn install --frozen-lockfile "
            ;;
        pnpm)
            echo "pnpm install --frozen-lockfile "
            ;;
        bun)
            echo "bun install --frozen-lockfile "
            ;;
        deno)
            echo "deno cache --reload "
            ;;
    esac
}

if whence abbrev-alias > /dev/null; then
    abbrev-alias -e ni='$(_ni_ni)'
    abbrev-alias -e na='$(_ni_na)'
    abbrev-alias -e nad='$(_ni_nad)'
    abbrev-alias -e nr='$(_ni_nr)'
    abbrev-alias -e nup='$(_ni_nup)'
    abbrev-alias -e nu='$(_ni_nu)'
    abbrev-alias -e ne='$(_ni_ne)'
    abbrev-alias -e nx='$(_ni_nx)'
    abbrev-alias -e nd='$(_ni_nd)'
    abbrev-alias -e nci='$(_ni_nci)'
else
    echo "[zsh-ni] This plugin requires zsh-abbrev-alias plugin to work."
fi
