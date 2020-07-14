function g.remote-to-ssh --description 'git swap remote origin from https to ssh'
    set -l funcname (status function)
    set -l remote (string split \t (git remote -v))
    set -l remoteurl (string split ' ' $remote[2])[1]
    set -l giturl (string match -r '^(git|https)(?:@|://)(.+)[:/]([^/]+)/(.+?)(?:\.git)?$' $remoteurl)
    if test -z "$giturl"
        echo "$funcname: git url not found or not correct: $remoteurl" >&2
        return 1
    end
    set -l newremoteurl "git@"$giturl[3]":"$giturl[4]"/"$giturl[5]".git"
    git remote set-url origin $newremoteurl
end
