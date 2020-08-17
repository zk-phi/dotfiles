(defun my-mark-sexp ()
  (interactive)
  (let* ((back (and (save-excursion
                      (search-backward-regexp "\\_>\\|\\s)\\|\\s\"" nil t))
                    (match-end 0)))
         (forward (and (save-excursion
                         (search-forward-regexp "\\_<\\|\\s(\\|\\s\"" nil t))
                       (match-beginning 0)))
         (back (and back (- (point) back)))
         (forward (and forward (- forward (point)))))
    (mark-sexp
     (if (or (not back) (and forward (< forward back))) 1 -1))))

(defun my-down-list ()
  (interactive)
  (let* ((back-list (save-excursion
                      (and (search-backward-regexp "\\s)" nil t)
                           (point))))
         (back-list (and back-list (- back-list (point))))
         (back-str (save-excursion
                     (and (search-backward-regexp "\\s\"" nil t)
                          (point))))
         (back-str (and back-str (- back-str (point))))
         (for-list (save-excursion
                     (and (search-forward-regexp "\\s(" nil t)
                          (point))))
         (for-list (and for-list (- for-list (point))))
         (for-str (save-excursion
                    (and (search-forward-regexp "\\s\"" nil t)
                         (point))))
         (for-str (and for-str (- for-str (point))))
         (diff (car (sort (list back-list back-str for-list for-str)
                          (lambda (a b)
                            (or (not (numberp b))
                                (and (numberp a) (< (abs a) (abs b)))))))))
    (if (numberp diff) (forward-char diff) (error "Cannot go down."))))

(defun my-copy-sexp ()
  (interactive)
  (save-mark-and-excursion
    (my-mark-sexp)
    (kill-ring-save (region-beginning) (region-end))))

(defun my-transpose-sexps ()
  (interactive)
  (transpose-sexps -1))

(defun my-comment-sexp ()
  (interactive)
  (my-mark-sexp)
  (comment-or-uncomment-region (region-beginning) (region-end)))

(defun my-up-list ()
  "handy version of up-list for interactive use"
  (interactive)
  (let* ((in-string (nth 3 (syntax-ppss (point))))
         (back-pos (save-excursion
                     (if in-string
                         (search-backward-regexp "\\s\"" nil t)
                       (ignore-errors (backward-up-list) (point)))))
         (for-pos (save-excursion
                    (if in-string
                        (search-forward-regexp "\\s\"" nil t)
                      (ignore-errors (up-list) (point))))))
    (when (not (or back-pos for-pos))
      (signal 'scan-error "cannot go up"))
    (goto-char (cond ((null back-pos) for-pos)
                     ((null for-pos) back-pos)
                     ((< (abs (- (point) for-pos))
                         (abs (- (point) back-pos))) for-pos)
                     (t back-pos)))))

(defun my-indent-defun ()
  (interactive)
  (save-mark-and-excursion
    (mark-defun)
    (indent-region (region-beginning) (region-end))))

(defun my-overwrite-sexp ()
  (interactive)
  (my-mark-sexp)
  (delete-region (region-beginning) (region-end))
  (yank))

(defun my-eval-sexp-dwim ()
  "eval-last-sexp or eval-region"
  (interactive)
  (if (not (use-region-p))
      (call-interactively 'eval-last-sexp) ; must be interactive
    (eval-region (region-beginning) (region-end))
    (deactivate-mark)))

(defun my-eval-and-replace-sexp ()
  "Evaluate the sexp at point and replace it with its value"
  (interactive)
  (let ((value (eval-last-sexp nil)))
    (kill-sexp -1)
    (insert (format "%S" value))))
