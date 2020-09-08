(require 'edmacro)
(require 'ring)

;; linewise motion

(defun my-next-line (n)
  (interactive "p")
  (call-interactively 'next-line)
  (when (looking-back "^[\s\t]*" (point-at-bol))
    (let (goal-column) (back-to-indentation))))

(defun my-previous-line (n)
  (interactive "p")
  (call-interactively 'previous-line)
  (when (looking-back "^[\s\t]*" (point-at-bol))
    (let (goal-column) (back-to-indentation))))

(defun my-smart-bol ()
  "beginning-of-line or back-to-indentation"
  (interactive)
  (let ((command (if (eq last-command 'back-to-indentation)
                     'beginning-of-line
                   'back-to-indentation)))
    (setq this-command command)
    (funcall command)))

;; blank-line-delimited navigation

(defconst my-next-blank-line-skip-faces
  '(font-lock-string-face
    font-lock-comment-face
    font-lock-comment-delimiter-face
    font-lock-doc-face))
(defun my-next-blank-line ()
  "Jump to the next empty line."
  (interactive)
  (when (eobp) (signal 'end-of-buffer "end of buffer"))
  (let ((type (get-text-property (point) 'face)))
    (skip-chars-forward "\s\t\n")
    (condition-case nil
        (while (and (search-forward-regexp "\n[\s\t]*$")
                    (let ((face (get-text-property (point) 'face)))
                      (and (memq face my-next-blank-line-skip-faces)
                           (not (eq face type))))))
      (error (goto-char (point-max))))))

(defun my-previous-blank-line ()
  "Jump to the previous empty line."
  (interactive)
  (when (bobp) (signal 'beginning-of-buffer "beginning of buffer"))
  (let ((type (get-text-property (point) 'face)))
    (skip-chars-backward "\s\t\n")
    (condition-case nil
        (while (and (search-backward-regexp "^[\s\t]*\n")
                    (let ((face (get-text-property (point) 'face)))
                      (and (memq face my-next-blank-line-skip-faces)
                           (not (eq face type))))))
      (error (goto-char (point-min))))))

;; jump-back!
(defvar-local my-jump-back!--marker-ring nil)

(defun my-jump-back!--ring-update ()
  (let ((marker (point-marker)))
    (unless my-jump-back!--marker-ring
      (setq my-jump-back!--marker-ring (make-ring 30)))
    (ring-insert my-jump-back!--marker-ring marker)))

(run-with-idle-timer 1 t 'my-jump-back!--ring-update)

(defun my-jump-back! ()
  (interactive)
  (let (marker)
    (cond ((or (null my-jump-back!--marker-ring)
               (ring-empty-p my-jump-back!--marker-ring))
           (error "No further undo information"))
          ((= (point-marker)
              (prog1 (setq marker (ring-ref my-jump-back!--marker-ring 0))
                (ring-remove my-jump-back!--marker-ring 0)))
           (my-jump-back!))
          (t
           (goto-char marker)
           (let ((repeat-key (vector last-input-event)))
             (message "(Type %s to repeat)" (edmacro-format-keys repeat-key))
             (set-transient-map
              (let ((km (make-sparse-keymap)))
                (define-key km repeat-key 'my-jump-back!)
                km)
              t))))))
