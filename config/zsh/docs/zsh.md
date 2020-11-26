# ZSH reference

I can't always remember all the ZSH goodies, so here's all the wonderful stuff I have learned and references to things other's have provided.

## Globbing

[Glob qualifiers][zsh-glob-qualifiers] are options tacked onto a wildcard pattern that filter or modify the match. Some examples:

```zsh
cd $ZDOTDIR
```

Show directories with `/`:

```zsh
$ echo *(/)
.zshrc.d .zfunctions
```

Show regular files with `.`:

```zsh
$ echo *(.)
.zlogin .zshenv .zshrc
```

Show symlinks with `@`:

```zsh
$ echo *(@)
.zsh_history
```

Toggle qualifiers to work with symlinks `-`:

```zsh
$ echo *(.-)
.zlogin .zshenv .zsh_history .zshrc
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
.zlogin .zshrc
```

## Expansion Modifiers

[Expansion modifiers][zsh-modifiers] change the path stored in a variable.

Set a file path in a variable to play with:

```zsh
$ cd $ZSH
$ filepath=./plugins/extract/extract.plugin.zsh
```

`:a` will expand a relative filepath to an absolute one

```zsh
$ echo $filepath
./plugins/extract/extract.plugin.zsh
$ echo ${filepath:a}
$ZSH/plugins/extract/extract.plugin.zsh
```

`:h` will remove the trailing pathname component, shortening the path by one directory level. This is the 'head' of the pathname, which works like `dirname`.

```zsh
$ echo ${filepath:h}
./plugins/extract
```

`:r` will remove the file extension leaving the 'root' name.

```zsh
$ echo ${filepath:r}
./plugins/extract/extract.plugin
```

`:t` will remove all leading path components leaving the final part, or 'tail'. This works like `basename`.

```zsh
$ echo ${filepath:t}
extract.plugin.zsh
```

`:u` will convert the variable to UPPERCASE. Conversely, `:l` will convert back to lowercase.

```zsh
$ echo ${filepath:u}
./PLUGINS/EXTRACT/EXTRACT.PLUGIN.ZSH
$ echo ${filepath:u:l}
./plugins/extract/extract.plugin
```

## Other great configs

- [Grml][grml-zshrc]

[zsh-modifiers]: http://zsh.sourceforge.net/Doc/Release/Expansion.html#Modifiers
[filename-generation]:  http://zsh.sourceforge.net/Doc/Release/Expansion.html#Filename-Generation
[zsh-glob-qualifiers]:  http://zsh.sourceforge.net/Doc/Release/Expansion.html#Glob-Qualifiers
[glob-filter-stackexchange]: https://unix.stackexchange.com/questions/31504/how-do-i-filter-a-glob-in-zsh
[grml-zshrc]: https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
