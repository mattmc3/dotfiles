def _clone(args):
    """Clone a git repo"""
    if not args or len(args) < 1:
        echo "What git repo do you want?" out>err
        return 1

    # repo
    repo = args[0]
    if '/' in repo:
        user, repo = repo.split('/')
    else:
        user = $(git config user.name).strip()

    # git url
    giturl = "github.com"
    if len(args) >= 2:
        giturl = args[1]

    # projects location
    if 'XDG_PROJECTS_HOME' in ${...}:
        projects_home = fp"{$XDG_PROJECTS_HOME}"
    else:
        projects_home = p"~/Projects"

    # check if dest dir exists
    dest_dir = projects_home / user / repo
    if dest_dir.exists():
        echo @(f"No need to clone, that directory already exists: {dest_dir}") out>err
        cd @(dest_dir)
    else:
        dest_dir.parent.mkdir(parents=True, exist_ok=True)
        git -C @(dest_dir.parent) clone @(f"git@{giturl}:{user}/{repo}")
    cd @(dest_dir)

aliases['clone'] = _clone
