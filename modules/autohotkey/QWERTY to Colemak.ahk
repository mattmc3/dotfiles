; Colemak layout for AutoHotkey (MS Windows)
; 2006-01-01 Shai Coleman, http://colemak.com/ . Public domain.
; See http://www.autohotkey.com/ for more information

; For this to work you have to make sure that the US (QWERTY) layout is installed,
; that is set as the default layout, and that it is set as the current layout.
; Otherwise some of the key mappings will be wrong.
;
; This is mainly useful for those who don't have privileges to install a new layout
; This doesn't support the international features of the Colemak layout.

#SingleInstance force
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode 3  ; Exact matching to avoid confusing T/B with Tab/Backspace.

;`::`
;1::1
;2::2
;3::3
;4::4
;5::5
;6::6
;7::7
;8::8
;9::9
;0::0
;-::-
;=::=

;q::q
;w::w
e::f
r::p
t::g
y::j
u::l
i::u
o::y
p::`;
;[::[
;]::]
;\::\

;a::a
s::r
d::s
f::t
g::d
;h::h
j::n
k::e
l::i
`;::o
;'::'

;z::z
;x::x
;c::c
;v::v
;b::b
n::k
;m::m
;,::,
;.::.
;/::/

Capslock::Backspace

;RCtrl::RWin
;RWin::RCtrl
;LCtrl::LWin
;LWin::LCtrl

; Doesn't seem to work
;LWin::Ctrl
;LCtrl::LWin
;#::Send, ^

#a::Send ^a
#c::Send ^c
#x::Send ^x
#v::Send ^v
#z::Send ^z
#s::Send ^s
#h::Send ^h
#f::Send ^f
#+Left::Send {ctrl down}{shift down}{Left}{shift up}{ctrl up}
#+Right::Send {ctrl down}{shift down}{Right}{shift up}{ctrl up}
;#+R::Send {f5}
;$f5::Send {ctrl down}{shift down}R{shift up}{ctrl up}


#IfWinActive ahk_class Notepad
#+F::MsgBox You pressed Win+Spacebar in Notepad.
#IfWinActive

; CMD+SHIFT+R for running a query in SSMS
#+R::Send {f5}
#+F::Send ^H

^\::`
^|::~


#Persistent

OnClipboardChange:
FileDelete, %A_ScriptDir%\CurrentClip.txt
FileAppend, %Clipboard%, %A_ScriptDir%\CurrentClip.txt
return
