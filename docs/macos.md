# macOS

## DefaultKeyBinding.dict

```
/* ~/Library/KeyBindings/DefaultKeyBinding.Dict

https://gist.githubusercontent.com/trusktr/1e5e516df4e8032cbc3d/raw/ab7c868a8354219782b37971f984564c66a53d78/DefaultKeyBinding.dict

This file remaps the key bindings of a single user on Mac OS X 10.5 to more
closely match default behavior on Windows systems. This makes the Command key
behave like Windows Control key. To use Control instead of Command, either swap
Control and Command in Apple->System Preferences->Keyboard->Modifier Keys...
or replace @ with ^ in this file.

Here is a rough cheatsheet for syntax.
Key Modifiers
^ : Ctrl
$ : Shift
~ : Option (Alt)
@ : Command (Apple)
# : Numeric Keypad

Non-Printable Key Codes

Standard
Up Arrow:     \UF700        Backspace:    \U0008        F1:           \UF704
Down Arrow:   \UF701        Tab:          \U0009        F2:           \UF705
Left Arrow:   \UF702        Escape:       \U001B        F3:           \UF706
Right Arrow:  \UF703        Enter:        \U000A        ...
Insert:       \UF727        Page Up:      \UF72C
Delete:       \UF728        Page Down:    \UF72D
Home:         \UF729        Print Screen: \UF72E
End:          \UF72B        Scroll Lock:  \UF72F
Break:        \UF732        Pause:        \UF730
SysReq:       \UF731        Menu:         \UF735
Help:         \UF746

OS X
delete:       \U007F

For a good reference see http://osxnotes.net/keybindings.html.

NOTE: typically the Windows 'Insert' key is mapped to what Macs call 'Help'.
Regular Mac keyboards don't even have the Insert key, but provide 'Fn' instead,
which is completely different.
*/

{
    "@\UF72B"  = "moveToEndOfDocument:";                         /* Cmd  + End   */
    "@\UF729"  = "moveToBeginningOfDocument:";                   /* Cmd  + Home  */

    "\UF729"   = "moveToBeginningOfLine:";                       /* Home         */
    "\UF72B"   = "moveToEndOfLine:";                             /* End          */

    "$\UF729"  = "moveToBeginningOfLineAndModifySelection:";     /* Shift + Home */
    "$\UF72B"  = "moveToEndOfLineAndModifySelection:";           /* Shift + End  */
}
```
