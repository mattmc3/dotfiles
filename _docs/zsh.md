# zsh

Files in your home directory are typically required configs, so making a zshrc.d
directory means you can have a minimal .zshrc and the directory contains files
that do all the things you would put in ~/.zshrc.

Also, in order to use XDG home, you can just define $ZDOTDIR in ~/.zshenv and
then move everything else out.

## customizing

How, you may ask, can I share my dotfiles with you safely without exposing all
my many zsh secrets? The answer is pretty easy - I have local files that aren't
checked into this repo. Instead, I have a second private repo called
dotfiles.local. This repo has machine level customizations and additional
secrets.

## Resources

- [Terminal Font][terminal-font]: Meslo LG M for Powerline
- [antigen][antigen]
- [antibody][antibody]
- [oh my zsh][omz]
- [supercharge your terminal with zsh][supercharge-zsh]

[antigen]: https://github.com/zsh-users/antigen/wiki/In-the-wild
[antibody]: https://getantibody.github.io/
[supercharge-zsh]: https://blog.callstack.io/supercharge-your-terminal-with-zsh-8b369d689770
[omz]: https://github.com/robbyrussell/oh-my-zsh/tree/master/lib
[terminal-font]: https://github.com/powerline/fonts
