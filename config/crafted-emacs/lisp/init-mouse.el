;; -*- lexical-binding: t -*-

;;; Commentary:

;;
;; Mouse.
;;

;;; Code:

;; Make shift-click extend the selection (region)
(global-set-key [S-down-mouse-1] 'ignore)
(global-set-key [S-mouse-1] 'mouse-save-then-kill)

(provide 'init-mouse)
