# git
alias g.resolve='git mergetool -t diffmerge .'
alias g.log="git log --pretty=oneline --abbrev-commit"
alias g.rollback="git reset --hard HEAD~1"
alias g.status-all="__git_status_all"
alias g.add-all="git add -A ."

function __git_status_all () {
    for gitdir in `find ./ -name .git`; 
    do
        workdir=${gitdir%/*}; 
        echo; 
        echo $workdir; 
        git --git-dir=$gitdir --work-tree=$workdir status; 
    done
}
