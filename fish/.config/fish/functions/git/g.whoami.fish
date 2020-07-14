function g.whoami -d 'Show the current git user info'
    echo "user.name:" (git config user.name)
    echo "user.email:" (git config user.email)
end
