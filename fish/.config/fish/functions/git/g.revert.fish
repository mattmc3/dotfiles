function g.revert --description "Stash and reset hard"
    git stash; and git reset --hard
end
