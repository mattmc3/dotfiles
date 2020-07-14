function g.checkpoint -d 'Add a checkpoint commit'
    git add -A; and git commit -m "Checkpoint "(date -u +'%Y-%m-%dT%H:%M:%SZ')
end
