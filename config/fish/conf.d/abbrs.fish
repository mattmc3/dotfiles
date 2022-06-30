set -q _abbrs_initialized && exit || set -U _abbrs_initialized true

abbr -a -U -- - 'cd -'
abbr -a -U -- nv nvim
abbr -a -U -- up 'cd ..'
abbr -a -U -- tarls 'tar -tvf'
abbr -a -U -- untar 'tar -xv'
abbr -a -U -- zz exit

# single key
abbr -a -U -- c clear
abbr -a -U -- h history
abbr -a -U -- l 'ls -UF'

# better ls
abbr -a -U -- la 'ls -la'
abbr -a -U -- ldot 'ls -ld .*'
abbr -a -U -- ll 'ls -lGFh'
abbr -a -U -- lsa 'ls -aGF'

# quick nav
abbr -a -U -- fconf 'cd $__fish_config_dir'
abbr -a -U -- fishconf 'cd $__fish_config_dir'
abbr -a -U -- fdot 'cd $__fish_config_dir'
abbr -a -U -- zdot 'cd $ZDOTDIR'

# date/time
abbr -a -U -- ds 'date +%Y-%m-%d'
abbr -a -U -- ts 'date +%Y-%m-%dT%H:%M:%SZ'
abbr -a -U -- yyyymmdd 'date +%Y%m%d'

# git
# abbr -a -U -- gad 'git add'
# abbr -a -U -- gbn 'git rev-parse --abbrev-ref HEAD'
# abbr -a -U -- gcl 'git clean'
# abbr -a -U -- gcmt 'git commit -am '
# abbr -a -U -- gco 'git checkout'
# abbr -a -U -- gcob 'git checkout -b '
# abbr -a -U -- gcod 'git checkout develop'
# abbr -a -U -- gcom 'git checkout master'
# abbr -a -U -- get git
# abbr -a -U -- glg 'git log'
# abbr -a -U -- glog git\ log\ --Uraph\ --pretty=\'\%Cred\%h\%Creset\ -\%C\(auto\)\%d\%Creset\ \%s\ \%Cgreen\(\%ad\)\ \%C\(bold\ blue\)\<\%an\>\%Creset\'\ --date=short
# abbr -a -U -- gpll 'git pull'
# abbr -a -U -- gpristine 'git reset --hard && git clean -fdx'
# abbr -a -U -- gpsh 'git push'
# abbr -a -U -- gpsuo 'git push --set-Upstream origin (git rev-parse --abbrev-ref HEAD)'
# abbr -a -U -- grm 'git rm'
# abbr -a -U -- grv 'git remote -v'
# abbr -a -U -- gsh 'git stash'
# abbr -a -U -- gst 'git status -sb'
abbr -a -U -- gclone 'git clone git@github.com:mattmc3/'
abbr -a -U -- gwhoami 'echo "user.name:" (git config user.name) && echo "user.email:" (git config user.email)'

# golang
abbr -a -U -- gob 'go build'
abbr -a -U -- goc 'go clean'
abbr -a -U -- god 'go doc'
abbr -a -U -- gof 'go fmt'
abbr -a -U -- gofa 'go fmt ./...'
abbr -a -U -- gog 'go get'
abbr -a -U -- goi 'go install'
abbr -a -U -- gol 'go list'
abbr -a -U -- gop 'cd $GOPATH'
abbr -a -U -- gopb 'cd $GOPATH/bin'
abbr -a -U -- gops 'cd $GOPATH/src'
abbr -a -U -- gor 'go run'
abbr -a -U -- got 'go test'
abbr -a -U -- gov 'go vet'
