function g.clone -d 'Clones a repo'
    set usage "usage - g.clone <protocol?>/<url?>/<user?>/<repo> <rest>..."
    if [ -z "$argv" ]
        echo "Missing argument: " >&2
        echo "$usage" >&2
        return 1
    end

    set repo_parts (string split "/" "$argv[1]")

    if test (count $repo_parts) -lt 3
        and begin
            [ -z "$GIT_DEFAULT_USERNAME" ]
            or [ -z "$GIT_DEFAULT_URL" ]
        end
        echo "Defaults not set for GIT_DEFAULT_URL/GIT_DEFAULT_USERNAME" >&2
        echo "usage - g.clone <protocol> <url> <user> <repo>" >&2
        return 1
    end

    # fill out repo_parts to 4 elements: ie: git github.com mattmc3 fish-gitdot
    test (count $repo_parts) -gt 2; or set repo_parts $GIT_DEFAULT_USERNAME $repo_parts
    test (count $repo_parts) -gt 3; or set repo_parts $GIT_DEFAULT_URL $repo_parts
    test (count $repo_parts) -eq 4; or set repo_parts "ssh" $repo_parts

    # expand abbreviations
    switch $repo_parts[2]
        case 'bb'
            set repo_parts[2] "bitbucket.org"
        case 'gh'
            set repo_parts[2] "github.com"
        case 'gl'
            set repo_parts[2] "gitlab.com"
    end

    # complete url
    # git@gitsite.com:user/repo.git
    # https://gitsite.com/user/repo.git
    switch $repo_parts[1]
        case 'ssh'
            set repo_parts[2] "git@$repo_parts[2]:"
        case 'git'
            set repo_parts[2] "git@$repo_parts[2]:"
        case '*'
            set repo_parts[2] "https://$repo_parts[2]/"
    end

    # remove .git suffix
    set repo_parts[4] (string replace -i -r '\.git$' '' $repo_parts[4])

    # echo "git clone $repo_parts[2]$repo_parts[3]/$repo_parts[4].git $argv[2..-1]"
    git clone $repo_parts[2]$repo_parts[3]/$repo_parts[4].git $argv[2..-1]
    if test (count $argv) -ge 2
        and [ -d $argv[2] ]
        cd $argv[2]
    else if [ -d $repo_parts[4] ]
        cd $repo_parts[4]
    end
end
