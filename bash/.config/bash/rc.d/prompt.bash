# prompt ------------------------------------------------------------------- {{{
# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
PROMPT_DIRTRIM=2

reset="\e[1;0m";
black="\e[1;30m";
blue="\e[1;34m";
cyan="\e[1;36m";
green="\e[1;32m";
orange="\e[1;33m";
purple="\e[1;35m";
red="\e[1;31m";
violet="\e[1;35m";
white="\e[1;37m";
yellow="\e[1;33m";

# __git_branch () { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'; }

# you can use git-prompt too if you want
if [[ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]]; then
  source /usr/local/etc/bash_completion.d/git-prompt.sh
  GIT_PS1_SHOWDIRTYSTATE=true
  # export PS1='[\u@\h \w$(__git_ps1)]\n\$ '
  export PS1="\[${red}\]\t \[${green}\]$USER \[${cyan}\]\h \[${blue}\]\w \[${yellow}\]$(__git_ps1)\[${reset}\]\n\$ "
  export PS2='\[\033[01;36m\]>'
else
  export PS1="\[${red}\]\t \[${green}\]$USER \[${cyan}\]\h \[${blue}\]\w \[${reset}\]\n\$ "
  export PS2='\[\033[01;36m\]>'
fi
