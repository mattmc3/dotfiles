function g.commit -d 'Commits to the repo with a message'
    if [ (count $argv) -eq 0 ]
        echo "Usage g.commit '<commit-message>'" >&2
        return 1
    end
    git commit -am "$argv"
end
