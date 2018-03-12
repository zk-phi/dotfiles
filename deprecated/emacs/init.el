;; ---- flyspell: core

(setup-lazy '(my-turn-on-flyspell) "flyspell-lazy"
  :prepare (add-hook 'find-file-hook 'my-turn-on-flyspell t)

  (require 'flyspell)
  (ispell-change-dictionary "english")
  (flyspell-lazy-mode 1)

  ;; do not spell-check non-ascii characters
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]"))

  (setq flyspell-mark-duplications-flag   nil
        flyspell-duplicate-distance       0
        flyspell-lazy-idle-seconds        1
        flyspell-lazy-window-idle-seconds 1.5
        ispell-personal-dictionary        my-ispell-dictionary
        ispell-extra-args
        `("--sug-mode=ultra"
          ,(concat "--repl=" (expand-file-name my-ispell-repl))))

  (defun my-turn-on-flyspell ()
    (interactive)
    (when (and (boundp 'flyspell-mode)
               (not flyspell-mode)
               (not buffer-read-only)
               (not (string-match "^\\*.*\\*$" (buffer-name))))
      (if (derived-mode-p 'text-mode)
          (flyspell-mode)
        (flyspell-prog-mode))))

  ;; overwrite "flyspell-emacs-popup" to use popup.el
  ;; Reference | EmacsWiki - Flyspell
  (setup-after "popup"
    (defun flyspell-emacs-popup (event poss word)
      (let* ((corrects (if flyspell-sort-corrections
                           (sort (car (cdr (cdr poss))) 'string<)
                         (car (cdr (cdr poss)))))
             (cor-menu (if (consp corrects)
                           (mapcar (lambda (correct)
                                     (list correct correct))
                                   corrects)
                         '()))
             (affix (car (cdr (cdr (cdr poss)))))
             show-affix-info
             (base-menu  (let ((save (if (and (consp affix) show-affix-info)
                                         (list
                                          (list (concat "Save affix: " (car affix))
                                                'save)
                                          '("Accept (session)" session)
                                          '("Accept (buffer)" buffer))
                                       '(("Save word" save)
                                         ("Accept (session)" session)
                                         ("Accept (buffer)" buffer)))))
                           (if (consp cor-menu)
                               (append cor-menu (cons "" save))
                             save)))
             (menu (mapcar
                    (lambda (arg) (if (consp arg) (car arg) arg))
                    base-menu)))
        (cadr (assoc (popup-menu* menu :scroll-bar t) base-menu)))))

  (setup-keybinds flyspell-mode-map
    '("C-;" "C-," "C-." "C-M-i") nil
    "C-c C-i" 'flyspell-correct-word-before-point)

  ;; apply workaround for auto-complete
  (setup-after "auto-complete"
    '(ac-flyspell-workaround))
  )

;; ---- flyspell: appearance

(setup-after "flyspell"
  (set-face-attribute
   'flyspell-incorrect nil
   :foreground 'unspecified
   :background 'unspecified
   :underline  (! `(:style wave :color ,(face-foreground 'term-color-red)))))

