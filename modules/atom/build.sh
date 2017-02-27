# atom
if which -s apm ; then
    echo "genertating atom package list..."
    apm list --installed --bare > $DOTFILES/modules/atom/apmfile.txt
    apm list > $DOTFILES/modules/atom/apm-list-raw.txt
fi
