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
;; (require 'crafted-defaults)    ; Sensible default settings for Emacs
;; (require 'crafted-updates)     ; Tools to upgrade Crafted Emacs
;; (require 'crafted-completion)  ; selection framework based on `vertico`
;; (require 'crafted-ui)          ; Better UI experience (modeline etc.)
;; (require 'crafted-ide)         ; Eglot configuration
;; (require 'crafted-windows)     ; Window management configuration
;; (require 'crafted-editing)     ; Whitspace trimming, auto parens etc.
;; ;(require 'crafted-evil)        ; An `evil-mode` configuration
;; (require 'crafted-org)         ; org-appear, clickable hyperlinks etc.
;; (require 'crafted-project)     ; built-in alternative to projectile
;; (require 'crafted-speedbar)    ; built-in file-tree
;; (require 'crafted-screencast)  ; show current command and binding in modeline
;; ;;(require 'crafted-compile)     ; automatically compile some emacs lisp files

(require 'init-cursor)
(require 'init-fish)
(require 'init-mouse)
(require 'init-multicursor)
(require 'init-org)
(require 'init-osx)
(require 'init-scratch)
(require 'init-tabline)
(require 'init-theme)
(require 'init-xah-fly-keys)
;;(require 'init-meow)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; To not load `custom.el' after `config.el', uncomment this line.
;; (setq crafted-load-custom-file nil)

(customize-set-variable 'crafted-startup-inhibit-splash t)

;; We have version control nowadays.
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Speedbar
(setq-default speedbar-use-images t)
(global-set-key (kbd "s-b") 'speedbar)

;; Make ESC behave more like it does in other editors
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;;; config.el ends here
