function g.unstage -d 'Unstage current files'
    git reset -- $argv
end
