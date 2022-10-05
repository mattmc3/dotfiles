;; -*- lexical-binding: t -*-

;;; Commentary:

;;
;; Commenting
;;

;;; Code:

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

(provide 'init-commenting)
