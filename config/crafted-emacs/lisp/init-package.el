;;; init-package.el --- Emacs Package management -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; straight and use-package
;; https://github.com/raxod502/straight.el#integration-with-use-package
;; https://github.com/jwiegley/use-package
;; https://jeffkreeftmeijer.com/emacs-straight-use-package/

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package
(straight-use-package 'use-package)

;; Configure use-package to use straight.el by default
(setq straight-use-package-by-default t
      use-package-always-ensure t
      straight-check-for-modifications nil)

(provide 'init-package)
