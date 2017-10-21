# functions
function cdl () {
    cd "$@" && ls
}

function zsh-load-benchmark() {
    for i in $(seq 1 10); do
        /usr/bin/time zsh -i -c exit
    done
}

function bash-load-benchmark() {
    for i in $(seq 1 10); do
        /usr/bin/time bash -i -c exit
    done
}
