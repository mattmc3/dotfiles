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

(provide 'init-org)
