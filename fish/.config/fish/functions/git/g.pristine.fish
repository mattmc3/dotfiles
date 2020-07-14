function g.pristine -d 'Restore your repo to freshly cloned state'
    git reset --hard; and git clean -fdx
end
