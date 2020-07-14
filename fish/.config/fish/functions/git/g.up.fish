function g.up --description "git pull with rebase, prune, and submodule updates"
    git pull --rebase --prune $argv; and git submodule update --init --recursive
end
