;;(defun add-list-to-list (dst src)
;;   "Similar to `add-to-list', but accepts a list as 2nd argument"
;;   (set dst
;;        (append (eval dst) src)))

;; ;; set the initial window position an UI elements
;; (add-list-to-list 'default-frame-alist
;;                   '((width . 120)
;;                     (left . 150)
;;                     (top . 100)))

(setq default-frame-alist
      '((height . 35)
        (width . 120)
        (left . 150)
        (top . 100)
        (vertical-scroll-bars . nil)
        (horizontal-scroll-bars . nil)
        (tool-bar-lines . 0)))
