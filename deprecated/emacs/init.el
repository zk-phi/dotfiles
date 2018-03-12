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

;; ---- eww: directories

(defconst my-eww-download-directory
  "~/.emacs.d/dat/eww_download/"
  "Directory to download files in.")

;; ---- eww: core

(setup-lazy '(eww) "eww"

  (setq eww-search-prefix      "http://search.yahoo.co.jp/search?p="
        eww-download-directory my-eww-download-directory
        eww-header-line-format nil)

  ;; disable colors by default
  ;; Reference | http://rubikitch.com/2014/11/19/eww-nocolor/
  (defvar my-eww-enable-colors nil)
  (defadvice shr-colorize-region (around my-eww-colorize-ad activate)
    (when my-eww-enable-colors ad-do-it))
  (defadvice eww-colorize-region (around my-eww-colorize-ad activate)
    (when my-eww-enable-colors ad-do-it))
  (defun my-eww-enable-colors ()
    "Enable colors in this eww buffer."
    (interactive)
    (setq-local my-eww-enable-colors t)
    (eww-reload))

  ;; Backward Compatibility (<= 24.3)
  ;; Reference | https://lists.gnu.org/archive/html/emacs-diffs/2013-06/msg00410.html
  (unless (fboundp 'add-face-text-property)
    (defun add-face-text-property (beg end face &optional appendp object)
      "Combine FACE BEG and END."
      (let ((b beg))
        (while (< b end)
          (let ((oldval (get-text-property b 'face)))
            (put-text-property
             b (setq b (next-single-property-change b 'face nil end))
             'face (cond ((null oldval)
                          face)
                         ((and (consp oldval)
                               (not (keywordp (car oldval))))
                          (if appendp
                              (nconc oldval (list face))
                            (cons face oldval)))
                         (t
                          (if appendp
                              (list oldval face)
                            (list face oldval))))))))))

  ;; disable sublimity-attractive-centering
  (setup-after "sublimity-attractive"
    (setup-hook 'eww-mode-hook
      (setq-local sublimity-attractive-centering-width nil)
      (set-window-margins (selected-window) nil nil)))

  ;; disable key-chord
  (setup-after "key-chord"
    (setup-hook 'eww-mode-hook
      (setq-local key-chord-mode nil)
      (setq-local input-method-function nil)))

  ;; disable hl-line
  (setup-after "hl-line"
    (setup-hook 'eww-mode-hook
      (setq-local global-hl-line-mode nil)))

  (setup-keybinds eww-mode-map
    ;; fundamental
    "q"   'quit-window
    "r"   'eww-reload
    ;; navigation
    "p"   'shr-previous-link
    "n"   'shr-next-link
    "h"   'eww-back-url
    "j"   '("pager" pager-row-down next-line)
    "k"   '("pager" pager-row-up previous-line)
    "C-f" '("pager" pager-page-down scroll-up-command)
    "C-b" '("pager" pager-page-up scroll-down-command)
    " "   '("pager" pager-page-down scroll-up-command)
    "DEL" '("pager" pager-page-up scroll-down-command)
    "l"   'eww-forward-url
    "f"   '("ace-link" ace-link-eww)
    "g"   'beginning-of-buffer
    "G"   'end-of-buffer
    ;; others
    "d"   'eww-download
    "w"   'eww-copy-page-url
    "x"   'eww-browse-with-external-browser
    "v"   'eww-view-source
    "C"   'url-cookie-list
    "H"   'eww-list-histories)
  )

;; ---- eww: ace-link

(setup-lazy '(ace-link-eww) "ace-link")

;; ---- highlight-changes-mode: core

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

;; ---- highlight-changes-mode: anything source

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
  (defvar anything-source-highlight-changes-mode
    '((name . "Changes")
      (init . (lambda () (setq my-change-buffer (current-buffer))))
      (candidates . my-change-candidates)
      (action . (lambda (num) (goto-char num)))
      (multiline))))

;; ---- window-undo: core

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

;; ---- window-undo: kaybinds

(setup-keybinds nil
  "C-x C--" 'my-window-undo)

;; ---- joke commands.

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

;; ---- add-log: core

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

;; ---- add-log: keybinds

(setup-keybinds nil
  "C-x C-l"   'my-add-change-log-entry)

;; ---- multifiles: core

(setup-lazy '(mf/mirror-region-in-multifile) "multifiles")

;; ---- multifiles: keybinds

(setup-keybinds nil
  "C-x C-a"   '("multifiles" mf/mirror-region-in-multifile))

;; ---- simple-demo: core

(setup-lazy '(simple-demo-set-up) "simple-demo")

;; ---- languages/CommonLisp: core

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

;; languages/Clojure: directories

(defconst my-clojure-jar-file
  (when (boundp 'my-clojure-jar-file) my-clojure-jar-file)
  "Path to clojure.jar executable.")

;; languages/Clojure: core

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

;; languages/Egison: core

(setup-lazy '(egison-mode) "egison-mode"
  :prepare (push '("\\.egi$" . egison-mode) auto-mode-alist)
  (setup-after "auto-complete"
    (push 'egison-mode ac-modes))
  (setup-keybinds egison-mode-map "C-j" nil))

;; languages/Racket: core

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

;; ---- languages/OCaml: core

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

