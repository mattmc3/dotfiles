

#################
# CORE SETTINGS #
#################

#
# Zim settings
#

# Select what modules you would like enabled.
# The second line of modules may depend on options set by modules in the first line.
# These dependencies are noted on the respective module's README.md.
zmodules=(directory environment git history input utility meta custom \
          syntax-highlighting history-substring-search prompt completion)


###################
# MODULE SETTINGS #
###################

#
# Prompt
#

# Set your desired prompt here
zprompt_theme='steeef'

#
# Completion
#

# set an optional host-specific filename for the completion cache file
# if none is provided, the default '.zcompdump' is used.
#zcompdump_file=".zcompdump-${HOST}-${ZSH_VERSION}"

#
# Utility
#

# Uncomment to enable command correction prompts
# See: http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
#setopt CORRECT

#
# Environment
#

# Set the string below to the desired terminal title format string.
# The terminal title is redrawn upon directory change, however, variables like 
# ${PWD} are only evaluated once. Use prompt expansion strings for dynamic data:
#   http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# The example below uses the following format: 'username@host:/current/directory'
ztermtitle='%n@%m:%~'

#
# Input
#

# Uncomment to enable double-dot expansion.
# This appends '../' to your input for each '.' you type after an initial '..'
#zdouble_dot_expand='true'

#
# Syntax-Highlighting
#

# This determines what highlighters will be used with the syntax-highlighting module.
# Documentation of the highlighters can be found here:
#   https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
# For (u)rxvt, termite and gnome-terminal users,
# removing the 'cursor' highlighter will fix the disappearing cursor problem
zhighlighters=(main brackets cursor)


#
# SSH
#

# Load these ssh identities with the ssh module
#zssh_ids=(id_rsa)


#
# Pacman
#

# Set (optional) pacman front-end.
#zpacman_frontend='powerpill'

# Load any helper scripts as defined here
#zpacman_helper=(aur)

#################
# CORE SETTINGS #
#################

#
# Zim settings
#

# Select what modules you would like enabled.
# The second line of modules may depend on options set by modules in the first line.
# These dependencies are noted on the respective module's README.md.
zmodules=(directory environment git history input utility meta custom \
          syntax-highlighting history-substring-search prompt completion)


###################
# MODULE SETTINGS #
###################

#
# Prompt
#

# Set your desired prompt here
zprompt_theme='pure'

#
# Completion
#

# set an optional host-specific filename for the completion cache file
# if none is provided, the default '.zcompdump' is used.
#zcompdump_file=".zcompdump-${HOST}-${ZSH_VERSION}"

#
# Utility
#

# Uncomment to enable command correction prompts
# See: http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
#setopt CORRECT

#
# Environment
#

# Set the string below to the desired terminal title format string.
# The terminal title is redrawn upon directory change, however, variables like 
# ${PWD} are only evaluated once. Use prompt expansion strings for dynamic data:
#   http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# The example below uses the following format: 'username@host:/current/directory'
ztermtitle='%n@%m:%~'

#
# Input
#

# Uncomment to enable double-dot expansion.
# This appends '../' to your input for each '.' you type after an initial '..'
#zdouble_dot_expand='true'

#
# Syntax-Highlighting
#

# This determines what highlighters will be used with the syntax-highlighting module.
# Documentation of the highlighters can be found here:
#   https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
# For (u)rxvt, termite and gnome-terminal users,
# removing the 'cursor' highlighter will fix the disappearing cursor problem
zhighlighters=(main brackets cursor)


#
# SSH
#

# Load these ssh identities with the ssh module
#zssh_ids=(id_rsa)


#
# Pacman
#

# Set (optional) pacman front-end.
#zpacman_frontend='powerpill'

# Load any helper scripts as defined here
#zpacman_helper=(aur)