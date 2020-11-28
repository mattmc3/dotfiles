# just execute 'ZPROF=1 zsh' to run 'zprof' to get the performance details
[[ $ZPROF -ne 1 ]] || zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${ZDOTDIR:-$HOME}/.oh-my-zsh"
if [[ ! -d "$ZSH" ]]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git --depth=1 "$ZSH"
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="refined"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="${ZDOTDIR:-$HOME}/.zsh_custom"
if [[ ! -d "$ZSH_CUSTOM" ]]; then
  git clone git@github.com:mattmc3/zsh_custom --recursive "$ZSH_CUSTOM"
fi

# Other OMZ variables
ZSH_DISABLE_COMPFIX=true
ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # first
  xdg

  # omz
  colored-man-pages
  copydir
  copyfile
  extract
  history
  sublime
  z

  # custom
  aliases
  autosuggestions
  brew
  cd-ls
  completions
  dotfiles
  gitdot
  golang
  history-substring-search
  iwd
  java
  jupyter
  lpass
  osx
  python
  safe-rm
  tmux
  todo-txt
  up
  zfunctions

  # last
  setopts
  fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
export VISUAL='code'

# set other stuff
export TZ="America/New_York"
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_ALL="en_US.UTF-8"

export CLICOLOR="1"
export LSCOLORS="ExfxcxdxbxGxDxabagacad"
export PAGER="less"

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# path
path=(
  $HOME/bin
  /usr/local/{sbin,bin}
  /usr/{sbin,bin}
  /{sbin,bin}
  $HOME/.emacs.d/bin
  /usr/local/share/npm/bin
  /usr/local/opt/go/libexec/bin
  $HOME/Projects/golang/bin
  /usr/local/opt/ruby/bin
)

# ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# local dotfiles
[[ -f ~/.config/dotfiles.local/zsh/zshrc.local.zsh ]] && . ~/.config/dotfiles.local/zsh/zshrc.local.zsh

[[ $ZPROF -ne 1 ]] || zprof
