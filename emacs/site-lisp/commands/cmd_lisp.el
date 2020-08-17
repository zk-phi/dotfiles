(defun my-lisp-toggle-exp (exprs)
  (save-excursion
    (when (nth 3 (syntax-ppss (point)))
      (search-backward-regexp "\\s\""))
    (let ((match-res (cl-some (lambda (pair)
                                (and (looking-at (car pair)) pair))
                              exprs)))
      (cond (match-res
             (replace-match (cdr match-res))
             (indent-sexp))
            ((looking-at "\\_<\\|\\s(")
             (condition-case nil
                 (backward-up-list)
               (error (error "nothing to toggle")))
             (forward-sexp)
             (backward-sexp)
             (my-lisp-toggle-exp exprs))
            (t
             (backward-sexp)
             (my-lisp-toggle-exp exprs))))))

(defun my-lisp-toggle-let ()
  "toggle let and let"
  (interactive)
  (my-lisp-toggle-exp
   '(("(let\\*" . "(let") ("(let" . "(let*"))))

(defun my-lisp-toggle-quote ()
  "toggle ' and `"
  (interactive)
  (my-lisp-toggle-exp '(("'" . "`") ("`" . "'"))))

(defun my-lisp-toggle-bracket ()
  "toggle () and []"
  (interactive)
  (save-excursion
    (backward-up-list)
    (let ((beg (point))
          (newparen (if (= (char-after) ?\() '("[" . "]") '("(" .  ")"))))
      (forward-sexp)
      (delete-char -1)
      (insert (cdr newparen))
      (goto-char beg)
      (delete-char 1)
      (insert (car newparen)))))
