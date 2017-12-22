function fish_prompt
    # last errorno
    if [ $status -eq 0 ]
        set status_face (set_color normal)"（*'-'）? "
    else
        set status_face (set_color red)"（`;w;）! "(set_color normal)
    end

    # pwd
    if [ $HOME = $PWD ]
        set pwd "~"
    else
        set pwd (set_color cyan -o)(basename $PWD)
    end

    # git info
    if git_repository_root > /dev/null
        set branch_name (set_color red -o)(git_branch_name)
        if git_is_touched
            set dirty "☁️ "
        else
            set dirty "✨ "
        end
        if git_is_stashed
            set stash " 📃"
        else
            set stash ""
        end
        set git_prompt (set_color normal)" git:("$branch_name$dirty(set_color normal)")"$stash
    else
        set git_prompt ""
    end

    echo $pwd$git_prompt $status_face
end
