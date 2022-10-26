;;; init-defaults.el -*- lexical-binding: t; -*-

;;; Commentary:

;; General sane defaults

;;; Code:

;; We have version control nowadays.
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Don't prompt when opening a symlink, just follow it
(setq vc-follow-symlinks t)

;; Make ESC behave more like it does in other editors
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

(global-display-line-numbers-mode t)

(provide 'init-defaults)

;;; init-defaults.el ends here
