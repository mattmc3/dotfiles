# dotfiles
set -q DOTFILES; or set -gx DOTFILES ~/.dotfiles

# it's nice to have a variable for where the fish config lives
set -q fish_config; or set -gx fish_config $HOME/.config/fish

# path
set -gx PATH "$HOME/bin" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/bin"

# no greeting
set fish_greeting

# apps
set -q PAGER; or set -gx PAGER less
set -q VISUAL; or set -gx VISUAL code
set -q EDITOR; or set -gx EDITOR vim

# where I store my projects
set -q PROJECTS; or set -x PROJECTS ~/Projects

# add ~/bin to function path
# http://fishshell.com/docs/current/tutorial.html#tut_path
set fish_function_path $HOME/bin $fish_function_path

# npm
set -gx PATH $HOME/bin $PATH $XDG_DATA_HOME/npm/bin

# add aliases to fish_function_path
set fish_function_path $XDG_CONFIG_HOME/fish/aliases $fish_function_path