# ------------------------------
# prompt
# ------------------------------

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
