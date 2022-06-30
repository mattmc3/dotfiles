## XDG
# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

# System level dirs
# set -q XDG_DATA_DIRS || set -gx XDG_DATA_DIRS /usr/share /usr/local/share
# set -q XDG_CONFIG_DIRS || set -gx XDG_CONFIG_DIRS /etc/xdg

# User level dirs
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -q XDG_CACHE_HOME || set -U XDG_CACHE_HOME $HOME/.cache
set -q XDG_CONFIG_HOME || set -U XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME || set -U XDG_DATA_HOME $HOME/.local/share
set -q XDG_RUNTIME_DIR || set -U XDG_RUNTIME_DIR $HOME/.xdg

# https://wiki.archlinux.org/index.php/XDG_user_directories
if not set -q XDG_DESKTOP_DIR
    switch (uname)
        case Darwin
            set -q XDG_DESKTOP_DIR || set -U XDG_DESKTOP_DIR $HOME/Desktop
            set -q XDG_DOCUMENTS_DIR || set -U XDG_DOCUMENTS_DIR $HOME/Documents
            set -q XDG_DOWNLOAD_DIR || set -U XDG_DOWNLOAD_DIR $HOME/Downloads
            set -q XDG_MUSIC_DIR || set -U XDG_MUSIC_DIR $HOME/Music
            set -q XDG_PICTURES_DIR || set -U XDG_PICTURES_DIR $HOME/Pictures
            set -q XDG_VIDEOS_DIR || set -U XDG_VIDEOS_DIR $HOME/Videos
            set -q XDG_PROJECTS_DIR || set -U XDG_PROJECTS_DIR $HOME/Projects
    end
end

# dotfiles
set -q DOTFILES || set -U DOTFILES ~/.config/dotfiles
set -q ZDOTDIR || set -U ZDOTDIR ~/.config/zsh

# path (app specific paths in the apps.fish file)
set -gx PATH \
    /usr/local/sbin \
    /usr/local/bin \
    /usr/sbin \
    /usr/bin \
    /bin

if [ -d /opt/homebrew ]
    set -gx PATH \
        /opt/homebrew/bin \
        /opt/homebrew/sbin \
        $PATH
end

[ -d $HOME/bin ] && set -gx PATH $HOME/bin $PATH

# no greeting
set fish_greeting

# apps
set -q PAGER || set -gx PAGER less
set -q VISUAL || set -gx VISUAL code
set -q EDITOR || set -gx EDITOR vim

# where I store my projects
set -q PROJECTS || set -x PROJECTS ~/Projects

# add function subdirs to fish_function_path
for d in $__fish_config_dir/functions/*/
    set fish_function_path (string trim -c / -r $d) $fish_function_path
end

# add completion subdirs to fish_function_path
for d in $__fish_config_dir/completions/*/
    set fish_complete_path (string trim -c / -r $d) $fish_complete_path
end
