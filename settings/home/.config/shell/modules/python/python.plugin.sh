# python

alias juno="jupyter notebook"

# my virtualenvwrapper replacement
export WORKON_HOME=~/.virtualenvs
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
