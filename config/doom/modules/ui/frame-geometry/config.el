;; frame-geometry
(defun frame-geometry/save ()
  "Gets the current frame's geometry and saves to ~/.emacs.d/frame-geometry."
  (let (
        (frame-geometry-left (frame-parameter (selected-frame) 'left))
        (frame-geometry-top (frame-parameter (selected-frame) 'top))
        (frame-geometry-width (frame-parameter (selected-frame) 'width))
        (frame-geometry-height (frame-parameter (selected-frame) 'height))
        (frame-geometry-file (expand-file-name "frame-geometry" user-emacs-directory))
        )

    (when (not (number-or-marker-p frame-geometry-left))
      (setq frame-geometry-left 0))
    (when (not (number-or-marker-p frame-geometry-top))
      (setq frame-geometry-top 0))
    (when (not (number-or-marker-p frame-geometry-width))
      (setq frame-geometry-width 0))
    (when (not (number-or-marker-p frame-geometry-height))
      (setq frame-geometry-height 0))

    (with-temp-buffer
      (insert
       ";;; This is the previous emacs frame's geometry.\n"
       ";;; Last generated " (current-time-string) ".\n"
       "(setq initial-frame-alist\n"
       "      '(\n"
       (format "        (top . %d)\n" (max frame-geometry-top 0))
       (format "        (left . %d)\n" (max frame-geometry-left 0))
       (format "        (width . %d)\n" (max frame-geometry-width 0))
       (format "        (height . %d)))\n" (max frame-geometry-height 0)))
      (when (file-writable-p frame-geometry-file)
        (write-file frame-geometry-file))))
  )

(defun frame-geometry/load ()
  "Loads ~/.emacs.d/frame-geometry which should load the previous frame's geometry."
  (let ((frame-geometry-file (expand-file-name "frame-geometry" user-emacs-directory)))
    (when (file-readable-p frame-geometry-file)
      (load-file frame-geometry-file)))
  )

  ;; add hooks to restore frame size and location, if we are using gui emacs
  (if window-system
      (progn
        (add-hook 'after-init-hook 'frame-geometry/load)
        (add-hook 'kill-emacs-hook 'frame-geometry/save))
    )
