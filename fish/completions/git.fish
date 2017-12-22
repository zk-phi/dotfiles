source "/usr/local/share/fish/completions/git.fish"

# Overwrite __fish_git_branches and __fish_git_unique_remote_branches
# NOT to TAB-complete remote branch names

function __fish_git_branches
    command git branch --no-color $argv ^/dev/null | string match -r -v ' -> ' | string trim -c "* " | string replace -r "^remotes/" ""
end

function __fish_git_unique_remote_branches
end
