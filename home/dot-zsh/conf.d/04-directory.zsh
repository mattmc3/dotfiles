typeset -ga zopts_directory=(
  AUTO_CD              # Auto changes to a directory without typing cd.
  AUTO_PUSHD           # Push the old directory onto the stack on cd.
  PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
  PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
  PUSHD_TO_HOME        # Push to home directory when no argument is given.
  CDABLE_VARS          # Change directory to a path stored in a variable.
  MULTIOS              # Write to multiple descriptors.
  EXTENDED_GLOB        # Use extended globbing syntax.
  NO_CLOBBER           # Do not overwrite files with > and >>. Use >| to bypass.
)
setopt $zopts_directory

alias -- -='cd -'
alias dirh='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index
