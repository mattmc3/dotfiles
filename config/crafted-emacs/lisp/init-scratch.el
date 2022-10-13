;;; init-scratch.el --- Scratch buffer settings -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; if we want to just set a scratch buffer message, use this
;; (setq initial-scratch-message "")

;; if we want the scratch buffer to behave more like sublime, use the
;; persistent-scratch package
;; https://github.com/Fanael/persistent-scratch

(use-package persistent-scratch
             :config (persistent-scratch-setup-default))

(defun my/new-scratch ()
  "Creates a new scratch buffer."
  (interactive)
  (switch-to-buffer (generate-new-buffer-name "*scratch-new*")))
(global-set-key (kbd "s-n") 'my/new-scratch)


;; TODO: Persist multiple scratch buffers
;; https://umarahmad.xyz/blog/quick-scratch-buffers/
;; (defconst CACHE-DIR (expand-file-name "cache/" user-emacs-directory))

;; (defun random-alnum (&optional length)
;;   (let ((times (or length 1))
;;         (random ""))
;;     (setq-local random "")
;;     (dotimes (_ times)
;;       (setq random (concat random (let* ((alnum "abcdefghijklmnopqrstuvwxyz0123456789")
;;                                          (i (% (abs (random)) (length alnum))))
;;                                     (substring alnum i (1+ i))))))
;;     random))

;; (setq auto-save-list-file-prefix (concat CACHE-DIR "auto-save-list/.saves-")
;;       auto-save-file-name-transforms `((".*" ,auto-save-list-file-prefix t)))

;; (use-package persistent-scratch
;;   :init
;;   :bind ("s-n" . persistent-scratch-quick-open)
;;   :config
;;   (eval-after-load '+popup
;;     '(set-popup-rule! "\\^*scratch:" :vslot -4 :autosave t :size 0.35 :select t :quit nil :ttl nil :modeline t))
;;   (setq persistent-scratch-save-file (concat CACHE-DIR ".persistent-scratch"))
;;   ;; (persistent-scratch-restore)
;;   ;; (persistent-scratch-setup-default)
;;   (persistent-scratch-autosave-mode)

;;   (defun persistent-scratch-buffer-identifier()
;;     (string-match "^*scratch:" (buffer-name)))

;;   (defun persistent-scratch-get-scratches()
;;     (let ((scratch-buffers)
;;           (save-data
;;            (read
;;             (with-temp-buffer
;;               (let ((coding-system-for-read 'utf-8-unix))
;;                 (insert-file-contents persistent-scratch-save-file))
;;               (buffer-string)))))
;;       (dolist (saved-buffer save-data)
;;         (push (substring (aref saved-buffer 0) (length "*scratch:")) scratch-buffers))
;;       scratch-buffers))

;;   (defun persistent-scratch-restore-this(&optional file)
;;     (interactive)
;;     (let ((current-buf (buffer-name (current-buffer)))
;;           (save-data
;;            (read
;;             (with-temp-buffer
;;               (let ((coding-system-for-read 'utf-8-unix))
;;                 (insert-file-contents (or file persistent-scratch-save-file)))
;;               (buffer-string)))))
;;       (dolist (saved-buffer save-data)
;;         (when (string= current-buf (aref saved-buffer 0))
;;           (with-current-buffer (get-buffer-create (aref saved-buffer 0))
;;             (erase-buffer)
;;             (insert (aref saved-buffer 1))
;;             (funcall (or (aref saved-buffer 3) #'ignore))
;;             (let ((point-and-mark (aref saved-buffer 2)))
;;               (when point-and-mark
;;                 (goto-char (car point-and-mark))
;;                 (set-mark (cdr point-and-mark))))
;;             (let ((narrowing (aref saved-buffer 4)))
;;               (when narrowing
;;                 (narrow-to-region (car narrowing) (cdr narrowing))))
;;             ;; Handle version 2 fields if present.
;;             (when (>= (length saved-buffer) 6)
;;               (unless (aref saved-buffer 5)
;;                 (deactivate-mark))))))))

;;   (defun persistent-scratch-quick-open()
;;     (interactive)
;;     (let* ((scratch-buffers (persistent-scratch-get-scratches))
;;           (chosen-scratch (concat "*scratch:"
;;                                   (completing-read
;;                                    "Choose a scratch: "
;;                                    scratch-buffers nil nil nil nil
;;                                    (random-alnum 4))))
;;           (buffer-exists-p (get-buffer chosen-scratch)))
;;       (switch-to-buffer chosen-scratch)
;;       (unless buffer-exists-p
;;         (persistent-scratch-restore-this))
;;       (persistent-scratch-mode)))
;;   (setq persistent-scratch-scratch-buffer-p-function 'persistent-scratch-buffer-identifier))

(provide 'init-scratch)
