function g.branch-push-upstream -d 'Push a new branch to the upstream remote'
    git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
end
