function g.submodule-rm --description 'git submodule removal'
    set -l funcname (status function)
    if test (count $argv) -lt 1
        echo "$funcname: Expecting path to submodule" >&2
        return 1
    else if test ! -d "./.git/modules/$argv[1]"
        echo "$funcname: Expecting to find submodule path in .git/modules" >&2
        return 1
    else if test ! -d "./$argv[1]"
        echo "$funcname: Expecting to find submodule in project path" >&2
        return 1
    end
    git submodule deinit -f "$argv[1]"
    rm -rf "./.git/modules/$argv[1]"
    git rm "./$argv[1]"
end
