function g.add-remote -d 'Add secondary pushurl remote to existing repo'
    set new_remote $argv
    set cur_remote (git config --get remote.origin.url)

    if [ -z $new_remote ]
        echo "Expecting new remote argument" 1>&2
        return 1
    end
    if [ -z $cur_remote ]
        echo "Cannot find existing remote URL for repo" 1>&2
        return 1
    end
    git remote set-url origin --push --add $new_remote
    git remote set-url origin --push --add $cur_remote
    git remote -v
    echo "If everything looks right, run 'git push'. If not, git config -e"
end
