def _prj(args):
    """Project Jump: quickly find a project and cd into it"""
    # make sure we have the fzf utility
    if !(command -v fzf).returncode != 0:
        echo "fzf command not found" out>err
        return 1

    # determine the project home
    if 'PROJECTS' in ${...}:
        prjhome = pf'{$PROJECTS}'.resolve()
    else:
        prjhome = p'~/Projects'.resolve()

    if not prjhome.exists():
        echo @(f"Project home directory not found '{prjhome}'") out>err
        return 1

    # collect all project folders
    projects = [str(f.parent.relative_to(prjhome))
                for f in pfg`{prjhome}/*/*/.git`]
    query = " ".join(args)
    selection = $(echo @("\n".join(projects)) | sort | fzf --layout=reverse-list --query=@(query))
    if selection:
        selection = selection.strip()
        print(f"Taking you to {selection}...")
        dirname = prjhome / selection
        cd @(dirname)
    else:
        return 1

aliases['prj'] = _prj
