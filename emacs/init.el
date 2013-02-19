;; |---------------------------------
;; |                                |
;; |  init.el (for emacs v23.3)     |
;; |                                |
;; |                        zk_phi  |
;; |                                |
;; ---------------------------------|

;; * ---- CHEAT SHEET ----
;; ** global

;; Format
;; |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
;;    |     |     |     |     |     |     |     |     |     |     |     |     |
;;       |     |     |     |     |     |     |     |     |     |     |     |
;;          |     |     |     |     |     |     |     |     |     |     |

;; C-_
;; |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  | Undo|     |     |     |
;;    | Quot| Cut | End |Rplce|TrsWd| Yank| PgUp| Tab | Open| U p |  *  |     |
;;       |MulCs|Serch|Delte|Right| Quit| B S | Home|CutLn|Centr|Comnt|     |
;;          | Fold|  *  |  *  | PgDn| Left| Down|Retrn|MrkPg|     |     |

;; C-M-_
;; |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  | Redo|     |     |     |
;;    |     | Copy|EdDef|RplAl|TrsLn|YankS|BgBuf|Align|Split|BPgph|  *  |     |
;;       |MulAl|SrchB|KilWd|FWord|Abort|BKlWd|BgDef|KlPgh|Cntr0|  -  |     |
;;          |     |     |     |EdBuf|BWord|NPgph|RetCm|MrkAl|     |     |

;; M-_
;; |AlWnd|VrWnd|HrWnd|Blnce|Follw|     |     |SwWnd|PvWnd|NxWnd|LstCg|     |     |     |
;;    |Scrtc|Palet| Eval|Slice|Table|YankP|Untab|ShCmd|Opcty|EvalP|     |     |
;;       |Artst|Sarch| Dir | File| Grep|Headr|BMJmp|KlWnd| Goto|     |     |
;;          |     |Comnd|Cmpil|     |Buffr|Narrw|DMcro| Howm|     |     |

;; M-Shift-
;; |     |     |     |     |     |     |     | Barf|Wrap)|Slurp| Undo|     |     |     |
;;    |     |CpSex|EvalR|Raise|TrSex| Yank|RaisB|IdntP| Open|UpSex|     |     |
;;       |     |SpltS|KlSex|FwSex| Quit|KlSex|JoinS|CutPe|Centr|CmntP|Wrap"|
;;          |     |     |     | Mark|BwSex|DnSex|Retrn|MkSex|     |     |

;; C-x C-_
;; |     |     |     |     |     |     |     |     |BgMcr|EdMcr|     |     |     |     |
;;    |     |Write|Encod|Revrt|Trnct|     |     |Shell|     |RdOly|     |     |
;;       |     | Save|Dired|     |     |     |BMSet|KilBf|CgLog|     |     |
;;          |     |     |Close|     |     |     |ExMcr|     |     |     |

;; nonconvert
;; -   NConv : iy-go-to-char
;; - C-NConv : ace-jump-mode

;; SPC
;; -   C-SPC : set-mark-command
;; - C-M-SPC : exchange-point-and-mark

;; others
;; -   C-RET : cua-set-rectangle-mark
;; -     TAB : ac-trigger
;; - ESC ESC : vi-mode

;; ** special bindings

;; key-combo
;;
;; - C-M-w -> C-M-w :
;;        kill-ring-save -> register-oneshot-snippet
;;
;; -   C-j ->   C-j :
;;        back-to-indentation -> beginning-of-line

;; key-chord
;;
;; -  j : transpose-chars / ac-complete
;; -  i : expand snippet
;; -  n : downcase word
;; -  p : upcase word
;; -  m : capitalize word

;; ** orgtbl-mode override

;; C-_
;; |     | Edit|     |     |     |     |     |     |     |     |     |ColFm|     |     |
;;    |     |RcCut|     |     |TrRow|RcPst|     |FwCel|InRow|     |     |     |
;;       |     |     |     |     | Exit|     |     |     |     |     |     |
;;          |     |     |     |     |     |     |FwRow|     |     | Sort|

;; C-M-_
;; |     |     |     |     |     |     |     |     |     |     |     |CelFm|     |     |
;;    |     |     |     |     |TrCol|AFill|     |InCol|InHrl|     |     |     |
;;       |     |     |     |FwCel|     |     |     |     |     |     |     |
;;          |     |     |     |     |BwCel|     |HrFwR|     |     |     |

;; M-_
;; |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
;;    |     |     | Eval|     |     |     |     |     |     |     |     |     |
;;       |     |     |     |     |     |     |     |     |     |     |     |
;;          |     |     |     |     |     |     |     |     |     |     |

;; * ---- environ check ----

(when (not (boundp my-home-system-p))
  (defconst my-home-system-p nil)
  (message "!! [init] WARNING: site-start.el does not match"))

(when (not my-home-system-p)
  (message "!! [init] WARNING: this is not my home system"))

(when (not (string-match "^23\." emacs-version))
  (message "!! [init] WARNING: emacs version is not 23.X"))

(when (not (eq 'windows-nt system-type))
  (message "!! [init] WARNING: system type is not windows-nt"))

;; * ---- constants ----

;; parent directories

(defconst my:init-directory "~/.emacs.d/")
(defconst my:backup-directory "~/.emacs.bak/")

;; subdirs

(defconst my:dat-directory (concat my:init-directory "dat/"))
(defconst my:howm-directory (concat my:init-directory "howm/"))
(defconst my:eshell-directory (concat my:init-directory "eshell/"))
(defconst my:snippets-directory (concat my:init-directory "snippets/"))
(defconst my:dictionary-directory (concat my:init-directory "ac-dict/"))

;; files

(defconst my:ac-history-file (concat my:dat-directory "ac-comphist.dat"))
(defconst my:howm-keyword-file (concat my:dat-directory "howm-keys.dat"))
(defconst my:howm-history-file (concat my:dat-directory "howm-history.dat"))
(defconst my:mc-list-file (concat my:dat-directory "mc-list.dat"))
(defconst my:ditaa-jar-file (concat my:dat-directory "ditaa.jar"))

(defconst my:recentf-file (concat my:dat-directory "recentf_" system-name ".dat"))
(defconst my:bm-repository-file (concat my:dat-directory "bm_" system-name ".dat"))
(defconst my:bookmark-file (concat my:dat-directory "bookmark_" system-name ".dat"))

;; dropbox association

(defconst my:dropbox-directory
  (if my-home-system-p "~/../../Dropbox/"))

(defconst my:howm-import-directory
  (if my-home-system-p (concat my:dropbox-directory "howm_import/")))

(defconst my:howm-export-file
  (if my-home-system-p (concat my:dropbox-directory "howm_schedule.txt")))

;; * ---- meta init ----
;; ** check if the library exists

(defvar my-found-libraries nil)
(defvar my-not-found-libraries nil)

(defun my-library-exists (lib)
  (cond ((member lib my-found-libraries) t)
        ((member lib my-not-found-libraries) nil)
        ((locate-library lib) (add-to-list 'my-found-libraries lib))
        (t (add-to-list 'my-not-found-libraries lib) nil)))

(defadvice load (after add-to-found-list activate)
  (if (null ad-return-value)
      (add-to-list 'my-not-found-libraries (ad-get-arg 0))
    (add-to-list 'my-found-libraries (ad-get-arg 0))))

;; ** safe-load macros

;; load and eval functions that never fail
;; reference | http://d.hatena.ne.jp/jimo1001/20090921/1253525484
;;           | http://d.hatena.ne.jp/ozawanay/20101120

(defmacro defconfig (ft &rest sexps)
  "require feature, and if succeeded, eval configures"
    `(let ((beg-time (current-time)))
       (if (require ,ft nil t)
           (progn
             (condition-case err
                 (eval '(progn ,@sexps
                               (message ">> [init] %s: succeeded in %d msec" ,ft
                                        (my-init-ellapsed-time beg-time))))
               (error (message "XX [init] %s: %s" ,ft (error-message-string err)))))
         (message "XX [init] %s: not found" ,ft))))

(defmacro deflazyconfig (triggers file &rest sexps)
  "load library later, and when loaded, eval configures"
  `(if (my-library-exists ,file)
       (progn
         (dolist (trigger ,triggers) (autoload trigger ,file nil t))
         (eval-after-load ,file
           '(condition-case err
                (progn ,@sexps (message "<< [init] %s: loaded" ,file))
              (error (message "XX [init] %s: %s" ,file (error-message-string err)))))
         (message "-- [init] %s: ... will be autoloaded" ,file))
     (message "XX [init] %s: not found" ,file)))

(defmacro defpostload (file &rest sexps)
  "add after-load-functions"
  `(eval-after-load ,file
     '(condition-case err (progn ,@sexps)
        (error (message "XX [init] %s: %s" ,file (error-message-string err))))))

(defmacro defprepare (file &rest sexps)
  "eval only when the library exists"
  `(when (my-library-exists ,file)
     (condition-case err (progn ,@sexps)
       (error (message "XX [init] %s: %s" ,file (error-message-string err))))))

;; evaluate symbol value only if bound
;; reference | http://www.sodan.org/~knagano/emacs/dotemacs.html

(defmacro ifbound (symbol)
  "if the symbol exists, the symbol value. otherwise nil."
  `(if (boundp ',symbol) ,symbol))

;; ** benchmark for init file

;; calc ellapsed time
;; reference | http://d.hatena.ne.jp/sugyan/20120105/1325756767

(defun my-init-ellapsed-time (beg-time)
  (let* ((now (current-time))
         (min (- (car now) (car beg-time)))
         (sec (- (cadr now) (cadr beg-time)))
         (msec (/ (- (car (cddr  now)) (car (cddr beg-time))) 1000)))
    (+ (* 60000 min) (* 1000 sec) msec)))

(defvar my-benchmark-start (current-time))

(add-hook 'after-init-hook
          (lambda()
            (interactive)
            (message ">> [init] TOTAL: %d msec"
                     (my-init-ellapsed-time my-benchmark-start))))

;; ** delayed load on idle time

(defvar my-idle-require-delay 15)
(defvar my-idle-require-list nil)

(defmacro delayed-require (ft)
  `(add-to-list 'my-idle-require-list ,ft))

(run-with-idle-timer my-idle-require-delay nil
                     (lambda ()
                       (dolist (feat my-idle-require-list)
                         (require feat))))

;; ** key-override checker

;; (defvar my-defined-keys nil)

;; ;; get this file name
;; ;; reference | http://hazimarino.blogspot.jp/2010/11/emacs.html
;; (defmacro this-file-name ()
;;   '(or (buffer-file-name) load-file-name))

;; (defadvice global-set-key (after add-defined-keys activate)
;;   (when (string-match "init.elc$" (this-file-name))
;;     (setq my-defined-keys
;;           (delete (assoc (ad-get-arg 0) my-defined-keys) my-defined-keys))
;;     (add-to-list 'my-defined-keys (cons (ad-get-arg 0) (ad-get-arg 1)))))

;; (defun my-overriden-keys ()
;;   (interactive)
;;   (dolist (mybinding my-defined-keys)
;;     (let ((keybinding (key-binding (car mybinding))))
;;       (when (not (equal (cdr mybinding) keybinding))
;;         (message "%s is overriden by %s"
;;                  (key-description (car mybinding)) keybinding)))))

;; * settings
;; ** font

;; reference | http://macemacsjp.sourceforge.jp/matsuan/FontSettingJp.html

(when my-home-system-p

  (set-face-attribute 'default nil        ; ASCII
                      :family "Source Code Pro"
                      :height (* 9 10))

  (set-fontset-font "fontset-default"     ; Kanji
                    'japanese-jisx0208
                    '("VL ゴシック" . "jisx0208-sjis"))

  (set-fontset-font "fontset-default"     ; Kana
                    'katakana-jisx0201
                    '("VL ゴシック" . "jisx0201-katakana"))

  (add-to-list 'face-font-rescale-alist '("VL ゴシック.*" . 1.2))
  )

;; ** coding-system

(prefer-coding-system 'utf-8)

;; on windows, use Shift-JIS as system font
;; reference | http://sakito.jp/emacs/emacsshell.html

(when (string= window-system "w32")
  (setq locale-coding-system 'sjis)
  (setq file-name-coding-system 'sjis))

;; ** split camelCase words

;; reference | http://smallsteps.seesaa.net/article/123661899.html

(define-category ?U "Upper case")
(define-category ?L "Lower case")

(modify-category-entry (cons ?A ?Z) ?U)
(modify-category-entry (cons ?a ?z) ?L)

(add-to-list 'word-separating-categories (cons ?L ?U))

;; ** minor adjustments

;; use y-or-n instead of yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)

;; suppress beep
(set-message-beep 'silent)

;; title format
(setq frame-title-format
      (concat "%b - emacs @ " system-name))

;; enable disabled commands
(put 'narrow-to-region 'disabled nil)

;; completion
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; TABs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 5)

;; use bar cursor
(setq-default cursor-type 'bar)

;; ** my commands
;; *** swap windows

;; reference | http://www.bookshelf.jp/soft/meadow_30.html#SEC400

(defun my-swap-screen ()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))

;; *** toggle narrowing

(defun my-is-narrowed-p ()
  "Returns if the buffer is narrowed"
  (or (not (= (point-min) 1)) (not (= (1+ (buffer-size)) (point-max)))))

(defun my-narrow-to-region-or-widen (s e)
  "If the buffer is narrowed, widen. Otherwise, narrow to region."
  (interactive "r")
  (if (my-is-narrowed-p) (widen) (narrow-to-region s e)))

;; *** downcase / upcase previous word

(defun upcase-previous-word ()
  (interactive) (upcase-word -1))


(defun downcase-previous-word ()
  (interactive) (downcase-word -1))

;; *** clear or create *scratch*

;; reference | http://www.bookshelf.jp/soft/meadow_29.html#SEC392

(defun my-make-scratch (&optional arg)
  ;; create new *scratch*
  (interactive)
  (progn
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(defun my-buffer-name-list ()
  (mapcar (function buffer-name) (buffer-list)))

;; clear *scratch* instead of killing it

(add-hook 'kill-buffer-query-functions
          (function (lambda ()
                      (if (string= "*scratch*" (buffer-name))
                          (progn (my-make-scratch 0) nil)
                        t))))

;; when *scratch* is saved, create another *scratch*

(add-hook 'after-save-hook
          (function (lambda ()
                      (unless (member "*scratch*" (my-buffer-name-list))
                        (my-make-scratch 1)))))

;; *** delete file with no content

;; reference | http://www.bookshelf.jp/soft/meadow_24.html#SEC265

(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (= 1 (1+ (buffer-size))))
    (when (y-or-n-p "Delete file and kill buffer ? ")
      (delete-file
       (buffer-file-name (current-buffer)))
      (kill-buffer (current-buffer)))))

(add-hook 'after-save-hook 'delete-file-if-no-contents)

;; *** retop

(defun retop ()
  (interactive) (recenter 0))

;; *** smartchr-like commands

(defun my-smart-comma ()
  (interactive)
  (if (equal last-command this-command)
      (backward-delete-char)
    (insert ", ")))

;; *** popup *scratch*

(defvar my-another-scratch nil)

(defun my-another-scratch ()
  (when (not (and my-another-scratch
                  (buffer-live-p my-another-scratch)))
    (setq my-another-scratch (get-buffer-create "*scratch2*"))
    (set-buffer my-another-scratch)
    (lisp-interaction-mode))
  my-another-scratch)

(if (my-library-exists "popwin")

    ;; popwin version
    (defun my-scratch-pop ()
      (interactive)
      (if (and popwin:popup-buffer
               (member (buffer-name popwin:popup-buffer)
                       '("*scratch*" "*scratch2*")))
          (popwin:close-popup-window)
      (popwin:popup-buffer
       (if (member "*scratch*"
                   (mapcar (lambda (w) (buffer-name (window-buffer w)))
                           (window-list)))
           (my-another-scratch) "*scratch*"))))

  ;; display-buffer version
  (defun my-scratch-pop ()
  (interactive)
  (select-window
   (display-buffer
    (if (member "*scratch*"
                (mapcar (lambda (w) (buffer-name (window-buffer w)))
                        (window-list)))
        (my-another-scratch) "*scratch*"))))
  )

;; *** eval region or last sexp

(defun my-eval-sexp-dwim ()
  (interactive)
  (if (and (interactive-p) transient-mark-mode mark-active)
      (call-interactively 'eval-region)
    (call-interactively 'eval-last-sexp)))

;; *** eval and replace sexp

;; reference | http://irreal.org/blog/?p=297

(defun my-eval-and-replace-sexp (value)
  "Evaluate the sexp at point and replace it with its value"
  (interactive (list (eval-last-sexp nil)))
  (kill-sexp -1)
  (insert (format "%S" value)))

;; *** smooth-paging

(defconst my-page-scroll-speeds
  ;; 6*5 + 3*2 + 2*2 + 1*1 = 40 lines
  '((6 . 5) (3 . 2) (2 . 2) (1 . 1)))

(if (my-library-exists "pager")

    ;; pager version
    (progn
      (defun my-page-up ()
        (interactive)
        (let (n)
          (dolist (spd my-page-scroll-speeds)
            (dotimes (n (cdr spd))
              (pager-scroll-screen (car spd))
              (sit-for 0)))))

      (defun my-page-down ()
        (interactive)
        (let (n)
          (dolist (spd my-page-scroll-speeds)
            (dotimes (n (cdr spd))
              (pager-scroll-screen (- (car spd)))
              (sit-for 0))))))

  ;; scroll version
  (defun my-page-up ()
    (interactive)
    (let (n)
      (dolist (spd my-page-scroll-speeds)
        (dotimes (n (cdr spd))
          (scroll-up (car spd))
          (sit-for 0)))))

  (defun my-page-down ()
    (interactive)
    (let (n)
      (dolist (spd my-page-scroll-speeds)
        (dotimes (n (cdr spd))
          (scroll-down (car spd))
          (sit-for 0)))))
  )

;; ** other utilities

(defun eol-point (&optional point)
  "Returns the end-of-line point that contains the POINT"
  (save-excursion
    (when point (goto-char point)) (end-of-line) (point)))

(defun bol-point (&optional point)
  "Returns the end-of-line point that contains the POINT"
  (save-excursion
    (when point (goto-char point)) (beginning-of-line) (point)))

(defun get-first-line-string (from to)
  "Returns string of the first line of region (FROM TO)"
  (let ((eol (eol-point from)) (str ""))
    (progn
      ;; while string is blank, try to get next-line
      (while (and (string= str "") (< (1+ from) eol))
        (progn
          (setq str (buffer-substring-no-properties from (min eol to)))
          (setq from (1+ eol))
          (setq eol (eol-point from))))
      ;; kill whitespaces
      (replace-regexp-in-string "^\\s-+\\|\\s-+$" "" str))))

(defun filter (condp lst)
  (delq nil
        (mapcar (lambda (x) (and (funcall condp x) x)) lst)))

(defun directory-regular-files (dir)
  "list of regular files in DIR"
  (filter (lambda(file)(file-regular-p (concat dir file)))
          (directory-files dir)))

(defun file-string (file)
  "Read the contents of a file and return as a string."
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))

;; * built-in libraries (abcdef)
;; ** add-log

(defpostload "add-log"

  (defun my-change-log-save-and-kill ()
    (interactive)
    (save-buffer) (kill-buffer) (delete-window))

  (defadvice add-change-log-entry (before split-window-before-add-log activate)
    (split-window-vertically (* (/ (window-height) 3) 2))
    (other-window 1))

  (define-key change-log-mode-map (kbd "C-x C-s") 'my-change-log-save-and-kill)
  )

;; ** align

(defun my-align-region ()
  (interactive)
  (when (and (interactive-p) transient-mark-mode mark-active)
    (align-entire (region-beginning) (region-end))))

;; ** artist

;; artist-mode enhancements
;; reference | http://d.hatena.ne.jp/tamura70/20100125/ditaa

(defpostload "artist"

  ;; *** utilities

  (defun picture-line-draw-str (h v str)
    (cond ((/= h 0) (cond ((string= str "|") "+") ((string= str "+") "+") (t "-")))
          ((/= v 0) (cond ((string= str "-") "+") ((string= str "+") "+") (t "|")))
          (t str)))

  (defun picture-line-delete-str (h v str)
    (cond ((/= h 0) (cond ((string= str "|") "|") ((string= str "+") "|") (t " ")))
          ((/= v 0) (cond ((string= str "-") "-") ((string= str "+") "-") (t " ")))
          (t str)))

  ;; *** line-draw commands

  (defun picture-line-draw (num v h del)
    (let ((indent-tabs-mode nil)
          (old-v picture-vertical-step)
          (old-h picture-horizontal-step))
      (setq picture-vertical-step v)
      (setq picture-horizontal-step h)
      (while (>= num 0)
        (when (= num 0)
          (setq picture-vertical-step 0)
          (setq picture-horizontal-step 0))
        (setq num (1- num))
        (let (str new-str)
          (setq str
                (if (eobp) " " (buffer-substring (point) (+ (point) 1))))
          (setq new-str
                (if del (picture-line-delete-str h v str)
                  (picture-line-draw-str h v str)))
          (picture-clear-column (string-width str))
          (picture-update-desired-column nil)
          (picture-insert (string-to-char new-str) 1)))
      (setq picture-vertical-step old-v)
      (setq picture-horizontal-step old-h)))

  (defun picture-line-draw-right (n)
    (interactive "p") (picture-line-draw n 0 1 nil))

  (defun picture-line-draw-left (n)
    (interactive "p") (picture-line-draw n 0 -1 nil))

  (defun picture-line-draw-up (n)
    (interactive "p") (picture-line-draw n -1 0 nil))

  (defun picture-line-draw-down (n)
    (interactive "p") (picture-line-draw n 1 0 nil))

  (define-key artist-mode-map (kbd "<right>") 'picture-line-draw-right)
  (define-key artist-mode-map (kbd "<left>") 'picture-line-draw-left)
  (define-key artist-mode-map (kbd "<up>") 'picture-line-draw-up)
  (define-key artist-mode-map (kbd "<down>") 'picture-line-draw-down)

  ;; *** line-delete commands

  (defun picture-line-delete-right (n)
    (interactive "p") (picture-line-draw n 0 1 t))

  (defun picture-line-delete-left (n)
    (interactive "p") (picture-line-draw n 0 -1 t))

  (defun picture-line-delete-up (n)
    (interactive "p") (picture-line-draw n -1 0 t))

  (defun picture-line-delete-down (n)
    (interactive "p") (picture-line-draw n 1 0 t))

  (define-key artist-mode-map (kbd "C-<right>") 'picture-line-delete-right)
  (define-key artist-mode-map (kbd "C-<left>")  'picture-line-delete-left)
  (define-key artist-mode-map (kbd "C-<up>") 'picture-line-delete-up)
  (define-key artist-mode-map (kbd "C-<down>") 'picture-line-delete-down)

  ;; *** region-move commands

  (defun picture-region-move (start end num v h)
    (let ((indent-tabs-mode nil)
          (old-v picture-vertical-step)
          (old-h picture-horizontal-step) rect)
      (setq picture-vertical-step v)
      (setq picture-horizontal-step h)
      (setq picture-desired-column (current-column))
      (setq rect (extract-rectangle start end))
      (clear-rectangle start end)
      (goto-char start)
      (picture-update-desired-column t)
      (picture-insert ?\  num)
      (picture-insert-rectangle rect nil)
      (setq picture-vertical-step old-v)
      (setq picture-horizontal-step old-h)))

  (defun picture-region-move-right (start end num)
    (interactive "r\np") (picture-region-move start end num 0 1))

  (defun picture-region-move-left (start end num)
    (interactive "r\np") (picture-region-move start end num 0 -1))

  (defun picture-region-move-up (start end num)
    (interactive "r\np") (picture-region-move start end num -1 0))

  (defun picture-region-move-down (start end num)
    (interactive "r\np") (picture-region-move start end num 1 0))

  (define-key artist-mode-map (kbd "M-<right>") 'picture-region-move-right)
  (define-key artist-mode-map (kbd "M-<left>")  'picture-region-move-left)
  (define-key artist-mode-map (kbd "M-<up>")    'picture-region-move-up)
  (define-key artist-mode-map (kbd "M-<down>")  'picture-region-move-down)

  ;; *** keymap modification

  (define-key artist-mode-map (kbd "C-r") 'picture-draw-rectangle)
  (define-key artist-mode-map (kbd "C-w") 'picture-clear-rectangle)
  (define-key artist-mode-map (kbd "C-y") 'picture-yank-rectangle)

  ;; *** (sentinel)
  )

;; ** auto-revert

(global-auto-revert-mode)

;; ** bookmark

(defpostload "bookmark"
  (setq bookmark-default-file my:bookmark-file)
  (setq bookmark-save-flag 1))

;; ** bytecomp

;; automatically byte recompile emacs-lisp files
;; reference | http://www.bookshelf.jp/soft/meadow_18.html#SEC170

(add-hook 'after-save-hook
          (lambda()
            (if (string-match "init\\.el$" (buffer-file-name))
                (byte-compile-file (buffer-file-name)))))

;; ** calendar

(defpostload "calendar"

  ;; *** exit calendar and kill buffer

  (defun my-calendar-exit ()
    (interactive)
    (calendar-exit)
    (kill-buffer "*Calendar*"))

  ;; *** insert date in "howm" format

  ;; reference | http://www.bookshelf.jp/soft/meadow_38.html#SEC563

  (defun my-insert-day ()
    (interactive)
    (let ((day nil)
          (calendar-date-display-form
           '("[" year "-" (format "%02d" (string-to-int month))
             "-" (format "%02d" (string-to-int day)) "]")))
      (setq day (calendar-date-string
                 (calendar-cursor-to-date t)))
      (my-calendar-exit)
      (insert day)))

  ;; *** keybinds

  (define-key calendar-mode-map (kbd "RET") 'my-insert-day)
  (define-key calendar-mode-map (kbd "C-g") 'my-calendar-exit)

  ;; *** (sentinel)
  )

;; ** cc-mode

(defpostload "cc-mode"

  ;; *** coding style for C

  ;; reference | http://www.cozmixng.org/webdav/kensuke/site-lisp/mode/my-c.el

  (defconst my-c-style
    '(
      ;; **** offset

      (c-basic-offset . 4)
      (c-comment-only-line-offset . 0)

      ;; **** block comment line prefix

      ;; /*
      ;;  *    <- BLOCK-COMMENT-PREFIX
      ;;  */

      (c-block-comment-prefix . "* ")

      ;; **** echo syntactic information

      (c-echo-syntactic-information-p . t)

      ;; **** indenet with "TAB"

      (c-tab-always-indent . t)

      ;; **** electrric newline criteria for ";" and ","

      (c-hanging-semi&comma-criteria
       . (
          ;; for(i=0; i<N; i++){}    <- DO NOT HANG THESE SEMIs
          c-semi&comma-inside-parenlist

          ;; inline int method(){ foo(); bar(); }    <- DO NOT HANG THESE SEMIs
          c-semi&comma-no-newlines-for-oneline-inliners
          ))

      ;; **** electric newline around "{" and "}"

      (c-hanging-braces-alist
       . (
          ;; ***** function symbols

          ;; int fun()
          ;; {    <- DEFUN-OPEN
          ;;     ...
          ;; }    <- DEFUN-CLOSE

          (defun-open before after) (defun-close before after)

          ;; ***** class related symbols

          ;; class Class
          ;; {    <- CLASS-OPEN
          ;;     int member;
          ;;     int method()
          ;;     {    <- INLINE-OPEN
          ;;         ...
          ;;     }    <- INLINE-CLOSE
          ;; }    <- CLASS-CLOSE

          (class-open before after) (class-close before after)
          (inline-open before after) (inline-close before after)

          ;; ***** conditional construct symbols

          ;; for(;;)
          ;; {    <- SUBSTATEMENT-OPEN
          ;;     ...
          ;;     {    <- BLOCK-OPEN
          ;;       ...
          ;;     }    <- BLOCK-CLOSE
          ;;     ...
          ;; }    <- BLOCK-CLOSE

          (substatement-open before after)
          (block-open before after) (block-close before after)

          ;; ***** switch statement symbols

          ;; switch(var)
          ;; {
          ;;   case 1:
          ;;     {    <- STATEMENT-CASE-OPEN
          ;;      ...
          ;;     }
          ;;   ...
          ;; }

          (statement-case-open before after) ; case label

          ;; ***** brace list symbols

          ;; struct pairs[] =
          ;; {    <- BRACE-LIST-OPEN
          ;;     {    <- BRACE-ENTRY-OPEN
          ;;         1, 2
          ;;     },   <- BRACE-LIST-CLOSE
          ;;     {
          ;;         3, 4
          ;;     },
          ;; }    <- BRACE-LIST-CLOSE

          (brace-list-open)             ; disable
          (brace-entry-open)            ; disable
          (brace-list-close after)

          ;; ***** external scope symbols

          ;; extern "C"
          ;; {    <- EXTERN-LANG-OPEN
          ;;     ...
          ;; }    <- EXTERN-LANG-CLOSE

          (extern-lang-open before after) (extern-lang-close before after)
          (namespace-open) (namespace-close)     ; disable
          (module-open) (module-close)           ; disable
          (composition-open) (composition-close) ; disable

          ;; ***** java symbols

          ;; public void watch(Observable o){
          ;;     Observer obs = new Observer()
          ;;     {    <- INEXPR-CLASS-OPEN
          ;;         public void update(Observable o, Object obj)
          ;;         {
          ;;             history.addElement(obj);
          ;;         }
          ;;     };   <- INEXPR-CLASS-CLOSE
          ;;     o.addObserver(obs);
          ;; }

          (inexpr-class-open before after) (inexpr-class-close before after)

          ;; ***** (sentinel)
          ))

      ;; **** electric newline around ":"

      (c-hanging-colons-alist
       . (
          ;; ***** switch statement symbols

          ;; switch(var)
          ;;   {
          ;;   case 1:    <- CASE-LABEL
          ;;     ...
          ;;   default:
          ;;     ...
          ;;   }

          (case-label after)

          ;; ***** literal symbols

          ;; int fun()
          ;; {
          ;;     ...
          ;;
          ;;   label:    <- LABEL
          ;;     ...
          ;; }

          (label after)

          ;; ***** class related symbols

          ;; class Class : public ClassA, ClassB    <- INHER-INTRO
          ;; {
          ;;   public:    <- ACCESS-LABEL
          ;;     Class() : m1(0), m2(1)    <- MEMBER-INIT-INTRO
          ;;     ...
          ;; }

          (inher-intro)                 ; disable
          (member-init-intro)           ; disable
          (access-label after)

          ;; ***** (sentinel)
          ))

      ;; **** offsets

      (c-offsets-alist
       . (
          ;; ***** function symbols

          ;; int    <- TOPMOST-INTRO
          ;; main()    <- TOPMOST-INTRO-CONT
          ;; {    <- DEFUN-OPEN
          ;;     a = 1 + 2    <- DEFUN-BLOCK-INTRO  --+
          ;;           + 3;    <- STATEMENT-CONT      +-- STATEMENT
          ;;     ...                                --+
          ;; }    <- DEFUN-CLOSE

          (topmost-intro . 0) (topmost-intro-cont . c-lineup-topmost-intro-cont)
          (defun-open . 0) (defun-block-intro . +) (defun-close . 0)
          (statement . 0) (statement-cont . c-lineup-math)

          ;; ***** class related symbols

          ;; class Class
          ;;     : public ClassA,    <- INHER-INTRO
          ;;     : public ClassB    <- INHER-CONT
          ;; {    <- CLASS-OPEN
          ;;   public:    <- ACCESS-LABEL            --+
          ;;     Class()                               |
          ;;         : m1(0),    <- MEMBER-INIT-INTRO  |
          ;;         : m2(1)    <- MEMBER-INIT-CONT    |
          ;;     {    <- INLINE-OPEN                   +-- INCLASS
          ;;         m1.foo();                         |
          ;;         m2.foo();                         |
          ;;     }    <- INLINE-CLOSE                  |
          ;;     friend class Friend;    <- FRIEND   --+
          ;; };

          (class-open . 0) (inclass . +) (class-close . 0)
          (inher-intro . +) (inher-cont . c-lineup-multi-inher)
          (member-init-intro . +) (member-init-cont . c-lineup-multi-inher)
          (inline-open . 0) (inline-close . 0)
          (access-label . /) (friend . 0)

          ;; ThingManager <int,
          ;;     Framework:: Callback *,      --+-- TEMPLATE-ARGS-CONT
          ;;     Mutex> framework_callbacks;  --+

          (template-args-cont c-lineup-template-args +)

          ;; ***** conditional construct symbols

          ;; if(cond)
          ;; {    <- SUBSTATEMENT-OPEN (for "if")
          ;;     ...    <- STATEMENT-BLOCK-INTRO
          ;;     {    <- BLOCK-OPEN
          ;;         baz();    <- STATEMENT-BLOCK-INTRO
          ;;     }    <- BLOCK-CLOSE
          ;; }
          ;; else    <- ELSE-CLAUSE
          ;;   label:    <- SUBSTATEMENT-LABEL
          ;;     bar();    <- SUBSTATEMENT

          (substatement-open . 0) (statement-block-intro . +)
          (substatement-label . *) (substatement . +)
          (else-clause . 0) (do-while-closure . 0) (catch-clause . 0)

          ;; ***** switch statement symbols

          ;; switch(var)
          ;; {
          ;;   case 1:    <- CASE-LABEL
          ;;     foo();    <- STATEMENT-CASE-INTRO
          ;;     break;
          ;;   default:
          ;;     {    <- STATEMENT-CASE-OPEN
          ;;       bar();
          ;;     }
          ;; }

          (case-label . *)
          (statement-case-intro . *) (statement-case-open . *)

          ;; ***** brace list symbols

          ;; struct pairs[] =
          ;; {    <- BRACE-LIST-OPEN
          ;;     { 1, 2 },    <- BRACE-LIST-INTRO  --+
          ;;     {    <- BRACE-ENTRY-OPEN            +-- BRACE-LIST-ENTRY
          ;;       3, 4                              |
          ;;     }    <- BRACE-LIST-CLOSE          --+
          ;; }    <- BRACE-LIST-CLOSE

          (brace-list-open . 0) (brace-list-intro . +) (brace-list-close . 0)
          (brace-list-entry . 0) (brace-entry-open . 0)

          ;; ***** external scope symbols

          ;; extern "C"
          ;; {    <- EXTERN-LANG-OPEN
          ;;     ...    <- INEXTERN-LANG
          ;; }    <- EXTERN-LANG-CLOSE

          (extern-lang-open . 0) (inextern-lang . +) (extern-lang-close . 0)
          (composition-open . 0) (incomposition . +) (composition-close . 0)
          (namespace-open . 0) (innamespace . +) (namespace-close . 0)
          (module-open . 0) (inmodule . +) (module-close . 0)

          ;; ***** paren list symbols

          ;; function1(
          ;;     a,    <- ARGLIST-INTRO
          ;;     b     <- ARGLIST-CONT
          ;;     );    <- ARGLIST-CLOSE

          ;; function2( a,
          ;;            b );    <- ARGLIST-CONT-NONEMPTY

          (arglist-intro . +) (arglist-close . 0)
          (arglist-cont c-lineup-gcc-asm-reg 0)
          (arglist-cont-nonempty c-lineup-gcc-asm-reg c-lineup-arglist)

          ;; ***** literal symbols

          ;; /*    <- COMMENT-INTRO
          ;;  */    <- C

          (comment-intro c-lineup-knr-region-comment c-lineup-comment)
          (c . c-lineup-C-comments)

          ;; void fun()
          ;; throw (int)    <- FUNC-DECL-CONT
          ;; {
          ;;     char* str = "a multiline\
          ;; string";    <- STRING
          ;;     ...
          ;;   label:    <- LABEL
          ;;     {    <- BLOCK-OPEN
          ;;         foo();
          ;;     }    <- BLOCK-CLOSE
          ;; }

          (func-decl-cont . *)
          (string . c-lineup-dont-change) (label . *)
          (block-open . 0) (block-close . 0)

          ;; cout << "Hello, "
          ;;      << "World!\n";    <- STREAM-OP

          (stream-op . c-lineup-streamop)

          ;; ***** multiline macro symbols

          ;; int main()
          ;; {
          ;;     ...
          ;;   #ifdef DEBUG    <-  CPP-MACRO
          ;;     ...
          ;;   #define swap(A, B) \
          ;;       {              \    <- CPP-DEFINE-INTRO  --+
          ;;         int t = A;   \                           |
          ;;         A = B;       \                           +-- CPP-MACRO-CONT
          ;;         B = t;       \                           |
          ;;       }              \                         --+
          ;;     ...
          ;; }

          (cpp-macro . /) ;; (cpp-macro . [0])
          (cpp-macro-cont . +)
          (cpp-define-intro c-lineup-cpp-define +)

          ;; ***** objective-c method symbols

          ;; - (void)setWidth: (int)width    <- OBJC-METHOD-INTRO
          ;;           height: (int)height    <- OBJC-METHOD-ARGS-CONT
          ;; {
          ;;     [object setWidth: 10
          ;;             height: 10];    <- OBJC-METHOD-CALL-CONT
          ;; }

          (objc-method-intro . 0)
          (objc-method-args-cont . c-lineup-ObjC-method-args)
          (objc-method-call-cont c-lineup-ObjC-method-call-colons
                                 c-lineup-ObjC-method-call +)

          ;; ***** java symbols

          ;; @Test
          ;; public void watch()    <- ANNOTATION-TOP-CONT
          ;; {
          ;;     @NonNull
          ;;     Observer obs = new Observer()    <- ANNOTATION-VAR-CONT
          ;;         {    <- INEXPR-CLASS
          ;;             public void update(Observable o, Object obj)
          ;;             {
          ;;                 history.addElement(arg);
          ;;             }
          ;;         };    <- INEXPR-CLASS
          ;;     o.addObserver(obs);
          ;; }

          ;; (annotation-top-cont . 0) (annotation-var-cont . 0)
          (inexpr-class . +)

          ;; ***** statement block symbols

          ;; int res = ({
          ;;         int t;    <- INEXPR-STATEMENT
          ;;         if(a<10) t = foo();
          ;;         else t = bar();
          ;;         t;
          ;;     });    <- INEXPR-STATEMENT

          (inexpr-statement . +)

          ;; string s = map (backtrace() [-2] [3..],
          ;;                 lambda
          ;;                     (mixed arg)    <- LAMBDA-INTRO-CONT
          ;;                 {    <- INLINE-OPEN           --+
          ;;                     return sprintf("%t", arg);  +-- INLAMBDA
          ;;                 }    <- INLINE-CLOSE          --+
          ;;                 ) * ", " + "\n";
          ;; return catch {
          ;;         write(s + "\n");  --+-- INEXPR-STATEMENT
          ;;     };                    --+

          (lambda-intro-cont . +) (inlambda . c-lineup-inexpr-block)

          ;; ***** K&R symbols

          ;; int fun(a, b, c)
          ;;   int a;    <- KNR-ARGDECL-INTRO
          ;;   int b;  --+-- KNR-ARGDECL
          ;;   int c;  --+
          ;; {
          ;;     ...
          ;; }

          (knr-argdecl-intro . *) (knr-argdecl . 0)

          ;; ***** (sentinel)
          ))

      ;; **** clean ups

      (c-cleanup-list
       . (
          brace-catch-brace               ; } <-catch <-{
          empty-defun-braces              ; fun(){ <-}
          defun-close-semi                ; } <-;
          list-close-comma                ; } <-,
          scope-operator                  ; : <-:
          one-liner-defun                 ; fun() <-{ <-stmt; <-}
          ))

      ;; **** (sentinel)
      ))

  (c-add-style "phi" my-c-style)

  ;; *** coding style diff for java

  (defun my-java-style-init ()
    (setq c-hanging-braces-alist
          '(
            (defun-open after) (defun-close before after)
            (class-open after) (class-close before after)
            (inline-open after) (inline-close before after)
            (substatement-open after)
            (block-open before after) (block-close before after)
            (statement-case-open after)
            (brace-list-open)
            (brace-entry-open)
            (brace-list-close after)
            (extern-lang-open after) (extern-lang-close before after)
            (namespace-open) (namespace-close)
            (module-open) (module-close)
            (composition-open) (composition-close)
            (inexpr-class-open after) (inexpr-class-close before after))))

  ;; *** settings

  (add-hook 'c-mode-common-hook
            (lambda ()
              (setq c-auto-newline t)
              (c-set-style "phi")))

  (add-hook 'java-mode-hook 'my-java-style-init)

  ;; *** slurp command

  (defun my-c-end-of-statement-p ()
    (= (point)
       (save-excursion
         (call-interactively 'c-beginning-of-statement)
         (c-end-of-statement)
         (point))))

  (defun my-c-slurp ()
    "slurp command for c-language
foo|; bar;}  ->  foo, bar;|}
foo;|} bar;  ->  foo; bark;}"
    (interactive)
    (save-excursion
      (c-end-of-statement)
      (cond
       ;; slurp semi
       ((equal (char-before) ?\;)
        (backward-char)
        (let ((beg (point)))
          (c-end-of-statement 2)
          (if (equal (char-before) ?\})
              (error "no more statements in this block")
            (call-interactively 'c-beginning-of-statement)
            (kill-region beg (point))
            (insert ", "))))
       ;; slurp brace
       ((equal (char-before) ?\})
        (delete-backward-char 1)
        (let* ((beg (point))
               (req-nl
                (= beg (save-excursion (back-to-indentation) (point)))))
          (when req-nl (kill-whole-line))
          (c-end-of-statement)
          (when req-nl (insert "\n"))
          (insert "}")
          (c-indent-region beg (point)))))))

  (defprepare "paredit"
    (deflazyconfig '(paredit-forward-up) "paredit")

    (defun my-c-slurp-or-paren-slurp ()
      (interactive)
      (if (< (save-excursion (paredit-forward-up) (point))
             (save-excursion (c-end-of-statement) (point)))
          (paredit-forward-slurp-sexp)
        (my-c-slurp)))
    )

  ;; *** keybinds

  (define-key c-mode-map (kbd ",") nil)
  (define-key c-mode-map (kbd "C-d") nil)
  (define-key c-mode-map (kbd "C-M-a") nil)
  (define-key c-mode-map (kbd "C-M-e") nil)
  (define-key c-mode-map (kbd "M-e") nil)
  (define-key c-mode-map (kbd "M-j") nil)
  (define-key c-mode-map (kbd "C-M-h") nil)
  (define-key c-mode-map (kbd "C-M-j") nil)
  (define-key c-mode-map (kbd "M-)") 'my-c-slurp)

  (defprepare "paredit"
    (define-key c-mode-map (kbd "M-)") 'my-c-slurp-or-paren-slurp))

  (define-key java-mode-map (kbd ",") nil)
  (define-key java-mode-map (kbd "C-d") nil)
  (define-key java-mode-map (kbd "C-M-a") nil)
  (define-key java-mode-map (kbd "C-M-e") nil)
  (define-key java-mode-map (kbd "M-e") nil)
  (define-key java-mode-map (kbd "M-j") nil)
  (define-key java-mode-map (kbd "C-M-h") nil)
  (define-key java-mode-map (kbd "C-M-j") nil)
  (define-key java-mode-map (kbd "M-)") 'my-c-slurp)

  (defprepare "paredit"
    (define-key java-mode-map (kbd "M-)") 'my-c-slurp-or-paren-slurp))

  ;; *** (sentinel)
  )

;; ** cua

(setq cua-enable-cua-keys nil)
(cua-mode 1)

;; a hack to disable shift-region

(defadvice cua--pre-command-handler-1 (around cua-disable-shift-region activate)
  (flet ((this-single-command-raw-keys () nil))
    (let ((window-system t))
      ad-do-it)))

;; ** delsel

(delete-selection-mode 1)

;; ** dired

;; show summary on startup

(add-hook 'dired-mode-hook 'dired-summary)

;; add "[Dired]" on dired mode buffer
;; reference | http://qiita.com/items/13585a5711d62e9800ef

(defun my-dired-append-buffer-name-hint ()
  (when (eq major-mode 'dired-mode)
    (rename-buffer (concat "[Dired]" (buffer-name)) t)))

(add-hook 'dired-mode-hook 'my-dired-append-buffer-name-hint)

;; ** eshell

(defpostload "eshell"

  ;; *** eshell directory

  (setq eshell-directory-name my:eshell-directory)

  ;; *** eshell aliases

  ;; run find-file with "emacs"
  ;; reference | http://www.emacswiki.org/cgi-bin/wiki?EshellFunctions

  (defun eshell/emacs (&optional file)
    "Open a file in emacs. Some habits die hard."
    (let ((dir default-directory))
      (when (equal (buffer-name) shell-pop-internal-mode-buffer)
        (shell-pop-out))
      (if file
          (find-file (concat dir file))
        (bury-buffer))))

  ;; open in associated application (for Windows)
  ;; reference | http://www.bookshelf.jp/soft/meadow_25.html

  (when (string= window-system "w32")
    (defun eshell/open (&optional file)
      "Type '\\[uenox-dired-winstart]': win-start the current line's file."
      (interactive)
      (unless (null file)
        (w32-shell-execute "open" (expand-file-name file)))))

  ;; *** (sentinel)
  )

;; ** files
;; *** backup

;; backup directory

(setq backup-directory-alist
      `( ("\\.*$" . ,(expand-file-name my:backup-directory))) )

;; version control
;; reference | http://aikotobaha.blogspot.jp/2010/07/emacs.html

(setq version-control t)

;; make backups even if VC is enabled
(setq vc-make-backup-files t)

(setq kept-new-versions 10)
(setq kept-old-versions 1)

(setq delete-old-versions t)

;; *** auto-save

;; enable auto-save
(setq auto-save-default t)

;; automatically delete auto-save files
(setq delete-auto-save-files t)

;; ** flymake

(defprepare "flymake"
  (add-hook 'c-mode-hook 'flymake-find-file-hook))

(deflazyconfig '(flymake-find-file-hook) "flymake"

  ;; *** turn-off flymake-mode in condition flymake cannot run

  ;; reference | http://moimoitei.blogspot.jp/2010/05/flymake-in-emacs.html

  (defadvice flymake-can-syntax-check-file
    (after my-flymake-can-syntax-check-file activate)
    (cond
     ((not ad-return-value))
     ((and (fboundp 'tramp-list-remote-buffers)
           (memq (current-buffer) (tramp-list-remote-buffers)))
      (setq ad-return-value nil))
     ((not (file-writable-p buffer-file-name))
      (setq ad-return-value nil))
     ((let ((cmd (nth 0 (prog1
                            (funcall
                             (flymake-get-init-function buffer-file-name))
                          (funcall
                           (flymake-get-cleanup-function buffer-file-name))))))
        (and cmd (not (executable-find cmd))))
      (setq ad-return-value nil))))

  ;; *** display warning under cursor automatically

  ;; reference | http://tech.kayac.com/archive/emacs.html

  (defun my-flymake-display-err-minibuf-for-current-line ()
    "Displays the error/warning for the current line in the minibuffer"
    (interactive)
    (let* ((line-no            (flymake-current-line-no))
           (line-err-info-list
            (nth 0 (flymake-find-err-info flymake-err-info line-no)))
           (count              (length line-err-info-list)))
      (while (> count 0)
        (when line-err-info-list
          (let* ((text
                  (flymake-ler-text (nth (1- count) line-err-info-list)))
                 (line
                  (flymake-ler-line (nth (1- count) line-err-info-list))))
            (message "[%s] %s" line text)))
        (setq count (1- count)))))

  (defadvice previous-line (after my-display-error-on-previous-line activate)
    (when flymake-mode (my-flymake-display-err-minibuf-for-current-line)))

  (defadvice next-line (after my-display-error-on-next-line activate)
    (when flymake-mode (my-flymake-display-err-minibuf-for-current-line)))

  ;; *** settings for each languages

  (setq-default flymake-allowed-file-name-masks nil)

  ;; template
  ;; reference | http://www.gfd-dennou.org/member/uwabami/cc-env/Emacs/flymake_config.html

  (defun flymake-simple-generic-init (cmd &optional opts)
    (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                        'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list cmd (append opts (list local-file)))))

  ;; **** setting for gcc (.c)

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.c\\'"
                 (lambda () (flymake-simple-generic-init
                             "gcc"
                             '("-fsyntax-only" "-ansi" "-pedantic" "-Wall"
                               "-W" "-Wextra" "-Wunreachable-code")))))

  ;; *** (sentinel)
  )

;; ** frame

;; do not blink cursor

(blink-cursor-mode -1)

;; toggle-opacity
;; reference | http://d.hatena.ne.jp/IMAKADO/20090215/1234699972

(set-frame-parameter nil 'alpha 100)

(defun toggle-opacity()
  (interactive)
  (if (= (assoc-default 'alpha (frame-parameters)) 100)
      (set-frame-parameter nil 'alpha 66)
    (set-frame-parameter nil 'alpha 100) ))

;; * built-in libraries (ghijkl)
;; ** hexl

;; open binary file with hexl-find-file
;; reference | http://www.bookshelf.jp/soft/meadow_23.html#SEC236

(defun my-file-binary-p (file &optional full)
  "Return t if FILE contains binary data.  If optional FULL is non-nil,
check for the whole contents of FILE, otherwise check for the first
1000-byte."
  (let ((coding-system-for-read 'binary)
        (enable-emultibyte-characters nil))
    (with-temp-buffer
      (insert-file-contents file nil 0 (if full nil 1000))
      (goto-char (point-min))
      (and (re-search-forward "[\000-\010\016-\032\034-\037]" nil t)
           t))))

(defadvice find-file (around my-find-hexl-file (file &optional wild) activate)
  (if (and (condition-case nil (my-file-binary-p file)(error))
           (y-or-n-p "Open with hexl-find-file ? "))
      (hexl-find-file file)
    ad-do-it))

;; ** hi-lock

(defun hi-lock-rehighlight ()
  (interactive)
  (when (and (boundp 'hi-lock-interactive-patterns)
             hi-lock-interactive-patterns)
    (unhighlight-regexp (car (car hi-lock-interactive-patterns))))
    (call-interactively 'highlight-regexp))

;; ** hl-line

(global-hl-line-mode)

;; ** hideshow

(defpostload "hideshow"

  (defun my-hs-display (ov)
          (when (eq 'code (overlay-get ov 'hs))
            (overlay-put ov 'display
                         (propertize
                          (format " -- %d line(s) --"
                                  (- (count-lines (overlay-start ov)
                                                  (overlay-end ov)) 1))
                          'face 'bold))))

  (setq hs-set-up-overlay 'my-hs-display)
  )

;; ** imenu

(setq imenu-auto-rescan t)

;; ** isearch

;; when region is active, isearch with the string

(defun my-isearch-forward ()
  (interactive)
  (when (not isearch-mode)
    (call-interactively 'isearch-forward-regexp)
    (when (and (interactive-p) transient-mark-mode mark-active)
      (let ((string
             (buffer-substring (region-beginning) (region-end))))
        (deactivate-mark)
        (isearch-yank-string string)))))

(defun my-isearch-backward ()
  (interactive)
  (when (not isearch-mode)
    (call-interactively 'isearch-backward-regexp)
    (when (and (interactive-p) transient-mark-mode mark-active)
      (let ((string
             (buffer-substring (region-beginning) (region-end))))
        (deactivate-mark)
        (isearch-yank-string string)))))

;; ** linum

;; show linum when "goto-line"

(defun my-linum-goto-line ()
  (interactive)
  (unwind-protect
      (progn (linum-mode 1) (call-interactively 'goto-line))
    (linum-mode -1)))

;; ** lisp
;; *** utilities

(defun my-beginning-of-sexp-p ()
  (= (point)
     (save-excursion
       (if (condition-case err (forward-sexp) (error t))
           -1
         (backward-sexp) (point)))))

(defun my-end-of-sexp-p ()
  (= (point)
     (save-excursion
       (if (condition-case err (backward-sexp) (error t))
           -1
         (forward-sexp) (point)))))

;; *** commands

(defun my-mark-sexp ()
  (interactive)
  (if (my-end-of-sexp-p) (mark-sexp -1) (mark-sexp 1)))

(defun my-yank-sexp ()
  (interactive)
  (save-excursion
    (my-mark-sexp) (call-interactively 'kill-ring-save)))

(defun my-transpose-sexps ()
  (interactive) (transpose-sexps -1))

(defun my-down-list ()
  (interactive)
  (if (my-end-of-sexp-p) (down-list -1) (down-list 1)))

(defun my-reindent-sexp ()
  (interactive)
  (save-excursion (my-mark-sexp) (indent-for-tab-command)))

;; ** lisp-mode

(defpostload "lisp-mode"

  (define-key emacs-lisp-mode-map (kbd "M-TAB") nil) ; align-entire
  (define-key lisp-interaction-mode-map (kbd "C-j") nil) ; beginning-of-line
  )

;; * built-in libraries (mnopqrs)
;; ** menu-bar

(menu-bar-mode -1)

;; ** org

(defpostload "org"

  (add-hook 'org-mode-hook 'auto-fill-mode)
  (setq org-ditaa-jar-path (expand-file-name my:ditaa-jar-file))

  ;; *** startup

  (setq org-startup-folded nil)
  (setq org-startup-indented t)
  (setq org-startup-with-inline-images t)

  ;; *** insert "src" dwim

  (defun my-org-insert-quote-dwim ()
    (interactive)
    (let ((flg (and (interactive-p) transient-mark-mode mark-active))
          (mode-name (read-from-minibuffer "mode ? ")))
      (when flg (kill-region (region-beginning) (region-end)))
      (insert "#+begin_src " mode-name "\n\n#+end_src")
      (unless flg (insert "\n"))
      (previous-line 2)
      (org-edit-special)
      (when flg (yank) (org-edit-src-exit))))

  ;; *** keymap

  (define-key org-mode-map (kbd "C-x '") 'my-org-insert-quote-dwim)
  (define-key org-mode-map (kbd "C-c '") 'org-edit-special)
  (define-key org-mode-map (kbd "M-RET") 'org-insert-heading)
  (define-key org-mode-map (kbd "TAB") 'org-cycle)
  (define-key org-mode-map (kbd "C-y") 'org-yank)
  (define-key org-mode-map (kbd "C-k") 'org-kill-line)
  (define-key org-mode-map (kbd "C-j") 'org-beginning-of-line)
  (define-key org-mode-map (kbd "C-e") 'org-end-of-line)

  (define-key org-mode-map (kbd "M-a") 'nil) ; org-backward-sentence
  (define-key org-mode-map (kbd "M-TAB") 'nil) ; org-complete
  (define-key org-mode-map (kbd "C-,") 'nil) ; org-agenda-files
  (define-key org-mode-map (kbd "C-a") 'nil) ; org-beginning-of-line
  (define-key org-mode-map (kbd "C-j") 'nil) ; org-return-indent
  (define-key org-mode-map (kbd "M-e") 'nil) ; org-forward-sentence

  ;; *** (sentinel)
  )

;; ** org-table

(defpostload "org-table"

  ;; *** kill row with "org-table-cut-region" if no region exists

  ;; reference | http://dev.ariel-networks.com/Members/matsuyama/tokyo-emacs-02/

  (defadvice org-table-cut-region (around cut-region-or-kill-row activate)
    (if (and (interactive-p) transient-mark-mode (not mark-active))
        (org-table-kill-row)
      ad-do-it))

  ;; *** enable overlay when entering fomula edit mode

  ;; record overlay state

  (defvar org-table-overlay-state nil)
  (make-variable-buffer-local 'org-table-overlay-state)

  (defadvice org-table-toggle-coordinate-overlays (before table-record-overlay activate)
    (setq org-table-overlay-state (not org-table-overlay-state)))

  ;; automatically enable overlay

  (defadvice org-table-eval-formula (around table-formula-helper activate)
    (progn
      (unless org-table-overlay-state (org-table-toggle-coordinate-overlays))
      ad-do-it
      (org-table-toggle-coordinate-overlays)))

  ;; disable overlay before toggle orgtbl-mode

  (defadvice orgtbl-mode (around overlay-reset activate)
    (if org-table-overlay-state
        (org-table-toggle-coordinate-overlays)
      ad-do-it))

  ;; *** keybinds

  (add-hook 'orgtbl-mode-hook
            (lambda ()
              (interactive)

              ;; **** cursor

              (define-key orgtbl-mode-map (kbd "C-f") 'forward-char)
              (define-key orgtbl-mode-map (kbd "C-M-f") 'org-table-next-field)
              (define-key orgtbl-mode-map (kbd "C-b") 'backward-char)
              (define-key orgtbl-mode-map (kbd "C-M-b") 'org-table-previous-field)
              (define-key orgtbl-mode-map (kbd "C-n") 'next-line)
              (define-key orgtbl-mode-map (kbd "C-M-n") 'next-line)
              (define-key orgtbl-mode-map (kbd "C-p") 'previous-line)
              (define-key orgtbl-mode-map (kbd "C-M-p") 'previous-line)

              ;; **** region

              (define-key orgtbl-mode-map (kbd "C-w") 'org-table-cut-region)
              (define-key orgtbl-mode-map (kbd "C-M-w") 'org-table-copy-region)
              (define-key orgtbl-mode-map (kbd "C-y") 'org-table-paste-rectangle)
              (define-key orgtbl-mode-map (kbd "C-M-y") 'org-table-copy-down)

              ;; **** newline and indent

              (define-key orgtbl-mode-map (kbd "C-i") 'org-table-next-field)

              (define-key orgtbl-mode-map (kbd "C-M-i")
                (lambda() (interactive)
                  (org-table-insert-column) (org-table-next-filed)))

              (define-key orgtbl-mode-map (kbd "C-o")
                (lambda() (interactive)
                  (point-to-register 't)
                  (org-table-insert-row '(4))
                  (jump-to-register 't)))

              (define-key orgtbl-mode-map (kbd "C-M-o") 'org-table-insert-hline)

              (define-key orgtbl-mode-map (kbd "C-m") 'org-table-next-row)
              (define-key orgtbl-mode-map (kbd "C-M-m") 'org-table-hline-and-move)

              ;; **** transpose

              (define-key orgtbl-mode-map (kbd "C-t") 'org-table-move-row-up)
              (define-key orgtbl-mode-map (kbd "C-M-t") 'org-table-move-column-left)

              ;; **** eval

              (define-key orgtbl-mode-map (kbd "C-=") ; column
                (lambda() (interactive) (org-table-eval-formula)))

              (define-key orgtbl-mode-map (kbd "C-M-=") ; field
                (lambda() (interactive) (org-table-eval-formula '(4))))

              ;; **** others

              (define-key orgtbl-mode-map (kbd "C-/") 'org-table-sort-lines)
              (define-key orgtbl-mode-map (kbd "C-2") 'org-table-edit-field)

              (define-key orgtbl-mode-map (kbd "M-e")
                (lambda() (interactive) (org-table-recalculate '(16))))

              (define-key orgtbl-mode-map (kbd "C-g") 'orgtbl-mode)

              ;; **** (sentinel)
              ))

  ;; *** (sentinel)
  )

;; ** paren

(show-paren-mode)
(setq show-paren-delay 0)

;; ** recentf

(defpostload "recentf"

  (setq recentf-save-file my:recentf-file)
  (setq recentf-max-saved-items 100)

  ;; auto-save recentf-list / delayed cleanup
  ;; reference | http://d.hatena.ne.jp/tomoya/20110217/1297928222

  (run-with-idle-timer 20 t 'recentf-save-list)
  (setq recentf-auto-cleanup 60)
  )

;; ** scroll-bar

(scroll-bar-mode -1)

;; ** simple
;; *** settings
;; **** auto-fill

;; auto re-fill on delete-char

(defadvice delete-char (after auto-re-fill activate)
  (when auto-fill-function
    (call-interactively 'fill-paragraph)))

;; activate auto-fill on fundamental-mode

(add-hook 'fundamental-mode-hook 'auto-fill-mode)

;; **** truncate lines

(set-default 'truncate-lines t)

;; **** line-move-visual

(setq line-move-visual t)

;; **** open-line

;; indent after open-line

(defadvice open-line (after open-line-and-indent activate)
  (save-excursion (forward-line) (beginning-of-line) (indent-according-to-mode)))

;; **** kill-region / kill-ring-save

;; kill/copy whole line when no region is active
;; reference | http://dev.ariel-networks.com/Members/matsuyama/tokyo-emacs-02/

(defun copy-line (&optional arg)
  (interactive "p")
  (copy-region-as-kill
   (line-beginning-position)
   (line-beginning-position (1+ (or arg 1))))
  (message "Line copied"))

(defadvice kill-region (around kill-line-or-kill-region activate)
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (kill-whole-line)
    ad-do-it))

(defadvice kill-ring-save (around kill-line-or-kill-region activate)
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (copy-line)
    ad-do-it))

;; **** shift-select

;; disable shift-select

(setq shift-select-mode nil)

;; **** line-number / column-number

;; show line/col-number on modeline

(line-number-mode t)
(column-number-mode t)

;; **** eval-last-sexp

;; print more on eval-last-sexp

(setq eval-expression-print-length nil)
(setq eval-expression-print-level 5)

;; *** backward transpose

(defun backward-transpose-words ()
  (interactive) (transpose-words -1))

(defun backward-transpose-lines ()
  (interactive) (transpose-lines 1)
  (forward-line -2) (end-of-line))

(defun backward-transpose-chars ()
  (interactive) (transpose-chars -1))

;; *** automatically delete trailing whitespaces

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; *** show region size on modeline

;; reference | http://d.hatena.ne.jp/sonota88/20110224/1298557375

(defun count-lines-and-chars()
  (if mark-active
      (format "[%3d:%4d]"
              (count-lines (region-beginning)(region-end))
              (- (region-end) (region-beginning)))
    ""))

(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))

;; ** startup

(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; * built-in libraries (tuvwxyz)
;; ** time

;; display time on modeline

(setq display-time-string-forms '(24-hours ":" minutes))
(display-time)

;; ** tool-bar

(tool-bar-mode -1)

;; ** vi-mode

(defpostload "vi"

  ;; *** do not put cursor on eol

  (defun my-vi-forward-char ()
    (interactive)
    (unless (or (= (point) (1- (eol-point)))
                (= (eol-point) (bol-point)))
      (forward-char 1)))

  (defun my-vi-backward-char ()
    (interactive)
    (unless (= (point) (bol-point))
      (backward-char 1)))

  (defun my-vi-previous-line ()
    (interactive)
    (previous-line 1)
    (when (and (= (point) (eol-point))
               (not (= (point) (bol-point))))
      (backward-char 1)))

  (defun my-vi-next-line ()
    (interactive)
    (next-line 1)
    (when (and (= (point) (eol-point))
               (not (= (point) (bol-point))))
      (backward-char 1)))

  (defun my-vi-end-of-line ()
    (interactive)
    (end-of-line)
    (unless (= (point) (bol-point))
      (backward-char 1)))

  (defadvice vi-mode (after backward-char-on-vi-startup activate)
    (when (and (= (point) (eol-point))
               (not (= (point) (bol-point))))
      (backward-char 1)))

  (define-key vi-com-map "h" 'my-vi-backward-char)
  (define-key vi-com-map "j" 'my-vi-next-line)
  (define-key vi-com-map "k" 'my-vi-previous-line)
  (define-key vi-com-map "l" 'my-vi-forward-char)
  (define-key vi-com-map "$" 'my-vi-end-of-line)

  ;; *** redo+ association

  (defprepare "redo+"
    (define-key vi-com-map "\C-r" 'redo)
    (define-key vi-com-map "u" 'undo-only))

  ;; *** vi-like paren-matching

  (defadvice show-paren-function (around vi-like-paren-matching activate)
    (if (eq major-mode 'vi-mode)
        (save-excursion (forward-char) ad-do-it)
      ad-do-it))

  ;; *** make cursor-type "box" while in vi-mode

  (defadvice vi-mode (after make-cursor-box-while-vi activate)
    (setq cursor-type 'box))

  (defadvice vi-goto-insert-state (after make-cursor-box-while-vi activate)
    (setq cursor-type 'bar))

  ;; *** (sentinel)
  )

;; ** window
;; *** split many windows

;; reference | http://d.hatena.ne.jp/yascentur/20110621/1308585547

;; **** utils

(defun split-window-horizontally-n (n)
  (cond
   ;; do not split
   ((< n 2)
    nil)
   ;; (n/2) | (n/2)
   ((= (mod n 2) 0)
    (split-window-horizontally)
    (next-multiframe-window)
    (split-window-horizontally-n (/ n 2))
    (previous-multiframe-window)
    (split-window-horizontally-n (/ n 2)))
   ;; (n-1) | 1
   (t
    (split-window-horizontally (- (window-width) (/ (window-width) n)))
    (split-window-horizontally-n (1- n)))
   ))

(defun split-window-vertically-n (n)
  (cond
   ;; do not split
   ((< n 2)
    nil)
   ;; (n/2) | (n/2)
   ((= (mod n 2) 0)
    (split-window-vertically)
    (next-multiframe-window)
    (split-window-vertically-n (/ n 2))
    (previous-multiframe-window)
    (split-window-vertically-n (/ n 2)))
   ;; (n-1) | 1
   (t
    (split-window-vertically (- (window-height) (/ (window-height) n)))
    (split-window-vertically-n (1- n)))
   ))

(defun delete-window-n (n)
  (when (> n 0)
    (delete-window)
    (delete-window-n (1- n))))

;; **** commands

(defun smart-split-window-horizontally ()
  (interactive)
  (cond
   ( (eq last-command 'smart-split-window-horizontally-4)
     (delete-window-n 3)
     (setq this-command 'smart-split-window-horizontally-5) )
   ( (eq last-command 'smart-split-window-horizontally-3)
     (delete-window-n 2)
     (split-window-horizontally-n 4)
     (setq this-command 'smart-split-window-horizontally-4) )
   ( (eq last-command 'smart-split-window-horizontally-2)
     (delete-window-n 2)
     (split-window-horizontally-n 2)
     (split-window-horizontally-n 2)
     (setq this-command 'smart-split-window-horizontally-3) )
   ( (eq last-command 'smart-split-window-horizontally-1)
     (delete-window-n 1)
     (split-window-horizontally-n 3)
     (setq this-command 'smart-split-window-horizontally-2) )
   ( t
     (split-window-horizontally-n 2)
     (setq this-command 'smart-split-window-horizontally-1) )
   ))

(defun smart-split-window-vertically ()
  (interactive)
  (cond
   ( (eq last-command 'smart-split-window-vertically-2)
     (delete-window-n 2)
     (setq this-command 'smart-split-window-vertically-3) )
   ( (eq last-command 'smart-split-window-vertically-1)
     (delete-window-n 1)
     (split-window-vertically-n 3)
     (setq this-command 'smart-split-window-vertically-2) )
   ( t
     (split-window-vertically-n 2)
     (setq this-command 'smart-split-window-vertically-1) )
   ))

;; * original libraries
;; ** outlined-elisp-mode

(defprepare "outlined-elisp-mode"
  (add-hook 'emacs-lisp-mode-hook 'outlined-elisp-find-file-hook))

(deflazyconfig
  '(outlined-elisp-find-file-hook
    outlined-elisp-mode) "outlined-elisp-mode")

;; ** scratch-palette

(deflazyconfig '(scratch-palette-popup) "scratch-palette"
  (define-key scratch-palette-minor-mode-map
    (kbd "M-w") 'scratch-palette-kill))

;; ** electric-case

(deflazyconfig
  '(electric-case-c-init
    electric-case-java-init
    electric-case-scala-init
    electric-case-ahk-init) "electric-case"

    (setq electric-case-convert-calls t)
    )

(defprepare "electric-case"
  (defpostload "cc-mode"
    (add-hook 'c-mode-hook 'electric-case-c-init)
    (add-hook 'java-mode-hook 'electric-case-java-init))
  (defpostload "scala-mode"
    (add-hook 'scala-mode-hook 'electric-case-scala-init))
  (defpostload "ahk-mode"
    (add-hook 'ahk-mode-hook 'electric-case-ahk-init)))

;; * external libraries (abcdef)
;; ** ace-jump-mode

(deflazyconfig '(ace-jump-word-mode) "ace-jump-mode")

;; ** all

(defprepare "all"
  (defun my-all-command ()
    (interactive)
    (delete-other-windows)
    (call-interactively 'all)
    (other-window 1)))

(deflazyconfig '(all) "all"

  (define-key all-mode-map (kbd "C-g")
    (lambda()
      (interactive) (kill-buffer) (delete-window)))

  (define-key all-mode-map (kbd "C-n")
    ;; next-line and all-goto
    (lambda()
      (interactive) (forward-line)
      (save-selected-window (all-mode-goto))))

  (define-key all-mode-map (kbd "C-p")
    ;; previous-line and all-goto
    (lambda()
      (interactive) (forward-line -1)
      (save-selected-window (all-mode-goto))))
  )

;; ** ahk-mode

(defprepare "ahk-mode"
  (setq auto-mode-alist
        (append auto-mode-alist
                '( ("\\.ahk$" . ahk-mode) ))))

(deflazyconfig '(ahk-mode) "ahk-mode"
  (define-key ahk-mode-map (kbd "C-j") nil)
  (define-key ahk-mode-map (kbd "C-h") nil)
  )

;; ** anything
;; *** load hilit-chg for anything-changes

(defprepare "anything-config"

  ;; **** run on find-file

  (defprepare "hilit-chg"
    (add-hook 'find-file-hook 'highlight-changes-mode))

  ;; **** settings

  (deflazyconfig '(highlight-changes-mode) "hilit-chg"

    ;; ***** do not make overlay

    (setq highlight-changes-visibility-initial-state nil)

    ;; ***** clear highlights after save

    (add-hook 'after-save-hook
              (lambda()
                (when highlight-changes-mode
                  (highlight-changes-remove-highlight 1 (1+ (buffer-size))))))

    ;; ***** fix for yasnippet

    (add-hook 'yas-before-expand-snippet-hook
              (lambda()
                (when highlight-changes-mode
                  (highlight-changes-mode -1))))

    (add-hook 'yas-after-exit-snippet-hook
              (lambda()
                (highlight-changes-mode 1)
                (hilit-chg-set-face-on-change yas-snippet-beg yas-snippet-end 0)))

    ;; ***** (sentinel)
    ))

;; *** anything

(defprepare "anything-config"
  (delayed-require 'anything-config))

(deflazyconfig
  '(my-anything
    my-anything-search
    my-anything-commands
    my-anything-jump
    anything-show-kill-ring) "anything-config"

    ;; **** force split window for anything

    ;; reference | http://emacs.g.hatena.ne.jp/k1LoW/20090713/1247496970

    (defvar anything-window-height-fraction 0.6)

    (defun anything-split-window (buf)
      (split-window (selected-window)
                    (round (* (window-height) anything-window-height-fraction)))
      (other-window 1)
      (switch-to-buffer buf))

    (setq anything-display-function 'anything-split-window)

    ;; **** persistent-action on move-selection

    ;; reference | http://shakenbu.org/yanagi/d/?date=20120213

    (add-hook 'anything-move-selection-after-hook
              (lambda()
                (if (member (cdr (assq 'name (anything-get-current-source)))
                            '("Occur" "Imenu" "Buffers" "Emacs Commands"
                              "Visible Bookmarks" "Changes not saved"
                              "Flymake"))
                    (anything-execute-persistent-action))))

    ;; **** anything-flymake

    (defpostload "flymake"

      ;; reference | http://d.hatena.ne.jp/kiris60/20091003

      (eval-when-compile (require 'cl))

      ;; ***** get errorlines from flymake

      (defvar anything-flymake-err-list nil)

      (defun anything-get-flymake-candidates ()
        (mapcar
         (lambda (err)
           (let* ((type (flymake-ler-type err))
                  (text (flymake-ler-text err))
                  (line (flymake-ler-line err)))
             (cons (propertize
                    (format "[%s] %s" line text)
                    'face (if (equal type "e") 'flymake-errline 'flymake-warnline))
                   err)))
         anything-flymake-err-list))

      ;; ***** provide anything-source

      (defvar anything-c-source-flymake
        '((name . "Flymake")
          (init . (lambda ()
                    (setq anything-flymake-err-list
                          (loop for err-info in flymake-err-info
                                for err = (nth 1 err-info)
                                append err))))
          (candidates . anything-get-flymake-candidates)
          (action
           . (("Goto line" .
               (lambda (candidate)
                 (goto-line (flymake-ler-line candidate) anything-current-buffer))))))))

    ;; **** anything-changes

    (defpostload "hilit-chg"

      ;; ***** search for the next change (from . to)

      (defun search-next-change (point)
        (let ( (start nil) (tmp nil) )
          ;; if the point is nil, return nil
          (when point
            ;; if the point is changed, scan from there
            ;; else scan from next change
            (setq start (if (get-text-property point 'hilit-chg)
                            point (next-single-property-change point 'hilit-chg)))
            ;; if there's no change more, return nil
            (when start
              ;; set tmp as the end of this change
              (setq tmp (next-single-property-change start 'hilit-chg))
              ;; search adjacent changes
              (while (and tmp (get-text-property tmp 'hilit-chg))
                (setq tmp (next-single-property-change tmp 'hilit-chg)))
              ;; if search reaches end-of-buffer, the end of change is point-max
              ;; else the end of change is stored in tmp
              (if tmp (cons start tmp) (cons start (1+ (buffer-size))))))))

      ;; ***** get candidates

      (defvar change-candidates-temporary nil)

      (defun change-candidates ()
        (setq change-candidates-temporary '())
        ;; search will start from the first letter
        (let ((start 1) (tmp nil))
          ;; while another change is there
          (while (setq tmp (search-next-change start))
            (progn
              ;; add candidate
              (add-to-list 'change-candidates-temporary
                           (cons (format "%5d:: %s"
                                         (line-number-at-pos (car tmp))
                                         (get-first-line-string (car tmp) (cdr tmp)))
                                 (car tmp))
                           t)
              ;; change start position of search
              (setq start (cdr tmp))))))

      ;; ***** provide source

      (defvar anything-source-highlight-changes-mode
        '((name . "Changes not saved")
          (candidates . change-candidates-temporary)
          (init . change-candidates)
          (action . (lambda (num)
                      (interactive)
                      (goto-char num)
                      (anything-match-line-color-current-line)))))

      ;; ***** (sentinel)
      )

    ;; **** anything caller functions
    ;; ***** anything outside buffer

    (defun my-anything()
      "My 'anything'."
      (interactive)
      (anything (list
                 anything-c-source-buffers
                 anything-c-source-files-in-current-dir
                 anything-c-source-recentf
                 anything-c-source-calculation-result)
                ""
                "anything : " nil))

    ;; ***** anything inside buffer

    (defprepare "bm"
      (deflazyconfig '(anything-c-bm-init) "bm"))

    (defun my-anything-jump()
      "My 'anything'."
      (interactive)
      (anything (list
                 (ifbound anything-source-highlight-changes-mode)
                 anything-c-source-bookmarks
                 anything-c-source-bm
                 (ifbound anything-c-source-flymake)
                 anything-c-source-imenu)
                (thing-at-point 'symbol)
                "symbol : " nil))

    ;; ***** isearch with anything

    (defun my-anything-search()
      "My 'anything'."
      (interactive)
      (anything (list
                 anything-c-source-occur)
                ""
                "symbol : " nil))

    ;; ***** M-x with anything

    (defun my-anything-commands()
      "My 'anything'."
      (interactive)
      (anything (list anything-c-source-emacs-commands)
                ""
                "M-x " nil))

    ;; **** (sentinel)
    )

;; ** auto-complete

(defconfig 'auto-complete-config

  ;; *** enable auto-complete

  (global-auto-complete-mode t)

  (append ac-modes
          '(ahk-mode haskell-mode literate-haskell-mode
            prolog-mode scala-mode sml-mode))

  ;; *** auto-complete dictionary

  (add-to-list 'ac-dictionary-directories my:dictionary-directory)
  (setq ac-comphist-file my:ac-history-file)

  ;; *** auto-complete sources

  ;; ac-source-symbols is really useful, but crushes

  (setq-default ac-sources
                '( ac-source-dictionary
                   ac-source-words-in-same-mode-buffers ))

  ;; *** minor adjustments

  (setq ac-auto-start t)
  (setq ac-dwim t)
  (setq ac-delay 0)
  (setq ac-auto-show-menu 0.8)
  (setq ac-disable-faces nil)

  ;; *** additional bindings

  (defpostload "key-chord"
    (key-chord-define ac-completing-map " j" 'ac-expand))

  ;; *** (sentinel)
  )

;; ** autopair

(defconfig 'autopair
  (autopair-global-mode t))

;; ** bm

(deflazyconfig '(bm-toggle) "bm"

  ;; *** bm-repogitory

  (setq bm-repository-file my:bm-repository-file)

  ;; *** change style

  (setq bm-highlight-style 'bm-highlight-only-fringe)

  ;; *** automatically save bookmarks

  (setq-default bm-buffer-persistence t)

  (add-hook 'kill-buffer-hook 'bm-buffer-save)

  (add-hook 'kill-emacs-hook
            (lambda () (bm-buffer-save-all) (bm-repository-save)))

  ;; *** automatically restore bookmarks

  (setq bm-restore-repository-on-load t)
  (add-hook 'after-init-hook 'bm-repository-load)

  (add-hook 'find-file-hook 'bm-buffer-restore)
  (add-hook 'after-revert-hook 'bm-buffer-restore)

  ;; *** (sentinel)
  )

;; ** color-theme

(defconfig 'color-theme)

;; ** diminish

(defconfig 'diminish

  (defpostload "outline" (diminish 'outline-minor-mode "Ol"))
  (defpostload "autopair" (diminish 'autopair-mode "AP"))
  (defpostload "yasnippet" (diminish 'yas-minor-mode "Ya"))
  (defpostload "rainbow-mode" (diminish 'rainbow-mode "Rb"))
  (defpostload "highlight-parentheses" (diminish 'highlight-parentheses-mode "Hp"))
  (defpostload "outlined-elisp-mode" (diminish 'outlined-elisp-mode "Oe"))
  (defpostload "hilit-chg" (diminish 'highlight-changes-mode "Cg"))
  )

;; ** dmacro

(defprepare "dmacro"
  (defun dmacro-exec ()
    (interactive)
    (let ((*dmacro-key* (this-single-command-keys)))
      (load "dmacro")
      ;; dmacro-exec is overriden here
      (call-interactively 'dmacro-exec))))

;; ** expand-region
;; *** load

(deflazyconfig '(er/expand-region) "expand-region")

;; *** my-change commands

(defprepare "expand-region"

  (deflazyconfig
    '(er/mark-inside-pairs
      er/mark-inside-quotes
      er/mark-paragraph
      er/mark-sentence
      er/mark-word) "expand-region")

  (deflazyconfig
    '(er/mark-latex-inside-environment) "latex-mode-expansions")

  (deflazyconfig
    '(er/mark-inner-tag) "html-mode-expansions")

  (deflazyconfig
    '(er/mark-text-sentence
      er/mark-text-paragraph) "text-mode-expansions")

  (define-prefix-command 'my-change-command)

  ;; **** my-change-inside-pairs

  (defun my-change-inside-pairs ()
    (interactive)
    (er/mark-inside-pairs)
    (kill-region (region-beginning) (region-end)))

  (define-key 'my-change-command (kbd "(") 'my-change-inside-pairs)
  (define-key 'my-change-command (kbd ")") 'my-change-inside-pairs)
  (define-key 'my-change-command (kbd "{") 'my-change-inside-pairs)
  (define-key 'my-change-command (kbd "}") 'my-change-inside-pairs)

  ;; **** my-change-inside-quotes

  (defun my-change-inside-quotes ()
    (interactive)
    (er/mark-inside-quotes)
    (kill-region (region-beginning) (region-end)))

  (define-key 'my-change-command (kbd "\"") 'my-change-inside-quotes)

  ;; **** my-change-paragraph

  (defun my-change-paragraph ()
    (interactive)
    (er/mark-text-paragraph)
    (kill-region (region-beginning) (region-end)))

  (define-key 'my-change-command (kbd "P") 'my-change-paragraph)

  ;; **** my-change-sentence

  (defun my-change-sentence ()
    (interactive)
    (er/mark-text-sentence)
    (kill-region (region-beginning) (region-end)))

  (define-key 'my-change-command (kbd "S") 'my-change-sentence)

  ;; **** my-change-word

  (defun my-change-word ()
    (interactive)
    (er/mark-word)
    (kill-region (region-beginning) (region-end)))

  (define-key 'my-change-command (kbd "W") 'my-change-word)

  ;; **** my-change-inner-tag-or-environ

  (defun my-change-inner-tag-or-environ ()
    (interactive)
    (if (equal major-mode 'latex-mode)
        (er/mark-latex-inside-environment)
      (er/mark-inner-tag))
    (kill-region (region-beginning) (region-end)))

  (define-key 'my-change-command (kbd "T") 'my-change-inner-tag-or-environ)
  )

;; ** fold-dwim

(deflazyconfig '(fold-dwim-toggle fold-dwim-hide-all) "fold-dwim"

  (defadvice fold-dwim-hide (before enable-hs-before-fold activate)
    (unless hs-minor-mode (hs-minor-mode 1)))

  (defadvice fold-dwim-hide-all (before enable-hs-before-fold activate)
    (unless hs-minor-mode (hs-minor-mode 1)))
  )

;; * external libraries (ghijkl)
;; ** goto-chg

(deflazyconfig '(goto-last-change) "goto-chg")

;; ** haskell-mode

(defprepare "haskell-mode"
  (setq auto-mode-alist
        (append auto-mode-alist
                '( ("\\.hs$"     . haskell-mode)
                   ("\\.lhs$"    . literate-haskell-mode)))))

(deflazyconfig
  '(haskell-mode
    literate-haskell-mode) "haskell-mode"
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
    (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode))

;; ** howm

(defprepare "howm"
  (delayed-require 'howm))

(deflazyconfig '(howm-menu-or-remember) "howm"

  ;; *** howm directories, files

  (setq howm-directory my:howm-directory)

  (setq howm-keyword-file my:howm-keyword-file)
  (setq howm-history-file my:howm-history-file)

  (setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")

  ;; *** howm menu

  (setq howm-menu-lang 'en)

  (setq howm-menu-schedule-days-before 0)
  (setq howm-menu-schedule-days 60)
  (setq howm-menu-todo-num 50)

  (setq howm-menu-reminder-separators
        '((-1000 . "\n// dead")
          (-1 . "\n// today")
          (0 . "\n// upcoming")
          (nil . "\n// someday")))

  ;; *** open howm files with org-mode

  (add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))

  ;; *** kill howm-list buffer automatically

  (setq howm-view-summary-persistent nil)

  ;; *** auto-update reminder

  (setq howm-action-lock-forward-save-buffer t)

  ;; *** template

  (setq howm-view-title-header "*")

  (setq howm-template-date-format "[%Y-%m-%d]")
  (setq howm-template "* %date %cursor\n")

  ;; *** remove noisy faces

  (set-face-background 'howm-reminder-today-face nil)
  (set-face-background 'howm-reminder-tomorrow-face nil)

  ;; *** import notes from dropbox

  (defvar howm-import-directory my:howm-import-directory)

  (defun howm-import-from-directory (dir)
    (when dir
      (mapc (lambda (filename)
              (let ((abs-path (concat dir filename)))
                (when (y-or-n-p (format "import %s ? " filename))
                  (howm-remember)
                  (insert (file-string abs-path))
                  (let ((howm-template
                         (concat "* メモ " filename "\n\n%cursor")))
                    (howm-remember-submit))
                  (delete-file abs-path))))
            (directory-regular-files dir))))

  (add-hook 'howm-menu-hook
            (lambda()
              (howm-import-from-directory howm-import-directory)))

  ;; *** commands
  ;; **** save and kill howm buffer

  (defun save-and-exit-howm ()
    (interactive)
    (when (and
           (buffer-file-name)
           (string-match "\\.howm" (buffer-file-name)))
      (let ((buf (buffer-name)))
        (progn
          (save-buffer)
          ;; codes below are added to avoid
          ;; confliction with "delete-file-if-no-contents"
          ;; - kill only when the buffer exists
          (when (string= (buffer-name) buf) (kill-buffer))
          ;; - reflesh menu
          (howm-menu)))))

  ;; **** export schedule to dropbox

  (defvar howm-schedule-file-on-dropbox my:howm-export-file)

  (defun howm-schedule-export-to-file (filename)
    (with-temp-file filename
      (set-buffer-file-coding-system 'utf-8)
      (insert (format "* Howm Schedule ~%s *\n"
                      (howm-reminder-today howm-menu-schedule-days)))
      (insert (howm-menu-reminder))
      (message "successfully exported")))

  (defun export-to-dropbox-and-kill-all-howm-buffers ()
    (interactive)
    ;; export to dropbox
    (when howm-schedule-file-on-dropbox
      (howm-schedule-export-to-file howm-schedule-file-on-dropbox))
    ;; kill all howm buffers
    (mapc
     (lambda(b) (when (cdr (assq 'howm-mode (buffer-local-variables b)))
                  (kill-buffer b)))
     (buffer-list)))

  ;; **** open howm-remember and automatically yank

  (defun howm-menu-or-remember ()
    (interactive)
    (if (and (interactive-p) transient-mark-mode mark-active)
        (progn (kill-ring-save (region-beginning) (region-end))
               (howm-remember)
               (yank))
      (howm-menu)))

  ;; *** keybinds

  ;; editing memo

  (define-key howm-mode-map (kbd "C-x C-s") 'save-and-exit-howm)
  (define-key howm-mode-map (kbd "M-c") 'calendar)

  ;; menu

  (define-key howm-menu-mode-map (kbd "q") 'export-to-dropbox-and-kill-all-howm-buffers)

  ;; remember

  (define-key howm-remember-mode-map (kbd "C-g") 'howm-remember-discard)
  (define-key howm-remember-mode-map (kbd "C-x C-s")
    (lambda()(interactive)
      (howm-remember-submit-with-template "* %date %file\n\n%cursor")))

  ;; *** (sentinel)
  )

;; ** hl-paren

;; Because of bug in version 1.0.1, the last element is always ignored.
;; For more informations, see :
;;   http://kouzuka.blogspot.jp/2011/02/highlight-parenthesesel.html

(defconfig 'highlight-parentheses
  (add-hook 'find-file-hook 'highlight-parentheses-mode))

;; ** htmlize

;; htmlize is used by "org-export-as-html"

(defpostload "org"
  (defconfig 'htmlize))

;; ** hungry-delete

(defconfig 'hungry-delete)

;; *** hungry backward-delete-char

;; hungry-backspace in hungry-delete.el, eats current-buffer even when
;; minibuffer is active. So use backward-delete-char-untabify instead.

(setq backward-delete-char-untabify-method 'hungry)

;; ** iy-go-to-char

(deflazyconfig '(iy-go-to-char) "iy-go-to-char")

;; ** key-chord

(defconfig 'key-chord
  (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.06))

;; ** key-combo

(defconfig 'key-combo
  (key-combo-mode 1))

;; * external libraries (mnopqrs)
;; ** maxframe

(defconfig 'maxframe
  (add-hook 'window-setup-hook 'maximize-frame))

;; ** multiple-cursors
;; *** mark-all dwim

(defprepare "multiple-cursors"

  ;; **** utilities

  (defun my-mark-whole-sexp ()
    (interactive)
    (if (my-end-of-sexp-p) (mark-sexp -1)
      (when (not (my-beginning-of-sexp-p)) (backward-sexp))
      (mark-sexp 1)))

  (defun my-marking-whole-sexp-p ()
    (and transient-mark-mode
         mark-active
         (save-excursion (goto-char (region-beginning))
                         (my-beginning-of-sexp-p))
         (save-excursion (goto-char (region-end))
                         (my-end-of-sexp-p))))

  (defun my-marking-whole-word-p ()
    (and transient-mark-mode
         mark-active
         (= (region-end)
            (save-excursion
              (condition-case err
                  (progn (goto-char (region-end))
                         (backward-word) (forward-word) (point))
                (error -1))))
         (= (region-beginning)
            (save-excursion
              (progn (goto-char (region-end)) (backward-word) (point))))))

  ;; **** main

  (defun my-mc/mark-all-dwim ()
    (interactive)
    (cond
     ;; mark is not active -> mark *symbols* under cursor
     ((not (and (interactive-p) transient-mark-mode mark-active))
      (my-mark-whole-sexp)
      (call-interactively 'mc/mark-all-symbols-like-this))
     ;; marked item is sexp -> mark all symbols or words
     ((my-marking-whole-sexp-p)
      (if (y-or-n-p "restrict to symbols ? ")
          (call-interactively 'mc/mark-all-symbols-like-this)
        (call-interactively 'mc/mark-all-words-like-this)))
     ;; marked item is word -> mark all words
     ((my-marking-whole-word-p)
      (call-interactively 'mc/mark-all-words-like-this))
     ;; marked item is not a word -> mark all
     (t
      (call-interactively 'mc/mark-all-like-this))))

  ;; **** (sentinel)
  )

;; *** settings

(deflazyconfig
  '(mc/mark-all-like-this
    mc/mark-next-like-this
    mc/mark-all-words-like-this
    mc/mark-all-symbols-like-this) "multiple-cursors"

    (setq mc/list-file my:mc-list-file)
    (load my:mc-list-file)

    ;; a fix for emacs 23
    (defadvice regexp-opt (after fix-regexp-opt-symbols activate)
      (setq ad-return-value
            (if (eq (ad-get-arg 1) 'symbols)
                (concat "\\_<" ad-return-value "\\_>")
              ad-return-value)))

    (defadvice mc/mark-all-like-this (after my-mark-all-echo activate)
      (message "ALL"))

    (defadvice mc/mark-all-words-like-this (after my-mark-all-echo activate)
      (message "WORDS"))

    (defadvice mc/mark-all-symbols-like-this (after my-mark-all-echo activate)
      (message "SYMBOLS"))
    )

;; ** nav

(defprepare "nav"

  (delayed-require 'nav)

  (defun nav-toggle-and-show-summary ()
    (interactive)
    (nav-toggle)
    (message "o-pen u-p c-opy m-ove d-elete n-ew SPC-index"))
  )

(deflazyconfig '(nav-toggle) "nav"

  (define-key nav-mode-map (kbd "C-g") 'nav-unsplit-window-horizontally)
  (define-key nav-mode-map (kbd "M-d") 'nav-unsplit-window-horizontally)
  )

;; ** *BINDME* org-tree-slide-mode

(defpostload "org"
  (deflazyconfig '(org-tree-slide-mode) "org-tree-slide"

    ;; profile configures

    (org-tree-slide-presentation-profile)
    (setq org-tree-slide-header nil)
    (setq org-tree-slide-heading-emphasis t)
    (setq org-tree-slide-modeline-display 'outside)
    ))

;; ** outline-magic

(defprepare "outline-magic"
  (defpostload "outline"

    (defun outline-cycle-dwim ()
      (interactive)
      (cond
       ((or (outline-on-heading-p) (= (point) 1))
        (outline-cycle))
       (t
        (indent-for-tab-command))))

    (define-key outline-minor-mode-map (kbd "TAB") 'outline-cycle-dwim)
    ))

(deflazyconfig '(outline-cycle) "outline-magic"

  (defadvice outline-cycle (after outline-cycle-do-not-show-subtree activate)
    ;; change "folded -> children -> subtree"
    ;; to "folded -> children -> folded -> ..."
    (when (eq this-command 'outline-cycle-children)
      (setq this-command 'outline-cycle))
    ;; change "overview -> contents -> show all"
    ;; to "overview -> show all -> overview -> ..."
    (when (eq this-command 'outline-cycle-overview)
      (setq this-command 'outline-cycle-toc)))
  )

;; ** pager

(deflazyconfig '(pager-scroll-screen) "pager")

;; ** paredit

(deflazyconfig
  '(paredit-splice-sexp-killing-backward
    paredit-wrap-round
    paredit-forward-slurp-sexp
    paredit-forward-barf-sexp
    paredit-kill
    paredit-meta-doublequote
    paredit-newline
    paredit-raise-sexp
    paredit-split-sexp
    paredit-join-sexps)
  "paredit")

;; ** popwin

(defconfig 'popwin

  ;; *** popwin buffers

  (setq popwin:special-display-config
        '( ("ChangeLog")
           ("*compilation*")
           ("*Help*")
           ("*Calendar*")
           ("*howm-remember*")
           ("*Shell Command Output*")
           ("*Completions*" :noselect t)
           ("*Backtrace*" :noselect t) ))

  ;; *** activate popwin

  (setq display-buffer-function 'popwin:display-buffer)

  ;; *** (sentinel)
  )

;; ** prolog-mode

(defprepare "prolog"
  (setq auto-mode-alist
        (append auto-mode-alist
                '( ("\\.swi$" . prolog-mode) ))))

(deflazyconfig '(prolog-mode) "prolog"
  (define-key prolog-mode-map (kbd "M-a") nil)
  (define-key prolog-mode-map (kbd "M-q") nil)
  (define-key prolog-mode-map (kbd "M-RET") nil)
  (define-key prolog-mode-map (kbd "C-M-h") nil)
  (define-key prolog-mode-map (kbd "C-M-e") nil)
  (define-key prolog-mode-map (kbd "C-M-n") nil)
  (define-key prolog-mode-map (kbd "C-M-p") nil)
  (define-key prolog-mode-map (kbd "M-e") nil))

;; ** rainbow-delimiters

(deflazyconfig '(rainbow-delimiters-mode) "rainbow-delimiters")

(defprepare "rainbow-delimiters"
  (add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'emacs-interaction-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode))

;; ** rainbow-mode

(deflazyconfig '(rainbow-mode) "rainbow-mode")

(defprepare "rainbow-mode"

  (defpostload "css-mode"
    (add-hook 'css-mode-hook 'rainbow-mode))

  (add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
  )

;; ** redo+

(defconfig 'redo+)

;; ** scala mode

(defprepare "scala-mode"
  (setq auto-mode-alist
        (append auto-mode-alist
                '( ("\\.scala$" . scala-mode) ))))

(deflazyconfig '(scala-mode) "scala-mode")

;; ** shell-pop

(deflazyconfig '(shell-pop) "shell-pop"

  ;; use eshell not shell

  (shell-pop-set-internal-mode "eshell")

  ;; move to current directory after pop-up

  ;; (defadvice shell-pop-up (around cd-when-shell-pop activate)
  ;;   (let ((cwd default-directory))
  ;;     ad-do-it
  ;;     (insert cwd)
  ;;     (eshell-send-input)))
  )

;; ** smart-compile

(deflazyconfig '(smart-compile) "smart-compile"
  (setq smart-compile-alist
        '( (emacs-lisp-mode  . (emacs-lisp-byte-compile))
           (html-mode        . (browse-url-of-buffer))
           (nxhtml-mode      . (browse-url-of-buffer))
           (html-helper-mode . (browse-url-of-buffer))
           (octave-mode      . (run-octave))
           (c-mode           . "gcc -ansi -pedantic -Wall -W -Wextra -Wunreachable-code %f")
           (java-mode        . "javac -Xlint:all -encoding UTF-8 %f")
           (haskell-mode     . "ghc -Wall -fwarn-missing-import-lists %f") )))

;; ** sml-mode

(defprepare "sml-mode"
  (setq auto-mode-alist
        (append auto-mode-alist
                '( ("\\.sml$" . sml-mode) ))))

(deflazyconfig '(sml-mode) "sml-mode")

;; ** sml-modeline

(defconfig 'sml-modeline
  (sml-modeline-mode))

;; ** smooth-scrolling

(defconfig 'smooth-scrolling
  (setq smooth-scroll-margin 3))

;; ** solarized

(defpostload "color-theme"
  (defconfig 'color-theme-solarized

    (color-theme-solarized-dark)

    ;; *** ace-jump-mode

    (defpostload "ace-jump-mode"
      (set-face-foreground 'ace-jump-face-foreground "#ff6666")
      (set-face-foreground 'ace-jump-face-background "#224444"))

    ;; *** font-lock

    (defpostload "font-lock"

      ;; highlight regexp symbols
      ;; reference | http://pastelwill.jp/wiki/doku.php?id=emacs:init.el

      (set-face-foreground 'font-lock-regexp-grouping-backslash "#9955CC")
      (set-face-foreground 'font-lock-regexp-grouping-construct "#9955CC")
      )

    ;; *** highlight-parentheses

    (defpostload "highlight-parentheses"
      (hl-paren-set 'hl-paren-colors nil)
      (hl-paren-set 'hl-paren-background-colors '("#35506b" "#000000")))

    ;; *** hl-line

    (defpostload "hl-line"
      (custom-set-faces '(hl-line-face ((t (:background "#0b3641"))))))

    ;; *** paren

    (defpostload "paren"

      (set-face-attribute 'show-paren-match-face nil
                          :underline t
                          :bold t)

      (set-face-attribute 'show-paren-mismatch-face nil
                          :background "#cf2820"
                          :bold t)
      )

    ;; *** sml-modeline

    (defpostload "sml-modeline"

      (set-face-attribute 'sml-modeline-end-face nil
                          :background "#bbd6e1"
                          :foreground "#4b6671")

      (set-face-attribute 'sml-modeline-vis-face nil
                          :background "#0b3641"
                          :foreground "#6b96a1")
      )

    ;; *** flymake

    (defpostload "flymake"

      (set-face-foreground 'flymake-errline nil)
      (set-face-inverse-video-p 'flymake-errline nil)
      (set-face-background 'flymake-errline "#4e2a2a")

      (set-face-foreground 'flymake-warnline nil)
      (set-face-inverse-video-p 'flymake-warnline nil)
      (set-face-background 'flymake-warnline "#4e2a2a")
      )

    ;; *** whitespace

    (defpostload "whitespace"

      (set-face-attribute 'whitespace-space nil
                          :foreground "#9f5850"
                          :background 'unspecified)

      (set-face-attribute 'whitespace-tab nil
                          :foreground "#9f5850"
                          :background 'unspecified)
      )

    ;; *** (sentinel)
    ))

;; ** sudden death

;; ＿人人人人人人人人＿
;; ＞  sudden-death  ＜
;; ￣ＹＹＹＹＹＹＹＹ￣

(deflazyconfig '(sudden-death) "sudden-death")

;; * external libraries (tuvwxyz)
;; ** traverselisp

(deflazyconfig '(traverse-deep-rfind) "traverselisp"
  (define-key traverse-mode-map (kbd "C-p") 'traverse-go-backward)
  (define-key traverse-mode-map (kbd "C-n") 'traverse-go-forward)
  (define-key traverse-mode-map (kbd "C-g") 'traverse-quit))

;; ** uniquify

(defconfig 'uniquify
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-ignore-buffers-re "*[^*]+*"))

;; ** whitespace

(defconfig 'whitespace

  ;; activate

  (global-whitespace-mode 1)

  ;; matching

  (setq whitespace-style
        '(face tabs spaces space-mark tab-mark))

  (setq whitespace-space-regexp "\\(\x3000+\\)")

  (setq whitespace-display-mappings
        '((space-mark   ?\x3000 [?□])
          (tab-mark ?\t [?\xBB ?\t]) ))
  )

;; ** yasnippet
;; *** yasnippet

(defprepare "yasnippet"

  (delayed-require 'yasnippet)

  ;; oneshot yasnippet
  ;; reference | http://d.hatena.ne.jp/rubikitch/20090702/1246477577

  (defvar yas-oneshot-snippet nil)

  (defun yas-expand-oneshot-snippet ()
    (interactive)
    (if yas-oneshot-snippet
        (yas-expand-snippet yas-oneshot-snippet (point) (point) nil)
      (message "oneshot-snippet is not registered")))

  (defun yas-register-oneshot-snippet (start end)
    (interactive "r")
    (setq yas-oneshot-snippet (buffer-substring-no-properties start end))
    (delete-region start end)
    (yas-expand-oneshot-snippet)
    (message "%s" (substitute-command-keys "Press \\[yas-expand-oneshot-snippet] to expand.")))
  )

(deflazyconfig
  '(yas-expand
    yas-expand-snippet) "yasnippet"

    ;; **** snippets directory

    (setq yas-snippet-dirs (cons my:snippets-directory '()))

    ;; **** enable yasnippet

    (yas-global-mode 1)
    (call-interactively 'yas-reload-all)

    ;; **** allow nested snippets

    (setq yas-triggers-in-field t)

    ;; **** disable fallback

    (setq yas-fallback-behavior 'return-nil)

    ;; **** anything prompt for yasnippet

    ;; reference | http://d.hatena.ne.jp/sugyan/20120111/1326288445

    (defprepare "anything-config"
      (custom-set-variables '(yas-prompt-functions '(yas-anything-prompt))))

    (deflazyconfig '(yas-anything-prompt) "anything-config"

      (eval-when-compile (require 'cl))

      (defun yas-anything-prompt (prompt choices &optional display-fn)
        (let* ((names (loop for choice in choices
                            collect (or (and display-fn (funcall display-fn choice))
                                        choice)))
               (selected (anything-other-buffer
                          `(((name . ,(format "%s" prompt))
                             (candidates . names)
                             (action . (("Insert snippet" . (lambda (arg) arg))))))
                          "*anything yas/prompt*")))
          (if selected
              (let ((n (position selected names :test 'equal)))
                (nth n choices))
            (signal 'quit "user quit!"))))
      )

    ;; **** keybind

    (define-key yas-minor-mode-map (kbd "TAB") nil) ; auto-complete
    (define-key yas-minor-mode-map (kbd "<tab>") nil) ; auto-complete

    (define-key yas-keymap (kbd "TAB") nil) ; auto-complete
    (define-key yas-keymap (kbd "<tab>") nil) ; auto-complete
    (key-chord-define yas-keymap " i" 'yas-next-field-or-maybe-expand)

    ;; **** (sentinel)
    )

;; ** zlc

(defconfig 'zlc)

;; * keybinds
;; ** keyboard translations

;; by default ...
;; - C-m is RET
;; - C-i is TAB
;; - C-[ is ESC

(keyboard-translate ?\C-h ?\C-?)

;; ** mouse

(global-set-key (kbd "<mouse-1>") 'ignore)
(global-set-key (kbd "<down-mouse-1>") 'ignore)
(global-set-key (kbd "<drag-mouse-1>") 'ignore)
(global-set-key (kbd "<double-mouse-1>") 'ignore)
(global-set-key (kbd "<triple-mouse-1>") 'ignore)
(global-set-key (kbd "<mouse-2>") 'ignore)
(global-set-key (kbd "<down-mouse-2>") 'ignore)
(global-set-key (kbd "<drag-mouse-2>") 'ignore)
(global-set-key (kbd "<double-mouse-2>") 'ignore)
(global-set-key (kbd "<triple-mouse-2>") 'ignore)

(global-set-key (kbd "C-<mouse-1>") 'ignore)
(global-set-key (kbd "C-<down-mouse-1>") 'ignore)
(global-set-key (kbd "C-<drag-mouse-1>") 'ignore)
(global-set-key (kbd "C-<double-drag-mouse-1>") 'ignore)
(global-set-key (kbd "C-<triple-drag-mouse-1>") 'ignore)
(global-set-key (kbd "C-<mouse-2>") 'ignore)
(global-set-key (kbd "C-<down-mouse-2>") 'ignore)
(global-set-key (kbd "C-<drag-mouse-2>") 'ignore)
(global-set-key (kbd "C-<double-drag-mouse-2>") 'ignore)
(global-set-key (kbd "C-<triple-drag-mouse-2>") 'ignore)

(global-set-key (kbd "M-<mouse-1>") 'ignore)
(global-set-key (kbd "M-<down-mouse-1>") 'ignore)
(global-set-key (kbd "M-<drag-mouse-1>") 'ignore)
(global-set-key (kbd "M-<double-drag-mouse-1>") 'ignore)
(global-set-key (kbd "M-<triple-drag-mouse-1>") 'ignore)
(global-set-key (kbd "M-<mouse-2>") 'ignore)
(global-set-key (kbd "M-<down-mouse-2>") 'ignore)
(global-set-key (kbd "M-<drag-mouse-2>") 'ignore)
(global-set-key (kbd "M-<double-drag-mouse-2>") 'ignore)
(global-set-key (kbd "M-<triple-drag-mouse-2>") 'ignore)

;; ** keyboard
;; *** fundamental
;; **** emacs

;; Ctrl-
(global-set-key (kbd "C-g") 'keyboard-quit)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-g") 'abort-recursive-edit)

;; Meta-Shift-
(global-set-key (kbd "M-G") 'keyboard-quit)
(global-set-key (kbd "M-E") 'my-eval-and-replace-sexp)

;; Meta-
(global-set-key (kbd "M-e") 'my-eval-sexp-dwim)
(global-set-key (kbd "M-p") 'eval-print-last-sexp)
(global-set-key (kbd "M-x") 'execute-extended-command)
(global-set-key (kbd "M-m") 'call-last-kbd-macro)

;; Ctrl-x
(global-set-key (kbd "C-x C-c") 'save-buffers-kill-emacs)
(global-set-key (kbd "C-x C-0") 'kmacro-end-macro)
(global-set-key (kbd "C-x C-9") 'kmacro-start-macro)
(global-set-key (kbd "C-x RET") 'kmacro-end-and-call-macro) ; C-x C-m

;; Overwrite
(defprepare "anything-config"
  (global-set-key (kbd "M-x") 'my-anything-commands))
(defprepare "dmacro"
  (global-set-key (kbd "M-m") 'dmacro-exec))

;; **** buffer

;; Meta-
(global-set-key (kbd "M-b") 'switch-to-buffer)

;; Ctrl-x
(global-set-key (kbd "C-x C-w") 'write-file)
(global-set-key (kbd "C-x C-s") 'save-buffer)
(global-set-key (kbd "C-x C-k") 'kill-buffer)
(global-set-key (kbd "C-x C-e") 'set-buffer-file-coding-system)
(global-set-key (kbd "C-x C-r") 'revert-buffer-with-coding-system)
(global-set-key (kbd "C-x C-p") 'toggle-read-only)

;; Overwrite
(defprepare "anything-config"
  (global-set-key (kbd "M-b") 'my-anything))

;; **** frame, window

;; Meta-
(global-set-key (kbd "M-0") 'next-multiframe-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'smart-split-window-vertically)
(global-set-key (kbd "M-3") 'smart-split-window-horizontally)
(global-set-key (kbd "M-4") 'balance-windows)
(global-set-key (kbd "M-8") 'my-swap-screen)
(global-set-key (kbd "M-9") 'previous-multiframe-window)
(global-set-key (kbd "M-o") 'toggle-opacity)
(global-set-key (kbd "M-k") 'delete-window)

;; Ctrl-x
(global-set-key (kbd "M-5") 'follow-delete-other-windows-and-split)

;; *** motion
;; **** cursor

;; Ctrl-
(global-set-key (kbd "C-b") 'backward-char)
(global-set-key (kbd "C-p") 'previous-line)
(global-set-key (kbd "C-n") 'next-line)
(global-set-key (kbd "C-f") 'forward-char)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-b") 'backward-word)
(global-set-key (kbd "C-M-p") 'backward-paragraph)
(global-set-key (kbd "C-M-n") 'forward-paragraph)
(global-set-key (kbd "C-M-f") 'forward-word)

;; Meta-Shift-
(global-set-key (kbd "M-B") 'backward-sexp)
(global-set-key (kbd "M-P") 'backward-up-list)
(global-set-key (kbd "M-N") 'my-down-list)
(global-set-key (kbd "M-F") 'forward-sexp)

;; **** jump

;; Ctrl-
(global-set-key (kbd "C-j") 'move-beginning-of-line)
(global-set-key (kbd "C-e") 'move-end-of-line)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-j") 'beginning-of-defun)
(global-set-key (kbd "C-M-e") 'end-of-defun)

;; Meta-
(global-set-key (kbd "M-l") 'my-linum-goto-line)

;; Overwrite
(defprepare "iy-go-to-char"
  (global-set-key (kbd "<oem-pa1>") 'iy-go-to-char)  ; US
  (global-set-key (kbd "<nonconvert>") 'iy-go-to-char)) ; JP
(defprepare "ace-jump-mode"
  (global-set-key (kbd "<C-oem-pa1>") 'ace-jump-word-mode) ; US
  (global-set-key (kbd "<C-non-convert>") 'ace-jump-word-mode)) ; JP
(defprepare "goto-chg"
  (global-set-key (kbd "M--") 'goto-last-change))

;; **** scroll

;; Ctrl-
(global-set-key (kbd "C-u") 'my-page-down)
(global-set-key (kbd "C-v") 'my-page-up)
(global-set-key (kbd "C-l") 'recenter)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-u") 'beginning-of-buffer)
(global-set-key (kbd "C-M-v") 'end-of-buffer)
(global-set-key (kbd "C-M-l") 'retop)

;; Meta-Shift-
(global-set-key (kbd "M-L") 'recenter)

;; *** edit
;; **** undo, redo

;; Ctrl-
(global-set-key (kbd "C--") 'undo)

;; Ctrl-Meta-
(global-set-key (kbd "C-M--") 'repeat-complex-command)

;; Meta-Shift-
(global-set-key (kbd "M-_") 'undo)

;; Overwrite
(defprepare "redo+"
  (global-set-key (kbd "C--") 'undo-only)
  (global-set-key (kbd "C-M--") 'redo))

;; **** mark, region

;; Ctrl-
(global-set-key (kbd "C-,") 'my-mark-sexp)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-,") 'mark-whole-buffer)

;; Meta-Shift-
(global-set-key (kbd "M-<") 'my-mark-sexp)
(global-set-key (kbd "M-V") 'set-mark-command)

;; Others
(global-set-key (kbd "C-SPC") 'set-mark-command)
(global-set-key (kbd "C-M-SPC") 'exchange-point-and-mark)
(global-set-key (kbd "C-<return>") 'cua-set-rectangle-mark)

;; Overwrite
(defprepare "expand-region"
  (global-set-key (kbd "<S-oem-pa1>") 'my-change-command))
(defprepare "multiple-cursors"
  (global-set-key (kbd "C-a") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-M-a") 'my-mc/mark-all-dwim))
(defprepare "expand-region"
  (global-set-key (kbd "C-,") 'er/expand-region))

;; **** kill, yank

;; when "DEL" is defined,
;; backward-delete-char on minibuffer sometimes doesn't work

;; Ctrl-
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "C-d") 'delete-char)
;; (global-set-key (kbd "DEL") 'backward-delete-char-untabify) ; C-h
(global-set-key (kbd "C-y") 'yank)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-w") 'kill-ring-save)
(global-set-key (kbd "C-M-k") 'kill-paragraph)
(global-set-key (kbd "C-M-d") 'kill-word)
(global-set-key (kbd "C-M-h") 'backward-kill-word)

;; Meta-Shift-
(global-set-key (kbd "M-W") 'my-yank-sexp)
(global-set-key (kbd "M-K") 'kill-line)
(global-set-key (kbd "M-D") 'kill-sexp)
(global-set-key (kbd "M-H") 'backward-kill-sexp)
(global-set-key (kbd "M-Y") 'yank)

;; Meta-
(global-set-key (kbd "M-y") 'yank-pop)

;; Overwrite
(defprepare "hungry-delete"
  (global-set-key (kbd "C-d") 'hungry-delete))
(defprepare "yasnippet"
  (global-set-key (kbd "M-y") 'anything-show-kill-ring)
  (global-set-key (kbd "C-M-y") 'yas-expand-oneshot-snippet))
(defprepare "paredit"
  (global-set-key (kbd "M-K") 'paredit-kill))

;; **** newline, indent, format

;; Ctrl-
(global-set-key (kbd "TAB") 'indent-for-tab-command) ; C-i
(global-set-key (kbd "C-o") 'open-line)
(global-set-key (kbd "RET") 'newline-and-indent) ; C-m

;; Ctrl-Meta-
(global-set-key (kbd "C-M-i") 'my-align-region)
(global-set-key (kbd "C-M-o") 'split-line)
(global-set-key (kbd "C-M-m") 'indent-new-comment-line)

;; Meta-Shift-
(global-set-key (kbd "M-I") 'my-reindent-sexp)
(global-set-key (kbd "M-O") 'open-line)
(global-set-key (kbd "M-M") 'newline-and-indent)

;; Meta-
(global-set-key (kbd "M-u") 'untabify)

;; Overwrite
(defprepare "paredit"
  (global-set-key (kbd "M-M") 'paredit-newline))

;; **** search, replace

;; Ctrl-
(global-set-key (kbd "C-r") 'query-replace-regexp)
(global-set-key (kbd "C-s") 'my-isearch-forward)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-r") 'replace-regexp)
(global-set-key (kbd "C-M-s") 'my-isearch-backward)

;; Meta-
(global-set-key (kbd "M-r") 'hi-lock-rehighlight)

;; Overwrite
(defprepare "anything-config"
  (global-set-key (kbd "M-s") 'my-anything-search))
(defprepare "all"
  (global-set-key (kbd "M-r") 'my-all-command))

;; **** other edit commands

;; Ctrl-
(global-set-key (kbd "C-t") 'backward-transpose-words)
(global-set-key (kbd "C-;") 'comment-dwim)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-t") 'backward-transpose-lines)

;; Meta-Shift-
(global-set-key (kbd "M-T") 'my-transpose-sexps)
(global-set-key (kbd "M-:") 'comment-dwim)

;; Overwrite
(defprepare "paredit"
  (global-set-key (kbd "M-*") 'paredit-forward-barf-sexp)
  (global-set-key (kbd "M-(") 'paredit-wrap-round)
  (global-set-key (kbd "M-)") 'paredit-forward-slurp-sexp)
  (global-set-key (kbd "M-R") 'paredit-raise-sexp)
  (global-set-key (kbd "M-U") 'paredit-splice-sexp-killing-backward)
  (global-set-key (kbd "M-S") 'paredit-split-sexp)
  (global-set-key (kbd "M-J") 'paredit-join-sexps)
  (global-set-key (kbd "M-:") 'paredit-comment-dwim)
  (global-set-key (kbd "M-\"") 'paredit-meta-doublequote))

;; *** file, directory, shell
;; **** browsing

;; Meta-
(global-set-key (kbd "M-d") 'dired)
(global-set-key (kbd "M-f") 'find-file)
(global-set-key (kbd "M-h") 'ff-find-other-file)
(global-set-key (kbd "M-g") 'rgrep)     ; require "grep"

;; Ctrl-x
(global-set-key (kbd "C-x C-d") 'dired)

;; Overwrite
(defprepare "nav"
  (global-set-key (kbd "M-d") 'nav-toggle-and-show-summary))
(defprepare "traverselisp"
  (global-set-key (kbd "M-g") 'traverse-deep-rfind))

;; **** shell command

;; Meta-
(global-set-key (kbd "M-i") 'shell-command)

;; Overwrite
(defprepare "shell-pop"
  (global-set-key (kbd "C-x C-i") 'shell-pop))

;; **** bookmark

;; Meta-
(global-set-key (kbd "M-j") 'list-bookmarks)

;; Ctrl-x
(global-set-key (kbd "C-x C-j") 'bookmark-set)

;; Overwrite
(defprepare "anything-config"
  (global-set-key (kbd "M-j") 'my-anything-jump))
(defprepare "bm"
  (global-set-key (kbd "C-x C-j") 'bm-toggle))

;; *** help

(define-prefix-command 'help-map)

(global-set-key (kbd "<f1>") 'help-map)
(global-set-key (kbd "<f1> b") 'describe-bindings)
(global-set-key (kbd "<f1> k") 'describe-key)
(global-set-key (kbd "<f1> m") 'describe-mode)
(global-set-key (kbd "<f1> f") 'describe-function)
(global-set-key (kbd "<f1> v") 'describe-variable)
(global-set-key (kbd "<f1> a") 'describe-face)

;; *** others

;; ignore some bindings

(global-set-key (kbd "M-<kanji>") 'ignore)

;; insert commands

(global-set-key (kbd "C-q") 'quoted-insert)
(global-set-key (kbd ",") 'my-smart-comma)

;; scratch notes

(global-set-key (kbd "M-q") 'my-scratch-pop)

(defprepare "scratch-palette"
  (global-set-key (kbd "M-w") 'scratch-palette-popup))

;; minor-modes

(global-set-key (kbd "ESC ESC") 'vi-mode)
(global-set-key (kbd "M-t") 'orgtbl-mode)
(global-set-key (kbd "M-a") 'artist-mode)

;; misc

(global-set-key (kbd "C-x C-l") 'add-change-log-entry)
(global-set-key (kbd "C-x C-t") 'toggle-truncate-lines)
(global-set-key (kbd "M-n") 'my-narrow-to-region-or-widen)

(defprepare "fold-dwim"
  (global-set-key (kbd "C-z") 'fold-dwim-toggle)
  (global-set-key (kbd "C-M-z") 'fold-dwim-hide-all))
(defprepare "howm"
  (global-set-key (kbd "M-,") 'howm-menu-or-remember))
(defprepare "smart-compile"
  (global-set-key (kbd "M-c") 'smart-compile))

;; ** keychord

(defpostload "key-chord"

  ;; Default
  (key-chord-define-global " j" 'backward-transpose-chars)
  (key-chord-define-global " n" 'downcase-previous-word)
  (key-chord-define-global " p" 'upcase-previous-word)
  (key-chord-define-global " m" 'capitalize-word)

  ;; Overwrite
  (defprepare "yasnippet"
    (key-chord-define-global " i" 'yas-expand))

  )

;; ** keycombo

(defpostload "key-combo"

  (key-combo-define-global (kbd ",")
                           '(", " ","))

  (key-combo-define-global (kbd "C-j")
                           '(back-to-indentation beginning-of-line))

  (defprepare "yasnippet"
    (key-combo-define-global (kbd "C-M-w")
                             '(kill-ring-save yas-register-oneshot-snippet)))

  )

;; * vvvvvvv not currently used vvvvvvv
;; * *COMMENT* minimap (Dustin's fork)

;; - this setting script is obsolete -

;; CONFLICTS WITH ORG ?
;; (require 'minimap)

;; (global-set-key (kbd "M-4") 'minimap-toggle) ; override

;; ** settings

;; (setq minimap-width-fraction 0.16)
;; (setq minimap-update-delay 0.1)

;; ** toggle minimap

;; (defun minimap-toggle ()
;;   (interactive)
;;   (if (and minimap-window
;;            (window-live-p minimap-window))
;;       (minimap-kill)
;;     (minimap-create)))

;; ** smart minimap
;; *** smart-minimap

;; (defvar smart-minimap nil)

;; (defun smart-minimap()
;;   (interactive)
;;   (if (setq smart-minimap (not smart-minimap))
;;       (progn
;;         (ad-activate-regexp "smart-minimap-ad")
;;         (smart-minimap-create-or-not))
;;     (progn
;;       (ad-deactivate-regexp  "smart-minimap-ad")
;;       (smart-minimap-kill-or-not))))

;; ;; *** utility functions

;; (defun smart-minimap-kill-or-not()
;;   (if (and minimap-window
;;            (window-live-p minimap-window))
;;       (minimap-kill)))

;; (defun smart-minimap-create-or-not()
;;   (if (and (or (not minimap-window)
;;                (not (window-live-p minimap-window)))
;;            (one-window-p))
;;       (if (not (= 1 (1+ (buffer-size)))
;;           (minimap-create)
;;         (kill-minimap-and-wait-for-contents))))

;; *** content monitor

;; (defvar smart-minimap-timer-object nil)

;; (defun kill-minimap-and-wait-for-contents()
;;   (ad-deactivate-regexp "smart-minimap-ad")
;;   (smart-minimap-kill-or-not)
;;   (setq smart-minimap-timer-object
;;         (run-with-idle-timer minimap-update-delay t
;;                              'smart-minimap-buffer-monitor)))

;; (defun smart-minimap-buffer-monitor()
;;   (if (not (= 1 (1+ buffer-size)))
;;         (smart-minimap-create-or-not)
;;         (cancel-timer smart-minimap-timer-object)
;;         (setq smart-minimap-timer-object nil)
;;         (ad-activate-regexp "smart-minimap-ad")))

;; *** automatically create minimap window

;; (defadvice delete-other-windows (after smart-minimap-ad)
;;   (smart-minimap-create-or-not))

;; (defadvice delete-window (after smart-minimap-ad)
;;   (smart-minimap-create-or-not))

;; (defadvice kill-buffer (after smart-minimap-ad)
;;   (smart-minimap-create-or-not))

;; *** automatically kill minimap window

;; (defadvice split-window-vertically (before smart-minimap-ad)
;;   (progn
;;     (ad-deactivate-regexp "smart-minimap-ad")
;;     (smart-minimap-kill-or-not)
;;     (ad-activate-regexp "smart-minimap-ad")))

;; (defadvice split-window-horizontally (before smart-minimap-ad)
;;   (progn
;;     (ad-deactivate-regexp "smart-minimap-ad")
;;     (smart-minimap-kill-or-not)
;;     (ad-activate-regexp "smart-minimap-ad")))

;; (defadvice minimap-update (around smart-minimap-ad)
;;   (if (= 1 (1+ (buffer-size)))
;;       (kill-minimap-and-wait-for-contents)
;;     ad-do-it))

;; *** skip minimap window

;; (defadvice previous-multiframe-window (after smart-minimap-ad)
;;   (when minimap-mode (previous-multiframe-window)))

;; (defadvice next-multiframe-window (after smart-minimap-ad)
;;   (when minimap-mode (next-multiframe-window)))

;; *** simple fix

;; (defadvice kill-region (around smart-minimap-ad)
;;   ;; minimap sometimes causes fatal error when a large region is killed
;;   ;; this code make minimap looks worse, but seems to be necessary for safe
;;   (ad-deactivate-regexp "smart-minimap-ad")
;;   (smart-minimap-kill-or-not)
;;   ad-do-it
;;   (smart-minimap-create-or-not)
;;   (ad-activate-regexp "smart-minimap-ad"))

;; *** nav fix

;; (defadvice nav-toggle-and-show-summary (before smart-minimap-ad)
;;   ;; nav sometimes conflicts with minimap
;;   (ad-deactivate-regexp "smart-minimap-ad")
;;   (smart-minimap-kill-or-not)
;;   (ad-activate-regexp "smart-minimap-nav-return"))

;; (defadvice nav-unsplit-window-horizontally (after smart-minimap-nav-return)
;;   (ad-deactivate-regexp "smart-minimap-nav-return")
;;   (smart-minimap-create-or-not)
;;   (ad-activate-regexp "smart-minimap-ad"))

;; *** howm fix

;; (defadvice howm-menu (before smart-minimap-ad)
;;   ;; howm sometimes conflicts with minimap
;;    (ad-deactivate-regexp "smart-minimap-ad")
;;    (smart-minimap-kill-or-not)
;;    (ad-activate-regexp "smart-minimap-howm-return"))

;; (defadvice bury-buffer (after smart-minimap-howm-return)
;;   (unless (cdr (assq 'howm-mode (buffer-local-variables)))
;;     (progn
;;       (ad-deactivate-regexp "smart-minimap-howm-return")
;;       (smart-minimap-create-or-not)
;;       (kill-buffer "*howmM:%menu%*")
;;       (ad-activate-regexp "smart-minimap-ad"))))

;; *** orgtbl-mode fix

;; (defadvice orgtbl-mode (after smart-minimap-ad)
;;   ;; eval-function in orgtbl-mode sometimes conflicts with minimap
;;   (if orgtbl-mode
;;         (ad-deactivate-regexp "smart-minimap-ad")
;;         (smart-minimap-kill-or-not)
;;         (ad-activate-regexp "smart-minimap-orgtbl-return")))

;; (defadvice orgtbl-mode (after smart-minimap-orgtbl-return)
;;   (unless orgtbl-mode
;;     (progn
;;       (ad-deactivate-regexp "smart-minimap-orgtbl-return")
;;       (smart-minimap-create-or-not)
;;       (ad-activate-regexp "smart-minimap-ad"))))

;; *** popwin fix

;; (defadvice popwin:display-buffer (around smart-minimap-ad)
;;   (ad-deactivate-regexp "smart-minimap-ad")
;;   ad-do-it
;;   (ad-activate-regexp "smart-MINIMAP-AD"))

;; *** auto-run

;; (add-hook 'after-init-hook
;;           (lambda()(run-with-idle-timer 0.5 nil 'smart-minimap)))

;; * *COMMENT* server

;; - this setting script is obsolete -

;; (require 'server)

;; ;; on Windows 7, change
;; ;;  "server" directory
;; ;;   -> property
;; ;;    -> security
;; ;;     -> details
;; ;;      -> owner
;; ;;       -> edit
;; ;;        -> (login-user)

;; ** automatically run server

;; (add-hook 'after-init-hook
;;           (lambda()
;;             (unless (server-running-p)
;;               (server-start)
;;               ;; (iconify-frame)
;;               )))

;; ** clear emacs and iconify

;; (defun kill-all-file-buffers ()
;;   "Kill all file editting buffers file,
;; and returns number of not-killed buffers"
;;   (interactive)
;;   (let ((errcount 0))
;;     (progn
;;       (mapc (lambda(b)
;;               (when (buffer-file-name b)
;;                 (unless (kill-buffer b) (setq errcount (1+ errcount)))))
;;             (buffer-list))
;;       errcount)))

;; (defun clear-and-iconify-emacs ()
;;   "Kill all file editting buffers, abort all recursive edit,
;; clear *scratch*, delete all splitted windows, and then iconify"
;;   (interactive)
;;   (when (= 0 (kill-all-file-buffers))
;;     (iconify-frame)
;;     (delete-other-windows)
;;     (switch-to-buffer "*scratch*")
;;     (my-make-scratch 0)
;;     (top-level)
;;     (server-edit)
;;     ))

;; ** quit emacs with [M-x exit]

;; ;; reference | http://qiita.com/items/48ac0af1e31eb9f69525

;; (defalias 'exit 'save-buffers-kill-emacs)

;; ** keybind

;; (global-set-key (kbd "C-x C-c") 'clear-and-iconify-emacs)

;; * *COMMENT* semantic

;; (setq semantic-default-submodes
;;       '(global-semantic-idle-scheduler-mode
;;         global-semantic-idle-summary-mode))

;; (defpostload "cc-mode"
;;   (add-hook 'c-mode-hook (lambda () (semantic-mode 1)))
;;   (add-hook 'java-mode-hook (lambda () (semantic-mode 1))))

;; (defpostload "auto-complete"
;;   (setq ac-sources (cons 'ac-source-semantic ac-sources)))

;; * ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
