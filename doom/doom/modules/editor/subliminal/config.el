;; subliminal
;; SublimeText behavior and keyboard shortcuts to help ease the transition

(defun move-line-up ()
  "Move the current line up."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move the current line down."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

;; key binding examples
;; https://github.com/hlissner/doom-emacs/blob/develop/docs/api.org#map
;; ;; (global-set-key (kbd "C-x y") #'do-something)
;; ;; (map! "C-x y" #'do-something)

;; move lines with ctrl-cmd-up/down
(map! "C-s-<up>" 'move-line-up)
(map! "C-s-<down>" 'move-line-down)
(map! :map org-mode-map "C-s-<up>" #'org-move-subtree-up)
(map! :map org-mode-map "C-s-<down>" #'org-move-subtree-down)

;; multi-cursor select match
(map! "s-d" 'evil-multiedit-match-and-next)
(map! "s-D" 'evil-multiedit-match-and-prev)

;; multi-cursor "split into lines" ala Sublime (in normal or visual mode)
(map! :nv "s-L" 'evil-mc-make-cursor-in-visual-selection-end)
