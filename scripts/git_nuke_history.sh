# http://stackoverflow.com/questions/13716658/how-to-delete-all-commit-history-in-github

echo "Whoa there cap'n! There be dragons" 1>&2
exit 1

# Checkout
git checkout --orphan latest_branch

# Add all the files
git add -A

# Commit the changes
git commit -am "initial commit"

# Delete the branch
git branch -D master

# Rename the current branch to master
git branch -m master

# Finally, force update your repository
git push -f origin master
