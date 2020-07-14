function g.branch-clean -d 'Cleans all merged branches'
    # git alias: bclean = "!f() { git checkout ${1-master} && git branch --merged ${1-master} | grep -v " ${1-master}$" | xargs git branch -d; }; f"
    if test (count $argv) -eq 0
        set argv[1] "master"
    end
    git checkout $argv[1]; and git branch --merged $argv[1] | grep -v $argv[1] | xargs git branch -d
end
