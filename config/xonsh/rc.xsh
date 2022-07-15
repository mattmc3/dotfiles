### XDG variables
$XDG_CONFIG_HOME = f"{$HOME}/.config"
$XDG_DATA_HOME   = f"{$HOME}/.local/share"
$XDG_CACHE_HOME  = f"{$HOME}/.cache"
$XDG_RUNTIME_DIR = f"{$HOME}/.xdg"

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
$XONSH_HISTORY_FILE = f"{$XDG_DATA_HOME}/xonsh/xonsh-history.sqlite"
$XONSH_HISTORY_BACKEND = 'sqlite'

### variables
$DOTFILES = p"~/.config/dotfiles"
$IWD = $PWD

### colors and styles
$XONSH_COLOR_STYLE = 'stata-dark'

### colored man page support
# using 'less' env vars (format is '\E[<brightness>;<colour>m')
$LESS_TERMCAP_mb = "\033[01;31m"     # begin blinking
$LESS_TERMCAP_md = "\033[01;31m"     # begin bold
$LESS_TERMCAP_me = "\033[0m"         # end mode
$LESS_TERMCAP_so = "\033[01;44;36m"  # begin standout-mode (bottom of screen)
$LESS_TERMCAP_se = "\033[0m"         # end standout-mode
$LESS_TERMCAP_us = "\033[00;36m"     # begin underline
$LESS_TERMCAP_ue = "\033[0m"         # end underline

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

$XONSH_FUNC_DIR = pf'{$XONSH_CONFIG_DIR}/functions'
for f in pg`$XONSH_FUNC_DIR/*.xsh`:
    if not f.is_dir():
        source @(f)

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
    'iwd': 'cd $IWD',
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
# xpip install xontrib-whatever
_xontribs = [
    'default_command',
    'up',
    'omx_macos',
]
if _xontribs:
    xontrib load @(_xontribs)
