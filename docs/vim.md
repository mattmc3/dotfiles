# vim

## Colemak

One of the tricky elements of using Colemak is the vim arrow movements (HJKL)
are positional instead of mnemonic, and those positions change from QWERTY.

There are a few approaches that I can take to address this:

1. Ignore it and leave everything as-is
1. Minimally change it to make it tolerable
1. Change it entirely to make it sane. With a subtype of doing it in such a way
   that it's also okay to use in QWERTY mode in case I ever have to flip back.

### Ignore it

[This blog post](https://sermoa.wordpress.com/2011/12/16/colemak-and-vim-but-what-about-hjkl/)
is a good advocacy for leaving the default nav of hjkl.

"         ↑
"         k          Hint: The `h`{normal} key is at the left and moves left.
"     ← h   l →            The `l`{normal} key is at the right and moves right.
"         j                The `j`{normal} key looks like a down arrow.
"         ↓

### Minimally change keys

J is north of K in Colemak which makes it feel like a flight simulator to ignore the

`set langmap=jh,kj,hk`

### Change entirely

One option is to mix QWERTY and Colemak positional

```vim
" Remap for Colemak based on https://github.com/ohjames/colemak/blob/master/vimrc
" rotate some keys about to get qwerty "hjkl" back for movement
noremap n j
noremap e k
noremap i l

" move these keys to their qwerty positions because they are
" in the way of hjkl (and E for J)
noremap k n
noremap K N
noremap u i
noremap U I
noremap l u
noremap L U
noremap N J
noremap E K
noremap I L

" this is the only key that isn't in qwerty or colemak position
noremap j e
noremap J E
```

Another option is NEST:

https://stackoverflow.com/questions/253820/colemak-keyboards-with-emacs-or-vim
https://forum.colemak.com/topic/50-colemak-vim/p2/#p2514
https://www.ryanheise.com/colemak/

"         ↑
"         e
"     ← s   t →
"         n
"         ↓
noremap n j|noremap <C-w>n <C-w>j|noremap <C-w><C-n> <C-w>j
noremap e k|noremap <C-w>e <C-w>k|noremap <C-w><C-e> <C-w>k
noremap s h
noremap t l

noremap f e
noremap k n
noremap K N

