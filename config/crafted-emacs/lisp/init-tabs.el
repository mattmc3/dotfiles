;;; init-tabs.el --- Buffer tabs setup -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Use tab line
;; (global-tab-line-mode 1)

(use-package centaur-tabs
  :init
  (setq centaur-tabs-set-icons t
        centaur-tabs-gray-out-icons t
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker "*")
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-group-by-projectile-project))

;; Centaur tabs is nice
(global-set-key (kbd "C-<prior>")  'centaur-tabs-backward)
(global-set-key (kbd "C-<next>") 'centaur-tabs-forward)

(defun centaur-tabs-buffer-groups ()
      "`centaur-tabs-buffer-groups' control buffers' group rules.
    Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
    All buffer name start with * will group to \"Emacs\".
    Other buffer group by `centaur-tabs-get-group-name' with project name."
      (list
    (cond
     ((or (string-equal "*" (substring (buffer-name) 0 1))
          (memq major-mode '(magit-process-mode
              magit-status-mode
              magit-diff-mode
              magit-log-mode
              magit-file-mode
              magit-blob-mode
              magit-blame-mode
              )))
      "Emacs")
     ((derived-mode-p 'dired-mode)
      "Dired")
     ((memq major-mode '(helpful-mode
               help-mode))
      "Help")
     (t
      (centaur-tabs-get-group-name (current-buffer))))))

(provide 'init-tabs)
