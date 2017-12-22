# No package managers are used in this configuration.
# To install packages, simply clone it in the "plugins" directory.
#
# ex.
# > cd ~/.congfig/fish/plugins
# > git clone git@github.com:ryotako/fish-global-abbreviation.git

# -----------------------------------------------
# directories
# -----------------------------------------------

# path to executables
set -x PATH $HOME/perl5/bin $HOME/.ndenv/bin $PATH

# path to plugins
for plugin in (ls $HOME/.config/fish/plugins)
    set fish_function_path $HOME/.config/fish/plugins/$plugin $fish_function_path
    set fish_function_path $HOME/.config/fish/plugins/$plugin/functions $fish_function_path
    set fish_complete_path $HOME/.config/fish/plugins/$plugin/completions $fish_complete_path
end

# -----------------------------------------------
# basic
# -----------------------------------------------

set fish_greeting ""

# -----------------------------------------------
# language-specific settings
# -----------------------------------------------

# perl
set -x PERL_CPANM_OPT "--local-lib=$HOME/perl5"
set -x PERL5LIB $HOME/perl5/lib/perl5:$PERL5LIB
. (plenv init - fish | psub)

# ruby
. (rbenv init - fish | psub)

# node
# ====
# branch "master" of ndenv does not support fish (at least at
# 2017/12/22) and checkingout PR #14 is required before starting the
# fish shell
. (ndenv init - fish | psub)

# -----------------------------------------------
# plugins
# -----------------------------------------------

# fish-global-abbreviation
# https://github.com/ryotako/fish-global-abbreviation
if type -t gabbr > /dev/null
    gabbr G '| grep'
    gabbr L '| less'
    gabbr --function B "git symbolic-ref --short HEAD"
end

# bass
# https://github.com/edc/bass

# git_util
# https://github.com/fisherman/git_util

# -----------------------------------------------
# abbrevs
# -----------------------------------------------

# git
abbr ga='git add'
abbr gc='git commit'
abbr gco='git checkout'
abbr gb='git branch'
abbr gd='git diff'
abbr gs='git diff --staged'
abbr gl='git log'
abbr glog='git log --oneline --decorate --graph'
abbr gr='git reset'
abbr gst='git status'

# typos
abbr gti='git'
abbr igt='git'
abbr sl='ls'
abbr sls='ls'

# use git-like diff if colordiff is available
if which colordiff > /dev/null
    function diff
        colordiff -u $argv | less
    end
else
    echo "[.zshrc] colordiff is unavailable."
end
