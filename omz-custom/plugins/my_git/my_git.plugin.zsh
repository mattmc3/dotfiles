
show_gdot=${GIT_SHOW_GDOT_CMD:-true}

function __run_git_cmd() {
    local _cmd=$1
    if [[ show_gdot ]]; then
        echo $_cmd
    fi
    eval $_cmd
}

function g.status-all() {
    for gitdir in `find ./ -name .git`; do
        workdir=${gitdir%/*};
        echo;
        echo $workdir;
        git --git-dir=$gitdir --work-tree=$workdir status;
    done
}

function g.resolve() {
    __run_git_cmd "git mergetool -t diffmerge ."
}

function g.log() {
    __run_git_cmd "git log --pretty=oneline --abbrev-commit"
}

function g.log-view-graph() {
    __run_git_cmd "git log --graph --oneline --decorate --all"
}

function g.log-view-changed-files() {
    __run_git_cmd "git log --name-status"
}

function g.status() {
    __run_git_cmd "git status"
}

function g.add-update-staging-index() {
    # -A option no longer needed after git v2
    __run_git_cmd "git add ."
}

function g.rollback() {
    __run_git_cmd "git reset --hard HEAD~1"
}

function g.undo() {
    __run_git_cmd "git reset --soft HEAD~1"
}

function g.clone() {
    if [ ! -n "$1" ]; then
        echo "No git host specified (ie: github.com, bitbucket.org, etc)" 1>&2
    elif [ ! -n "$2" ]; then
        echo "No repo specified (ie: username/repo.git)" 1>&2
    else
        __run_git_cmd "git clone git@$1:$2.git $3"
    fi
}

function g.clone-https() {
    if [ ! -n "$1" ]; then
        echo "No https URL specified (ie: http://github.com/mattmc3/dotfiles.git)" 1>&2
    else
        __run_git_cmd "git clone $1 $2"
    fi
}

function g.config-user-email() {
    if [ ! -n "$1" ]; then
        echo "No email specified" 1>&2
    else
        __run_git_cmd "git config user.email \"$1\""
    fi
}

function g.config-user-name() {
    if [ ! -n "$1" ]; then
        echo "No name specified" 1>&2
    else
        __run_git_cmd "git config user.name \"$1\""
    fi
}

function g.commit-and-push() {
    __run_git_cmd "git add ."
    if [ -n "$1" ]; then
        __run_git_cmd "git commit -am \"$1\""
    else
        __run_git_cmd "git commit"
    fi
    __run_git_cmd "git push"
}

function g.checkout-new-branch-and-push() {
    if [ ! -n "$1" ]; then
        echo "FAIL: No branch name specified" 1>&2
    else
        __run_git_cmd "git checkout -b \"$1\""
        __run_git_cmd "git push --set-upstream origin \"$1\""
    fi
}

function g.delete-branch() {
    if [ ! -n "$1" ]; then
        echo "FAIL: No branch name specified" 1>&2
    else
        __run_git_cmd "git push origin --delete \"$1\""
        __run_git_cmd "git branch -D \"$1\""
    fi
}

function g.checkpoint() {
    __run_git_cmd "git add . && git commit -am 'checkpoint' && git push"
}
