function dotty --description 'dotfiles bare git repo'
    GIT_WORK_TREE=~ GIT_DIR=~/.dotfiles $argv
    #git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv
end
