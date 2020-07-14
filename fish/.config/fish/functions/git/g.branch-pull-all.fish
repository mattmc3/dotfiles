function g.branch-pull-all -d 'Pull all branches from the remote'
    git branch -a | sed -n "/\/HEAD /d; /\/master\$/d; /remotes/p;" | xargs -L1 git checkout -t
end
