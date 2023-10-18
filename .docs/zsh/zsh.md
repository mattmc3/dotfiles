# Zsh reference

I can't always remember all the Zsh goodies, so here's all the wonderful stuff I have
learned and references to things other's have provided.

## Bare Zsh

Zsh can be run without RCs using the following command:

```zsh
zsh -dfi
```

When run this way, be careful - all exported environment variables are still set.

If you want to run a totally clean environment, you can with with `env -i`.

```
env -i zsh -dfi
```

## $0

`${BASH_SOURCE[0]` is `${(%):-%x}}` in Zsh

For example:

```zsh
# $ZDOTDIR/functions/foo
#functon foo {

# prints foo
echo $0

# prints $ZDOTDIR/functions/foo
echo ${(%):-%x}

#}
```

- [See here](https://stackoverflow.com/questions/9901210/bash-source0-equivalent-in-zsh)

## String functions

If you want to replace '~' with '$HOME' in a variable, you can do this:

```zsh
mydir='~/path/to/my/dir'
mydir=${mydir:s/~/$HOME}
echo $mydir
```

## Option parsing

Features:
- supports short and long flags (ie: -v|--verbose)
- supports short and long key/value options (ie: -f <file> | --filename <file>)
- does NOT support short and long key/value options with equals assignment (ie: -f=<file> | --filename=<file>)
- supports short option chaining (ie: -vh)
- everything after -- is positional even if it looks like an option (ie: -f)
- once we hit an arg that isn't an option flag, everything after that is considered positional

Resources:
- [https://xpmo.gitlab.io/post/using-zparseopts](https://xpmo.gitlab.io/post/using-zparseopts)
- [https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#index-zparseopts](https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#index-zparseopts)

### zparseopts

```zsh
function zparseopts_demo() {
  local flag_help flag_verbose
  local arg_filename=(myfile)  # set a default
  local usage=(
    "zparseopts_demo [-h|--help]"
    "zparseopts_demo [-v|--verbose] [-f|--filename=<file>] [<message...>]"
  )

  # -D pulls parsed flags out of $@
  # -E allows flags/args and positionals to be mixed, which we don't want in this example
  # -F says fail if we find a flag that wasn't defined
  # -M allows us to map option aliases (ie: h=flag_help -help=h)
  # -K allows us to set default values without zparseopts overwriting them
  zmodload zsh/zutil
  zparseopts -D -F -K -- \
    {h,-help}=flag_help \
    {v,-verbose}=flag_verbose \
    {f,filename}:=arg_filename ||
    return 1

  [[ -z "$flag_help" ]] || { print -l $usage && return }
  if (( $#flag_verbose )); then
    echo "verbose mode"
  fi

  echo "--verbose: $flag_verbose"
  echo "--filename: $arg_filename[-1]"
  echo "positional: $@"
}
```

### Manually

You can manually parse options with a `case` statement:

```zsh
function optparsing_demo() {
  local positional=()
  local flag_verbose=false
  local filename=myfile

  local usage=(
    "optparsing_demo [-h|--help]"
    "optparsing_demo [-v|--verbose] [-f|--filename=<file>] [<message...>]"
  )
  opterr() { echo >&2 "optparsing_demo: Unknown option '$1'" }

  # supports short and long flags (ie: -v|--verbose)
  # supports short and long key/value options (ie: -f <file> | --filename <file>)
  # supports short and long key/value options with equals assignment (ie: -f=<file> | --filename=<file>)
  # does not support short option chaining (ie: -vh)
  # everything after -- is positional even if it looks like an option (ie: -f)
  # once we hit an arg that isn't an option flag, everything after that is considered positional

  while (( $# )); do
    case $1 in
      --)                 shift; positional+=("$@"); break  ;;
      -h|--help)          printf "%s\n" $usage && return    ;;
      -v|--verbose)       flag_verbose=true                 ;;
      -f|--filename)      shift; filename=$1                ;;
      -f=*|--filename=*)  filename="${1#*=}"                ;;
      -*)                 opterr $1 && return 2             ;;
      *)                  positional+=("$@"); break         ;;
    esac
    shift
  done

  echo "--verbose: $flag_verbose"
  echo "--filename: $filename"
  echo "positional: $positional"
}
```

## Globbing

[Glob qualifiers][zsh-glob-qualifiers] are options tacked onto a wildcard pattern that
filter or modify the match. Some examples:

```zsh
cd $ZDOTDIR
```

Show directories with `/`:

```zsh
$ echo *(/)
plugins zshrc.d zfunctions
```

Show regular files with `.`:

```zsh
$ echo *(.)
.zshenv .zshrc
```

Show symlinks with `@`:

```zsh
$ echo *(@)
.zsh_history
```

Toggle qualifiers to work with symlinks `-`:

```zsh
$ echo *(.-)
.zshenv .zsh_history .zshrc
```

Exclude files with `^`:

```zsh
$ # exclude dotfiles
$ echo ^.*
README.md
```

Null glob, or "don't error on zero results":

```zsh
$ mkdir empty && cd empty
$ echo *
zsh: no matches found: *
$ echo *(N)
```

Files over/unsder a certain size with `L[+|-]n`:

```zsh
$ # files over 1k
$ echo *(Lk+1)
LICENSE README.md
```

## Expansion Modifiers

[Expansion modifiers][zsh-modifiers] change the path stored in a variable.

Set a file path in a variable to play with (assumes OMZ installed):

```zsh
cd $ZSH
filepath=./plugins/extract/extract.plugin.zsh
```

`:a` will expand a relative filepath to an absolute one

```zsh
$ echo $filepath
./plugins/extract/extract.plugin.zsh
$ echo ${filepath:a}
$ZSH/plugins/extract/extract.plugin.zsh
```

`:h` will remove the trailing pathname component, shortening the path by one directory
level. This is the 'head' of the pathname, which works like `dirname`.

```zsh
$ echo ${filepath:h}
./plugins/extract
```

`:r` will remove the file extension leaving the 'root' name.

```zsh
$ echo ${filepath:r}
./plugins/extract/extract.plugin
```

`:t` will remove all leading path components leaving the final part, or 'tail'. This
works like `basename`.

```zsh
$ echo ${filepath:t}
extract.plugin.zsh
```

`:u` will convert the variable to UPPERCASE. Conversely, `:l` will convert back to
lowercase.

```zsh
$ echo ${filepath:u}
./PLUGINS/EXTRACT/EXTRACT.PLUGIN.ZSH
$ echo ${filepath:u:l}
./plugins/extract/extract.plugin
```

[zsh-modifiers]: http://zsh.sourceforge.net/Doc/Release/Expansion.html#Modifiers
[filename-generation]:  http://zsh.sourceforge.net/Doc/Release/Expansion.html#Filename-Generation
[zsh-glob-qualifiers]:  http://zsh.sourceforge.net/Doc/Release/Expansion.html#Glob-Qualifiers
[glob-filter-stackexchange]: https://unix.stackexchange.com/questions/31504/how-do-i-filter-a-glob-in-zsh
