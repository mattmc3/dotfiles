### XDG variables
$XDG_CACHE_HOME = f"{$HOME}/.cache"
$XDG_DESKTOP_DIR = f"{$HOME}/Desktop"
$XDG_DOCUMENTS_DIR = f"{$HOME}/Documents"
$XDG_DOWNLOAD_DIR = f"{$HOME}/Downloads"
$XDG_MUSIC_DIR = f"{$HOME}/Music"
$XDG_PICTURES_DIR = f"{$HOME}/Pictures"
$XDG_VIDEOS_DIR = f"{$HOME}/Videos"
$XDG_PROJECTS_DIR = f"{$HOME}/Projects"

### path
_my_paths = [
    # user bins
    p'~/bin',

    # override bins
    p'/opt/homebrew/bin',
    p'/opt/homebrew/sbin',
    p'/usr/local/bin',
    p'/usr/local/sbin',

    # system bins
    p'/usr/bin',
    p'/bin',
    p'/usr/sbin',
    p'/sbin',

    # golang bins
    p'/usr/local/opt/go/libexec/bin',
    p'~/Projects/golang/bin',

    # emacs bins
    p'~/.emacs.d/bin',
    p'~/.config/emacs/bin',
    p'~/.config/emacs.doom/bin',

    # node.js bins
    p'/usr/local/share/npm/bin',

    # ruby bins
    p'/usr/local/opt/ruby/bin',
]
for _p in reversed(_my_paths):
    if _p.is_dir() and _p not in $PATH:
        $PATH.insert(0, _p)

### history
$XONSH_HISTORY_BACKEND = 'sqlite'

### variables
$DOTFILES=p"~/.config/dotfiles"

### colors and styles
$XONSH_COLOR_STYLE = 'stata-dark'

### prompt
$STARSHIP_CONFIG = fp"$DOTFILES/config/starship/xonsh.toml"
execx($(starship init xonsh))

### functions
def _up(args):
    """Go up any number of directories"""
    if not args or len(args) < 1:
        args = [1]
    balloons = ('../' * int(args[0]))
    cd @(balloons)

def _juno(args):
    """Jupyter notebook"""
    if not args or len(args) < 1:
        args = ["~/Projects/jupyter"]
    jupyter notebook @(args[0])

def _xbench(args):
    """Benchmark xonsh by running it 10 times"""
    for i in range(10):
        /usr/bin/time xonsh -c "exit" > /dev/null

def describe(fn):
    """Describe a function"""
    import inspect
    print(inspect.getsource(fn))

### aliases
_my_aliases = {
    # shadow built-ins
    'grep': 'grep --color=auto --exclude-dir="{.git,.vscode}"',
    'ls': 'ls -G',

    # shortcuts
    'hist': 'history show all | less',
    'clr': 'clear',
    'l': 'ls -G',
    'la': 'ls -lAfh',
    'll': 'ls -lGh',
    'ldot': 'ls -ld .*',

    # macos
    'brewup': 'brew update && brew upgrade',
    'xshrc': 'nvim ~/.config/xonsh/xsh.rc',

    # misc
    'zz': 'exit',
    'nv': 'nvim',
    'xsh': 'xonsh',

    # quick dirs
    'proj': 'cd ~/Projects',
    'dotf': 'cd $DOTFILES',
    'dotfl': 'cd $DOTFILES.local',
    'bdot': 'cd ~/.config/bash',
    'fdot': 'cd ~/.config/fish',
    'xdot': 'cd ~/.config/xonsh',
    'zdot': 'cd ~/.config/zsh',

	# function aliases
	'up': _up,
	'xbench': _xbench,
}
aliases.update(_my_aliases)


### xontribs
_xontribs = [
    'default_cmd',
    'up',
]
if _xontribs:
    xontrib load @(_xontribs)
