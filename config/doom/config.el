;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.



;; Custom

;; make the cursor a bar, not a blinking box
(setq-default cursor-type 'bar)

;; line numbers
(global-display-line-numbers-mode)

;; hide splash screen
;; (setq inhibit-splash-screen t)

;; empty *scratch*
;; (setq initial-scratch-message "")

;; desktop save mode (session restore)
(setq desktop-save t)
(desktop-save-mode 1)

;; trailing newlines are the bomb
(setq require-final-newline t)

;; highlight the current line
(global-hl-line-mode +1)

;; Set the font
;; On a Mac, fonts can be found in the FontBook app
(ignore-errors (set-frame-font "MesloLGL Nerd Font 14"))

;; recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; show tab bar (er... don't actually show it and use ui: tabs per doom docs)
;; (global-tab-line-mode t)

;; don't confirm when emacs exits
(setq confirm-kill-emacs nil)

;;; Whitespace
;; (setq whitespace-style '(face
;;                          tabs
;;                          tab-mark
;;                          trailing
;;                          space-before-tab
;;                          missing-newline-at-eof))
(whitespace-mode)
(whitespace4r-mode)


;;; Keybindings

;; In the old days ESC was used as a prefix key, but I want ESC to act like it
;; does everywhere else on my system and, you know, escape from things. So
;; I've remapped ESC to `keyboard-quit'.
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; Make shift-click extend the selection (region)
(global-set-key [S-down-mouse-1] 'ignore)
(global-set-key [S-mouse-1] 'mouse-save-then-kill)

;; Use M-drag-mouse-1 to create rectangle regions
(global-set-key [M-down-mouse-1] #'mouse-drag-region-rectangle)
(global-set-key [M-drag-mouse-1] #'ignore)
(global-set-key [M-mouse-1]      #'mouse-set-point)

;; Make emacs keybindings work like other Mac apps
(global-set-key [(super up)] 'beginning-of-buffer)
(global-set-key [(super down)] 'end-of-buffer)
(global-set-key [(super left)] 'beginning-of-line)
(global-set-key [(super right)] 'end-of-line)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-/") 'evilnc-comment-or-uncomment-lines)
;; (global-set-key (kbd "s-/") 'comment-dwim)

;; sublime ⌘-P opens the command window
(global-set-key (kbd "s-P") 'execute-extended-command)

;; multiple cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "s-d") 'mc/mark-next-like-this-word)
(global-set-key (kbd "s-L") 'mc/edit-ends-of-lines)

;;; config.el ends here
