function g.branch-name -d 'Show name of current branch'
    git rev-parse --abbrev-ref HEAD
end
