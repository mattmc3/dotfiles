# shellcheck shell=bash

if [[ "$OSTYPE" == darwin* && -x /usr/libexec/java_home ]]; then
  alias setjavahome='export JAVA_HOME="$(/usr/libexec/java_home)"'
fi
