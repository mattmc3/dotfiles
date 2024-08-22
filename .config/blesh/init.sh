# -*- mode: sh; mode: sh-bash -*-

## This is a template for "~/.blerc".
##
## To use ble.sh in bash, please set up "~/.bashrc" as follows:
##
## ```bash
## # bashrc
##
## # Please put the following line in the beginning of .bashrc
## # Note: Please replace $HOME/.local/share/blesh with the path to your ble.sh
## [[ $- == *i* ]] && source "$HOME/.local/share/blesh/ble.sh" --noattach
##
## # Your bashrc contents should come between the two lines.
##
## # Please put the following line in the end of .bashrc
## [[ ${BLE_VERSION-} ]] && ble-attach
## ```
##

## See: https://github.com/akinomyoga/ble.sh/blob/master/blerc.template

##-----------------------------------------------------------------------------
## Basic settings


## The following setting specifies the input encoding. Currently only "UTF-8"
## and "C" is available.

#bleopt input_encoding=UTF-8


## The following setting specifies the pager used by ble.sh.  This is used to
## show the help of commands (f1).

#bleopt pager=less

## The following setting specifies the editor used by ble.sh.  This is used for
## the widget edit-and-execute (C-x C-e) and editor for a large amount of
## command line texts.  Possible values include, for example, "vim", "emacs
## -nw" and "nano".

#bleopt editor=vim


## The following settings sets the behavior of visible bells (vbell).  The
## option "vbell_duration" sets the time duration to show the vbell.  The
## option "vbell_align" controls the position of vbell with a colon-separated
## fields. The fields "left", "center", and "right" specify that the vbell
## should be shown up on the left, center, and right, respectively, in the
## terminal display.  The default is "right".  The field "panel" specify that
## vbell should be shown below the command line within the line editor
## interface (as far as the line editor is currently active).  The faces
## "vbell", "vbell_erase", and "vbell_flash" specify the graphic style of the
## vbell, the one after vbell is erased, and the one used to blink the vbell,
## respectively.

#bleopt vbell_default_message=' Wuff, -- Wuff!! '
#bleopt vbell_duration=2000
#bleopt vbell_align=right
#ble-face vbell='reverse'
#ble-face vbell_erase='bg=252'
#ble-face vbell_flash='fg=green,reverse'


##-----------------------------------------------------------------------------
## Line editor settings


## This option controls the behavior of the bell in the line editing by
## colon-separated values.  When "abell", "vbell", and "visual" are contained,
## the audible bells, the visible bells, and the visual bells are enabled.  The
## audible bell sends BEL to the terminal.  The visible bell shows the message
## on the terminal display.  The visual bell is the GNU-Screen style bell that
## flashes the terminal display by turning on DECSCNM in a short moment.  Old
## settings "edit_vbell" and "edit_abell" should be updated to use "edit_bell".

#bleopt edit_bell=abell


## The following setting turns on the delayed load of history when an non-empty
## value is set.

#bleopt history_lazyload=1


## The following setting turns on the delete selection mode when an non-empty
## value is set. When the mode is turned on the selection is removed when a
## user inserts a character.

#bleopt delete_selection_mode=1


## The following settings control the indentation. "indent_offset" sets the
## indent width. "indent_tabs" controls if tabs can be used for indentation or
## not. If "indent_tabs" is set to 0, tabs will never be used. Otherwise
## indentation is made with tabs and spaces.

#bleopt indent_offset=4
#bleopt indent_tabs=1


## "undo_point" controls the cursor position after "undo". When "beg" or "end"
## is specified, the cursor will be moved to the beginning or the end of the
## dirty section, respectively. When other values are specified, the original
## cursor position is reproduced.

#bleopt undo_point=end


## The following setting controls forced layout calculations before graphical
## operations. When a non-empty value is specified, the forced calculations are
## enabled. When an empty string is set, the operations are switched to logical
## ones.

#bleopt edit_forced_textmap=1


## The following option controls the interpretation of lines when going to the
## beginning or the end of the current line.  When the value `logical` is
## specified, the logical line is used, i.e., the beginning and the end of the
## line is determined based on the newline characters in the edited text.  When
## the value `graphical` is specified, the graphical line is used, i.e., the
## beginning and the end of the displayed line in the terminal is used.

#bleopt edit_line_type=graphical


## The following option specifies the set of expansions performed by
## magic-space with a colon-separated list of expansion types. "history",
## "sabbrev", "alias", and "autocd" can be specified.

#bleopt edit_magic_expand=history:sabbrev


## This option configures the detailed behavior of the widget "magic-space"
## with a colon-separated list.  If the field "inline-sabbrev-no-insert" is
## specified, the insertion of "SP" is skipped when the inline sabbrev is
## performed by "magic-space".

#bleopt edit_magic_opts=


## This option specifies the expansions performed on accept-line by a
## colon-separated list.  The expansion is performed in a similar way as Bash's
## history expansion.  When "sabbrev", "alias", "autocd", and "history" is
## specified, the respective expansions are attempted on the command line.
## When "verify" is specified, if sabbrev, alias, or autocd expansions changed
## the command line, the execution of the command line is canceled so the user
## can examine or continue to edit the expanded line.  The history expansion
## can be controlled by "shopt -s histverify" in a similar manner.  When
## "verify-syntax" is specified and any expansions change the command string, a
## syntax check is performed.  The command execution is canceled when the
## command string is not syntactically complete.  When "history-line" is
## specified, the history expansion replaces the command line instead of just
## printing the expansion result.  The default value of this option is empty.

#bleopt edit_magic_accept=sabbrev


## The following option controls the position of the info pane where completion
## menu, mode names, and other information are shown.  When the value "top" is
## specified, the info pane is shown just below the command line.  When the
## value "bottom" is specified, the info pane is shown at the bottom of the
## terminal.  The default is "top".

#bleopt info_display=top


## The following settings controls the prompt after the cursor left the command
## line.  "prompt_ps1_final" contains a prompt string.  "prompt_ps1_transient"
## is a colon-separated list of fields "always", "same-dir" and "trim".  The
## prompt is replaced by "prompt_ps1_final" if it has a non-empty value.
## Otherwise, the prompt is trimmed leaving the last line if
## "prompt_ps1_transient" has a field "trim".  Otherwise, the prompt vanishes
## if "prompt_ps1_transient" has a non-empty value.  When
## "prompt_ps1_transient" contains a field "same-dir", the setting of
## "prompt_ps1_transient" is effective only when the current working directory
## did not change since the last command line.

bleopt prompt_ps1_final="$(tput setaf 006)❯$(tput sgr0) "
bleopt prompt_ps1_transient=trim


## The following settings controls the right prompt. "prompt_rps1" specifies
## the contents of the right prompt in the format of PS1.  When the cursor
## leaves the current command line, the right prompt is replaced by
## "prompt_rps1_final" if it has a non-empty value, or otherwise, the right
## prompt vanishes if "prompt_rps1_transient" is set to a non-empty value,

#bleopt prompt_rps1='\w'
#bleopt prompt_rps1_final=
#bleopt prompt_rps1_transient=''


## The following settings specify the content of terminal titles and status
## lines.  "prompt_xterm_title" specifies the terminal title which can be set
## by "OSC 0 ; ... BEL".  "prompt_screen_title" is effective inside terminal
## multiplexers such as GNU screen and tmux and specifies the window title of
## the terminal multiplexer which can be set by "ESC k ... ST".
## "prompt_term_status" is only effective when terminfo entries "tsl" and "fsl"
## (or termcap entries "ts" and "ds") are available, and specifies the content
## of the status line which can be set by the terminfo entries.  When each
## setting has non-empty value, the content of corresponding title or status
## line is replaced just before PS1 is shown.

#bleopt prompt_xterm_title=
#bleopt prompt_screen_title=
#bleopt prompt_term_status=


## The following settings control the status line.  "prompt_status_line"
## specifies the content of the status line.  If its value is empty, the status
## line is not shown.  "prompt_status_align" controls the position of the
## content in the status line.  The face "prompt_status_line" specifies the
## default graphic style of the status line.

#bleopt prompt_status_line=
#bleopt prompt_status_align=left
#ble-face prompt_status_line='fg=231,bg=240'


## "prompt_eol_mark" specifies the contents of the mark used to indicate the
## command output is not ended with newlines. The value can contain ANSI escape
## sequences.

#bleopt prompt_eol_mark=$'\e[94m[ble: EOF]\e[m'


## "prompt_ruler" specifies the ruler between the previous command and the
## prompt (like powerlevel10k
## "POWERLEVEL9K_PROMPT_{ADD_NEWLINE,SHOW_RULER,RULER_*}").  When the empty
## value is specified, the ruler is disabled.  This is the default.  When the
## value "empty-line" is specified, an empty line is inserted between the
## command and the prompt.  When the other values are specified, the value is
## interpreted as an ANSI sequences, and the result is repeated to fill a line.

#bleopt prompt_ruler=            # no ruler (default)
#bleopt prompt_ruler=empty-line  # empty line
#bleopt prompt_ruler=$'\e[94m-'  # blue line


## "prompt_command_changes_layout" specifies whether the commands called from
## the blehook PRECMD or the variable PROMPT_COMMAND output texts to the
## terminal and changes the layout.  When a non-empty value is specified,
## ble.sh resets the layout before running the hooks PRECMD and PROMPT_COMMAND
## and restores the layout after running the hooks.  When a empty value is
## specified, ble.sh assumes that these hooks do not output texts to the
## terminal and do not changes the cursor positions and skip the special
## treatment.

#bleopt prompt_command_changes_layout=   # PRECMD/PROMPT_COMMAND not output
#bleopt prompt_command_changes_layout=1  # PRECMD/PROMPT_COMMAND may output


## "exec_restore_pipestatus" controls whether ble.sh restores PIPESTATUS of the
## previous user command.  When this option is set to a non-empty value,
## PIPESTATUS is restored.  This feature is turned off by default because it
## adds extra execution costs.  Note that the values of PIPESTATUS of the
## previous command are always available with the array BLE_PIPESTATUS
## regardless of this setting.

#bleopt exec_restore_pipestatus=1  # restores PIPESTATUS


## "edit_marker" and "edit_marker_error" define the default styles of the
## markers [ble: ...] used by ble.sh.  "edit_marker" is used for the normal
## notifications, and "edit_marker_error" is used for the error information.
## When they are set to an empty string, those markers are disabled (unless
## additional information other than the markers needs to be output after the
## markers).  Those default styles can be overridden by specific mark settings,
## such as `exec_errexit_mark`, `exec_elapsed_mark`, and `exec_exit_mark`.

#bleopt edit_marker=$'\e[94m[ble: %s]\e[m'
#bleopt edit_marker_error=$'\e[91m[ble: %s]\e[m'


## "exec_errexit_mark" specifies the format of the mark to show the exit status
## of the command when it is non-zero.  If this setting is an empty string, the
## exit status will not be shown.  The value can contain ANSI escape sequences.

#bleopt exec_errexit_mark=$'\e[91m[ble: exit %d]\e[m'


## "exec_elapsed_mark" specifies the format of the command execution time
## report.  It takes two arguments: the first is the string that explains the
## elapsed time, and the second is a number that represents the percentage of
## CPU core usage.  "exec_elapsed_enabled" specifies the condition that the
## command execution time report is displayed after the command execution.  The
## condition is expressed by an arithmetic expression, where a non-zero result
## causes displaying the report.  In the arithmetic expression, variables
## "real", "{usr,sys}{,_self,_child}", and "cpu" can be used.  "real"
## represents the elapsed time.  "usr" and "sys" represent the user and system
## time, respectively.  The suffixes "_self" and "_child" represent the part
## consumed in the main shell process and the other child processes including
## subshells and external programs, respectively.  "cpu" represents the
## percentage of the CPU core usage in integer, which can be calculated by
## "(usr+sys)*100/real".  The other values are all in unit of milliseconds.

#bleopt exec_elapsed_mark=$'\e[94m[ble: elapsed %s (CPU %s%%)]\e[m'
#bleopt exec_elapsed_enabled='usr+sys>=10000'


## "exec_exit_mark" specifies the marker printed when the bash session ends.
## When an empty string is specified, the marker is disabled.

#bleopt exec_exit_mark=$'\e[94m[ble: exit]\e[m'


## The following setting controls the exit when jobs are remaining. When an
## empty string is set, the shell will never exit with remaining jobs through
## widgets. When an non-empty value is set, the shell will exit when exit is
## attempted twice consecutively.

#bleopt allow_exit_with_jobs=


## The following setting controls the cursor position after the move to other
## history entries. When non-empty values are specified, the offset of the
## cursor from the beginning of the command line is preserved. When an empty
## value is specified the cursor position is the beginning or the end of the
## command lines when the move is to a newer or older entry, respectively.

#bleopt history_preserve_point=


## The following setting controls the history sharing. If it has non-empty
## value, the history sharing is enabled. With the history sharing, the command
## history is shared with the other Bash ble.sh sessions with the history
## sharing turned on.

bleopt history_share=1


## This option controls the target range in the command history for
## "erasedups", which is performed when it is specified in "HISTCONTROL".  When
## this option has an empty value, the target range is the entire history as in
## the plain Bash.  When this option evaluates to a positive integer "count",
## the target range is the last "n" entries in the command history.  When this
## option evaluates to a non-positive integer "offset", "offset" specifies the
## beginning of the target range relative to the history count at the session
## start.  The end of the target range is always the end of the command
## history.

#bleopt history_erasedups_limit=       # entire history
#bleopt history_erasedups_limit=0      # only new items added in this session
#bleopt history_erasedups_limit=-1000  # new items and 1000 prev-session items
#bleopt history_erasedups_limit=1000   # last 1000 items


## The following setting controls the behavior of the widget
## "accept-single-line-or-newline" in the single-line editing mode. The value
## is a subject of arithmetic evaluation. When it evaluates to negative
## integers, the line is always accepted. When it evaluates to 0, it enters the
## multiline editing mode when there is any unprocessed user inputs, or
## otherwise the line is accepted. When it evaluates to a positive integer "n",
## it enters the multiline editing mode when there is more than "n"unprocessed
## user inputs.

#bleopt accept_line_threshold=5


## The following option controls the behavior when the number of characters
## exceeds the capacity specified by `line_limit_length`.  The value `none`
## means that the number of characters will not be checked.  The value
## `discard` means that the characters cannot be inserted when the number of
## characters exceeds the capacity.  The value `truncate` means that the
## command line is truncated from its end to fit into the capacity.  The value
## `editor` means that the widget `edit-and-execute` will be invoked to open an
## editor to edit the command line contents.

#bleopt line_limit_type=none


## The following option specifies the capacity of the command line in the
## number of characters.  The number 0 or negative numbers means the unlimited
## capacity.

#bleopt line_limit_length=10000


## The following option specifies the maximal number of characters which can be
## appended into the history.  When this option has a positive value, commands
## with the length longer than the value is not appended to the history.  When
## this option has a non-positive value, commands are always appended to the
## history regardless of their length.

#bleopt history_limit_length=10000


##-----------------------------------------------------------------------------
## Terminal state control


## When the follwoing setting is set to a non-empty value, ble.sh saves the TTY
## state at the end of the command executation and restores it before the next
## command execution.  This adds a slight overload of running an extra call of
## stty.  If this is enabled, when a command breaks the TTY state, the effect
## remains in later commands.

#bleopt term_stty_restore=1


## The following setting specifies the cursor type when commands are executed.
## The cursor type is specified by the argument of the control function
## DECSCUSR.

#bleopt term_cursor_external=0


## The following settings, external and internal, specify the "modifyOtherKeys"
## states [the control function SM(>4)] when commands are executed and when
## ble.sh has control, respectively.

#bleopt term_modifyOtherKeys_external=auto
#bleopt term_modifyOtherKeys_internal=auto


## The following setting controls whether the kitty-keyboard-protocol sequences
## should pass-through the terminal multiplexers when the outermost terminal is
## kitty.  When this option has a non-empty string, the pass-through kitty
## protocol sequences are enabled.
##
## * This is intended to be used with tmux-3.4+.  This works with tmux-3.3a and
##   below as far as the user does not enable CapsLock or NumLock.  Note that
##   this might cause problems of keyboard inputs after detaching from tmux;
##   You might lose the control of the terminal applications that do not
##   support extended keys outside the terminal multiplexers.
##
## * This will cause the same problems when used with multiple windows in GNU
##   screen.  You will lose the control of the terminal applications without
##   the support for extended keys when there are more than one ble.sh session
##   or when there is at least one foreground ble.sh session in GNU screen.

#bleopt term_modifyOtherKeys_passthrough_kitty_protocol=1

##-----------------------------------------------------------------------------
## Rendering options


## "tab_width" specifies the width of TAB on the command line. When an empty
## value is specified, the width in terminfo (tput it) is used.

#bleopt tab_width=


## "char_width_mode" specifies the width of East_Asian_Width=A characters.
## When the value "east" is specified, the width is 2. When the value "west" is
## specified, the width is 1.  When the value "emacs" is specified, the width
## table (depending on characters) used in Emacs is used.  When the value
## "musl" is specified, the table for "wcwidth" of the musl C library in 2014
## is used [Note: recent versions of musl library is more conforming to Unicode
## so favor "west" or "east"].  When "auto" is specified, the character width
## mode is automatically selected based on interactions with the terminal.

#bleopt char_width_mode=auto


## "char_width_version" specifies the Unicode version that char width
## determination bases on.  When "auto" is specified, ble.sh automatically
## tests the behavior of the terminal on startup and try to determine the
## appropriate version.  Supported versions are "4.1", "5.0", "5.2", "6.0",
## "6.1", "6.2", "6.3", "7.0", "8.0", "9.0", "10.0", "11.0", "12.0", "12.1",
## "13.0", "14.0", "15.0", and "15.1".  The default value is "auto".

#bleopt char_width_version=auto


## "emoji_width" specifies the width of emoji characters.  If an empty value is
## specified, special treatment of emoji is disabled.

#bleopt emoji_width=2


## "emoji_version" specifies the version of Unicode Emoji.  Available values
## are 0.6, 0.7, 1.0, 2.0, 3.0, 4.0, 5.0, 11.0, 12.0, 12.1, 13.0, 13.1, 14.0,
## 15.0, and 15.1.

#bleopt emoji_version=13.1


## "emoji_opts" is a colon-separated list that represents the terminal
## capability for emojis.  When "tpvs" and "epvs" are specified, TPVS and EPVS
## (text/emoji presentation variation selectors), respectively, can be used to
## change he representation of emoji characters.  When "zwj" is specified, the
## emoji ZWJ sequences are supported.  When "ri" is specified, the flag emojis
## formed by two Regional_Indicators are supported.  When "unqualified" is
## specified, unqualified emojis are treated as emojis as well as the qualified
## emojis.

#bleopt emoji_opts=ri


## This option specifies the type of the supported grapheme cluster of the
## terminal.  The empty string indicates that the terminal does not support the
## grapheme clusters.  The values "extended" and "legacy" indicate that the
## terminal supports the extended and legacy grapheme clusters, respectively.

#bleopt grapheme_cluster=extended


## This option controls the behavior when ble.sh receives SIGWINCH.
## * When the value "redraw-safe" is specified, ble.sh redraws the new prompt
##   starting from the line of the current cursor position.
## * When the value "redraw-prev" is specified, ble.sh tries to go to the
##   beginning of the current prompt and overwrite the current one.  This is
##   similar to the behavior of GNU Readline.  This possibly erase the output
##   of the previous command because ble.sh tries to go to the beginning of the
##   current prompt assuming that the number of lines in the prompt does not
##   change by the terminal resizing.
## * When the value "redraw-here" is specified, ble.sh tries to determine the
##   number of lines that can be safely erased and go to the beginning of the
##   safe lines before the redraw.  This is the default behavior.  In
##   principle, this can also erase the previous outputs, but it would be
##   supposed to be rarely happen as far as the text reflowing of the terminal
##   behaves in a reasonable way.
## * When the value "clear" is specified, the terminal content is erased and
##   the new prompt will be drawn at the top of the terminal.  The previous
##   terminal contents including the command outputs will be lost.

#bleopt canvas_winch_action=redraw-here

##-----------------------------------------------------------------------------
## User input settings

## The following setting sets the default keymap. The value "emacs" specifies
## that the emacs keymap should be used. The value "vi" specifies that the vi
## keymap (insert mode) should be used as the default. The value "auto"
## specifies that the keymap should be automatically selected from "emacs" or
## "vi" according to the current readline state "set -o emacs" or "set -o vi".

#bleopt default_keymap=auto


## The following setting controls the treatment of isolated ESCs.  The value
## "esc" indicates that it should be treated as ESC.  The value "meta"
## indicates that it should be treated as Meta modifier.  The value "auto"
## indicates that the behavior will be switched to an appropriate side of "esc"
## or "meta" depending on the current keymap.

#bleopt decode_isolated_esc=esc


## The following setting specifies the byte code used to abort the currently
## processed inputs. The default value 28 corresponds to "C-\".

#bleopt decode_abort_char=28


## The following settings sets up the behavior for errors while user input
## decoding. "error_char" is the decoding error for the current character
## encoding. "error_cseq" indicates the unrecognized CSI sequences.
## "error_kseq" indicates the unbound key sequences. "abell" and "vbell" turn
## on/off the audible bells and visible bells on errors. If the variable is
## empty the bells are turned off, or otherwise turned on. "discard" controls
## if the chars/sequences will be discarded or processed in later stage. If a
## non-empty value is given, chars/sequences are discarded.

#bleopt decode_error_char_abell=
#bleopt decode_error_char_vbell=1
#bleopt decode_error_char_discard=
#bleopt decode_error_cseq_abell=
#bleopt decode_error_cseq_vbell=1
#bleopt decode_error_cseq_discard=1
#bleopt decode_error_kseq_abell=1
#bleopt decode_error_kseq_vbell=1
#bleopt decode_error_kseq_discard=1


## This variable sets the limit to the count of recursive calls of keyboard
## macros.

#bleopt decode_macro_limit=1024


## When a non-empty value is specified to this settings, the terminal's
## Bracketed Paste Mode (DEC mode 2004) is enabled.  This setting is
## synchronized with the readline variable "enable-bracketed-paste".

#bleopt term_bracketed_paste_mode=on

##-----------------------------------------------------------------------------
## Settings for completion


## The following settings turn on/off the corresponding functionalities. When
## non-empty strings are set, the functionality is enabled. Otherwise, the
## functionality is inactive.

#bleopt complete_auto_complete=1
#bleopt complete_menu_complete=1
#bleopt complete_menu_filter=1


## If "complete_ambiguous" has non-empty values, ambiguous completion
## candidates are generated for completion.

#bleopt complete_ambiguous=1


## If "complete_contract_function_names" has non-empty values, the function
## name candidates are grouped by prefixes of the directory-like form "*/".

#bleopt complete_contract_function_names=1


## By default, ble.sh does not allow rewriting the existing text if non-unique
## candidates does not contain the existing text.  If this setting has
## non-empty values, ble.sh rewrites the existing text.

#bleopt complete_allow_reduction=1


## This option specifies the threshold to simplify the quotation type of the
## inserted word.  This option is evaluated as an arithmetic expression.  When
## this option evaluates to a negative value, the simplification of the
## quotation is disabled.  Otherwise, when the number of characters will be
## reduced by at least the specified value, the quotation is simplified.  The
## default is 0, which means that the quotation is simplified unless the number
## of characters increases by the simplification.

#bleopt complete_requote_threshold=0


## If "complete_auto_history" has non-empty values, auto-complete searches
## matching command lines from history.

#bleopt complete_auto_history=1


## The following setting controls the delay of auto-complete after the last
## user input. The unit is millisecond.

#bleopt complete_auto_delay=100


## The face "auto_complete" can be used to specify the graphic style of the
## suggestion by auto-complete.  The default style is choosed just to make it
## work in both the terminals with light and dark backgrounds.  A better style
## can be specified based on the user's preference.

#ble-face auto_complete='fg=238,bg=254'           # default
#ble-face auto_complete='fg=white,bg=69'          # blue background
#ble-face auto_complete='fg=240,underline,italic' # darker background


## The setting "complete_auto_wordbreaks" is used as the delimiters for
## identifying words for M-right (auto-complete/insert-word).  The default
## value is $' \t\n'.  If the empty value is set, the default value is used.

#bleopt complete_auto_wordbreaks=$' \t\n/'


## The setting "complete_auto_complete_opts" is a colon-separated list of
## options:
##
## - The option "suppress-after-complete" controls whether auto-complete is
##   enabled after TAB completions.  If "suppress-after-complete" is included,
##   auto-complete is enabled after TAB completions.  Otherwise, auto-complete
##   is disabled after TAB completions.

#bleopt complete_auto_complete_opts=suppress-after-complete


## The faces "menu_filter_fixed" and "menu_filter_input" can be used to specify
## the graphic styles of the part of the text that is used to filter the menu
## items by the menu-filter feature.

#ble-face menu_filter_fixed='bold'
#ble-face menu_filter_input='fg=16,bg=229'


## The setting "complete_auto_menu" controls the delay of "auto-menu".  When a
## non-empty string is set, auto-menu is enabled.  The string is evaluated as
## an arithmetic expression to give the delay in milliseconds.  ble.sh will
## automatically show the menu of completions after the idle time (for which
## user input does not arrive) reaches the delay.

#bleopt complete_auto_menu=500


## When there are user inputs while generating completion candidates, the
## candidates generation will be canceled to process the user inputs. The
## following setting controls the interval of checking user inputs while
## generating completion candidates.

#bleopt complete_polling_cycle=50


## A hint on the maximum acceptable size of any data structure generated during
## the completion process, beyond which the completion may be prematurely
## aborted to avoid excessive processing time.  "complete_limit" is used for
## TAB completion.  When its value is empty, the size checks are disabled.
## "complete_limit_auto" is used for auto-completion.  When its value is empty,
## the setting "complete_limit" is used instead. "complete_limit_auto_menu" is
## used for auto-menu.

#bleopt complete_limit=500
#bleopt complete_limit_auto=200
#bleopt complete_limit_auto_menu=100


## The following setting controls the timeout for the pathname expansions
## performed in auto-complete.  When the word contains a glob pattern that
## takes a long time to evaluate the pathname expansion, auto-complete based on
## the filename is canceled based on the timeout setting.  The value specifies
## the timeout duration in milliseconds.  When the value is empty, the
## timeout is disabled.

#bleopt complete_timeout_auto=5000


## The following setting controls the timeout for the pathname expansions to
## prepare COMP_WORDS and COMP_LINE for progcomp.  When the word contains a
## glob pattern that takes a long time to evaluate, the pathname expansion is
## canceled, and a noglob expansion is used to construct COMP_WORDS and
## COMP_LINE.  The value specifies ## the timeout duration in milliseconds.
## When the value is empty, the timeout is disabled.

#bleopt complete_timeout_compvar=200


## The following setting specifies the style of the menu to show completion
## candidates. The value "dense" and "dense-nowrap" shows candidates separated
## by spaces. "dense-nowrap" is different from "dense" in the behavior that it
## inserts a new line before the candidates that does not fit into the
## remaining part of the current line. The value "align" and "align-nowrap"
## aligns the candidates. The value "linewise" shows a candidate per line.  The
## value "desc" and "desc-text" shows a candidate per line with description for
## each. "desc-text" is different from "desc" in the behavior that it does not
## interprets ANSI escape sequences in the descriptions.

#bleopt complete_menu_style=align-nowrap


## When a non-empty value is specified to this setting, the matching text on
## the right of the cursor is removed on the insertion of the completion.  This
## setting is synchronized with the readline variable "skip-completed-text".

#bleopt complete_skip_matched=on


## The following setting controls the detailed behavior of menu-complete with a
## colon-separated list of options.  When the option "insert-selection" is
## specified, the currently selected menu item is temporarily inserted in the
## command line.  When "hidden" is specified, "insert-selection" is enabled,
## and additionally, the completion menu is hidden by default.  The default is
## "insert-selection".

#bleopt complete_menu_complete_opts=insert-selection


## When a non-empty value is specified to this setting, the highlighting of the
## menu items is enabled.  This setting is synchronized with the readline
## variable "colored-stats".

#bleopt complete_menu_color=on


## When a non-empty value is specified to this setting, the part of the menu
## items matching with the already input text is highlighted.  This setting is
## synchronized with the readline variable "colored-completion-prefix".

#bleopt complete_menu_color_match=on


## The following settings specify the maximal and minimal align widths for
## complete_menu_style="align" and "align-nowrap".

#bleopt menu_align_min=4
#bleopt menu_align_max=20


## The following setting specifies the maximal height of the menu.  When this
## value is evaluated to be a positive integer, the maximal line number of the
## menu is limited to that value.

#bleopt complete_menu_maxlines=10


## The following settings specify the prefix of the menu items.  "menu_prefix"
## specifies the default prefix for any menu-style.
## "menu_{align,desc,linewise,dense}_prefix" specify the prefixes in the
## respective menu-styles.  The value is specified by a printf format, where
## the first argument is the index of the candidate.  ANSI escape sequences can
## also be used.  For example, the candidate index can be shown by setting the
## value '%d '.  The default value is empty.

#bleopt menu_align=
#bleopt menu_align_prefix='\e[1m%d:\e[m '
#bleopt menu_desc_prefix='\e[1m%d.\e[m '
#bleopt menu_linewise_prefix='\e[1;36m%d:\e[m '
#bleopt menu_dense_prefix='\e[1;32m>\e[m '


## The following setting specifies the minimum column width for the multicolumn
## description for `complete_menu_style=desc'.  When the empty value is
## specified, the multicolumn mode is disabled.

#bleopt menu_desc_multicolumn_width=65


## These faces control graphics styles used in the menu descriptions.  Face
## "menu_desc_default" is used as a default highlighting of the description.
## Face "menu_desc_type" is used for the prefix string "(type) " to indicate
## the type of the menu item.  Face "menu_desc_quote" is used to quote strings
## embedded in the descriptions.

#ble-face menu_desc_default=none
#ble-face menu_desc_type=ref:syntax_delimiter
#ble-face menu_desc_quote=ref:syntax_quoted


## When this Readline setting is enabled, the cases of alphabets are ignored on
## completion generation.

#bind 'set completion-ignore-case off'


## When this Readline setting is turned on, suffixes are added to the filename
## completions in the menu.  The characters "@", "/" and "*" are added to
## symbolic links, directories and executables, respectively.

#bind 'set visible-stats off'


## When this Readline setting is turned on, the suffix "/" is inserted after
## the insertion of directory names.

#bind 'set mark-directories on'


## When this Readline setting is turned on, the suffix "/" is inserted after
## symbolic links pointing to directories.

#bind 'set mark-symlinked-directories on'


## When this Readline setting is turned on, the filenames starting with "." is
## also generated as possible completions.

#bind 'set match-hidden-files on'


## By default, when filenames of the form "dir/file*" is shown in the menu, the
## part of the directory name "dir/" is omitted.  When this Readline setting is
## turned on, the directory name of filename completions are not omitted.

#bind 'set menu-complete-display-prefix off'


## This option specifies a colon-separated list of glob patterns of sabbrev
## names ignored in generating the sabbrev completion candidates.

#bleopt complete_source_sabbrev_ignore=


## This is a colon-separated list of options.  When the field
## `no-empty-completion` is specified, the sabbrev completion candidates are
## not generated when the word to complete is empty.

#bleopt complete_source_sabbrev_opts=no-empty-completion

##-----------------------------------------------------------------------------
## Color settings

## The setting "term_index_colors" specifies the number of index colors used to
## specify colors in the terminal.  The value "auto" means that the use of
## index colors are determined based on the terminfo database and the value of
## TERM shell variable.  Otherwise, the value is evaluated as an arithmetic
## expression.  When it is evaluated to 256, the index colors are assumed to be
## xterm 256-color palette (16 basic + 6x6x6 color cube + 24 gray scale).  When
## it is evaluated to 88, the index colors are assumed to be xterm 88-color
## palette (16 basic + 4x4x4 color cube + 8 gray scale).  When it is evaluated
## to 0, ble.sh will never use the index colors to set colors.  When it is
## evaluated to other integers, the value specifies the maximum available
## index.

#bleopt term_index_colors=256


## The setting "term_true_colors" specifies the format of 24-bit color escape
## sequences supported by your terminal.  The value "semicolon" indicates the
## format "CSI 3 8 ; 2 ; R ; G ; B m".  The value "colon" indicates the format
## "CSI 3 8 : 2 : R : G : B m".  The other value implies that the terminal does
## not support 24-bit color sequences.  In this case, ble.sh tries to output
## indexed color sequences or basic color sequences with properly reduced
## colors.

#bleopt term_true_colors=semicolon


## The setting "filename_ls_colors" can be used to import the filename coloring
## scheme by the environment variable LS_COLORS.

#bleopt filename_ls_colors="$LS_COLORS"


## The following settings enable or disable the syntax highlighting.  When the
## setting "highlight_syntax" has a non-empty value, the syntax highlighting is
## enabled.  When the setting "highlight_filename" has a non-empty value, the
## highlighting based on the filename and the command name is enabled during
## the process of the syntax highlighting.  Similarly, when the setting
## "highlight_variable" has a non-empty value, the highlighting based on the
## variable type is enabled.  All of these settings have non-empty values by
## default.

#bleopt highlight_syntax=
#bleopt highlight_filename=
#bleopt highlight_variable=


## The following settings control the timeout and user-input cancellation of
## the pathname expansions performed in the syntax highlighting.  When the word
## contains a glob pattern that takes a long time to evaluate the pathname
## expansion, the syntax highlighting based on the filename is canceled based
## on the timeouts specified by these settings.  "highlight_timeout_sync" /
## "highlight_timeout_async" specify the timeout durations in milliseconds to
## be used for the foreground / background syntax highlighting, respectively.
## When the timeout occurred in the foreground, the syntax highlighting will be
## deferred to the background syntax highlighting.  When the timeout occurred
## in the background, the syntax highlighting for the filename is canceled.
## When the value is empty, the corresponding timeout is disabled.
## "syntax_eval_polling_interval" specifies the maximal interval between the
## user-input checking.

#bleopt highlight_timeout_sync=500
#bleopt highlight_timeout_async=5000
#bleopt syntax_eval_polling_interval=50


# The following settings specify graphic styles of corresponding faces.  Faces
# used for specific features are described in the respective sections.

#bleopt color_scheme=default
bleopt color_scheme=base16

# ble-face argument_error=fg=red,underline
# ble-face argument_option=fg=teal
ble-face auto_complete=fg=240                # fg=black,bg=silver
# ble-face cmdinfo_cd_cdpath=fg=navy,bg=yellow
# ble-face command_alias=fg=teal
# ble-face command_builtin=fg=red
# ble-face command_builtin_dot=fg=red,bold
# ble-face command_directory=fg=blue,underline
# ble-face command_file=fg=green
# ble-face command_function=fg=magenta
# ble-face command_jobs=fg=red,bold
# ble-face command_keyword=fg=blue
# ble-face command_suffix=fg=white,bg=green
# ble-face command_suffix_new=fg=white,bg=brown
# ble-face disabled=fg=silver
# ble-face filename_block=fg=yellow,bg=black,underline
# ble-face filename_character=fg=white,bg=black,underline
# ble-face filename_directory=fg=blue,underline
# ble-face filename_directory_sticky=fg=white,bg=blue,underline
# ble-face filename_executable=fg=green,underline
# ble-face filename_link=fg=teal,underline
# ble-face filename_ls_colors=underline
# ble-face filename_orphan=fg=cyan,bg=brown,underline
# ble-face filename_other=underline
# ble-face filename_pipe=fg=lime,bg=black,underline
# ble-face filename_setgid=fg=black,bg=lime,underline
# ble-face filename_setuid=fg=black,bg=yellow,underline
# ble-face filename_socket=fg=cyan,bg=black,underline
# ble-face filename_url=fg=blue,underline
# ble-face filename_warning=fg=red,underline
# ble-face menu_desc_default=none
# ble-face menu_desc_quote=ref:syntax_quoted
# ble-face menu_desc_type=ref:syntax_delimiter
# ble-face menu_filter_fixed=bold
# ble-face menu_filter_input=fg=black,bg=yellow
# ble-face overwrite_mode=fg=black,bg=cyan
# ble-face prompt_status_line=fg=white,bg=gray
# ble-face region=fg=white,bg=navy
# ble-face region_insert=fg=blue,bg=silver
# ble-face region_match=fg=white,bg=navy
# ble-face region_target=fg=black,bg=cyan
# ble-face syntax_brace=fg=teal,bold
# ble-face syntax_command=fg=brown
# ble-face syntax_comment=fg=silver
# ble-face syntax_default=none
# ble-face syntax_delimiter=bold
# ble-face syntax_document=fg=olive
# ble-face syntax_document_begin=fg=olive,bold
ble-face syntax_error=fg=red,bold      # fg=white,bg=red
# ble-face syntax_escape=fg=magenta
# ble-face syntax_expr=fg=blue
# ble-face syntax_function_name=fg=magenta,bold
# ble-face syntax_glob=fg=magenta,bold
# ble-face syntax_history_expansion=fg=white,bg=brown
# ble-face syntax_param_expansion=fg=magenta
# ble-face syntax_quotation=fg=green,bold
# ble-face syntax_quoted=fg=green
# ble-face syntax_tilde=fg=blue,bold
# ble-face syntax_varname=fg=olive
# ble-face varname_array=fg=olive,bold
# ble-face varname_empty=fg=teal
# ble-face varname_export=bold
# ble-face varname_expr=fg=blue,bold
# ble-face varname_hash=fg=green,bold
# ble-face varname_number=fg=olive
# ble-face varname_readonly=fg=magenta
# ble-face varname_transform=fg=teal,bold
# ble-face varname_unset=fg=brown
# ble-face vbell=reverse
# ble-face vbell_erase=bg=silver
# ble-face vbell_flash=fg=green,reverse

##-----------------------------------------------------------------------------
## Keybindings


## The default mapping of <SP> in ble.sh is magic-space which performs history
## and sabbrev expansion before inserting a space.  If you want to insert just
## a space without expansions as Bash's default, use the following setting:

#ble-bind -f 'SP' 'self-insert'


## The default mapping of `/' (<slash>) in ble.sh is magic-slash which performs
## sabbrev expansions of the name ` ~*'.  If you want to insert just a slash
## without expansions as Bash's default, use the following setting:

#ble-bind -f '/' 'self-insert'


## If you want to search the already input string using <up> and <down> keys,
## use the following setting:

#ble-bind -f up 'history-search-backward'
#ble-bind -f down 'history-search-forward'


## If you want to immediately run the matched command by RET, you can specify
## the option "immediate-accept" to nsearch widgets:

#ble-bind -f up 'history-search-backward immediate-accept'
#ble-bind -f down 'history-search-forward immediate-accept'


## If you want to kill/copy words including the spaces preceding them, you can
## use the following keybindings:

#ble-bind -f C-w 'kill-region-or kill-uword'
#ble-bind -f M-w 'copy-region-or copy-uword'


## The following keybindings can be used to execute the command by RET even in
## the multiline mode.

# # For emacs editing mode
# ble-bind -m emacs -f 'C-m' 'accept-line'
# ble-bind -m emacs -f 'RET' 'accept-line'

# # For vim editing mode
# ble-bind -m vi_imap -f 'C-m' 'accept-line'
# ble-bind -m vi_imap -f 'RET' 'accept-line'
# ble-bind -m vi_nmap -f 'C-m' 'accept-line'
# ble-bind -m vi_nmap -f 'RET' 'accept-line'


## If you want to accept the suggestion by auto-complete using TAB, please use
## the following keybindings.  By default, <right> key can be used to accept
## the suggestion, and <TAB> is assigned to the normal TAB completion which is
## independent of auto-complete.

# ble-bind -m auto_complete -f C-i auto_complete/insert
# ble-bind -m auto_complete -f TAB auto_complete/insert

##-----------------------------------------------------------------------------
## Settings for Emacs mode

function blerc/emacs-load-hook {
  #----------------------------------------------------------------------------
  # Settings for the mode indicator

  ## The following option specifies the content of the mode indicator shown in
  ## the info line as a prompt sequence.

  #bleopt prompt_emacs_mode_indicator='\q{keymap:emacs/mode-indicator}'


  ## The following option specifies the multiline mode name used in the prompt
  ## sequence \q{keymap:emacs/mode-indicator} in the multiline editing mode.

  # default
  #bleopt keymap_emacs_mode_string_multiline=$'\e[1m-- MULTILINE --\e[m'
  # do not show the mode name
  #bleopt keymap_emacs_mode_string_multiline=

  #----------------------------------------------------------------------------
  # Keybindings

  ## The default mapping of RET and C-m inserts newline with multiline commands
  ## or incomplete commands.  With the following setting, RET and C-m always
  ## causes the execution of the command even in the multiline mode or when the
  ## command is not syntactically completed.

  #ble-bind -f 'C-m' accept-line
  #ble-bind -f 'RET' accept-line


  ## With the following settings, M-backspace (whose actual key sequence
  ## depends on your terminal) will kill the backward word as in the default
  ## readline.

  #ble-bind -f 'M-C-?' kill-backward-cword
  #ble-bind -f 'M-DEL' kill-backward-cword
  #ble-bind -f 'M-C-h' kill-backward-cword
  #ble-bind -f 'M-BS'  kill-backward-cword

  return 0
}
blehook/eval-after-load keymap_emacs blerc/emacs-load-hook

##-----------------------------------------------------------------------------
## Settings for Vim mode

function blerc/vim-load-hook {
  ((_ble_bash>=40300)) && builtin bind 'set keyseq-timeout 1'

  #----------------------------------------------------------------------------
  # Settings for the mode indicator

  ## The following option specifies the content of the mode indicator shown in
  ## the info line as a prompt sequence.

  #bleopt prompt_vi_mode_indicator='\q{keymap:vi/mode-indicator}'


  ## The following option controls whether the prompt sequence
  ## \q{keymap:vi/mode-indicator} is activated.  When this option has a
  ## non-empty value, \q{keymap:vi/mode-indicator} is expanded to the mode
  ## indicator. Otherwise, \q{keymap:vi/mode-indicator} is expanded to the
  ## empty string.

  #bleopt keymap_vi_mode_show=1


  ## The following options specify the name of modes in
  ## \q{keymap:vi/mode-indicator}.

  #bleopt keymap_vi_mode_name_insert=INSERT
  #bleopt keymap_vi_mode_name_replace=REPLACE
  #bleopt keymap_vi_mode_name_vreplace=VREPLACE
  #bleopt keymap_vi_mode_name_visual=VISUAL
  #bleopt keymap_vi_mode_name_select=SELECT
  #bleopt keymap_vi_mode_name_linewise=LINE
  #bleopt keymap_vi_mode_name_blockwise=BLOCK


  ## This option specifies the result of \q{keymap:vi/mode-indicator} in the
  ## normal mode.  For example, if you want to show an explicit name of the
  ## normal mode like in other modes, please use the following setting:

  #bleopt keymap_vi_mode_string_nmap:=$'\e[1m-- NORMAL --\e[m'


  ## This option specifies that all the prompts should be recalculated on the
  ## mode change.  When this option has a non-empty value, the prompt will be
  ## recalculated.

  #bleopt keymap_vi_mode_update_prompt=

  #----------------------------------------------------------------------------
  # Keybindings

  ## The following setting sets up the keymap settings with Meta modifiers.
  ## With this setting, M-RET can be used to insert a newline in the
  ## commandline.

  #ble-decode/keymap:vi_imap/define-meta-bindings

  ## In this case, C-RET can be optionally configured so that it forcibly
  ## executes the command.

  #ble-bind -m vi_imap -f 'C-RET' 'accept-line'

  ## The default mapping of <M-backspace> (whose actual key sequence depends on
  ## your terminal) copies the previous shell word in the kill ring.  Instead,
  ## the following settings will kill the backward word as in the default
  ## readline.

  #ble-bind -m vi_imap -f 'M-C-?' kill-backward-cword
  #ble-bind -m vi_imap -f 'M-DEL' kill-backward-cword
  #ble-bind -m vi_imap -f 'M-C-h' kill-backward-cword
  #ble-bind -m vi_imap -f 'M-BS'  kill-backward-cword


  ## The default mapping of RET and C-m in the insert mode inserts newline with
  ## multiline commands or incomplete commands.  They moves the cursor position
  ## to the next line in the normal mode.  Instead, with the following setting,
  ## RET and C-m always causes the execution of the command even in the
  ## multiline mode or when the command is not syntactically completed.

  #ble-bind -m vi_imap -f 'C-m' accept-line
  #ble-bind -m vi_imap -f 'RET' accept-line
  #ble-bind -m vi_nmap -f 'C-m' accept-line
  #ble-bind -m vi_nmap -f 'RET' accept-line


  ## The default mapping of C-o is vi_imap/single-command-mode.  If you want to
  ## execute the current command line and load the next history entry with
  ## <C-o>, use the following setting:

  #ble-bind -m vi_imap -f 'C-o' 'accept-and-next'


  ## The default mapping of C-k is kill-forward-line.  If you want to input
  ## digraphs with <C-k>{char1}{char2}, use the following setting:

  #ble-bind -m vi_imap -f 'C-k' 'vi_imap/insert-digraph'


  ## The default mapping of C-c is vi_imap/normal-mode-without-insert-leave
  ## (imap), vi-command/cancel (nmap).  If you instead want to discard the
  ## current line and go to the next line, you can bind C-c to 'discard-line':

  #ble-bind -m vi_imap -f 'C-c' discard-line
  #ble-bind -m vi_nmap -f 'C-c' discard-line


  ## The default mapping of 'g g' and G moves the current position in the
  ## command history.  If you would like to move the cursor position in the
  ## current command entry, you can overwrite the bindings as follows.

  #ble-bind -m vi_nmap -f 'g g' vi-command/first-nol
  #ble-bind -m vi_omap -f 'g g' vi-command/first-nol
  #ble-bind -m vi_xmap -f 'g g' vi-command/first-nol
  #ble-bind -m vi_nmap -f 'G' vi-command/last-line
  #ble-bind -m vi_omap -f 'G' vi-command/last-line
  #ble-bind -m vi_xmap -f 'G' vi-command/last-line


  ## The default mapping of 'C-r' in the normal mode is "vi_nmap/redo".  If you
  ## want to use the incremental search mode from Emacs in the Vim mode (as in
  ## Readline), please use the following keybinding.

  #ble-bind -m vi_nmap -f 'C-r' history-isearch-backward

  #----------------------------------------------------------------------------
  # Cursor shapes and other terminal settings

  ## Cursor settings

  #ble-bind -m vi_nmap --cursor 2
  #ble-bind -m vi_imap --cursor 5
  #ble-bind -m vi_omap --cursor 4
  #ble-bind -m vi_xmap --cursor 2
  #ble-bind -m vi_smap --cursor 2
  #ble-bind -m vi_cmap --cursor 0

  ## DECSCUSR setting
  ##
  ##   If you don't have the entry Ss in terminfo, yet your terminal supports
  ##   DECSCUSR, please comment out the following line to enable DECSCUSR.
  ##
  #_ble_term_Ss=$'\e[@1 q'

  ## Control sequences that will be output on entering each mode
  #bleopt term_vi_nmap=
  #bleopt term_vi_imap=
  #bleopt term_vi_omap=
  #bleopt term_vi_xmap=
  #bleopt term_vi_smap=
  #bleopt term_vi_cmap=

  #----------------------------------------------------------------------------
  # Miscellaneous settings

  ## This option controls the frequency of recording "undo".  When the value
  ## "more" is specified, "undo" will be recorded for various operations in
  ## "vi_imap".

  #bleopt keymap_vi_imap_undo=


  ## This option controls the behavior of motion in select mode.  The value is
  ## a list of words separated by commas.  When the word "stopsel" is contained
  ## in this option, ble.sh exits the select mode with a motion in select mode.

  #bleopt keymap_vi_keymodel=


  ## This option sets the upper limit of the maximal depth of recurrence of

  ## replaying keyboard macros.
  #bleopt keymap_vi_macro_depth=64


  ## This option specifies the operator name when the user input "g@" in normal
  ## mode.  The function "ble/keymap:vi/operator:$value", where "$value" is the
  ## value of this setting, is used as the implementation of the operator.

  #bleopt keymap_vi_operatorfunc=


  ## When this option has a non-empty value, "/", "?", "n", "N" search the word
  ## on the current position.  When this option has the empty value, these keys
  ## follows the behavior of `vim`.

  #bleopt keymap_vi_search_match_current=

  #----------------------------------------------------------------------------
  # plugins

  ## vim-surround

  #ble-import vim-surround
  #bleopt vim_surround_45:=$'$( \r )'
  #bleopt vim_surround_61:=$'$(( \r ))'

  ## vim-arpeggio

  #ble-import vim-arpeggio
  #bleopt vim_arpeggio_timeoutlen=10
  #ble/lib/vim-arpeggio.sh/bind -s jk 'hello'

  ## vim-airline

  #ble-import vim-airline
  #bleopt vim_airline_theme=light
  #bleopt vim_airline_section_a='\e[1m\q{lib/vim-airline/mode}'
  #bleopt vim_airline_section_b='\q{lib/vim-airline/gitstatus}'
  #bleopt vim_airline_section_c='\w'
  #bleopt vim_airline_section_x='bash'
  #bleopt vim_airline_section_y='$_ble_util_locale_encoding[unix]'
  #bleopt vim_airline_section_z=' \q{history-percentile} \e[1m!\q{history-index}/\!\e[22m \q{position}'
  #bleopt vim_airline_left_sep=$'\uE0B0'
  #bleopt vim_airline_left_alt_sep=$'\uE0B1'
  #bleopt vim_airline_right_sep=$'\uE0B2'
  #bleopt vim_airline_right_alt_sep=$'\uE0B3'
  #bleopt vim_airline_symbol_branch=$'\uE0A0'
  #bleopt vim_airline_symbol_dirty=$'\u26A1'
}
blehook/eval-after-load keymap_vi blerc/vim-load-hook

##-----------------------------------------------------------------------------
## Internal settings


## When the option "connect_tty" is set to a non-empty value, ble.sh in the
## child interactive Bash processes tries to connect to /dev/tty for its user
## interface when the initial standard streams of Bash are redirected to
## non-TTY streams.  The standard streams for the user command executions are
## kept to be the original ones.  This does not affect the behavior of the
## current session.  If it is set to the value "inherit", ble.sh tries to
## export the TTY for the child ble.sh sessions.  This might cause an issue in
## non-closing terminal window when a background process starts in the session.
## The default value is "1".

#bleopt connect_tty=


## This option sets the interval of checking new user inputs.  The value is
## evaluated as an arithmetic expression.  On the evaluation, a shell variable
## "ble_util_idle_elapsed" is provided for the time since the last user input
## in millisecond.  This option is used for the polling for the background
## execution when there is no user inputs.

#bleopt idle_interval='ble_util_idle_elapsed>600000?500:(ble_util_idle_elapsed>60000?200:(ble_util_idle_elapsed>5000?100:20))'


## This option specifies a colon-separated list of custom search paths of "ble-import".

#bleopt import_path="${XDG_DATA_HOME:-$HOME/.local/share}/blesh/local"


## When a non-empty value is specified to this option, displays the internal
## syntax analysis information and the syntax tree.  This is only effective in
## devel versions.

#bleopt syntax_debug=


## When the option "debug_xtrace" contains a non-empty value, xtrace (set -x)
## is enabled for the internal processing of ble.sh.  The value is used for the
## xtrace output log filename. [ Caution: The file size of the log file can
## soon grow up to hundred megabytes or to gigabytes. ]  The option
## "debug_xtrace_ps4" specifies the value of PS4 for xtrace enabled by
## "debug_xtrace".

#bleopt debug_xtrace=~/blesh.xtrace
#bleopt debug_xtrace_ps4='+ '


## When the option "debug_idle" contains a non-empty value, the background
## tasks currently running are shown in the info panel.

#bleopt debug_idle=1


## [The setting "openat_base" needs to be set before ble.sh is loaded or
## specified in the source options.  Therefore the value should be assigned
## directly to the shell variable "bleopt_openat_base" instead of using
## "bleopt" command.]
##
## This setting "openat_base" specifies the starting number of the file
## descriptors which ble.sh internally uses in Bash 4.0 or lower.  The value of
## this setting is used as the number for the first file descriptor of internal
## use, and the next value is used for the second file descriptor, and so on.
## When you want to use the default value 30 and succeeding number 31, 32,
## etc. for other purposes, please set to this settings another value which
## does not conflict with file descriptors of other purposes.

# echo "usage: e.g. source out/ble.sh -o openat_base=30"


## This option specifies the context of the command execution.  The value
## "gexec" specifies that the user command is evaluated in global contexts.
## The value "exec" (ble-0.3 and before) specified that the user command is
## evaluated in a function, but the support is removed in ble-0.4 because this
## is only remained for a debugging purpose and not tested well.

#bleopt internal_exec_type=gexec


## If this option has a non-empty value, when the execution of a shell function
## is interrupted by SIGINT, the processing of SIGINT by the DEBUG trap is
## printed to stderr.  The default is empty.

#bleopt internal_exec_int_trace=1


## This option sets the message that Bash outputs when "C-d" is input by user.
## This value is used to detect that the user inputs "C-d" in Bash 3.

#bleopt internal_ignoreeof_trap='Use "exit" to leave the shell.'


## This option controls the output of stack dump when assertion is failed in
## ble.sh.  When the value is evaluated to be non-zero, the stack dump is
## printed for assertion failures.

#bleopt internal_stackdump_enabled=0


## When a non-empty value is specified to this option, the standard output and
## standard error from Bash is not output to the terminal.  When the value is
## empty, ble.sh tries to realize the line editing allowing Bash to output its
## own standard output and error.  This setting has a flickering problem and
## only left for debugging purpose, so it is not tested.  Normally a non-empty
## value should be specified so as to suppress the standard output and error
## from Bash.

#bleopt internal_suppress_bash_output=1


## This is a colon-separated list of fields to control the behavior of
## ble/debug/profiler.  When the field "line" and "func" are specified,
## statistics for lines and function calls, respectively, are enabled.  When
## the field "tree" is specified, function-call trees are saved.  Optional
## parameter "html" can be specified to "line" and "func" separated by the
## equal sign, i.e., "line=html" and "func=html".  In such a case, the results
## are also saved in the .html format.

#bleopt debug_profiler_opts=line:func


## This option specifies the threshold time in milliseconds to determine
## whether to include a command in the tree generated by "bleopt
## debug_profiler_opts=tree".  The commands that took less than this time in
## execution will be skipped.  The default value is 5.0 msec.

#bleopt debug_profiler_tree_threshold=5.0
