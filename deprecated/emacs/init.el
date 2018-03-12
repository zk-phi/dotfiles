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

;; ---- flycheck: core

(setup-lazy '(flycheck-mode) "flycheck"
  :prepare (add-hook 'prog-mode-hook 'flycheck-mode)
  (setq flycheck-display-errors-delay 0.1
        flycheck-highlighting-mode    'lines))

;; ---- flycheck: anything source

(setup-lazy '(my-anything-jump) "anything"

  ;; reference | http://d.hatena.ne.jp/kiris60/20091003
  ;;           | https://github.com/yasuyk/helm-flycheck/
  (setup-after "flycheck"
    (defvar my-flycheck-candidates nil)
    (defun my-flycheck-candidates ()
      (mapcar
       (lambda (err)
         (let* ((type (flycheck-error-level err))
                (type (propertize (symbol-name type) 'face
                                  (flycheck-error-level-error-list-face type)))
                (line (flycheck-error-line err))
                (text (flycheck-error-message err)))
           (cons (format "%s:%s: %s" line type text) err)))
       my-flycheck-candidates))
    (defvar my-anything-source-flycheck
      '((name . "Flycheck")
        (init . (lambda ()
                  (setq my-flycheck-candidates
                        (sort flycheck-current-errors 'flycheck-error-<))))
        (candidates . my-flycheck-candidates)
        (action . (("Goto line" .
                    (lambda (err)
                      (goto-line (flycheck-error-line err)
                                 (flycheck-error-buffer err)))))))))
  )

;; ---- flycheck: cc-mode

(setup-after "cc-mode"

  (setup-after "flycheck"
    (defun my-flycheck-use-c99-p ()
      (save-excursion
        (goto-char (point-min))
        (search-forward-regexp "__STDC_VERSION__[^\n]*1999" 500 t)))
    ;; C/C++ checker powered by gcc/g++
    ;; reference | https://github.com/jedrz/.emacs.d/blob/master/setup-flycheck.el
    (flycheck-define-checker
     c-gcc "A C checker using gcc"
     :command ("gcc" "-fsyntax-only" "-ansi" "-pedantic" "-Wall" "-Wextra" "-W" "-Wunreachable-code" source-inplace)
     :error-patterns ((warning line-start (file-name) ":" line ":" column ":" " warning: " (message) line-end)
                      (error line-start (file-name) ":" line ":" column ":" " error: " (message) line-end))
     :modes 'c-mode
     :predicate (lambda () (not (my-flycheck-use-c99-p))))
    (flycheck-define-checker
     c99-gcc "A C checker using gcc -std=c99"
     :command ("gcc" "-fsyntax-only" "-std=c99" "-pedantic" "-Wall" "-Wextra" "-W" "-Wunreachable-code" source-inplace)
     :error-patterns ((warning line-start (file-name) ":" line ":" column ":" " warning: " (message) line-end)
                      (error line-start (file-name) ":" line ":" column ":" " error: " (message) line-end))
     :modes 'c-mode
     :predicate my-flycheck-use-c99-p)
    (flycheck-define-checker
     c++-g++ "A C checker using g++"
     :command ("g++" "-fsyntax-only" "-std=c++11" "-pedantic" "-Wall" "-Wextra" "-W" "-Wunreachable-code" source-inplace)
     :error-patterns ((warning line-start (file-name) ":" line ":" column ":" " warning: " (message) line-end)
                      (error line-start (file-name) ":" line ":" column ":" " error: " (message) line-end))
     :modes 'c++-mode)
    (add-to-list 'flycheck-checkers 'c-gcc)
    (add-to-list 'flycheck-checkers 'c++-g++)
    (add-to-list 'flycheck-checkers 'c99-gcc))
  )

