function mand -d 'Open a specified man page in Dash.app' -a cmd
    if not set -q cmd
        echo "Usage: mand <manpage>" >&2
        return 1
    end

    set dashcmd "dash://manpages:$cmd"
    set cmdtype (eval type $cmd)
    if test "$cmdtype" = "$cmd is a builtin"
        set dashcmd "dash://fish:$cmd"
    end

    open "$dashcmd" 2>/dev/null
    if test $status -ne 0
        echo "Dash is not installed." >&2
        return 2
    end
end
