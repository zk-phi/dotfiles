;; + Isearch workaround for japanese windows systems

;; I'm not sure if this is needed (or fixed)
(setup-after "isearch"
  ;; isearch in japanese (for windows)
  ;; reference | http://d.hatena.ne.jp/myhobby20xx/20110228/1298865536
  (!when (string= window-system 'w32)
    (defun my-isearch-update ()
      (interactive)
      (isearch-update))
    (setup-keybinds isearch-mode-map
      [compend] 'my-isearch-update
      [kanji]   'isearch-toggle-input-method))
  ;; do not use lax-whitespace (for Emacs>=24)
  (setq isearch-lax-whitespace nil))

;; + flyspell: core

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

;; + flyspell: appearance

(setup-after "flyspell"
  (set-face-attribute
   'flyspell-incorrect nil
   :foreground 'unspecified
   :background 'unspecified
   :underline  (! `(:style wave :color ,(face-foreground 'term-color-red)))))

;; + flycheck: core

(setup-lazy '(flycheck-mode) "flycheck"
  :prepare (add-hook 'prog-mode-hook 'flycheck-mode)
  (setq flycheck-display-errors-delay 0.1
        flycheck-highlighting-mode    'lines))

;; + flycheck: anything source

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

;; + flycheck: cc-mode

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

;; + highlight-changes-mode: core

(setup-lazy '(highlight-changes-mode) "hilit-chg"
  :prepare (setup-hook 'find-file-hook 'highlight-changes-mode)

  ;; start with invisible mode
  (setq highlight-changes-visibility-initial-state nil)

  ;; clear highlights after save
  (setup-hook 'after-save-hook
    (when highlight-changes-mode
      (save-restriction
        (widen)
        (highlight-changes-remove-highlight (point-min) (point-max)))))

  ;; fix for yasnippet
  (setup-after "yasnippet"
    (setup-hook 'yas-before-expand-snippet-hook
      (when highlight-changes-mode
        (highlight-changes-mode -1)))
    (setup-hook 'yas-after-exit-snippet-hook
      (highlight-changes-mode 1)
      (hilit-chg-set-face-on-change yas-snippet-beg yas-snippet-end 0)))
  )

;; + highlight-changes-mode: anything source

(setup-after "hilit-chg"
  (defun my-change-search-next (point)
    (let (start tmp)
      ;; if the point is nil, return nil
      (when point
        (setq start (if (get-text-property point 'hilit-chg) point
                      (next-single-property-change point 'hilit-chg)))
        ;; if there are no changes more, return nil
        (when start
          ;; possibly, the end of this change
          (setq tmp (next-single-property-change start 'hilit-chg))
          ;; join adjacent changes
          (while (and tmp (get-text-property tmp 'hilit-chg))
            (setq tmp (next-single-property-change tmp 'hilit-chg)))
          (if tmp (list start tmp)
            (list start (point-max)))))))
  (defun my-change-get-string (from to)
    (let* ((from (save-excursion (goto-char from)
                                 (skip-chars-forward "\n")
                                 (point)))
           (to (save-excursion (goto-char to)
                               (skip-chars-backward "\s\t\n")
                               (if (looking-back "[\s\t\n]")
                                   (1- (point))
                                 (point))))
           (string (buffer-substring from to)))
      (if (string-match "^[\s\t\n]*$" string) ""
        string)))
  (defun my-change-buffer nil)
  (defun my-change-candidates ()
    (with-current-buffer my-change-buffer
      (let ((start (point-min)) tmp candidates)
        (while (setq tmp (my-change-search-next start))
          (add-to-list 'candidates
                       (cons (format "%5d:: %s"
                                     (line-number-at-pos (car tmp))
                                     (apply 'my-change-get-string tmp))
                             (car tmp)))
          ;; change start position of search
          (setq start (cadr tmp)))
        (reverse candidates))))
  (defvar my-anything-source-highlight-changes-mode
    '((name . "Changes")
      (init . (lambda () (setq my-change-buffer (current-buffer))))
      (candidates . my-change-candidates)
      (action . (lambda (num) (goto-char num)))
      (multiline))))

;; + highlight-indent-guides: core

(!-
 (setup "highlight-indent-guides"
   (setq highlight-indent-guides-method       'character
         highlight-indent-guides-character    ?|
         highlight-indent-guides-responsive   'top
         highlight-indent-guides-delay        0
         highlight-indent-guides-auto-enabled nil)
   (setup-hook 'prog-mode-hook
     (highlight-indent-guides-mode 1))))

;; + highlight-indent-guides: appearance

(setup-after "highlight-indent-guides"
  (set-face-attribute 'highlight-indent-guides-character-face nil
                      :foreground 'unspecified
                      :inherit 'elemental-hidden-fg-face)
  (set-face-attribute 'highlight-indent-guides-top-character-face nil
                      :foreground 'unspecified
                      :inherit 'elemental-darker-fg-face))

;; + window-undo: core

;; seems not working :(

;; window-undo ("winner-mode" simplified)
(defvar my-window-undo-list `((1 . ,(current-window-configuration))))
(setup-hook 'window-configuration-change-hook
  (let ((wins (length (window-list))))
    (unless (or (eq this-command 'my-window-undo)
                (and (boundp 'phi-search--original-position)
                     phi-search--original-position)
                (and (boundp 'phi-search--target)
                     phi-search--target)
                (and my-window-undo-list
                     (= (caar my-window-undo-list) wins)))
      (push (cons wins (current-window-configuration)) my-window-undo-list))))
(setup-lazy '(my-window-undo) "edmacro"
  (defun my-window-undo ()
    (interactive)
    (let ((repeat-key (vector last-input-event)))
      (set-temporary-overlay-map
       (let ((km (make-sparse-keymap)))
         (define-key km repeat-key 'my-window-undo)
         km) t)
      (message "(Type %s to repeat)" (edmacro-format-keys repeat-key))
      (pop my-window-undo-list)
      (if (null my-window-undo-list)
          (message "No further undo information")
        (set-window-configuration (cdar my-window-undo-list))))))

;; + window-undo: kaybinds

(setup-keybinds nil
  "C-x C--" 'my-window-undo)

;; + joke commands.

;; Emacs sɔɐɯƎ
(!-
 (defun my-flip-char (char)
   (cl-case char
     ((97) 592) ((98) 113) ((99) 596) ((100) 112) ((101) 477)
     ((102) 607) ((103) 387) ((104) 613) ((105) 7433) ((106) 638)
     ((107) 670) ((108) 108) ((109) 623) ((110) 117) ((111) 111)
     ((112) 100) ((113) 98) ((114) 633) ((115) 115) ((116) 647)
     ((117) 110) ((118) 652) ((119) 653) ((120) 120) ((121) 654)
     ((122) 122) ((65) 8704) ((66) 113) ((67) 390) ((68) 112)
     ((69) 398) ((70) 8498) ((71) 1508) ((72) 72) ((73) 73)
     ((74) 383) ((75) 670) ((76) 741) ((77) 87) ((78) 78)
     ((79) 79) ((80) 1280) ((81) 81) ((82) 633) ((83) 83)
     ((84) 9524) ((85) 8745) ((86) 923) ((87) 77) ((88) 88)
     ((89) 8516) ((90) 90) ((49) 406) ((50) 4357) ((51) 400)
     ((52) 12579) ((53) 987) ((54) 57) ((55) 12581) ((56) 56)
     ((57) 54) ((48) 48) ((41) 40) ((40) 41) ((93) 91)
     ((91) 93) ((125) 123) ((123) 125) ((39) 44) ((34) 44)
     ((46) 729) ((44) 39) ((47) 47) ((92) 92) ((33) 161)
     ((38) 8523) ((95) 8254) ((96) 44) ((62) 60) ((60) 62) (t char)))
 (defun my-flip-rectangle (beg end)
   (interactive "r")
   (let ((rect (mapcar (lambda (str)
                         (mapconcat (lambda (char)
                                      (char-to-string (my-flip-char char)))
                                    (nreverse (string-to-list str)) ""))
                       (nreverse (extract-rectangle beg end)))))
     (delete-rectangle beg end)
     (goto-char beg)
     (insert-rectangle rect))))

;; biyo~~n
(defun biyonbiyon ()
  (interactive)
  (run-with-timer
   0 0.1
   '(lambda ()
      (set-frame-size
       (selected-frame)
       (floor (* 20 (+ (sin (* 2 (float-time))) 2)))
       (floor (* 10 (+ (cos (* 2 (float-time))) 2)))))))

;; + add-log: core

;; add change-lod entry
(setup-lazy '(my-add-change-log-entry) "add-log"
  (setup-after "popwin"
    (push '("ChangeLog") popwin:special-display-config))
  (defun my-change-log-save-and-kill ()
    (interactive)
    (save-buffer)
    (kill-buffer)
    (delete-window))
  (defun my-add-change-log-entry ()
    (interactive)
    (select-window
     (split-window-below (* (/ (window-height) 3) 2)))
    (add-change-log-entry))
  (setup-keybinds change-log-mode-map
    "C-x C-s" 'my-change-log-save-and-kill
    "C-g"     'my-change-log-save-and-kill))

;; + add-log: keybinds

(setup-keybinds nil
  "C-x C-l"   'my-add-change-log-entry)

;; + multifiles: core

(setup-lazy '(mf/mirror-region-in-multifile) "multifiles")

;; + multifiles: keybinds

(setup-keybinds nil
  "C-x C-a"   '("multifiles" mf/mirror-region-in-multifile))

;; + simple-demo: core

(setup-lazy '(simple-demo-set-up) "simple-demo")

;; + languages/CommonLisp: core

(setup-after "lisp-mode"

  (setup-after "auto-complete"
    (push 'lisp-mode ac-modes))

  (setup "cldoc"
    (setup-hook 'lisp-mode-hook
      (turn-on-cldoc-mode)))

  (setup-lazy '(my-run-lisp-other-window my-lisp-send-dwim my-lisp-load) "inf-lisp"

    (setq inferior-lisp-program "sbcl")

    (defun my-run-lisp-other-window ()
      (interactive)
      (with-selected-window (split-window-vertically -10)
        (switch-to-buffer (get-buffer-create "*inferior-lisp*"))
        (run-lisp inferior-lisp-program))
      (when buffer-file-name
        (my-lisp-load)))

    (defun my-lisp-send-dwim ()
      (interactive)
      (if (use-region-p)
          (lisp-eval-region (region-beginning) (region-end))
        (lisp-eval-last-sexp)))

    (defun my-lisp-load (&optional file)
      (interactive)
      (let ((file (or file
                      (expand-file-name buffer-file-name)
                      (read-file-name "Load file: "))))
        (with-temp-buffer
          (lisp-eval-string (format "(load \"%s\")" file)))))
    )

  (setup-keybinds lisp-mode-map
    '("M-TAB" "C-j") nil
    "C-c C-s" 'my-run-lisp-other-window
    "C-c C-e" 'my-lisp-send-dwim
    "C-c C-l" 'my-lisp-load)
  )

;; + languages/Coq: core (proof-general)

(setup-lazy '(coq-mode) "proof-site"
  :prepare (push '("\\.v$" . coq-mode) auto-mode-alist)

  (setq proof-shrink-windows-tofit       t
        proof-splash-enable              nil
        proof-electric-terminator-enable t
        proof-keep-response-history      t)

  (defadvice proof-electric-terminator (before reindent-terminator activate)
    (open-line 1)
    (indent-for-tab-command))

  (setup-after "coq"

    (setup-after "auto-complete"
      (push 'coq-mode ac-modes))

    (setup-expecting "key-combo"
      (defun my-coq-smart-pipes ()
        "insert pipe surrounded by spaces, and reindent"
        (interactive)
        (if (looking-back "\\[")
            ;; empty list delimiter
            (insert "| ")
          ;; guard
          (insert (concat (unless (looking-back " ") " ")
                          "|"
                          (unless (looking-at " ") " "))))
        (save-excursion (smie-indent-line)))
      (setup-hook 'coq-mode-hook
        (key-combo-mode 1)
        ;; top level(?)
        (key-combo-define-local (kbd "|") '(my-coq-smart-pipes))
        (key-combo-define-local (kbd ":") '(" : " " :: "))
        (key-combo-define-local (kbd ":=") " := ")
        (key-combo-define-local (kbd "=") " = ")
        ;; logic
        (key-combo-define-local (kbd "->") " -> ")
        (key-combo-define-local (kbd "<-") " <- ")
        (key-combo-define-local (kbd "&&") " && ")
        (key-combo-define-local (kbd "||") " || ")
        (key-combo-define-local (kbd "/\\") " /\\ ")
        (key-combo-define-local (kbd "\\/") " \\/ ")
        (key-combo-define-local (kbd "|-") " |- ")
        (key-combo-define-local (kbd "|=") " |= ")
        ;; types
        (key-combo-define-local (kbd "=>") " => ")
        (key-combo-define-local (kbd ":<") " :< ")
        (key-combo-define-local (kbd ":>") " :> ")
        ;; arithmetic
        (key-combo-define-local (kbd "<") " < ")
        (key-combo-define-local (kbd "<=") " <= ")
        (key-combo-define-local (kbd ">") " > ")
        (key-combo-define-local (kbd ">=") " >= ")
        (key-combo-define-local (kbd "+") (my-unary "+"))
        (key-combo-define-local (kbd "-") (my-unary "-"))
        (key-combo-define-local (kbd "*") " * ")
        (key-combo-define-local (kbd "/") " / ")))

    (setup-keybinds coq-mode-map
      "C-m"     'reindent-then-newline-and-indent
      "C-c C-n" 'proof-assert-next-command-interactive
      "C-c C-p" 'proof-undo-last-successful-command
      "C-c C-u" 'proof-retract-buffer
      "C-c C-e" 'proof-goto-end-of-locked
      "C-c C-c" 'proof-goto-point
      '("M-a" "M-e" "M-n" "M-p") nil)
    )
  )

;; + languages/Clojure: directories

(defconst my-clojure-jar-file
  (when (boundp 'my-clojure-jar-file) my-clojure-jar-file)
  "Path to clojure.jar executable.")

;; + languages/Clojure: core

(setup-lazy '(clojure-mode) "clojure-mode"
  :prepare (progn (push '("\\.clj$" . clojure-mode) auto-mode-alist))

  (setq clojure-inf-lisp-command (when my-clojure-jar-file
                                   (concat "java -jar " my-clojure-jar-file)))

  (setup-after "auto-complete"
    (push 'clojure-mode ac-modes))

  (defun my-run-clojure-other-window ()
    (interactive)
    (if (not clojure-inf-lisp-command)
        (error "Clojure executable is not specified.")
      (with-selected-window (split-window-vertically -10)
        (run-lisp clojure-inf-lisp-command))
      (when buffer-file-name
        (clojure-load-file buffer-file-name))))

  (defun my-clojure-send-dwim ()
    (interactive)
    (if (use-region-p)
        (lisp-eval-region (region-beginning) (region-end))
      (lisp-eval-last-sexp)))

  (setup-keybinds clojure-mode-map
    "C-c C-e" 'my-clojure-send-dwim
    "C-c C-s" 'my-run-clojure-other-window
    "C-c C-l" 'clojure-load-file)
  )

;; + languages/Egison: core

(setup-lazy '(egison-mode) "egison-mode"
  :prepare (push '("\\.egi$" . egison-mode) auto-mode-alist)
  (setup-after "auto-complete"
    (push 'egison-mode ac-modes))
  (setup-keybinds egison-mode-map "C-j" nil))

;; + languages/Haskell: core

(setup-lazy '(haskell-mode literate-haskell-mode) "haskell-mode"
  :prepare (progn (push '("\\.hs$" . haskell-mode) auto-mode-alist)
                  (push '("\\.lhs$" . literate-haskell-mode) auto-mode-alist))

  ;; USE FOLLOWING SEXP TO GENERATE haskell-mode-autoloads.el:
  ;; (let ((generated-autoload-file
  ;;        "~/Documents/dotfiles/emacs/site-lisp/plugins/haskell-mode/haskell-mode-autoloads.el"))
  ;;   (update-directory-autoloads "~/Documents/dotfiles/emacs/site-lisp/plugins/haskell-mode/"))
  (require 'haskell-mode-autoloads)

  (setup-keybinds haskell-mode-map
    "C-c C-s" 'my-run-haskell-other-window
    "C-c C-l" 'inferior-haskell-reload-file
    "C-c C-e" 'my-haskell-send-decl-dwim)

  (defun my-run-haskell-other-window ()
    (interactive)
    (with-selected-window (split-window-vertically -10)
      (switch-to-buffer
       (process-buffer (inferior-haskell-process nil))))
    (when buffer-file-name
      (inferior-haskell-load-file)))

  (defun my-haskell-send-decl-dwim ()
    (interactive)
    (if (not (use-region-p))
        (inferior-haskell-send-decl)
      (save-excursion
        (save-restriction
          (narrow-to-region (region-beginning) (region-end))
          (goto-char (point-min))
          (while (progn
                   (inferior-haskell-send-decl)
                   (haskell-ds-forward-decl)))))))

  (setup-hook 'haskell-mode-hook
    (turn-on-haskell-indentation)
    (turn-on-haskell-doc-mode))

  (setup-after "auto-complete"
    (push 'haskell-mode ac-modes)
    (push 'literate-haskell-mode ac-modes))

  (setup-after "smart-compile"
    (push '(haskell-mode . "ghc -Wall -fwarn-missing-import-lists %f")
          smart-compile-alist))

  (setup-expecting "key-combo"
    (defun my-install-haskell-smartchr ()
      (key-combo-mode 1)
      ;; types
      (key-combo-define-local (kbd ":") '(":" " :: "))
      (key-combo-define-local (kbd "<-") " <- ")
      (key-combo-define-local (kbd "->") " -> ")
      (key-combo-define-local (kbd "=>") " => ")
      ;; boolean
      (key-combo-define-local (kbd "|") '(" | " " || " " ||| "))
      (key-combo-define-local (kbd "&&") '(" & " " && " " &&& "))
      ;; compare
      (key-combo-define-local (kbd "=") '(" = " " == "))
      (key-combo-define-local (kbd "/=") " /= ")
      (key-combo-define-local (kbd "<") '(" < " " << " " <<< "))
      (key-combo-define-local (kbd ">") '(" > " " >> " " >>> "))
      (key-combo-define-local (kbd "<=") " <= ")
      (key-combo-define-local (kbd ">=") " >= ")
      ;; operation
      (key-combo-define-local (kbd "+") `(,(my-unary "+") " ++ " " +++ "))
      (key-combo-define-local (kbd "-") (my-unary "-"))
      (key-combo-define-local (kbd "*") '(" * " " ** "))
      (key-combo-define-local (kbd "/") '(" / " " // "))
      (key-combo-define-local (kbd "%") " % ")
      (key-combo-define-local (kbd "^") '(" ^ " " ^^ " " ^^^ "))
      ;; bits
      (key-combo-define-local (kbd ".|.") " .|. ")
      (key-combo-define-local (kbd ".&.") " .&. ")
      ;; list
      (key-combo-define-local (kbd ".") '(" . " ".."))
      (key-combo-define-local (kbd "!") '("!" " !! "))
      (key-combo-define-local (kbd "\\\\") " \\\\ ")
      ;; monad
      (key-combo-define-local (kbd ">>=") " >>= ")
      (key-combo-define-local (kbd "=<") " =< ") ; required to make =<< work
      (key-combo-define-local (kbd "=<<") " =<< ")
      ;; arrow : does not work ...
      ;; (key-combo-define-local (kbd "^>>") " ^>> ")
      ;; (key-combo-define-local (kbd ">>^") " >>^ ")
      ;; (key-combo-define-local (kbd "<<^") " <<^ ")
      ;; (key-combo-define-local (kbd "^<<") " ^<< ")
      ;; sequence
      (key-combo-define-local (kbd "><") " >< ")
      (key-combo-define-local (kbd ":>") " :> ")
      (key-combo-define-local (kbd ":<") " :< ")
      ;; others
      (key-combo-define-local (kbd "?") " ? ")
      (key-combo-define-local (kbd "@") " @ ")
      (key-combo-define-local (kbd "~") " ~ ")
      (key-combo-define-local (kbd "$") " $ ")
      (key-combo-define-local (kbd "$!") " $! "))
    (setup-hook 'haskell-mode-hook 'my-install-haskell-smartchr)
    (setup-hook 'literate-haskell-mode-hook 'my-install-haskell-smartchr))
  )

;; + languages/Racket: core

(setup-lazy '(racket-mode) "racket-mode"
  :prepare (push '("\\.rkt$" . racket-mode) auto-mode-alist)

  ;; implement hooks
  (defvar racket-mode-hook nil)
  (defadvice racket-mode (after my-racket-run-hooks activate)
    (run-hooks 'racket-mode-hook))

  (setup-after "auto-complete"
    (push 'racket-mode ac-modes))

  (defun my-run-racket-other-window ()
    (interactive)
    (with-selected-window (split-window-vertically -10)
      (racket-repl)
      (switch-to-buffer racket--repl-buffer-name))
    (when buffer-file-name
      (my-racket-load buffer-file-name)))

  (defun my-racket-send-dwim ()
    (interactive)
    (if (use-region-p)
        (racket-send-region (region-beginning) (region-end))
      (racket-send-last-sexp)))

  (defun my-racket-load (&optional file)
    (interactive)
    (let ((file (or file
                    (expand-file-name buffer-file-name)
                    (read-file-name "Load file: "))))
      (with-temp-buffer
        (racket--eval (format ",run %s\n" (expand-file-name file))))))

  (defun my-racket-expand-dwim ()
    (cond ((eq last-command this-command)
           (racket-expand-again))
          ((use-region-p)
           (racket-expand-region (region-beginning) (region-end)))
          (t
           (racket-expand-last-sexp))))

  ;; less fancy font-locking
  (setup-hook 'racket-mode-hook
    (setq-local font-lock-builtin-face 'default)
    (setq-local racket-selfeval-face 'default)
    (setq-local racket-lambda-char
                '(?l (cr cl 0 0) ?a (cr cl 0 0) ?m (cr cl 0 0)
                     ?b (cr cl 0 0) ?d (cr cl 0 0) ?a)))
  (setup-hook 'racket-repl-mode-hook
    (setq-local font-lock-builtin-face 'default)
    (setq-local racket-selfeval-face 'default)
    (setq-local racket-lambda-char
                '(?l (cr cl 0 0) ?a (cr cl 0 0) ?m (cr cl 0 0)
                     ?b (cr cl 0 0) ?d (cr cl 0 0) ?a)))

  (setup-keybinds racket-mode-map
    '("<f5>" "M-C-<f5>" "C-<f5>" "M-C-x" "C-x C-e" "C-c C-r"
      "C-c C-e x" "C-c C-e e" "C-c C-e r" "C-c C-e a"
      "RET" ")" "]" "}" "C-c C-p" "M-C-y" "<f1>"
      "C-c C-h" "C-c C-d" "C-c C-f" "C-c C-U") nil
      "C-c C-e" 'my-racket-send-dwim
      "C-c C-l" 'my-racket-load
      "C-c C-m" 'my-racket-expand-dwim
      "C-c C-s" 'my-run-racket-other-window
      "C-c C-p" 'racket-cycle-paren-shapes
      "C-c C-d" 'racket-find-definition
      "C-c C-f" 'racket-fold-all-tests
      "C-c C-u" 'racket-unfold-all-tests
      "<f1> s" 'racket-help)
  )

;; + languages/OCaml: core

(setup-lazy '(tuareg-mode) "tuareg"
  :prepare (push '("\\.ml[iylp]?$" . tuareg-mode) auto-mode-alist)

  (setq tuareg-interactive-program "ocaml")

  (set-face-foreground 'tuareg-font-lock-governing-face
                       (face-foreground 'font-lock-keyword-face))
  (set-face-foreground 'tuareg-font-lock-operator-face
                       'unspecified)

  (defun my-tuareg-load-file (&optional file)
    (interactive)
    (let ((file (or file buffer-file-name)))
      (when (and file (comint-check-proc tuareg-interactive-buffer-name))
        (with-current-buffer tuareg-interactive-buffer-name
          (comint-send-string
           tuareg-interactive-buffer-name (format "#use \"%s\";;" file))
          (comint-send-input)))))

  (defun my-run-ocaml-other-window ()
    (interactive)
    (with-selected-window (split-window-vertically -10)
      (switch-to-buffer
       (get-buffer-create tuareg-interactive-buffer-name))
      (tuareg-run-process-if-needed tuareg-interactive-program)
      (when buffer-file-name
        (my-tuareg-load-file buffer-file-name))))

  (defun my-tuareg-send-dwim ()
    (interactive)
    (if (use-region-p)
        (tuareg-eval-region (region-beginning) (region-end))
      (save-excursion
        (tuareg-skip-to-end-of-phrase)
        (tuareg-eval-phrase))))

  (setup-keybinds tuareg-mode-map
    "C-c C-e" 'my-tuareg-send-dwim
    "C-c C-s" 'my-run-ocaml-other-window
    "C-c C-l" 'my-tuareg-load-file
    '("C-M-p" "C-M-n" "C-M-h" "M-q") nil)

  (setup-lazy '(ocamldebug) "ocamldebug")

  (setup-after "indent-guide"
    (push 'tuareg-interactive-mode indent-guide-inhibit-modes))

  (setup-after "auto-complete"
    (push 'tuareg-mode ac-modes))
  )

;; + languages/LMNtal: directories

(defconst my-lmntal-home-directory
  (when (boundp 'my-lmntal-home-directory) my-lmntal-home-directory)
  "The LMNTAL_HOME Path.")

;; + languages/LMNtal: core

(setup-lazy '(lmntal-mode lmntal-slimcode-mode) "lmntal-mode"
  :prepare (progn
             (push '("\\.lmn$" . lmntal-mode) auto-mode-alist)
             (push '("\\.cslmn" . lmntal-mode) auto-mode-alist)
             (push '("\\.il$" . lmntal-slimcode-mode) auto-mode-alist))

  (setq lmntal-home-directory my-lmntal-home-directory
        lmntal-mc-use-dot     (! (executable-find "dot")))

  (setup-hook 'lmntal-trace-mode-hook 'my-kindly-view-mode)
  (setup-hook 'lmntal-mc-mode-hook 'my-kindly-view-mode)
  (setup-hook 'lmntal-slimcode-help-hook 'my-kindly-view-mode)

  ;; highlight additional keywords
  (font-lock-add-keywords
   'lmntal-mode '(("\\_<\\(typedef\\|define\\|defop\\)\\_>" . font-lock-function-name-face)))

  (setup-after "popwin"
    (push '("*SLIMcode-help*") popwin:special-display-config))

  (setup-after "auto-complete"
    (push 'lmntal-mode ac-modes))

  (setup-expecting "key-combo"
    (defun my-lmntal-smart-slashes ()
      (interactive)
      (if (looking-back "}")
          (insert "/")
        (insert (concat (unless (looking-back " ") " ")
                        "/"
                        (unless (looking-at " ") " ")))))
    (setup-hook 'lmntal-mode-hook
      (my-install-prolog-common-smartchr)
      ;; membrane or binary
      (key-combo-define-local (kbd "/") '(my-lmntal-smart-slashes))
      ;; comments
      (key-combo-define-local (kbd "//") "// ")
      ;; (key-combo-define-local (kbd "/*") "/*\n`!!'\n*/")
      ;; cmpfloat
      (key-combo-define-local (kbd "=:=.") " =:=. ")
      (key-combo-define-local (kbd "==.") " =:=. ")
      (key-combo-define-local (kbd "=\\=.") " =\\=. ")
      (key-combo-define-local (kbd "!==.") " =\\=. ")
      (key-combo-define-local (kbd "<.") " <. ")
      (key-combo-define-local (kbd ">.") " >. ")
      (key-combo-define-local (kbd "=<.") " =<. ")
      (key-combo-define-local (kbd "<=.") " =<. ")
      (key-combo-define-local (kbd ">=.") " >=. ")))

  (setup-after "mark-hacks"
    (push 'lmntal-slimcode-mode mark-hacks-auto-indent-inhibit-modes))
  )

;; + languages/LMNtal: appearance

(setup-after "lmntal-mode"
  (set-face-background 'lmntal-link-name-face
                       (! (my-make-color (face-background 'default) 3.5 -10))))

;; + languages/ZOMBIE: core

(setup-lazy '(zombie-mode) "zombie"
  :prepare (push '("\\.zombie$" . zombie-mode) auto-mode-alist))

;; + languages/PHP: core

;; *NOTE* PHP mode derives C mode
(setup-lazy '(php-mode) "php-mode"
  :prepare (push '("\\.php$" . php-mode) auto-mode-alist)

  (setup-hook 'php-mode-hook
    (c-set-style "php"))

  (setup-keybinds php-mode-map
    "C-M-h" nil
    "<tab>" nil)

  (setup-expecting "key-combo"
    (setup-hook 'php-mode-hook
      (key-combo-define-local (kbd "<?") "<?php\n")))
  )

;; + languages/Promela: core

(setup-lazy '(promela-mode) "promela-mode"
  :prepare (progn (push '("\\.pml$" . promela-mode) auto-mode-alist)
                  ;; workaround for emacs>=24
                  (when (version<= "24" emacs-version)
                    (defvar font-lock-defaults-alist nil)
                    (make-obsolete-variable 'font-lock-defaults-alist
                                            "(setq-local 'font-lock-defaults)"
                                            "Emacs 24")))

  (setq promela-selection-indent 0
        promela-block-indent 4)

  (set-face-attribute 'promela-fl-send-poll-face nil
                      :foreground 'unspecified
                      :background 'unspecified
                      :inverse-video 'unspecified
                      :bold t)

  (setup-hook 'promela-mode-hook
    (setq-local font-lock-defaults promela-font-lock-defaults))

  (setup-after "auto-complete"
    (push 'promela-mode ac-modes))

  (defun my-promela-electric-semi ()
    (interactive)
    (insert ";")
    (unless (string-match "}" (buffer-substring (point) (point-at-eol)))
      (promela-indent-newline-indent)))
  ;;
  (defun my-promela-smart-colons ()
    "insert two colons followed by a space, and reindent"
    (interactive)
    (insert (concat "::"
                    (if (looking-at " ") "" " ")))
    (save-excursion (promela-indent-line)))

  (setup-expecting "key-combo"
    (setup-hook 'promela-mode-hook
      (my-install-c-common-smartchr)
      ;; guards
      (key-combo-define-local (kbd "->") " -> ")
      (key-combo-define-local (kbd ":") '(":" my-promela-smart-colons))
      ;; LTL
      (key-combo-define-local (kbd "<>") "<>")
      (key-combo-define-local (kbd "[]") "[]")
      ;; does not work ...
      ;; (key-combo-define-local (kbd "do") "do\n`!!'\nod")
      ;; (key-combo-define-local (kbd "if") "if\n`!!'\nfi")
      ))

  (setup-keybinds promela-mode-map
    ";"   'my-promela-electric-semi
    "C-m" 'promela-indent-newline-indent)
  )

;; + languages/Promela: cedit

(setup-lazy
  '(cedit-or-paredit-slurp
    cedit-wrap-brace
    cedit-or-paredit-barf
    cedit-or-paredit-splice-killing-backward
    cedit-or-paredit-raise) "cedit"
    :prepare (setup-after "promela-mode"
               (setup-keybinds promela-mode-map
                 "M-)" 'cedit-or-paredit-slurp
                 "M-{" 'cedit-wrap-brace
                 "M-*" 'cedit-or-paredit-barf
                 "M-U" 'cedit-or-paredit-splice-killing-backward
                 "M-R" 'cedit-or-paredit-raise)))

;; + languages/Scala: core

;; NOTE: scala-mode seems replaced with the new one
;; https://github.com/ensime/emacs-scala-mode.git

(setup-lazy '(scala-mode) "scala-mode"
  :prepare (push '("\\.scala$" . scala-mode) auto-mode-alist)

  (require 'scala-mode-auto)
  (autoload 'scala-mode-inf "scala-mode-inf")

  (defun my-run-scala-other-window ()
    (interactive)
    (with-selected-window (split-window-vertically -10)
      (switch-to-buffer (make-comint "inferior-scala" "scala"))
      (scala-mode-inf))
    (when buffer-file-name
      (scala-load-file buffer-file-name)))

  ;; *FIXME* not DWIM for multi-line defuns
  (defun my-scala-eval-dwim ()
    (interactive)
    (if (use-region-p)
        (scala-eval-region (region-beginning) (region-end))
      (save-excursion
        (let ((beg (search-backward-regexp "^[^\s\t\n]" nil t)))
          (when beg
            (let* ((end (progn
                          (forward-char)
                          (search-forward-regexp "^[^\s\t\n]" nil t)))
                   (end (if end (1- end) (point-max))))
              (scala-eval-region beg end)))))))

  (setup-keybinds scala-mode-map
    "C-c C-l" 'scala-load-file
    "C-c C-e" 'my-scala-eval-dwim
    "C-c C-s" 'my-run-scala-other-window
    "<f1>"    nil)

  (setup-after "auto-complete"
    (push 'scala-mode ac-modes))
  )

;; + languages/Web: jquery-doc

(setup-after "web-mode"
  (setup "jquery-doc"
    (push 'ac-source-jquery (cdr (assoc "javascript" web-mode-ac-sources-alist)))
    (setup-after "popwin"
      (push '("^\\*jQuery doc" :regexp t) popwin:special-display-config))
    (setup-after "key-combo-web"
      (key-combo-web-define "javascript" (kbd "<f1> s") 'jquery-doc))))

;; + spray: core

;; Spritz-like speed reading mode
(setup-lazy '(spray-mode) "spray"
  (setq spray-wpm 400))

;; + symon: core

(!-
 (setup "symon"
   (setq symon-sparkline-ascent (!if my-home-system-p 97 100))
   (symon-mode 1)))

;; + symon-lingr: file

(defconst my-lingr-account
  (when (boundp 'my-lingr-account) my-lingr-account)
  "My Lingr account.")

(defconst my-lingr-log-file
  (! (concat my-dat-directory "lingr"))
  "File to save `symon-lingr' log in.")

;; + symon-lingr: core

(setup-after "symon"
  (when my-lingr-account
    (setup-in-idle "symon-lingr")
    (setup-after "symon-lingr"
      (setup-after "popwin"
        (push '("*symon-lingr*") popwin:special-display-config))
      (setq symon-lingr-user-name (car my-lingr-account)
            symon-lingr-password  (cdr my-lingr-account)
            symon-lingr-log-file  my-lingr-log-file
            symon-lingr-app-key   "pvCm1t")
      (add-to-list 'symon-monitors 'symon-lingr-monitor t)
      ;; restart symon
      (symon-mode -1)
      (symon-mode 1))))

;; + eldoc

(setup-lazy '(turn-on-eldoc-mode) "eldoc"
  (setq eldoc-idle-delay                0.1
        eldoc-echo-area-use-multiline-p nil))

(setup-after "lisp-mode"
  (setup-expecting "eldoc"
    (setup-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)))

(setup-after "gauche-mode"
  (setup-after "scheme-complete"
    (setup-expecting "eldoc"
      (setup-hook 'gauche-mode-hook
        (turn-on-eldoc-mode)
        (setq-local eldoc-documentation-function 'scheme-get-current-symbol-info)))))

(setup-after "cc-mode"
  (setup-expecting "eldoc"
    (setup "c-eldoc"
      (setq c-eldoc-buffer-regenerate-time 15)
      (setup "find-file"
        (setq c-eldoc-cpp-command "cpp"
              c-eldoc-includes (mapconcat (lambda (s) (format "-I\"%s\"" s))
                                          cc-search-directories " ")))
      (setup-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)
      (setup-hook 'c-mode-hook 'c-turn-on-eldoc-mode))))
;; + howm
;;   + calendar

;; Calendar
(setup-after "calendar"
  ;; mark today
  (add-hook 'calendar-today-visible-hook 'calendar-mark-today)
  ;; mark japanese holidays
  (setup "japanese-holidays"
    (setq calendar-mark-holidays-flag t
          calendar-holidays (append japanese-holidays
                                    holiday-local-holidays
                                    holiday-other-holidays))))

;;   + constants

;; Inherit some constant definitions from site-start.el, so that we
;; can write system-specific settings not in this file but in it.
;; Note that we need some of these values also during compilation.
(eval-and-compile
  (defconst my-howm-import-directory
    (when (boundp 'my-howm-import-directory) my-howm-import-directory)
    "Directory which Howm should import notes from.")
  (defconst my-howm-export-file
    (when (boundp 'my-howm-export-file) my-howm-export-file)
    "File which Howm should export schedules to.")
  (defconst my-howm-export-ics
    (when (boundp 'my-howm-export-ics) my-howm-export-ics)
    "iCal which Howm should export schedules to."))

;; Howm Datas

(defconst my-howm-directory
  (! (concat my-dat-directory "howm_" system-name "/"))
  "Directory to save Howm notes.")

(defconst my-howm-keyword-file
  (! (concat my-dat-directory "howm-keys_" system-name))
  "File to save Howm keyword list.")

(defconst my-howm-history-file
  (! (concat my-dat-directory "howm-history_" system-name))
  "File to save Howm history.")

;; recentf

(setup-after "recentf"
  (push "\\.howm$" recentf-exclude))

;;   + core

(setup-lazy '(my-howm-menu-or-remember) "howm"
  :prepare (progn (setup-in-idle "howm")
                  (push '("\\.howm$" . org-mode) auto-mode-alist))

  (setq howm-directory                       my-howm-directory
        howm-keyword-file                    my-howm-keyword-file
        howm-history-file                    my-howm-history-file
        howm-file-name-format                "%Y/%m/%Y-%m-%d-%H%M%S.howm"
        howm-view-summary-persistent         nil
        howm-view-title-header               "*"
        howm-template-date-format            "[%Y-%m-%d]"
        howm-template                        "* %date %cursor\n"
        howm-action-lock-forward-save-buffer t
        howm-insert-date-future              t
        howm-menu-lang                       'en
        howm-menu-schedule-days-before       0
        howm-menu-schedule-days              250
        howm-menu-todo-num                   100
        howm-menu-reminder-separators
        '((-1000 . "\n// past")
          (-1 . "\n// today")
          (0 . "\n// upcoming")
          (nil . "\n// todo (-n: n日後から↓ / +n: n日後から↑ / ~n: n日周期↑↓)")))

  (set-face-background 'howm-reminder-today-face nil)
  (set-face-background 'howm-reminder-tomorrow-face nil)

  (setup-after "popwin"
    (push '("*howm-remember*") popwin:special-display-config))

  ;; + utilities

  (defun my-howm-menu-reminder ()
    "like `howm-menu-reminder' but if howm-menu is already
displayed, use substring of the buffer."
    (if (null (get-buffer "*howmM:%menu%*"))
        (howm-menu-reminder)
      (with-current-buffer "*howmM:%menu%*"
        (save-excursion
          (save-restriction
            (widen)
            (goto-char (point-min))
            (search-forward (cdar howm-menu-reminder-separators))
            (buffer-substring-no-properties (match-beginning 0) (point-max)))))))

  ;; + dropbox -> howm

  (setup-hook 'howm-menu-hook
    (when my-howm-import-directory
      (let ((imported-flag nil))
        (dolist (file (directory-files my-howm-import-directory))
          (unless (string-match "^[#-]\\|~$" file)
            (let ((abs-path (concat my-howm-import-directory file)))
              (when (file-regular-p abs-path)
                (howm-remember)
                (insert-file-contents abs-path)
                (goto-char (point-min))
                (cl-case (read-char-choice (format "import %s (y, n or x)? " file) '(?y ?n ?x))
                  ((?y)
                   (let ((howm-template (concat "* " (howm-reminder-today)
                                                "- " file "\n\n%cursor")))
                     (howm-remember-submit)
                     (delete-file abs-path)
                     (setq imported-flag t)))
                  ((?n)
                   (howm-remember-discard))
                  ((?x)
                   (howm-remember-discard)
                   (let* ((newname-base (concat my-howm-import-directory "-" file))
                          (newname newname-base)
                          (n 0))
                     (while (file-exists-p newname)
                       (setq n       (1+ n)
                             newname (concat newname-base "_" (number-to-string n) ".txt")))
                     (rename-file abs-path newname))))))))
        ;; force update
        (when imported-flag
          (let ((my-howm-import-directory nil))
            (howm-menu-refresh))))))

  ;; + howm -> dropbox

  (setup-lazy '(my-howm-export-file) "calendar"
    (defun my-howm-export-file (target)
      (with-temp-file target
        (set-buffer-file-coding-system 'utf-8) ; Dropbox App compatibility
        (insert (format "* Howm Schedule %s ~ %s *\n\n"
                        (howm-reminder-today)
                        (howm-reminder-today howm-menu-schedule-days))
                ;; calendar of the next two months
                (let* ((date (calendar-current-date))
                       (month (calendar-extract-month date))
                       (year (calendar-extract-year date)))
                  (concat
                   (with-temp-buffer
                     (calendar-generate-month month year 0)
                     (buffer-substring-no-properties (point-min) (point-max)))
                   "\n\n"
                   (with-temp-buffer
                     (calendar-increment-month month year 1)
                     (calendar-generate-month month year 0)
                     (buffer-substring-no-properties (point-min) (point-max)))))
                "\n"
                (my-howm-menu-reminder))
        (message "successfully exported"))))

  (defun my-howm-generate-vevent (y m d dd body)
    (concat "BEGIN:VEVENT\n"
            "SUMMARY:" body "\n"
            "DTSTART:"
            (format-time-string "%Y%m%d" (encode-time 0 0 0 d m y)) "\n"
            "DTEND:"
            (format-time-string "%Y%m%d" (encode-time 0 0 0 (+ d dd) m y)) "\n"
            "END:VEVENT\n"))
  (defun my-howm-export-ics (target)
    (let ((lst nil))
      (with-temp-buffer
        (insert (my-howm-menu-reminder))
        (goto-char 1)
        (while (search-forward-regexp
                "\\[\\([0-9]+\\)-\\([0-9]+\\)-\\([0-9]+\\)\\][@!]\\([0-9]+\\)? \\(.+\\)$"
                nil t)
          (push (list (read (match-string 1))          ; year
                      (read (match-string 2))          ; month
                      (read (match-string 3))          ; day
                      (read (or (match-string 4) "1")) ; duration
                      (match-string 5))                ; body
                lst)))
      (with-temp-file target
        (set-buffer-file-coding-system 'utf-8-dos)
        (insert (concat "BEGIN:VCALENDAR\n"
                        "PRODID:Emacs Howm\n"
                        "VERSION:2.0\n"
                        "METHOD:PUBLISH\n"
                        "CALSCALE:GREGORIAN\n"
                        "X-WR-CALNAME:Emacs Howm\n"
                        "X-WR-TIMEZONE:Asia/Tokyo\n"
                        "BEGIN:VTIMEZONE\n"
                        "TZID:Asia/Tokyo\n"
                        "BEGIN:STANDARD\n"
                        "DTSTART:19700101T000000\n"
                        "TZOFFSETFROM:+0900\n"
                        "TZOFFSETTO:+0900\n"
                        "END:STANDARD\n"
                        "END:VTIMEZONE\n"))
        (dolist (elem lst)
          (insert (apply 'my-howm-generate-vevent elem)))
        (insert "END:VCALENDAR"))))

  ;; + howm-calendar

  (setup-lazy '(my-howm-calendar) "calendar"

    (defvar my-howm-calendar-highlight-face 'font-lock-keyword-face)

    (defvar my-howm-calendar-keymap
      (let ((kmap (make-sparse-keymap)))
        (set-keymap-parent kmap calendar-mode-map)
        (setup-keybinds kmap
          [remap calendar-exit] 'my-howm-calendar-exit
          "RET"                 'my-howm-calendar-insert-date
          "C-g"                 'my-howm-calendar-exit)))

    ;; reference | http://www.bookshelf.jp/soft/meadow_38.html#SEC563
    (defun my-howm-calendar-insert-date ()
      (interactive)
      (let ((day nil)
            (calendar-date-display-form
             '("[" year "-" (format "%02d" (string-to-number month))
               "-" (format "%02d" (string-to-number day)) "]")))
        (setq day (calendar-date-string
                   (calendar-cursor-to-date t)))
        (calendar-exit t)
        (insert day)))

    (defun my-howm-calendar-exit ()
      "like `calendar-exit' but kills the calendar buffer."
      (interactive)
      (calendar-exit t))

    (defun my-howm-calendar ()
      (interactive)
      (calendar)
      (use-local-map my-howm-calendar-keymap)
      ;; mark howm reminders
      (let (matches marker-fn)
        (with-temp-buffer
          (insert (my-howm-menu-reminder))
          (goto-char 1)
          (while (search-forward-regexp
                  ;; marked with `@' or `!' but does not starts with `('
                  "\\[\\([0-9]+\\)-\\([0-9]+\\)-\\([0-9]+\\)\\][@!]\\([0-9]+\\)? [^(]"
                  nil t)
            (let ((m (read (match-string 2)))                ; month
                  (d (read (match-string 3)))                ; date
                  (y (read (match-string 1))))               ; year
              (dotimes (dd (read (or (match-string 4) "1"))) ; duration
                (cl-destructuring-bind (_ __ ___ d m y . ____)
                    (decode-time (encode-time 0 0 0 (+ d dd) m y))
                  (push (list m d y) matches))))))
        (setq marker-fn
              `(lambda ()
                 (dolist (match ',matches)
                   (when (calendar-date-is-visible-p match)
                     (calendar-mark-visible-date match my-howm-calendar-highlight-face)))))
        (add-hook 'calendar-move-hook marker-fn nil t)
        (funcall marker-fn)))
    )

  ;; + commands

  (defvar my-howm-saved-window-configuration nil)

  (defun my-howm-exit ()
    (interactive)
    (when my-howm-export-file
      (my-howm-export-file my-howm-export-file))
    (when my-howm-export-ics
      (my-howm-export-ics my-howm-export-ics))
    ;; kill all howm buffers
    (mapc (lambda(b)
            (when (cdr (assq 'howm-mode (buffer-local-variables b)))
              (kill-buffer b)))
          (buffer-list))
    (set-window-configuration my-howm-saved-window-configuration))

  (defun my-howm-menu-or-remember ()
    (interactive)
    (if (use-region-p)
        (let ((str (buffer-substring (region-beginning) (region-end))))
          (howm-remember)
          (insert str))
      (setq my-howm-saved-window-configuration (current-window-configuration))
      (delete-other-windows)
      (howm-menu)))

  (defun my-howm-kill-buffer ()
    "save and kill this howm buffer"
    (interactive)
    (when (and buffer-file-name (string-match "\\.howm" buffer-file-name))
      (let ((buf (buffer-name)))
        (save-buffer)
        ;; codes below are added to avoid
        ;; confliction with "delete-file-if-no-contents"
        ;; - kill only when the buffer exists
        (when (string= (buffer-name) buf) (kill-buffer))
        ;; - reflesh menu
        (howm-menu-refresh))))

  ;; redefine howm-action-lock-date to allow from~to style input
  (defun howm-action-lock-interpret-input (str date future-p)
    (cond ((string-match "^[-+][0-9]+$" str) ; relative
           (howm-datestr-shift date 0 0 (string-to-number str)))
          ((string-match "^[0-9]+$" str)  ; absolute
           (howm-datestr-expand str date future-p))
          ((string-match "^\\.$" str)     ; today
           (howm-time-to-datestr))
          (t
           (error (format "Invalid input %s." str)))))
  (define-advice howm-action-lock-date (:override (date &optional new future-p))
    (let* ((prompt (concat "[" (howm-datestr-day-of-week date) "] "
                           "RET(list), [+-]num(shift), yymmdd(set)"
                           ", x~y(from/to), .(today): "))
           (str (howm-read-string prompt nil "+-~0123456789" nil nil)))
      (if (not (string-match
                "^\\([-+]?[0-9]+\\|\\.\\)\\(?:~\\([-+]?[0-9]+\\|\\.\\)\\)?$" str))
          (error (format "Invalid input %s." str))
        (save-excursion
          (let ((d1 (save-match-data
                      (howm-action-lock-interpret-input (match-string 1 str) date future-p)))
                (d2 (when (match-beginning 2)
                      (howm-action-lock-interpret-input (match-string 2 str) date future-p))))
            (while (not (looking-at howm-date-regexp))
              (backward-char))
            (replace-match d1)
            (when d2
              (goto-char (1+ (match-end 0)))
              (insert
               (format "@%d" (- (1+ (time-to-days (howm-datestr-to-time d2)))
                                (time-to-days (howm-datestr-to-time d1)))))))))))

  ;; + keybinds

  (setup-keybinds howm-mode-map
    "C-x C-s"                   'my-howm-kill-buffer
    "C-c C-d"                   'howm-insert-date
    "C-c C-c"                   'my-howm-calendar
    [remap phi-search]          'phi-search-migemo
    [remap phi-search-backward] 'phi-search-migemo-backward)
  (setup-keybinds howm-menu-mode-map
    "q"                         'my-howm-exit
    [remap phi-search]          'phi-search-migemo
    [remap phi-search-backward] 'phi-search-migemo-backward)
  (setup-keybinds howm-remember-mode-map
    "C-g"                       'howm-remember-discard
    "C-x C-s"                   'howm-remember-submit
    [remap phi-search]          'phi-search-migemo
    [remap phi-search-backward] 'phi-search-migemo-backward)

  ;; + (sentinel)
  )

;;   + global keybinds

(setup-keybinds nil
  "M-," '("howm" my-howm-menu-or-remember))
;; + mini-modeline: core

(setup-include "mini-modeline"
  (defun my-header-line--icon () nil)
  (!-
   (setup "all-the-icons"
     (defun my-header-line--icon ()
       (let ((icon (all-the-icons-icon-for-buffer)))
         (and (stringp icon) icon)))
     (setq all-the-icons-scale-factor 1.0)))
  (defun my-headerline-format ()
    (let ((lmargin
           (propertize " " 'display '((space :align-to left-fringe)) 'face 'header-line-bg-face))
          (rmargin
           (propertize " " 'display '((space :align-to (+ 1 scroll-bar))) 'face 'header-line-bg-face)))
      (concat lmargin "  "
              (my-header-line--icon)
              " "
              my-mode-line--filename
              (my-mode-line--palette-status) my-mode-line--recur-status
              " " (my-mode-line--indicators)
              "  "
              (propertize " "  'face 'header-line-bg-face) (my-header-line--full-branch)
              rmargin)))
  (defun my-mini-modeline-format ()
    (concat (my-mode-line--linum) my-mode-line--separator
            (my-mode-line--colnum) my-mode-line--separator
            (my-mode-line--mode-name) (my-mode-line--process) " "
            (my-mode-line--full-encoding) my-mode-line--separator
            (my-mode-line--clock)
            " " (my-mode-line--battery-status)))
  (setq-default header-line-format '((:eval (my-headerline-format))))
  (setq mini-modeline-r-format '((:eval (my-mini-modeline-format)))
        mini-modeline-face-attr nil)
  (setup-with-delayed-redisplay
   (mini-modeline-mode 1)))

;; + mini-modeline: appearance

(setup-after "mini-modeline"
  (set-face-attribute
   'mini-modeline-mode-line nil
   :height 0.1
   :background 'unspecified
   :inherit 'elemental-highlight-bg-1-face)
  (set-face-attribute
   'mini-modeline-mode-line-inactive nil
   :height 0.1
   :background 'unspecified
   :inherit 'elemental-brighter-bg-face)
  (!-
   (setup "sky-color-clock"
     (defun my-set-borderline-color-with-scc ()
       (let ((time (current-time))
             (cloudiness (sky-color-clock--cloudiness)))
         (set-face-attribute
          'mini-modeline-mode-line nil
          :background (sky-color-clock--pick-bg-color time cloudiness))))
     (sky-color-clock-initialize 35.40)
     (when my-openweathermap-api-key
       (sky-color-clock-initialize-openweathermap-client my-openweathermap-api-key 1850144))
     (run-with-timer 0 60 'my-set-borderline-color-with-scc))))

;; + mini-modeline: dimmer

(!-
 (setup "dimmer"
   (setq dimmer-fraction 0.2)
   (dimmer-mode 1)))

;; + mini-modeline: all-the-icons

(defun all-the-icons-octicon (&rest _) nil) ; redefined later
(defsubst my-header-line--full-branch ()
  (if my-current-branch-full-name
      (propertize (concat (all-the-icons-octicon "git-branch") " " my-current-branch-full-name)
                  'face 'header-line-bg-face)
    ""))

;; + tramp

(eval-and-compile
  (defconst my-tramp-proxies
    (when (boundp 'my-tramp-proxies) my-tramp-proxies)
    "My tramp proxies.")
  (defconst my-tramp-abbrevs
    (when (boundp 'my-tramp-abbrevs) my-tramp-abbrevs)
    "Abbreviation table for remote hosts."))

(defconst my-ftp-executable
  (!when (file-exists-p "~/.emacs.d/lib/ftp.exe")
    "~/.emacs.d/lib/ftp.exe")
  "/path/to/ftp")

(defconst my-tramp-file
  (! (concat my-dat-directory "tramp_" system-name))
  "File to save tramp settings.")

(setup-after "tramp"
  (setq tramp-persistency-file-name my-tramp-file
        tramp-default-proxies-alist (nconc my-tramp-proxies tramp-default-proxies-alist))
  (setup "docker-tramp"))
(setup-expecting "tramp"
  (define-abbrev-table 'my-tramp-abbrev-table my-tramp-abbrevs)
  (setup-hook 'minibuffer-setup-hook
    (abbrev-mode 1)
    (setq local-abbrev-table (symbol-value 'my-tramp-abbrev-table))))

;; use SSH over fakecygpty on Windows
(!when (executable-find "fakecygpty")
  (setup-after "em-alias"
    (eshell/alias "ssh" "fakecygpty ssh $*"))
  (setup-after "tramp"
    ;; reference | http://www.emacswiki.org/emacs/SshWithNTEmacs
    (push '("cygssh"
            (tramp-login-program "fakecygpty ssh")
            (tramp-login-args (("-l" "%u")
                               ("-p" "%p")
                               ("-e" "none")
                               ("%h")))
            (tramp-async-args (("-q")))
            (tramp-remote-shell "/bin/sh")
            (tramp-remote-shell-args ("-c"))
            (tramp-gw-args (("-o" "GlobalKnownHostsFile=/dev/null")
                            ("-o" "UserKnownHostsFile=/dev/null")
                            ("-o" "StrictHostKeyChecking=no")))
            (tramp-default-port 22))
          tramp-methods)
    (setq tramp-default-method "cygssh")))

;; ftp settings
(setup-after "ange-ftp"
  (when my-ftp-executable
    (setq ange-ftp-ftp-program-name my-ftp-executable)))

;; + sdic

(defconst my-sdic-eiwa-dictionary
  (!when (file-exists-p "~/.emacs.d/sdic/gene.sdic")
    "~/.emacs.d/sdic/gene.sdic")
  "Eiwa dictionary for sdic.")

(defconst my-sdic-waei-dictionary
  (!when (file-exists-p "~/.emacs.d/sdic/jedict.sdic")
    "~/.emacs.d/sdic/jedict.sdic")
  "Waei dictionary for sdic.")

(setup-after "sdic"

  ;; implement mode-hook
  (defvar sdic-mode-hook nil)
  (define-advice sdic-mode (:after (&rest _))
    (run-hooks 'sdic-mode-hook))

  ;; advice "word-at-point" to use "word-at-point"
  (setup "thingatpt"
    (define-advice sdic-word-at-point (:override (&rest _))
      (let* ((str (or (word-at-point) ""))
             (len (length str)))
        (set-text-properties 0 len nil str)
        str)))

  ;; popwin workaround
  (setup-after "popwin"
    (push '("*sdic*") popwin:special-display-config)
    ;; redefine some functions so that popwin can work with
    ;; reference | http://aikotobaha.blogspot.jp/2013/04/popwinel.html
    (define-advice sdic-display-buffer (:override (&optional start-point))
      (let ((p (or start-point (point))))
        (and sdic-warning-hidden-entry
             (> p (point-min))
             (message "この前にもエントリがあります。"))
        (goto-char p)
        (display-buffer (get-buffer sdic-buffer-name))
        (set-window-start (get-buffer-window sdic-buffer-name) p)))
    (define-advice sdic-other-window (:override (&rest _))
      (other-window 1))
    (define-advice sdic-close-window (:override (&rest _))
      (bury-buffer sdic-buffer-name)))

  ;; settings
  (setq sdic-eiwa-dictionary-list (when my-sdic-eiwa-dictionary
                                    `((sdicf-client ,my-sdic-eiwa-dictionary)))
        sdic-waei-dictionary-list (when my-sdic-waei-dictionary
                                    `((sdicf-client ,my-sdic-waei-dictionary))))
  )

(setup-lazy '(sdic-describe-word) "sdic"
  (setup-expecting "vi"
    (setup-hook 'sdic-mode-hook 'my-kindly-view-mode)))

(setup-keybinds nil
  "<f1> w" '("sdic" sdic-describe-word))
