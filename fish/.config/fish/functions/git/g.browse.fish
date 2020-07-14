function g.browse -d 'Open the browser to go to the git web site'
    # git alias
    # ! f() { URL=$(git config remote.${1-origin}.url | sed -e 's#^.*@#https://#' -e 's#.git$##' -e 's#:#/#2'); git web--browse $URL; } f
    if test (count $argv) -eq 0
        set argv[1] "origin"
    end
    set gitremote (git config remote.$argv.url)
    set gitremote (string replace -r '\.git$' '' $gitremote)
    set gitremote (string replace -r '^git@(.+):' 'https://$1/' $gitremote)
    git web--browse $gitremote
end
