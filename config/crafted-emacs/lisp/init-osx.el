;; -*- lexical-binding: t -*-

;;; Commentary:

;;
;; MacOS.
;;

;;; Code:

(setq mac-option-key-is-meta t
      mac-command-key-is-meta nil
      mac-command-modifier 'super
      mac-option-modifier 'meta)

;; Make mouse wheel / trackpad scrolling less jerky
(setq mouse-wheel-scroll-amount '(1
                                ((shift) . 5)
                                ((control))))
(dolist (multiple '("" "double-" "triple-"))
(dolist (direction '("right" "left"))
    (global-set-key (read-kbd-macro (concat "<" multiple "wheel-" direction ">")) 'ignore)))
(global-set-key (kbd "M-`") 'ns-next-frame)
(global-set-key (kbd "M-h") 'ns-do-hide-emacs)
(global-set-key (kbd "M-˙") 'ns-do-hide-others)
(with-eval-after-load 'nxml-mode
(define-key nxml-mode-map (kbd "M-h") nil))
(global-set-key (kbd "M-ˍ") 'ns-do-hide-others) ;; what describe-key reports for cmd-option-h

;; sublime ⌘-P opens the command window
(global-set-key (kbd "s-P") 'execute-extended-command)

;; Now, let's set up some better CUA support
;; https://www.emacswiki.org/emacs/CuaMode - this isn't helpful on a Mac
;; (cua-mode t) ;; this is the Windows way, but the Mac uses command keys, so let's manually set that up
;; (global-set-key [(alt c)] 'kill-ring-save)
;; (global-set-key [(alt v)] 'yank)
;; (global-set-key [(alt x)] 'kill-region)
;; https://osdn.net/projects/macwiki/svn/view/zenitani/CarbonEmacs/src/lisp/mac-key-mode.el?root=macwiki&view=markup
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

(provide 'init-osx)
