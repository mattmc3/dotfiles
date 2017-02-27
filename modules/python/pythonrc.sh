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

pip3upgrade () {
    pip3 list --outdated | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade
}
