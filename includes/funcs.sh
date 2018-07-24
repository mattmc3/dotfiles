# functions
zsh-benchmark () {
    for i in $(seq 1 10); do
        /usr/bin/time zsh -i -c exit
    done
}

bash-benchmark () {
    for i in $(seq 1 10); do
        /usr/bin/time bash -i -c exit
    done
}

echoerr () { echo "$@" 1>&2; }

# use keychain to store passwords
get_pw () {
    # https://www.netmeister.org/blog/keychain-passwords.html
    # security find-generic-password -ga "$1" -w
    security find-generic-password -a ${USER} -s "$1" -w
}

### golang ###
resetgopath () {
    export GOPATH=$GLOBALGOPATH
    echo $GOPATH
}

setgopath () {
    export GOPATH="$(pwd)"
    echo $GOPATH
}

goinit () {
    mkdir pkg bin src
    setgopath
    mkdir src/$(basename $PWD)
    cd src/$(basename $PWD)
    te .
}


### python ###
workon () {
    source "$WORKON_HOME/$@/bin/activate"
}

pyclean () {
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
}

pip3update () {
    # the --outdated flag didn't give me everything :(
    pip3 list --format=freeze | awk -F"==" '{print $1}' | xargs -n1 pip3 install --upgrade
}

pip2update () {
    # the --outdated flag didn't give me everything :(
    pip2 list --format=freeze | awk -F"==" '{print $1}' | xargs -n1 pip2 install -U
}
