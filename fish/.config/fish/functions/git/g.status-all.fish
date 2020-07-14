function g.status-all --description "Show the status of all git project subdirectories"
    [ -n "$argv" ]; or set argv '.'
    cd "$argv"
    for gitdir in (find . -type d -name .git)
        set workdir (dirname $gitdir)
        echo $workdir
        git --git-dir=$gitdir --work-tree=$workdir status -sb
        echo
    end
end
