function dottyloc --description 'dotfiles local bare git repo'
    GIT_WORK_TREE=~ GIT_DIR=~/.dotfiles.local $argv
end
