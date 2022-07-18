;;; config.el -- Crafted Emacs user customization file -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Crafted Emacs supports user customization through a `config.el' file
;; similar to this one.  You can copy this file as `config.el' to your
;; Crafted Emacs configuration directory as an example.
;;
;; In your configuration you can set any Emacs configuration variable, face
;; attributes, themes, etc as you normally would.
;;
;; See the README.org file in this repository for additional information.

;;; Code:
;; At the moment, Crafted Emacs offers the following modules.
;; Comment out everything you don't want to use.
;; At the very least, you should decide whether or not you want to use
;; evil-mode, as it will greatly change how you interact with Emacs.
;; So, if you prefer Vim-style keybindings over vanilla Emacs keybindings
;; remove the comment in the line about `crafted-evil' below.
(require 'crafted-defaults)    ; Sensible default settings for Emacs
(require 'crafted-use-package) ; Configuration for `use-package`
(require 'crafted-updates)     ; Tools to upgrade Crafted Emacs
(require 'crafted-completion)  ; selection framework based on `vertico`
(require 'crafted-ui)          ; Better UI experience (modeline etc.)
(require 'crafted-windows)     ; Window management configuration
(require 'crafted-editing)     ; Whitspace trimming, auto parens etc.
;(require 'crafted-evil)        ; An `evil-mode` configuration
(require 'crafted-org)         ; org-appear, clickable hyperlinks etc.
(require 'crafted-project)     ; built-in alternative to projectile
(require 'crafted-speedbar)    ; built-in file-tree
(require 'crafted-screencast)  ; show current command and binding in modeline
(require 'crafted-compile)     ; automatically compile some emacs lisp files

;; Set the default face. The default face is the basis for most other
;; faces used in Emacs. A "face" is a configuration including font,
;; font size, foreground and background colors and other attributes.
;; The fixed-pitch and fixed-pitch-serif faces are monospace faces
;; generally used as the default face for code. The variable-pitch
;; face is used when `variable-pitch-mode' is turned on, generally
;; whenever a non-monospace face is preferred.
(add-hook 'emacs-startup-hook
          (lambda ()
            (custom-set-faces
             `(default ((t (:font "MesloLGL Nerd Font 13"))))
             `(fixed-pitch ((t (:inherit (default)))))
             `(fixed-pitch-serif ((t (:inherit (default)))))
             `(variable-pitch ((t (:font "Arial 18")))))))

;; Themes are color customization packages which coordinate the
;; various colors, and in some cases, font-sizes for various aspects
;; of text editing within Emacs, toolbars, tabbars and
;; modeline. Several themes are built-in to Emacs, by default,
;; Crafted Emacs uses the `deeper-blue' theme. Here is an example of
;; loading a different theme from the venerable Doom Emacs project.
;; (crafted-package-install-package 'doom-themes)
;; (progn
;;   (disable-theme 'deeper-blue)          ; first turn off the deeper-blue theme
;;   (load-theme 'doom-palenight t))       ; load the doom-palenight theme

;; To not load `custom.el' after `config.el', uncomment this line.
;; (setq crafted-load-custom-file nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; User customizations
;; Anything beyond the default config goes here

(customize-set-variable 'crafted-startup-inhibit-splash t)

;; Use a nice dark theme
(crafted-package-install-package 'modus-themes)
(progn
  (disable-theme 'deeper-blue)
  (load-theme 'modus-vivendi t))

;; On a Mac, fonts can be found in the FontBook app
;;(ignore-errors (set-frame-font "MesloLGL Nerd Font 13"))

;; Use a nice dark theme
;; (crafted-package-install-package 'modus-themes)
;; (load-theme 'modus-vivendi t)

;; Use tab line
(global-tab-line-mode 1)

;; Make the cursor a bar, not a blinking box
(setq-default cursor-type 'bar)

;; We have version control nowadays.
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Better commenting
(defun my/comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no
    active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key (kbd "s-/") 'my/comment-or-uncomment-region-or-line)

(defun my/with-mark-active ()
  "Keep mark active after command. To be used as advice AFTER any
function that sets `deactivate-mark' to t."
  (setq deactivate-mark nil))

(advice-add 'my/comment-or-uncomment-region-or-line :after #'my/with-mark-active)

;; Speedbar
(setq-default speedbar-use-images t)
(global-set-key (kbd "s-b") 'speedbar)

;; Use multi-cursor editing.
(crafted-package-install-package 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "s-d") 'mc/mark-next-like-this-word)
(global-set-key (kbd "s-L") 'mc/edit-ends-of-lines)

;; Make shift-click extend the selection (region)
(global-set-key [S-down-mouse-1] 'ignore)
(global-set-key [S-mouse-1] 'mouse-save-then-kill)

;; Mac settings
(setq mac-option-key-is-meta t
      mac-command-key-is-meta nil
      mac-command-modifier 'super
      mac-option-modifier 'meta)

;; Make emacs keybindings work like other Mac apps
;; https://osdn.net/projects/macwiki/svn/view/zenitani/CarbonEmacs/src/lisp/mac-key-mode.el?root=macwiki&view=markup
(global-set-key [(super up)] 'beginning-of-buffer)
(global-set-key [(super down)] 'end-of-buffer)
(global-set-key [(super left)] 'beginning-of-line)
(global-set-key [(super right)] 'end-of-line)
(global-set-key (kbd "s-o") 'menu-find-file-existing)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-x") 'kill-region)

;; Make ESC behave more like it does in other editors
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; Make org mode keybindings not suck.
;; https://emacs.stackexchange.com/questions/43656/make-c-s-up-handle-shift-selection-under-org-mode
;; https://orgmode.org/manual/Conflicts.html
(setq org-support-shift-select t
      org-replace-disputed-keys t)
(eval-when-compile
  (require 'org))
(eval-after-load "org"
  '(progn
     (define-key org-mode-map (kbd "<S-up>") nil)
     (define-key org-mode-map (kbd "<S-down>") nil)
     (define-key org-mode-map (kbd "<S-left>") nil)
     (define-key org-mode-map (kbd "<S-right>") nil)
     (define-key org-mode-map (kbd "<M-S-left>") nil)
     (define-key org-mode-map (kbd "<M-S-right>") nil)
     (define-key org-mode-map (kbd "<M-left>") nil)
     (define-key org-mode-map (kbd "<M-right>") nil)
     (define-key org-mode-map [C-S-up] 'org-shiftup)
     (define-key org-mode-map [C-S-down] 'org-shiftdown)
     (define-key org-mode-map [C-S-left] 'org-shiftleft)
     (define-key org-mode-map [C-S-right] 'org-shiftright)
     (define-key org-mode-map [C-S-right] 'org-shiftmetaright)
     (define-key org-mode-map [C-S-left] 'org-shiftmetaleft)
     (define-key org-mode-map [C-right] 'org-metaright)
     (define-key org-mode-map [C-left] 'org-metaleft)
     (define-key org-mode-map [C-S-return] 'org-insert-todo-heading)
     ))

;; To not load `custom.el' after `config.el', uncomment this line.
(setq crafted-load-custom-file nil)

;;; config.el ends here
