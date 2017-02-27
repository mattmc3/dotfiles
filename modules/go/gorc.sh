# go
export GLOBALGOPATH=$HOME/.go
export GOPATH=$GLOBALGOPATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin # Add GOPATH/bin to PATH for scripting

function resetgopath () {
    export GOPATH=$GLOBALGOPATH
    echo $GOPATH
}

function setgopath () {
    export GOPATH="$(pwd)"
    echo $GOPATH
}

function goinit () {
    mkdir pkg bin src
    setgopath
    mkdir src/$(basename $PWD)
    cd src/$(basename $PWD)
    te .
}
