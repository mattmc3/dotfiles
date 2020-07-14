function juno --description 'Shorthand for jupyter notebook'
    set junopath $argv
    if test (count $argv) = 0; and set -q JUPYTER_PROJECT_DIR; and test -d "$JUPYTER_PROJECT_DIR"
        set junopath $JUPYTER_PROJECT_DIR
    end
    jupyter notebook $junopath
end
