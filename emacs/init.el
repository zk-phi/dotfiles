;; |---------------------------------
;; |  init.el (for emacs v23.3)     |
;; |                        zk_phi  |
;; ---------------------------------|

;; * ------------------------------
;; * CHEAT SHEET
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
;;    |     | Copy|EdDef|RplAl|TrsLn|YankS|BgBuf| Fill|Split|BPgph|  *  |     |
;;       |MulAl|SrchB|KilWd|FWord|Abort|BKlWd|BgDef|KlPgh|Cntr0|  -  |     |
;;          |HidAl|     |     |EdBuf|BWord|NPgph|RetCm|MrkAl|     |     |

;; M-_
;; |AlWnd|VrWnd|HrWnd|Blnce|Follw|     |     |SwWnd|PvWnd|NxWnd|LstCg|     |     |     |
;;    |Scrtc|Palet| Eval|Recnt|Table|YankP|Untab|Shell|Opcty|EvalP|     |     |
;;       |Artst| All | Dir | File| Grep|Shrnk|BMJmp|KlWnd| Goto|     |     |
;;          |     |Comnd|Cmpil| VReg|Buffr|Narrw|DMcro| Howm|     |     |

;; M-Shift-
;; |     |     |     |     |     |     |     | Barf|Wrap)|Slurp| Undo|     |     |     |
;;    |     |CpSex|EvalR|Raise|TrSex| Yank|RaisB|IdntP| Open|UpSex|     |     |
;;       |     |SpltS|KlSex|FwSex| Quit|KlSex|JoinS|CutPe|Centr|CmntP|Wrap"|
;;          |     |     |     | Mark|BwSex|DnSex|Retrn|MkSex|     | Help|

;; C-x C-_
;; |     |     |     |     |     |     |     |     |BgMcr|EdMcr|     |Scale|     |     |
;;    |     |Write|Encod|Revrt|Trnct|     |     |     |     |RdOly|     |     |
;;       |     | Save|Dired|     |     |FHead|BMSet|KilBf|CgLog|     |     |
;;          |     |     |Close|     |     |     |ExMcr|     |     |     |

;; nonconvert
;; -   NConv : iy-go-to-char
;; - C-NConv : iy-go-to-char-backward

;; SPC
;; -   C-SPC : set-mark-command
;; - C-M-SPC : exchange-point-and-mark

;; Function
;; -    <f1> : help prefix
;; -  M-<f4> : kill-emacs

;; others
;; -   C-RET : cua-set-rectangle-mark
;; -     TAB : ac-trigger
;; -     ESC : vi-mode

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
;; - df : yasnippet or dabbrev (in HTML modes, zencoding)
;; - jk :                     "
;; - fj : transpose-chars
;; - fn : downcase word
;; - fp : upcase word
;; - fm : capitalize word
;; - ,. : ace-jump-word

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

;; * META INIT
;; ** environ check

(when (not (boundp 'my-home-system-p))
  (defconst my-home-system-p nil)
  (message "!! [init] WARNING: site-start.el does not match"))

(when (not my-home-system-p)
  (message "!! [init] WARNING: this is not my home system"))

(when (not (string-match "^23\." emacs-version))
  (message "!! [init] WARNING: emacs version is not 23.X"))

(when (not (eq 'windows-nt system-type))
  (message "!! [init] WARNING: system type is not windows-nt"))

;; ** constants

(defconst my:skip-checking-libraries my-home-system-p)

;; directories

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
(defconst my:smex-save-file (concat my:dat-directory "smex.dat"))
(defconst my:ido-save-file (concat my:dat-directory "ido.dat"))

(defconst my:recentf-file (concat my:dat-directory "recentf_" system-name ".dat"))
(defconst my:bookmark-file (concat my:dat-directory "bookmark_" system-name ".dat"))

;; dropbox association

(defconst my:dropbox-directory
  (if my-home-system-p "~/../../Dropbox/"))

(defconst my:howm-import-directory
  (if my-home-system-p (concat my:dropbox-directory "howm_import/")))

(defconst my:howm-export-file
  (if my-home-system-p (concat my:dropbox-directory "howm_schedule.txt")))

;; ** macros / utilities
;; *** check if the library exists

;; check if the library exists

(defvar my-found-libraries nil)
(defvar my-not-found-libraries nil)

(defun my-library-exists (lib)
  (if my:skip-checking-libraries
      ;; do not check on home-system
      t
    (cond ((member lib my-found-libraries) t)
          ((member lib my-not-found-libraries) nil)
          ((locate-library lib) (add-to-list 'my-found-libraries lib))
          (t (add-to-list 'my-not-found-libraries lib) nil))))

(defadvice load (after add-to-found-list activate)
  (unless my:skip-checking-libraries
    (if (null ad-return-value)
        (add-to-list 'my-not-found-libraries (ad-get-arg 0))
      (add-to-list 'my-found-libraries (ad-get-arg 0)))))

;; *** benchmark for init file

;; reference | http://d.hatena.ne.jp/sugyan/20120105/1325756767

(defun my-init-ellapsed-time (beg-time)
  "ellapsed time from beg-time"
  (let* ((now (current-time))
         (min (- (car now) (car beg-time)))
         (sec (- (cadr now) (cadr beg-time)))
         (msec (/ (- (car (cddr  now)) (car (cddr beg-time))) 1000)))
    (+ (* 60000 min) (* 1000 sec) msec)))

;; benchmark for whole init

(defvar my-benchmark-start (current-time))

(add-hook 'after-init-hook
          (lambda()
            (interactive)
            (message ">> [init] TOTAL: %d msec"
                     (my-init-ellapsed-time my-benchmark-start))))

;; *** safe-load macros

;; reference | http://d.hatena.ne.jp/jimo1001/20090921/1253525484
;;           | http://d.hatena.ne.jp/ozawanay/20101120

(defmacro defconfig (ft &rest sexps)
  "require feature, and if succeeded, eval configures"
  `(let ((beg-time (current-time)))
     (if (require ,ft nil t)
         (condition-case err
             (eval '(progn ,@sexps
                           (message ">> [init] %s: succeeded in %d msec" ,ft
                                    (my-init-ellapsed-time beg-time))))
           (error (message "XX [init] %s: %s" ,ft (error-message-string err))))
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

;; reference | http://www.sodan.org/~knagano/emacs/dotemacs.html

(defmacro ifbound (symbol)
  "if the symbol exists, the symbol value. otherwise nil."
  `(and (boundp ',symbol) ,symbol))

;; *** delayed load on idle time

;; when emacs is idle more than 15 seconds, load libraries

(defvar my-idle-require-delay 15)
(defvar my-idle-require-list nil)

(run-with-idle-timer my-idle-require-delay nil
                     (lambda ()
                       (dolist (feat my-idle-require-list)
                         (require feat))))

(defmacro delayed-require (ft)
  `(add-to-list 'my-idle-require-list ,ft))

;; *** *COMMENT* key-override checker

;; ;; get the name of "this" file
;; ;; reference | http://hazimarino.blogspot.jp/2010/11/emacs.html

;; (defmacro this-file-name ()
;;   '(or (buffer-file-name) load-file-name))

;; ;; check if any of MY keybindings is shadowed

;; (defvar my-defined-keys nil)

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

;; * ------------------------------
;; * settings
;; ** font

;; reference | http://macemacsjp.sourceforge.jp/matsuan/FontSettingJp.html

(when my-home-system-p

  (set-face-attribute 'default nil        ; ASCII
                      :family "Source Code Pro"
                      :height 90)

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

;; use Shift-JIS for file names in Windows
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

;; ** mode-line settings

;; reference | http://amitp.blogspot.jp/2011/08/emacs-custom-mode-line.html

;; *** make faces

(make-face 'mode-line-bright-face)
(set-face-attribute 'mode-line-bright-face nil
                    :inherit 'mode-line-face)

(make-face 'mode-line-dark-face)
(set-face-attribute 'mode-line-dark-face nil
                    :inherit 'mode-line-face)

(make-face 'mode-line-highlight-face)
(set-face-attribute 'mode-line-highlight-face nil
                    :inherit 'mode-line-face)

(make-face 'mode-line-special-mode-face)
(set-face-attribute 'mode-line-special-mode-face nil
                    :inherit 'mode-line-face)

(make-face 'mode-line-warning-face)
(set-face-attribute 'mode-line-warning-face nil
                    :inherit 'mode-line-face)

(make-face 'mode-line-modified-face)
(set-face-attribute 'mode-line-modified-face nil
                    :inherit 'mode-line-face)

(make-face 'mode-line-read-only-face)
(set-face-attribute 'mode-line-read-only-face nil
                    :inherit 'mode-line-face)

(make-face 'mode-line-narrowed-face)
(set-face-attribute 'mode-line-narrowed-face nil
                    :inherit 'mode-line-face)

(make-face 'mode-line-mc-face)
(set-face-attribute 'mode-line-mc-face nil
                    :inherit 'mode-line-face)

;; *** utilities

(defun my-shorten-directory (max-length)
  (let* ((file (buffer-file-name))
         (dir (if file (file-name-directory file) "")))
    (if (null dir) ""
      (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
            (output ""))
        (when (and path (equal "" (car path)))
          (setq path (cdr path)))
        (while (and path (< (length output) (- max-length 4)))
          (setq output (concat (car path) "/" output))
          (setq path (cdr path)))
        (when path
          (setq output (concat ".../" output)))
        output))))

;; *** mode-line-format

(setq-default mode-line-format
              '(
                ;; **** window-position / region-size

                " "

                (:eval
                 (if mark-active
                     ;; region size
                     (propertize (format "%d"
                                         (let ((rows
                                                (count-lines (region-beginning) (region-end)))
                                               (chars
                                                (- (region-end) (region-beginning))))
                                           (if (= rows 1) chars rows)))
                                 'face 'mode-line-warning-face)
                   ;; window-position
                   (propertize (format "%d%%%%"
                                       (/ (* 100 (point)) (point-max)))
                               'face 'mode-line-bright-face)))

                ;; **** linum / colnum

                " "

                (:propertize "%l " face mode-line-bright-face)

                (:eval
                 (propertize "%c" 'face
                             (if (>= (current-column) 80)
                                 'mode-line-warning-face
                               'mode-line-bright-face)))

                ;; **** indicators

                " "

                (:eval
                 (if (buffer-modified-p)
                     (propertize "*" 'face 'mode-line-modified-face)
                   (propertize "*" 'face 'mode-line-dark-face)))

                (:eval
                 (if buffer-read-only
                     (propertize "%%" 'face 'mode-line-read-only-face)
                   (propertize "%%" 'face 'mode-line-dark-face)))

                (:eval
                 (if (or (/= (point-min) 1) (/= (point-max) (1+ (buffer-size))))
                     (propertize "n" 'face 'mode-line-narrowed-face)
                   (propertize "n" 'face 'mode-line-dark-face)))

                (:eval
                 (if (ifbound multiple-cursors-mode)
                     (propertize (format "%02d" (mc/num-cursors))
                                 'face 'mode-line-mc-face)
                   (propertize "00" 'face 'mode-line-dark-face)))

                ;; **** directory / file name

                "  "

                (:eval
                 (propertize (my-shorten-directory 10)
                             'face 'mode-line-dark-face))

                (:propertize "%b" face mode-line-highlight-face)

                ;; **** major-mode / coding system

                "  "

                (:propertize "%[" face mode-line-dark-face)

                (:eval (cond
                        ((and (boundp 'artist-mode) artist-mode)
                         (propertize "*Artist*" 'face 'mode-line-special-mode-face))
                        ((and (boundp 'orgtbl-mode) orgtbl-mode)
                         (propertize "*OrgTbl*" 'face 'mode-line-special-mode-face))
                        (t
                         (propertize mode-name 'face 'mode-line-bright-face))))

                (:propertize mode-line-process face mode-line-highlight-face)

                (:eval
                 (propertize
                  (format " (%s)%%]" (symbol-name buffer-file-coding-system))
                  'face 'mode-line-dark-face))

                ;; **** others

                "  "

                (global-mode-string global-mode-string)

                ;; **** (sentinel)
                ))

;; *** change color while recording

(defvar my-mode-line-background '("#194854" . "#594854"))

(defun my-update-mode-line-background ()
  (set-face-background
   'mode-line
   (if defining-kbd-macro
       (cdr my-mode-line-background)
     (car my-mode-line-background))))

(add-hook 'post-command-hook 'my-update-mode-line-background)

;; ** settings for reading

;; reference | http://d.hatena.ne.jp/nitro_idiot/20130215/1360931962

(defun my-install-reading-config ()

  (setq line-spacing 0.3)
  (setq cursor-type 'hbar)

  ;; keybinds
  (local-set-key (kbd "h") 'backward-char)
  (local-set-key (kbd "l") 'forward-char)
  (defprepare "pager"
    (local-set-key (kbd "C-n") 'pager-row-down)
    (local-set-key (kbd "j") 'pager-row-down)
    (local-set-key (kbd "C-p") 'pager-row-up)
    (local-set-key (kbd "k") 'pager-row-up))

  ;; buffer-face-mode
  (let ((buffer-face-mode-face
         '(:family "Times New Roman"
                   :height 125 :width semi-condensed)))
    (buffer-face-mode 1))

  ;; global-hl-line-mode must be made buffer-local
  (setq global-hl-line-mode nil)

  ;; show-paren-mode mustb be made buffer-local
  (setq show-paren-mode nil)

  ;; hl-paren
  (defprepare "highlight-parentheses"
    (setq highlight-parentheses-mode nil))
  )

;; ** minor adjustments

;; use y-or-n instead of yes-or-no

(fset 'yes-or-no-p 'y-or-n-p)

;; title bar string

(setq frame-title-format
      (concat "%b - emacs @ " system-name))

;; do not ask to narrow

(put 'narrow-to-region 'disabled nil)

;; completion ignore case

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; use spaces not tabs

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; cursor type

(setq-default cursor-type 'bar)

;; visible end-of-buffer

(setq-default indicate-empty-lines t)

;; do not pause redisplay
;; reference | http://masteringemacs.org/articles/2011/10/02/improving-performance-emacs-display-engine/

(setq redisplay-dont-pause t)

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

(defvar my-up/downcase-count nil)

(defun my-upcase-previous-word ()
  (interactive)
  (setq my-up/downcase-count
        (if (equal last-command this-command)
            (1- my-up/downcase-count)
          -1))
  (upcase-word my-up/downcase-count))

(defun my-downcase-previous-word ()
  (interactive)
  (setq my-up/downcase-count
        (if (equal last-command this-command)
            (1- my-up/downcase-count)
          -1))
  (downcase-word my-up/downcase-count))

;; *** make *scratch* always available

;; reference | http://www.bookshelf.jp/soft/meadow_29.html#SEC392

;; **** create new scratch

;; a command to create new scratch, or clear existing scratch

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

;; **** clear scratch instead of killing it

;; when scratch is going to be killed, clear scratch instead

(add-hook 'kill-buffer-query-functions
          (function (lambda ()
                      (if (string= "*scratch*" (buffer-name))
                          (progn (my-make-scratch 0) nil)
                        t))))

;; **** create scratch when saved

;; when scratch is saved to file, create new scratch

(defun my-buffer-name-list ()
  (mapcar (function buffer-name) (buffer-list)))

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

;; *** smartchr-like commands

;; key-combo does not work inside string, comments

(defun my-smart-comma ()
  (interactive)
  (cond ((not (eq last-command 'my-smart-comma))
         (insert ", "))
        ((= (char-before) ?\s)
         (delete-char -1))
        (t
         (insert " "))))

;; *** retop

;; name (recenter 0)

(defun retop ()
  (interactive) (recenter 0))

;; *** eval region or last sexp

;; if region is active, eval all sexps in the region.
;; otherwise eval previous sexp

(defun my-eval-sexp-dwim ()
  (interactive)
  (if (and (interactive-p) transient-mark-mode mark-active)
      (call-interactively 'eval-region)
    (call-interactively 'eval-last-sexp)))

;; *** eval and replace sexp

;; eval sexp and replace it with the value
;; reference | http://irreal.org/blog/?p=297

(defun my-eval-and-replace-sexp (value)
  "Evaluate the sexp at point and replace it with its value"
  (interactive (list (eval-last-sexp nil)))
  (kill-sexp -1)
  (insert (format "%S" value)))

;; *** move-region

;; reference | http://www.pitecan.com/tmp/move-region.el

;; **** utility

;; take a cursor-move function as an arg, and move region with it

(defun my-move-region (sexp)
  (if (and transient-mark-mode mark-active)
      (let (m)
        (kill-region (mark) (point))
        (eval sexp)
        (setq m (point))
        (yank)
        (set-mark m)
        (setq deactivate-mark nil))
    (eval sexp)))

;; **** commands

(defun my-move-region-up ()
  (interactive)
  (my-move-region '(forward-line -1)))

(defun my-move-region-down ()
  (interactive)
  (my-move-region '(forward-line 1)))

(defun my-move-region-left ()
  (interactive)
  (my-move-region '(forward-char -1)))

(defun my-move-region-right ()
  (interactive)
  (my-move-region '(forward-char 1)))

;; *** visible-register

;; store current position to a visible register.
;; when called again, pop it.

(defvar my-visible-register nil)
(make-variable-buffer-local 'my-visible-register)

(defvar my-visible-register-face 'cursor)

(defun my-visible-register ()
  (interactive)
  (if my-visible-register
      (progn (goto-char (overlay-start my-visible-register))
             (delete-overlay my-visible-register)
             (setq my-visible-register nil))
    (progn
      (setq my-visible-register
            (make-overlay (point) (1+ (point))))
      (overlay-put my-visible-register
                   'face my-visible-register-face))))

;; *** shrink-spaces

;; shrink spaces or newlines

(defun my-shrink-whitespaces ()
  (interactive)
  (cond
   ;; shrink newlines
   ((= (bol-point) (eol-point))
    (skip-chars-backward "\s\t\n")
    (delete-region (point)
                   (progn (skip-chars-forward "\s\t\n") (point)))
    (insert "\n")
    (when (char-after) (save-excursion (insert "\n"))))
   ;; shrink spaces
   (t
    (skip-chars-backward "\s\t")
    (delete-region (point)
                   (progn (skip-chars-forward "\s\t") (point)))
    (insert " "))))

;; *** url-encode

(defun my-url-encode-string (str &optional sys)
  (let ((sys (or sys 'utf-8)))
    (url-hexify-string (encode-coding-string str sys))))

(defun my-url-decode-string (str &optional sys)
  (let ((sys (or sys 'utf-8)))
    (decode-coding-string (url-unhex-string str) sys)))

(defun my-url-decode-region (beg end)
  (interactive "r")
  (let ((pos beg)
        (str (buffer-substring beg end)))
    (goto-char beg)
    (delete-region beg end)
    (insert (my-url-decode-string str 'utf-8))))

(defun my-url-encode-region (beg end)
  (interactive "r")
  (let ((pos beg)
        (str (buffer-substring beg end)))
    (goto-char beg)
    (delete-region beg end)
    (insert (my-url-encode-string str 'utf-8))))

;; ** other utilities

;; "point-at-eol" never fails, and returns line-number.
;; "eol-point" may fail, and returns position.

(defun eol-point (&optional point)
  "Returns the end-of-line point that contains the POINT"
  (save-excursion
    (when point (goto-char point)) (end-of-line) (point)))

(defun bol-point (&optional point)
  "Returns the end-of-line point that contains the POINT"
  (save-excursion
    (when point (goto-char point)) (beginning-of-line) (point)))

;; get first line substring of the region

(defun get-first-line-string (from to)
  "Returns substring of the first line (FROM TO)"
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

;; and some more utilities ...

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
(setq global-auto-revert-non-file-buffers t)

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

  ;; *** keybinds

  (dolist (map (list c-mode-map c++-mode-map
                     objc-mode-map java-mode-map))
    (define-key map (kbd ",") nil)
    (define-key map (kbd "C-d") nil)
    (define-key map (kbd "C-M-a") nil)
    (define-key map (kbd "C-M-e") nil)
    (define-key map (kbd "M-e") nil)
    (define-key map (kbd "M-j") nil)
    (define-key map (kbd "C-M-h") nil)
    (define-key map (kbd "C-M-j") nil))

  ;; *** settings

  (add-hook 'c-mode-common-hook
            (lambda ()
              (setq c-auto-newline t)
              (c-set-style "phi")))

  (add-hook 'java-mode-hook 'my-java-style-init)

  ;; *** (sentinel)
  )

;; ** cua

(setq cua-enable-cua-keys nil)
(cua-mode 1)

;; *** disable shift-region

(defadvice cua--pre-command-handler-1 (around cua-disable-shift-region activate)
  (flet ((this-single-command-raw-keys () nil))
    (let ((window-system t))
      ad-do-it)))

;; *** advices for cua commands

;; see also -> simple.el settings

;; auto-indent on yank

(defadvice cua-paste (around auto-indent-on-yank activate)
  (if (member major-mode my-auto-indent-inhibit-modes)
      ad-do-it
    (indent-region (point)
                   (progn ad-do-it (point)))))

;; exchange-region triggers

(defadvice cua-paste (around exchange-start activate)
  (if (and (interactive-p)
           (eq last-command 'kill-region))
      (progn
        (setq exchange-pending-overlay
              (make-overlay (point) (1+ (point))))
        (overlay-put exchange-pending-overlay
                     'face exchange-pending-face))
    (progn
      (when exchange-pending-overlay
        (delete-overlay exchange-pending-overlay)
        (setq exchange-pending-overlay nil))
      ad-do-it)))

(defadvice cua-cut-region (around exchange-exec activate)
  (if (not (and (interactive-p) transient-mark-mode mark-active
                exchange-pending-overlay))
      ad-do-it
    (let* ((str (buffer-substring (region-beginning) (region-end)))
           (pending-pos (overlay-start exchange-pending-overlay))
           (pos (+ (region-beginning)
                   (if (< pending-pos (point)) (length str) 0))))
      (delete-region (region-beginning) (region-end))
      (goto-char (overlay-start exchange-pending-overlay))
      (delete-overlay exchange-pending-overlay)
      (setq exchange-pending-overlay nil)
      (insert str)
      (goto-char pos)
      (setq this-command 'kill-region))))

;; exchange-point-and-mark on set-mark-command

(defadvice cua-set-mark (around auto-exchange-mark-and-point activate)
  (if (not (and (interactive-p) transient-mark-mode mark-active))
      ad-do-it
    (setq this-command 'exchange-point-and-mark)
    (call-interactively 'exchange-point-and-mark)))

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

;; ** eldoc

(deflazyconfig '(turn-on-eldoc-mode) "eldoc")

(defprepare "eldoc"

  (setq eldoc-idle-delay 0.1)
  (setq eldoc-echo-area-use-multiline-p t)

  (defpostload "lisp-mode"
    (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
    (add-hook 'lisp-interaction-mode 'turn-on-eldoc-mode))
  )

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
  (add-hook 'find-file-hook 'flymake-find-file-hook))

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

;; ** flyspell

;; flyspell requires aspell.Axe

(deflazyconfig
  '(flyspell-mode
    flyspell-prog-mode) "flyspell")

(defpostload "flyspell"

  ;; ispell settings
  (defpostload "ispell"
    (setq ispell-program-name "aspell")
    (add-to-list 'ispell-skip-region-alist '("[^\000-\377]"))
    (setq ispell-extra-args '("--sug-mode=ultra")))

  ;; auto-complete compatibility
  (defpostload "auto-complete" (ac-flyspell-workaround))

  ;; inhibit welcome message
  (setq flyspell-issue-welcome-flag nil)

  ;; keybindings
  (define-key flyspell-mode-map (kbd "C-,") nil)
  (define-key flyspell-mode-map (kbd "C-;") nil)
  (define-key flyspell-mode-map (kbd "M-t") nil)
  (define-key flyspell-mode-map (kbd "C-M-i") nil)
  (define-key flyspell-mode-map (kbd "C-.") 'flyspell-auto-correct-word)
  )

;; flyspell-mode triggers
(add-hook 'fundamental-mode-hook 'flyspell-mode)
(defpostload "text-mode"
  (add-hook 'text-mode-hook 'flyspell-mode))
(defpostload "org"
  (add-hook 'org-mode-hook 'flyspell-mode))
;; (defpostload "sgml-mode"
;;   (add-hook 'html-mode-hook 'flyspell-mode))
;; (defpostload "nxhtml-mode"
;;   (add-hook 'xml-mode-hook 'flyspell-mode))
;; (defpostload "web-mode"
;;   (add-hook 'web-mode-hook 'flyspell-mode))
;; (defpostload "tex-mode"
;;   (add-hook 'latex-mode-hook 'flyspell-mode))
(defpostload "add-log"
  (add-hook 'change-log-mode-hook 'flyspell-mode))

;; flyspell-prog-mode triggers
;; (defpostload "lisp-mode"
;;   (add-hook 'lisp-mode-hook 'flyspell-prog-mode)
;;   (add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode)
;;   (add-hook 'lisp-interaction-mode-hook 'flyspell-prog-mode))
;; (defpostload "cc-mode"
;;   (add-hook 'c-mode-hook 'flyspell-prog-mode)
;;   (add-hook 'c++-mode-hook 'flyspell-prog-mode)
;;   (add-hook 'objc-mode-hook 'flyspell-prog-mode)
;;   (add-hook 'java-mode-hook 'flyspell-prog-mode))
;; (defpostload "js"
;;   (add-hook 'js-mode-hook 'flyspell-prog-mode))
;; (defpostload "prolog"
;;   (add-hook 'prolog-mode-hook 'flyspell-prog-mode))
;; (defpostload "scheme"
;;   (add-hook 'scheme-mode-hook 'flyspell-prog-mode))
;; (defpostload "python"
;;   (add-hook 'python-mode-hook 'flyspell-prog-mode))
;; (defpostload "css-mode"
;;   (add-hook 'css-mode-hook 'flyspell-prog-mode))
;; (defpostload "ahk-mode"
;;   (add-hook 'ahk-mode-hook 'flyspell-prog-mode))
;; (defpostload "scala-mode"
;;   (add-hook 'scala-mode-hook 'flyspell-prog-mode))
;; (defpostload "haskell-mode"
;;   (add-hook 'haskell-mode-hook 'flyspell-prog-mode)
;;   (add-hook 'literate-haskell-mode-hook 'flyspell-prog-mode))

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
;; ** help

(add-hook 'help-mode-hook 'my-install-reading-config)

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

;; ** hi-lock

(defun hi-lock-rehighlight ()
  (interactive)
  (when (ifbound hi-lock-interactive-patterns)
    (unhighlight-regexp (car (car hi-lock-interactive-patterns))))
  (call-interactively 'highlight-regexp))

;; ** hl-line

;; reference | http://stackoverflow.com/questions/9990370/how-to-disable-hl-line-feature-in-specified-mode

(global-hl-line-mode 1)
(make-variable-buffer-local 'global-hl-line-mode)

;; ** ido

(defconfig 'ido

  (setq ido-save-directory-list-file my:ido-save-file)

  (ido-mode t)
  (ido-everywhere)
  (setq ido-enable-regexp t)

  ;; ** dwim complete command

  (defun my-ido-spc-or-next ()
    (interactive)
    (call-interactively
     (cond ((= (length ido-matches) 1) 'ido-exit-minibuffer)
           ((= (length ido-text) 0) 'ido-next-match)
           (t 'ido-restrict-to-matches))))

  ;; ** keymap

  ;; reference | http://github.com/milkypostman/dotemacs/blob/master/init.el

  (defun my-ido-hook ()
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
    (define-key ido-completion-map (kbd "TAB") 'my-ido-spc-or-next)
    (define-key ido-completion-map (kbd "<S-tab>") 'ido-prev-match)
    (define-key ido-completion-map (kbd "SPC") 'ido-restrict-to-matches))

  (add-hook 'ido-minibuffer-setup-hook 'my-ido-hook)

  ;; ** (sentinel)
  )

;; ** isearch

;; isearch with japanese

(when (string= window-system "w32")

 (defun w32-isearch-update ()
   (interactive)
   (isearch-update))

 (define-key isearch-mode-map [compend] 'w32-isearch-update)
 (define-key isearch-mode-map [kanji] 'isearch-toggle-input-method)
 )

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
  (let ((quick-syntax-info (syntax-ppss)))
    (and
     (not (nth 3 quick-syntax-info))    ; outside string literal
     (not (nth 4 quick-syntax-info))    ; outside comment
     (= (point)
        (save-excursion
          (if (condition-case err (forward-sexp) (error t))
              -1
            (or (ignore-errors (backward-sexp) (point))
                -1)))))))

(defun my-end-of-sexp-p ()
  (let ((quick-syntax-info (syntax-ppss)))
    (and
     (not (nth 3 quick-syntax-info))    ; outside string literal
     (not (nth 4 quick-syntax-info))    ; outside comment
     (= (point)
        (save-excursion
          (if (condition-case err (backward-sexp) (error t))
              -1
            (or (ignore-errors (forward-sexp) (point))
                -1)))))))

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

(defun my-up-list ()
  "up-list that works even in string constants. for interactive use."
  (interactive)
  (let* ((str-p (and (member 'font-lock-string-face
                             (text-properties-at (point)))
                     (member 'font-lock-string-face
                             (text-properties-at (1- (point))))))
         (back-pos (save-excursion
                     (if str-p
                         (progn (skip-chars-backward "^\"")
                                (backward-char)
                                (point))
                       (condition-case err
                           (progn (backward-up-list) (point))
                         (error nil)))))
         (for-pos (save-excursion
                    (if str-p
                        (progn (skip-chars-forward "^\"")
                               (forward-char)
                               (point))
                      (condition-case err
                          (progn (up-list) (point))
                        (error nil))))))
    (when (not (or back-pos for-pos))
      (error "cannot go up"))
    (goto-char (cond ((null back-pos) for-pos)
                     ((null for-pos) back-pos)
                     ((< (abs (- (point) for-pos))
                         (abs (- (point) back-pos))) for-pos)
                     (t back-pos)))))

(defun my-reindent-sexp ()
  (interactive)
  (save-excursion (my-mark-sexp) (indent-for-tab-command)))

(defun my-replace-sexp ()
  (interactive)
  (my-mark-sexp)
  (delete-region (region-beginning)
                 (region-end))
  (call-interactively 'yank))

;; ** lisp-mode

(defprepare "lisp-mode"
  (add-to-list 'auto-mode-alist
               '("\\.cl$" . common-lisp-mode)))

(defpostload "lisp-mode"
  (dolist (map (list lisp-mode-map
                     emacs-lisp-mode-map
                     lisp-interaction-mode-map))
    (define-key map (kbd "M-TAB") nil)
    (define-key map (kbd "C-j") nil)))

;; * built-in libraries (mnopqrs)
;; ** menu-bar

(menu-bar-mode -1)

;; ** org

(defpostload "org"

  (add-hook 'org-mode-hook 'auto-fill-mode)
  (add-hook 'org-mode-hook 'iimage-mode)
  (setq org-ditaa-jar-path (expand-file-name my:ditaa-jar-file))

  ;; *** startup

  (setq org-startup-folded t)
  (setq org-startup-indented t)
  (setq org-startup-with-inline-images t)

  ;; *** insert "src" dwim

  (defun my-org-insert-quote-dwim ()
    (interactive)
    (let* ((flg (and (interactive-p) transient-mark-mode mark-active))
           (str (if flg (buffer-substring (region-beginning) (region-end))))
           (mode-name (read-from-minibuffer "mode ? ")))
      (when flg (delete-region (region-beginning) (region-end)))
      (insert "#+begin_src " mode-name "\n")
      (save-excursion (insert "\n#+end_src" (if flg "" "\n")))
      (org-edit-src-code)
      (when flg (insert str) (org-edit-src-exit))))

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

(make-variable-buffer-local 'show-paren-mode)

;; ** recentf

(deflazyconfig
  '(ido-recentf-open) "recentf"

  (setq recentf-save-file my:recentf-file)
  (setq recentf-max-saved-items 100)
  (recentf-mode 1)

  ;; auto-save recentf-list / delayed cleanup
  ;; reference | http://d.hatena.ne.jp/tomoya/20110217/1297928222

  (run-with-idle-timer 20 t 'recentf-save-list)
  (setq recentf-auto-cleanup 60)

  ;; ido interface for recentf
  ;; reference | http://www.masteringemacs.org/articles/2011/01/27/find-files-faster-recent-files-package/

  (require 'ido)

  (defun ido-recentf-open ()
    "Use `ido-completing-read' to \\[find-file] a recent file"
    (interactive)
    (if (find-file
         (ido-completing-read "Find recent file: " recentf-list))
        (message "Opening file...")
      (message "Aborting")))
  )

;; ** scroll-bar

(scroll-bar-mode -1)

;; ** *COMMENT* server

;; (require 'server)

;; on Windows 7, change
;;  "server" directory
;;   -> property
;;    -> security
;;     -> details
;;      -> owner
;;       -> edit
;;        -> (login-user)

;; *** automatically run server

;; (add-hook 'after-init-hook
;;           (lambda()
;;             (unless (server-running-p)
;;               (server-start))))

;; *** quit emacs with [M-x exit]

;; reference | http://qiita.com/items/48ac0af1e31eb9f69525

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
;;     (server-edit)))

;; (global-set-key (kbd "C-x C-c") 'clear-and-iconify-emacs)

;; (defalias 'exit 'save-buffers-kill-emacs)

;; ** simple
;; *** settings
;; **** truncate lines

(setq-default truncate-lines t)

;; **** line-move-visual

(setq line-move-visual t)

;; **** open-line

;; indent after open-line

(defadvice open-line (after open-line-and-indent activate)
  (save-excursion (forward-line) (indent-according-to-mode)))

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

(setq shift-select-mode nil)

;; **** line-number / column-number

;; now these settings are no use.
;; because colnum and linum are directly added to mode-line-format.

(line-number-mode t)
(column-number-mode t)

;; **** eval-last-sexp

(setq eval-expression-print-length nil)
(setq eval-expression-print-level 5)

;; **** delete-trailing-whitespace

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; report that trailing whitespaces are deleted
(defadvice delete-trailing-whitespace (around echo-trailing-ws activate)
  (when (not (string= (buffer-string)
                      (progn ad-do-it (buffer-string))))
    (message "trailing whitespace deleted")))

;; **** yank

;; auto-indent on yank
;; see also -> cua.el settings

(defvar my-auto-indent-inhibit-modes
  '(fundamental-mode org-mode text-mode))

(defadvice yank (around auto-indent-on-yank activate)
  (if (member major-mode my-auto-indent-inhibit-modes)
      ad-do-it
    (indent-region (point)
                   (progn ad-do-it (point)))))

;; **** set-mark-command

;; exchange-point-and-mark with set-mark-command
;; see also -> cua.el settings

(defadvice set-mark-command (around auto-exchange-mark-and-point activate)
  (if (not (and (interactive-p) transient-mark-mode mark-active))
      ad-do-it
    (setq this-command 'exchange-point-and-mark)
    (call-interactively 'exchange-point-and-mark)))

;; **** kill-line

;; shrink spacess on kill-line
;; reference | http://www.emacswiki.org/emacs/AutoIndentation

(defadvice kill-line (before kill-line-and-indentation activate)
  (when (and (eolp) (not (bolp)))
    (forward-char 1)
    (just-one-space 0)
    (backward-char 1)))

;; *** exchange-region

;; see also -> cua.el settings

(defvar exchange-pending-overlay nil)
(make-variable-buffer-local 'exchange-pending-overlay)

(defvar exchange-pending-face 'cursor)

(defadvice yank (around exchange-start activate)
  (if (and (interactive-p)
           (eq last-command 'kill-region))
      (progn
        (setq exchange-pending-overlay
              (make-overlay (point) (1+ (point))))
        (overlay-put exchange-pending-overlay
                     'face exchange-pending-face))
    (progn
      (when exchange-pending-overlay
        (delete-overlay exchange-pending-overlay)
        (setq exchange-pending-overlay nil))
      ad-do-it)))

(defadvice kill-region (around exchange-exec activate)
  (if (not (and (interactive-p) transient-mark-mode mark-active
                exchange-pending-overlay))
      ad-do-it
    (let* ((str (buffer-substring (region-beginning) (region-end)))
           (pending-pos (overlay-start exchange-pending-overlay))
           (pos (+ (region-beginning)
                   (if (< pending-pos (point)) (length str) 0))))
      (delete-region (region-beginning) (region-end))
      (goto-char (overlay-start exchange-pending-overlay))
      (delete-overlay exchange-pending-overlay)
      (setq exchange-pending-overlay nil)
      (insert str)
      (goto-char pos)
      (setq this-command 'kill-region))))

;; *** backward transpose

(defun backward-transpose-words ()
  (interactive) (transpose-words -1))

(defun backward-transpose-lines ()
  (interactive) (transpose-lines 1)
  (forward-line -2) (end-of-line))

(defun backward-transpose-chars ()
  (interactive) (transpose-chars -1) (forward-char))

;; *** kill-backward

;; reference | http://emacsredux.com/blog/2013/04/08/kill-line-backward/

(defun my-kill-line-backward ()
  (interactive)
  (kill-line 0)
  (indent-according-to-mode))

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

;; ** tramp

;; tramp is required by anything, ido, etc
;; it takes long time to load so load in idle-time
(delayed-require 'tramp)

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
;; ** cedit

(defprepare "paredit"

  (defpostload "cc-mode"
    (defprepare "cedit"
      (dolist (map (list c-mode-map c++-mode-map
                         objc-mode-map java-mode-map))
        (define-key map (kbd "M-)") 'cedit-or-paredit-slurp)
        (define-key map (kbd "M-{") 'cedit-wrap-brace)
        (define-key map (kbd "M-*") 'cedit-or-paredit-barf)
        (define-key map (kbd "M-U") 'cedit-or-paredit-splice-killing-backward)
        (define-key map (kbd "M-R") 'cedit-or-paredit-raise))))

  (deflazyconfig
    '(cedit-or-paredit-slurp
      cedit-wrap-brace
      cedit-or-paredit-barf
      cedit-or-paredit-splice-killing-backward
      cedit-or-paredit-raise) "cedit")
  )

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
    (add-hook 'ahk-mode-hook 'electric-case-ahk-init))
  )

;; ** indent-guide

(defconfig 'indent-guide)

;; ** outlined-elisp-mode

(defprepare "outlined-elisp-mode"
  (add-hook 'emacs-lisp-mode-hook 'outlined-elisp-find-file-hook))

(deflazyconfig
  '(outlined-elisp-find-file-hook
    outlined-elisp-mode) "outlined-elisp-mode")

;; ** phi-search / phi-replace

(deflazyconfig
  '(phi-search phi-search-backward) "phi-search"
  (define-key phi-search-mode-map (kbd "C-M-s") 'phi-search-again-or-previous))

(deflazyconfig
  '(phi-replace
    phi-replace-query) "phi-replace"
    (define-key phi-replace-mode-map (kbd "C-u") 'phi-replace-scroll-down))

;; ** scratch-palette

(deflazyconfig '(scratch-palette-popup) "scratch-palette"
  (define-key scratch-palette-minor-mode-map
    (kbd "M-w") 'scratch-palette-kill))

;; ** scratch-pop

(deflazyconfig '(scratch-pop) "scratch-pop")

;; ** simple-demo

(deflazyconfig '(simple-demo-set-up) "simple-demo"
  (setq simple-demo-highlight-face 'compilation-warning))

;; ** sublimity

(defconfig 'sublimity
  (require 'sublimity-scroll)
  ;; (require 'sublimity-map)
  )

;; ** uedalab

(deflazyconfig '(lmntal-mode) "lmntal-mode")
(deflazyconfig '(hydla-mode) "hydla-mode")

(defprepare "lmntal-mode"
  (add-to-list 'auto-mode-alist
               '("\\.lmn$" . lmntal-mode)))

(defprepare "hydla-mode"
  (add-to-list 'auto-mode-alist
               '("\\.hydla$" . hydla-mode)))

;; * external libraries (abcdef)
;; ** ace-jump-mode

(deflazyconfig '(ace-jump-word-mode) "ace-jump-mode")

;; ** ahk-mode

(defprepare "ahk-mode"
  (add-to-list 'auto-mode-alist
               '("\\.ahk$" . ahk-mode)))

(deflazyconfig '(ahk-mode) "ahk-mode"
  (define-key ahk-mode-map (kbd "C-j") nil)
  (define-key ahk-mode-map (kbd "C-h") nil))

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

;; ** anything
;; *** prepare highlight-changes-mode

(add-hook 'find-file-hook 'highlight-changes-mode)

(deflazyconfig
  '(highlight-changes-mode) "hilit-chg"

  ;; start with invisible mode
  (setq highlight-changes-visibility-initial-state nil)

  ;; clear highlights after save
  (add-hook 'after-save-hook
            (lambda()
              (when highlight-changes-mode
                (highlight-changes-remove-highlight 1 (1+ (buffer-size))))))

  ;; fix for yasnippet
  (defpostload "yasnippet"
    (add-hook 'yas-before-expand-snippet-hook
              (lambda()
                (when highlight-changes-mode
                  (highlight-changes-mode -1))))
    (add-hook 'yas-after-exit-snippet-hook
              (lambda()
                (highlight-changes-mode 1)
                (hilit-chg-set-face-on-change yas-snippet-beg yas-snippet-end 0))))
  )

;; *** anything-jump

(deflazyconfig
  '(my-anything-jump) "anything"

  ;; ** force split window for anything

  ;; reference | http://emacs.g.hatena.ne.jp/k1LoW/20090713/1247496970

  (defvar anything-window-height-fraction 0.6)

  (defun anything-split-window (buf)
    (split-window (selected-window)
                  (round (* (window-height) anything-window-height-fraction)))
    (other-window 1)
    (switch-to-buffer buf))

  (setq anything-display-function 'anything-split-window)

  ;; ** execute parsistent-action on move

  ;; reference | http://shakenbu.org/yanagi/d/?date=20120213

  (add-hook 'anything-move-selection-after-hook
            (lambda()
              (if (member (cdr (assq 'name (anything-get-current-source)))
                          '("Imenu" "Visible Bookmarks"
                            "Changes not saved" "Flymake"))
                  (anything-execute-persistent-action))))

  ;; ** anything source for hilit-chg

  (defpostload "hilit-chg"

    ;; *** search for the next change (from . to)

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

    ;; *** get candidates

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

    ;; *** provide source

    (defvar anything-source-highlight-changes-mode
      '((name . "Changes not saved")
        (init . change-candidates)
        (candidates . change-candidates-temporary)
        (action . (lambda (num)
                    (interactive)
                    (goto-char num)))))

    ;; *** (sentinel)
    )

  ;; ** anything source for flymake

  ;; reference | http://d.hatena.ne.jp/kiris60/20091003

  (defpostload "flymake"

    (eval-when-compile (require 'cl))

    ;; *** get errorlines from flymake

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

    ;; *** provide anything-source

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
               (goto-line (flymake-ler-line candidate) anything-current-buffer)))))))

    ;; *** (sentinel)
    )

  ;; ** anything source for imenu

  ;; reference | http://www.emacswiki.org/cgi-bin/wiki/AnythingSources

  (require 'imenu)
  (setq imenu-auto-rescan t)

  (defvar anything-c-imenu-delimiter "/")

  (defvar anything-c-source-imenu
    '((name . "Imenu")
      (init . (lambda ()
                (setq anything-c-imenu-current-buffer
                      (current-buffer))))
      (candidates
       . (lambda ()
           (condition-case nil
               (with-current-buffer anything-c-imenu-current-buffer
                 (mapcan
                  (lambda (entry)
                    (if (listp (cdr entry))
                        (mapcar (lambda (sub)
                                  (concat (car entry) anything-c-imenu-delimiter (car sub)))
                                (cdr entry))
                      (list (car entry))))
                  (setq anything-c-imenu-alist (imenu--make-index-alist))))
             (error nil))))
      (volatile)
      (action
       . (lambda (entry)
           (let* ((pair (split-string entry anything-c-imenu-delimiter))
                  (first (car pair))
                  (second (cadr pair)))
             (imenu
              (if second
                  (assoc second (cdr (assoc first anything-c-imenu-alist)))
                entry))
             )))))

  ;; ** anything-jump

  (defun my-anything-jump ()
    "My 'anything'."
    (interactive)
    (anything (list
               (ifbound anything-source-highlight-changes-mode)
               (ifbound anything-c-source-flymake)
               anything-c-source-imenu)
              (thing-at-point 'symbol)
              "symbol : " nil))

  ;; ** (sentinel)
  )

;; ** auto-complete

(defconfig 'auto-complete-config

  ;; *** enable auto-complete

  (global-auto-complete-mode t)

  (append ac-modes
          '(ahk-mode haskell-mode literate-haskell-mode
                     prolog-mode scala-mode))

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

  ;; *** (sentinel)
  )

;; ** browse-kill-ring

(deflazyconfig
  '(browse-kill-ring) "browse-kill-ring"
  (setq browse-kill-ring-highlight-current-entry t)
  (define-key browse-kill-ring-mode-map (kbd "C-n") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "j") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "C-p") 'browse-kill-ring-previous)
  (define-key browse-kill-ring-mode-map (kbd "C-k") 'browse-kill-ring-previous)
  (define-key browse-kill-ring-mode-map (kbd "C-g") 'browse-kill-ring-quit))

;; ** c-eldoc

(deflazyconfig
  '(c-turn-on-eldoc-mode) "c-eldoc"

  ;; try MinGW on Windows
  (when (string= window-system "w32")
    (setq c-eldoc-includes "-I./ -I../ -I\"C:/MinGW/include\"")
    (setq c-eldoc-cpp-command "C:/MinGW/bin/cpp"))

  (setq c-eldoc-buffer-regenerate-time 15)
  )

(defprepare "c-eldoc"
  (defpostload "cc-mode"
    (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)
    (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)))

;; ** color-theme

(defconfig 'color-theme)

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
;; ** haskell-mode

(defprepare "haskell-mode"
  (add-to-list 'auto-mode-alist
               '("\\.hs$" . haskell-mode))
  (add-to-list 'auto-mode-alist
               '("\\.lhs$" . literate-haskell-mode)))

(deflazyconfig
  '(haskell-mode
    literate-haskell-mode) "haskell-mode"

    (add-hook 'haskell-mode-hook
              (lambda ()
                (turn-on-haskell-indentation)
                (turn-on-haskell-doc-mode))))

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
                (howm-remember)
                (insert (file-string abs-path))
                (beginning-of-buffer)
                (if (not (y-or-n-p (format "import %s ? " filename)))
                    (howm-remember-discard)
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

  ;; **** export schedule to dropbox and kill howm

  (defvar howm-schedule-file-on-dropbox my:howm-export-file)

  (defun howm-schedule-export-to-file (filename)
    (with-temp-file filename
      (set-buffer-file-coding-system 'utf-8)
      (insert (format "* Howm Schedule %s ~ %s *\n"
                      (howm-reminder-today)
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
  (define-key howm-remember-mode-map (kbd "C-x C-s") 'howm-remember-submit)

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

;; ** ido-ubiquitous

(defpostload "ido"
  (defconfig 'ido-ubiquitous
    (ido-ubiquitous-mode)))

;; ** iy-go-to-char

(deflazyconfig
  '(iy-go-to-char iy-go-to-char-backward) "iy-go-to-char")

;; ** key-chord

(defconfig 'key-chord
  (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.08))

;; ** key-combo

(defconfig 'key-combo

  (key-combo-mode 1)

  ;; *** disable while in multiple-cursors-mode

  (defadvice key-combo-pre-command-function (around mc-combo activate)
    (unless (and (boundp 'multiple-cursors-mode)
                 multiple-cursors-mode)
      ad-do-it))

  ;; *** smartchr for c-like languages

  ;; if region is active,  wrap region with {}.
  ;; else insert "{`\!\!'}".
  (defun my-c-smart-braces ()
    (interactive)
    (cond ((use-region-p)
           (let ((beg (region-beginning))
                 (end (region-end)))
             (deactivate-mark)
             (goto-char beg)
             (insert "{\n")
             (goto-char (+ 2 end))
             (insert "\n}")
             (indent-region beg (point))))
          ((looking-back "\s")
           (insert "{  }")
           (backward-char 2))
          (t
           (unless (= (point)
                      (save-excursion (back-to-indentation) (point)))
             (insert "\n"))
           (indent-region (point) (progn (insert "{\n\n}") (point)))
           (forward-line -1)
           (indent-according-to-mode))))

  (defun my-install-c-common-smartchr ()
    ;; add / sub / mul / div
    (key-combo-define-local (kbd "+") '(" + " "++"))
    (key-combo-define-local (kbd "+=") " += ")
    ;; vv conflict with electric-case vv
    ;; (key-combo-define-local (kbd "-") '(" - " "--" "-"))
    (key-combo-define-local (kbd "-=") " -= ")
    (key-combo-define-local (kbd "*") " * ")
    (key-combo-define-local (kbd "*=") " *= ")
    (key-combo-define-local (kbd "/") " / ")
    (key-combo-define-local (kbd "/=") " /= ")
    (key-combo-define-local (kbd "%") " % ")
    (key-combo-define-local (kbd "%=") " %= ")
    ;; compare
    (key-combo-define-local (kbd ">") '(" > " " >> "))
    (key-combo-define-local (kbd ">=") " >= ")
    (key-combo-define-local (kbd "<") '(" < " " << "))
    (key-combo-define-local (kbd "<=") " <= ")
    (key-combo-define-local (kbd "=") '(" = " " == "))
    (key-combo-define-local (kbd "!=") " != ")
    ;; logical / bitwise
    (key-combo-define-local (kbd "&") '(" & " " && "))
    (key-combo-define-local (kbd "&=") " &= ")
    (key-combo-define-local (kbd "&&=") " &&= ")
    (key-combo-define-local (kbd "|") '(" | " " || "))
    (key-combo-define-local (kbd "|=") " |= ")
    (key-combo-define-local (kbd "||=") " ||= ")
    (key-combo-define-local (kbd "^") " ^ ")
    (key-combo-define-local (kbd "^=") " ^= ")
    ;; others
    (key-combo-define-local (kbd "?") '( " ? `!!' : " "?"))
    (key-combo-define-local (kbd "/*") "/* `!!' */")
    (key-combo-define-local (kbd "{") '(my-c-smart-braces "{ `!!' }")))

  (defun my-install-promela-smartchr ()
    ;; electric semi
    (key-combo-define-local (kbd ";") ";\n")
    ;; operators
    (key-combo-define-local (kbd "-") '(" - " "--" "-"))
    ;; channels
    (key-combo-define-local (kbd "?") " ? ")
    (key-combo-define-local (kbd "!") '(" ! " "!"))
    ;; guards
    (key-combo-define-local (kbd "->") " -> ")
    (key-combo-define-local (kbd "::") ":: ")
    (key-combo-define-local (kbd "dod") "do\n`!!'\nod")
    (key-combo-define-local (kbd "ifi") "if\n`!!'\nfi"))

  (defun my-install-c-smartchr ()
    ;; pointers
    (key-combo-define-local (kbd "&") '("&" " && " " & "))
    (key-combo-define-local (kbd "*") '(" * " "*"))
    (key-combo-define-local (kbd "->") "->")
    ;; include
    (key-combo-define-local (kbd "<") '(" < " " << " "<"))
    (key-combo-define-local (kbd ">") '(" > " " >> " ">")))

  (defun my-install-java-smartchr ()
    ;; javadoc comment
    (key-combo-define-local (kbd "/**") "/**\n`!!'\n*/")
    ;; one-liner comment
    (key-combo-define-local (kbd "/") '(" / " "//"))
    ;; ad-hoc polymorphism
    (key-combo-define-local (kbd "<") '(" < " "<" " << "))
    (key-combo-define-local (kbd ">") '(" > " ">" " >> ")))

  (defpostload "cc-mode"
    (add-hook 'c-mode-common-hook 'my-install-c-common-smartchr)
    (add-hook 'c-mode-hook 'my-install-c-smartchr)
    (add-hook 'java-mode-hook 'my-install-java-smartchr))

  (defpostload "promela-mode"
    (add-hook 'promela-mode-hook 'my-install-c-common-smartchr)
    (add-hook 'promela-mode-hook 'my-install-promela-smartchr))

  ;; *** smartchr for lisp-like languages

  (defun my-install-lisp-common-smartchr ()
    (key-combo-define-local (kbd ".") '(" . " ".")) ; . may be floating point
    (key-combo-define-local (kbd ";") ";; ")
    (key-combo-define-local (kbd "=") '("=" "equal" "eq")))

  (defpostload "lisp-mode"
    (add-hook 'lisp-mode-hook 'my-install-lisp-common-smartchr)
    (add-hook 'emacs-lisp-mode-hook 'my-install-lisp-common-smartchr)
    (add-hook 'lisp-interaction-mode-hook 'my-install-lisp-common-smartchr))

  (defpostload "scheme"
    (add-hook 'scheme-mode-hook 'my-install-lisp-common-smartchr))

  ;; *** smartchr for html / web

  ;; if region is active, and "smartparens" is available,
  ;; wrap region with tag. else insert "<`\!\!'>"
  (defun my-html-sp-or-smart-lt ()
    (interactive)
    (if (and (ifbound smartparens-mode)
             transient-mark-mode mark-active)
        (call-interactively 'sp--self-insert-command)
      (insert "<>")
      (backward-char)))

  (defun my-install-html-smartchr ()
    (key-combo-define-local (kbd "<") '(my-html-sp-or-smart-lt "&lt;" "<"))
    (key-combo-define-local (kbd "<!") "<!-- `!!' -->")
    (key-combo-define-local (kbd ">") '("&gt;" ">"))
    (key-combo-define-local (kbd "&") '("&amp;" "&")))

  (defpostload "sgml-mode"
    (add-hook 'html-mode-hook 'my-install-html-smartchr))

  (defpostload "web-mode"
    (add-hook 'web-mode-hook 'my-install-html-smartchr))

  ;; *** smartchr for haskell

  (defun my-install-haskell-smartchr ()
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
    (key-combo-define-local (kbd "<=") " <= ")
    (key-combo-define-local (kbd ">=") " >= ")
    ;; operation
    (key-combo-define-local (kbd "+") '(" + " " ++ " " +++ "))
    (key-combo-define-local (kbd "-") '(" - " "-")) ; maybe unary
    (key-combo-define-local (kbd "*") '(" * " " ** "))
    (key-combo-define-local (kbd "/") '(" / " " // "))
    (key-combo-define-local (kbd "%") " % ")
    (key-combo-define-local (kbd "^") '(" ^ " " ^^ "))
    ;; bits
    (key-combo-define-local (kbd ".|.") " .|. ")
    (key-combo-define-local (kbd ".&.") " .&. ")
    ;; list
    (key-combo-define-local (kbd ".") '(" . " ".."))
    (key-combo-define-local (kbd "!") '("!" " !! "))
    (key-combo-define-local (kbd "\\\\") " \\\\ ")
    ;; monad
    (key-combo-define-local (kbd ">>=") " >>= ")
    (key-combo-define-local (kbd "=<<") " =<< ")
    ;; arrow
    (key-combo-define-local (kbd "^>>") " ^>> ")
    (key-combo-define-local (kbd ">>^") " >>^ ")
    (key-combo-define-local (kbd "<<^") " <<^ ")
    (key-combo-define-local (kbd "^<<") " ^<< ")
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

  (defpostload "haskell-mode"
    (add-hook 'haskell-mode-hook 'my-install-haskell-smartchr)
    (add-hook 'literate-haskell-mode-hook 'my-install-haskell-smartchr))

  ;; *** (sentinel)
  )

;; * external libraries (mnopqrs)
;; ** maxframe

(when (string= window-system "w32")
 (defconfig 'maxframe
   (add-hook 'window-setup-hook 'maximize-frame)))

;; ** multiple-cursors

(deflazyconfig
  '(my-mc/mark-next-dwim
    my-mc/mark-all-dwim-or-skip-this) "multiple-cursors"

    ;; ** mc-list file

    (setq mc/list-file my:mc-list-file)
    (ignore-errors (load mc/list-file))

    ;; ** dwim commands
    ;; *** load and fix mc-mark-more

    (require 'mc-mark-more)

    ;; (mc--in-defun) sometimes seems not work (why?)
    ;; so make him return always non-nil
    (dolist (fun '(mc/mark-all-like-this-in-defun
                   mc/mark-all-words-like-this-in-defun
                   mc/mark-all-symbols-like-this-in-defun))
      (eval
       `(defadvice ,fun (around fix-restriction activate)
          (flet ((mc--in-defun () t)) ad-do-it))))

    ;; *** utilities

    (defun my-mc/marking-words-p ()
      (ignore-errors
        (and (use-region-p)
             (save-excursion
               (= (goto-char (region-end))
                  (progn (backward-word) (forward-word) (point))))
             (save-excursion
               (= (goto-char (region-beginning))
                  (progn (forward-word) (backward-word) (point)))))))

    ;; *** mc/mark-next-dwim

    (defun my-mc/mark-next-dwim ()
      (interactive)
      (if (and (interactive-p) transient-mark-mode mark-active
               (string-match "\n" (buffer-substring (region-beginning)
                                                    (region-end))))
          (call-interactively 'mc/edit-lines)
        (setq this-command 'mc/mark-next-like-this)
        (mc/mark-next-like-this 1)))

    ;; *** mc/mark-all-dwim

    (defvar my-mc/mark-all-last-executed nil)

    (defun my-mc/mark-all-dwim-or-skip-this (arg)
      (interactive "P")
      (if arg (mc/mark-all-like-this)
        (if (eq last-command this-command)
            (case my-mc/mark-all-last-executed
              ('skip
               (mc/mark-next-like-this 0))
              ('restricted-defun
               (setq my-mc/mark-all-last-executed 'restricted)
               (mc/mark-all-symbols-like-this)
               (message "SYMBOLS defun -> [SYMBOLS]"))
              ('words-defun
               (setq my-mc/mark-all-last-executed 'words)
               (mc/mark-all-words-like-this)
               (message "WORDS defun -> [WORDS] -> ALL"))
              ('words
               (setq my-mc/mark-all-last-executed 'all)
               (mc/mark-all-like-this)
               (message "WORDS defun -> WORDS -> [ALL]"))
              ('all-defun
               (setq my-mc/mark-all-last-executed 'all)
               (mc/mark-all-like-this)
               (message "ALL defun -> [ALL]"))
              (t
               (message "no items more to mark")))
          (cond ((eq last-command 'mc/mark-next-like-this)
                 (setq my-mc/mark-all-last-executed 'skip)
                 (mc/mark-next-like-this 0))
                ((and (mc--no-region-and-in-sgmlish-mode) (mc--on-tag-name-p))
                 (mc/mark-sgml-tag-pair)
                 (message "TAG PAIR"))
                ((not (use-region-p))
                 (mc--mark-symbol-at-point)
                 (setq my-mc/mark-all-last-executed 'restricted-defun)
                 (mc/mark-all-symbols-like-this-in-defun)
                 (message "[SYMBOLS defun] -> SYMBOLS"))
                ((my-mc/marking-words-p)
                 (setq my-mc/mark-all-last-executed 'words-defun)
                 (mc/mark-all-words-like-this-in-defun)
                 (message "[WORDS defun] -> WORDS -> ALL"))
                (t
                 (setq my-mc/mark-all-last-executed 'all-defun)
                 (mc/mark-all-like-this-in-defun)
                 (message "[ALL defun] -> ALL"))))))
    ;; ** minor hacks

    ;; a fix for emacs 23
    (defadvice regexp-opt (after fix-regexp-opt-symbols activate)
      (setq ad-return-value
            (if (eq (ad-get-arg 1) 'symbols)
                (concat "\\_<" ad-return-value "\\_>")
              ad-return-value)))

    ;; add not only "killed-rectangle" but "cua--last-killed-rectangle"
    (deflazyconfig '(cua--insert-rectangle) "cua-rect")
    (defadvice mc--maybe-set-killed-rectangle
      (around mc--maybe-set-cua--killed-rectangle activate)
      (let ((entries (mc--kill-ring-entries)))
        (unless (mc--all-equal entries)
          (setq killed-rectangle entries
                cua--last-killed-rectangle
                (cons (and kill-ring (car kill-ring)) entries)))))

    ;; pop "cua--last-killed-rectangle" if non-nil
    (defadvice cua-paste
      (before mc--maybe-set-cua--killed-rectangle activate)
      (when (and multiple-cursors-mode
                 cua--last-killed-rectangle)
        (let* ((n 1))
          (mc/for-each-cursor-ordered
           (let ((kill-ring (overlay-get cursor 'kill-ring))
                 (kill-ring-yank-pointer (overlay-get cursor 'kill-ring-yank-pointer)))
             (kill-new (or (nth n cua--last-killed-rectangle) ""))
             (overlay-put cursor 'kill-ring kill-ring)
             (overlay-put cursor 'kill-ring-yank-pointer kill-ring-yank-pointer)
             (setq n (1+ n)))))
        (setq cua--last-killed-rectangle nil)))

    ;; ** (sentinel)
    )

;; ** nav

(defprepare "nav"
  (delayed-require 'nav))

(deflazyconfig '(my-nav-toggle) "nav"

  (defun my-nav-toggle ()
    (interactive)
    (nav-toggle)
    (message "o-pen u-p c-opy m-ove d-elete n-ew SPC-index"))

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

;; ** page-break-lines

(defprepare "page-break-lines"
  (add-hook 'find-file-hook 'page-break-lines-mode))

(deflazyconfig
  '(page-break-lines-mode) "page-break-lines")

;; ** pager

(deflazyconfig
  '(pager-row-up
    pager-row-down
    pager-page-up
    pager-page-down) "pager")

;; ** paredit

(defprepare "paredit"

  ;; use my delete-forward/backward commands on lisp-mode
  (defpostload "lisp-mode"
    (dolist (map (list lisp-mode-map
                       emacs-lisp-mode-map
                       lisp-interaction-mode-map))
      (define-key map (kbd "DEL") 'my-paredit-delete-backward)
      (define-key map (kbd "C-d") 'my-paredit-delete-forward)
      (define-key map (kbd "C-M-h") 'my-paredit-delete-backward-word)
      (define-key map (kbd "C-M-d") 'my-paredit-delete-forward-word)))

  ;; and scheme-mode
  (defpostload "scheme-mode"
    (define-key scheme-mode-map (kbd "DEL") 'my-paredit-delete-backward)
    (define-key scheme-mode-map (kbd "C-d") 'my-paredit-delete-forward)
    (define-key scheme-mode-map (kbd "C-M-h") 'my-paredit-delete-backward-word)
    (define-key scheme-mode-map (kbd "C-M-d") 'my-paredit-delete-forward-word))
  )

(deflazyconfig
  '(my-paredit-kill
    my-paredit-delete-forward
    my-paredit-delete-backward
    my-paredit-delete-worward-word
    my-paredit-delete-backward-word
    paredit-newline
    paredit-forward-barf-sexp
    paredit-wrap-round
    paredit-forward-slurp-sexp
    paredit-raise-sexp
    paredit-convolute-sexp
    paredit-splice-sexp-killing-backward
    paredit-split-sexp
    paredit-join-sexps
    paredit-comment-dwim
    paredit-meta-doublequote) "paredit"

    (defun my-paredit-kill ()
      (interactive)
      (if (member 'font-lock-string-face
                  (text-properties-at (point)))
          (kill-region (point)
                       (progn (skip-chars-forward "^\"")
                              (point)))
        (kill-region (point)
                     (progn (while (ignore-errors (forward-sexp 1) t))
                            (point)))))

    (defun my-looking-at-closing ()
      (and (not (looking-back "\\\\"))
           (if (paredit-in-string-p)
               (= (char-after) ?\")
             (member (char-after) '(?\) ?\])))))

    (defun my-looking-back-opening ()
      (and (not (looking-back "\\\\."))
           (if (paredit-in-string-p)
               (= (char-before) ?\")
             (member (char-before) '(?\( ?\[)))))

    (defun my-paredit-delete-backward ()
      (interactive)
      (cond ((my-looking-back-opening)
             (condition-case err
                 (paredit-splice-sexp-killing-backward)
               (error (backward-delete-char 1))))
            ((interactive-p)
             (backward-delete-char-untabify 1))
            (t
             (paredit-backward-delete))))

    (defun my-paredit-delete-forward ()
      (interactive)
      (cond ((my-looking-at-closing)
             (condition-case err
                 (paredit-splice-sexp-killing-forward)
               (error (delete-char 1))))
            ((interactive-p)
             (if (fboundp 'hungry-delete)
                 (hungry-delete 1) (delete-char 1)))
            (t
             (paredit-forward-delete))))

    (defun my-paredit-delete-backward-word ()
      (interactive)
      (while (progn
               (my-paredit-delete-backward)
               (not (looking-back "\\<."))))
      (delete-backward-char 1))

    (defun my-paredit-delete-forward-word ()
      (interactive)
      (while (progn
               (my-paredit-delete-forward)
               (not (looking-at ".\\>"))))
      (delete-char 1))

    (defadvice paredit-wrap-round (around paredit-auto-insert-spc activate)
      (if (not (member major-mode
                       '(lisp-mode emacs-lisp-mode scheme-mode
                                   lisp-interaction-mode)))
          ;; NOT lisp modes
          ;; => automatically delete SPC just after ")"
          (let ((spc-req (save-excursion
                           (ignore-errors
                             (forward-sexp)
                             (= (char-after) ?\s)))))
            ad-do-it
            (when (not spc-req)
              (save-excursion (backward-up-list)
                              (forward-sexp)
                              (when (= (char-after) ?\s) (delete-char 1)))))
        ;; lisp modes
        ;; => automatically insert SPC just after "("
        ad-do-it
        (when (my-beginning-of-sexp-p)
          (save-excursion (just-one-space)))))
    )

;; ** point-undo

(defconfig 'point-undo)

;; ** popwin

(defconfig 'popwin

  ;; *** popwin buffers

  (setq popwin:special-display-config
        '( ("ChangeLog")
           ("*compilation*")
           ("*Help*")
           ("*Calendar*")
           ("*howm-remember*")
           ("*Kill Ring*")
           ("*Shell Command Output*")
           ("*Completions*" :noselect t)
           ("*Backtrace*" :noselect t) ))

  ;; *** activate popwin

  (setq display-buffer-function 'popwin:display-buffer)

  ;; *** (sentinel)
  )

;; ** prolog-mode

(defprepare "prolog"
  (add-to-list 'auto-mode-alist
               '("\\.swi$" . prolog-mode)))

(deflazyconfig '(prolog-mode) "prolog"
  (define-key prolog-mode-map (kbd "M-a") nil)
  (define-key prolog-mode-map (kbd "M-q") nil)
  (define-key prolog-mode-map (kbd "M-RET") nil)
  (define-key prolog-mode-map (kbd "C-M-h") nil)
  (define-key prolog-mode-map (kbd "C-M-e") nil)
  (define-key prolog-mode-map (kbd "C-M-n") nil)
  (define-key prolog-mode-map (kbd "C-M-p") nil)
  (define-key prolog-mode-map (kbd "M-e") nil))

;; ** promela-mode

(deflazyconfig '(promela-mode) "promela-mode")

(defprepare "promela-mode"
 (add-to-list 'auto-mode-alist
              '("\\.pml$" . promela-mode)))

;; ** rainbow-delimiters

(deflazyconfig
  '(my-turn-on-rainbow-delimiters) "rainbow-delimiters"

  (defun my-turn-on-rainbow-delimiters ()
    (rainbow-delimiters-mode 1))
  )

(defprepare "rainbow-delimiters"
  (defpostload "lisp-mode"
    (add-hook 'lisp-mode-hook 'my-turn-on-rainbow-delimiters)
    (add-hook 'emacs-lisp-mode-hook 'my-turn-on-rainbow-delimiters)
    (add-hook 'lisp-interaction-mode-hook 'my-turn-on-rainbow-delimiters))
  (defpostload "scheme"
    (add-hook 'scheme-mode-hook 'my-turn-on-rainbow-delimiters)))

;; ** rainbow-mode

(deflazyconfig '(rainbow-mode) "rainbow-mode")

(defprepare "rainbow-mode"

  (defpostload "css-mode"
    (add-hook 'css-mode-hook 'rainbow-mode))

  (add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
  )

;; ** redo+

(defconfig 'redo+)

;; ** scala-mode

(defprepare "scala-mode"
  (add-to-list 'auto-mode-alist
               '("\\.scala$" . scala-mode)))

(deflazyconfig '(scala-mode) "scala-mode")

;; ** shell-pop

(deflazyconfig '(shell-pop) "shell-pop"

  ;; *** *COMMENT* settings for "shell"

  ;; (shell-pop-set-internal-mode "shell")

  ;; (defadvice shell-pop-up (around cd-when-shell-pop activate)
  ;;   (let ((cwd default-directory))
  ;;     ad-do-it
  ;;     (unless (string= default-directory cwd)
  ;;       (insert "cd " cwd)
  ;;       ;; (comint-send-input)
  ;;       )))

  ;; *** settings for "eshell"

  (shell-pop-set-internal-mode "eshell")

  (defadvice shell-pop-up (around cd-when-shell-pop activate)
    (let ((cwd default-directory))
      ad-do-it
      (unless (string= default-directory cwd)
        (insert cwd)
        ;; (eshell-send-input)
        )))
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

;; ** smartparens

(defconfig 'smartparens-config

  (setq sp-autoinsert-if-followed-by-same 0
        sp-autoinsert-if-followed-by-word t
        sp-autoescape-string-quote nil
        sp-highlight-pair-overlay nil
        sp-autodelete-pair nil          ; => see "paredit" settings
        sp-autodelete-wrap nil          ; => see "paredit" settings
        )

  ;; enable "<>" for web-mode
  (sp-local-tag 'web-mode "<" "<_>" "</_>"
                :transform 'sp-match-sgml-tags)

  (smartparens-global-mode)

  ;; automatically insert " " between sexps
  (defadvice sp-insert-pair
    (after sp-autospace-for-lisp activate)
    (when (and (member major-mode
                       '(lisp-mode emacs-lisp-mode scheme-mode
                                   lisp-interaction-mode))
               (= (char-before) ?\()
               (= (char-after) ?\)))
      (when (save-excursion (backward-char) (my-end-of-sexp-p))
        (save-excursion (backward-char) (insert " ")))
      (when (save-excursion (forward-char) (my-beginning-of-sexp-p))
        (save-excursion (forward-char) (insert " ")))))
  )

;; ** smex

(deflazyconfig '(smex) "smex"
  (setq smex-save-file my:smex-save-file)
  (smex-initialize))

;; ** smooth-scrolling

(defconfig 'smooth-scrolling
  (setq smooth-scroll-margin 3))

;; ** solarized

(defpostload "color-theme"
  (defconfig 'color-theme-solarized

    ;; add some colors to palette
    (add-to-list 'solarized-colors '(modeline-active "#194854"))
    (add-to-list 'solarized-colors '(modeline-record "#594854"))
    (add-to-list 'solarized-colors '(flymake-err "#402b36"))

    ;; function to a search color from palette
    (defun my-solarized-color (name)
      (cadr (assq name solarized-colors)))

    ;; load solarized
    (color-theme-solarized-dark)

    ;; *** ace-jump-mode

    (defpostload "ace-jump-mode"

      (set-face-foreground 'ace-jump-face-foreground
                           (my-solarized-color 'magenta))

      (set-face-foreground 'ace-jump-face-background
                           (my-solarized-color 'base01))
      )

    ;; *** font-lock

    (defpostload "font-lock"

      ;; highlight regexp symbols
      ;; reference | http://pastelwill.jp/wiki/doku.php?id=emacs:init.el

      (set-face-foreground 'font-lock-regexp-grouping-backslash
                           (my-solarized-color 'orange))

      (set-face-foreground 'font-lock-regexp-grouping-construct
                           (my-solarized-color 'orange))
      )

    ;; *** highlight-parentheses

    ;; the last color is ignored
    ;; because of a bug in highlight-parentheses

    (defpostload "highlight-parentheses"

      (hl-paren-set 'hl-paren-colors nil)

      (hl-paren-set 'hl-paren-background-colors
                    (list (my-solarized-color 'base01) "#000000"))
      )

    ;; *** paren

    (defpostload "paren"

      ;; color is set by color-theme-solarized

      (set-face-attribute 'show-paren-match-face nil
                          :underline t
                          :bold t)

      (set-face-attribute 'show-paren-mismatch-face nil
                          :underline t
                          :bold t)
      )

    ;; *** flymake

    (defpostload "flymake"

      (set-face-attribute 'flymake-errline nil
                          :foreground 'unspecified
                          :inverse-video 'unspecified
                          :background (my-solarized-color 'flymake-err))

      (set-face-attribute 'flymake-warnline nil
                          :foreground 'unspecified
                          :inverse-video 'unspecified
                          :background (my-solarized-color 'flymake-err))
      )

    ;; *** whitespace

    (defpostload "whitespace"

      (set-face-attribute 'whitespace-space nil
                          :foreground (my-solarized-color 'yellow)
                          :background 'unspecified)

      (set-face-attribute 'whitespace-tab nil
                          :foreground (my-solarized-color 'yellow)
                          :background 'unspecified)
      )

    ;; *** modeilne

    (setq my-mode-line-background (cons (my-solarized-color 'modeline-active)
                                        (my-solarized-color 'modeline-record)))

    (set-face-attribute 'mode-line nil
                        :foreground (my-solarized-color 'base1)
                        :background (my-solarized-color 'modeline-active)
                        :inverse-video nil
                        :box (append '(:line-width 1)
                                     `(:color ,(my-solarized-color 'modeline-active))))

    (set-face-attribute 'mode-line-inactive nil
                        :foreground (my-solarized-color 'base01)
                        :background (my-solarized-color 'base02)
                        :inverse-video nil
                        :box (append '(:line-width 1)
                                     `(:color ,(my-solarized-color 'base02))))

    (set-face-attribute 'mode-line-dark-face nil
                        :foreground (my-solarized-color 'base01))

    (set-face-attribute 'mode-line-highlight-face nil
                        :foreground (my-solarized-color 'yellow)
                        :weight 'bold)

    (set-face-attribute 'mode-line-special-mode-face nil
                        :foreground (my-solarized-color 'cyan)
                        :weight 'bold)

    (set-face-attribute 'mode-line-warning-face nil
                        :foreground (my-solarized-color 'base03)
                        :background (my-solarized-color 'yellow))

    (set-face-attribute 'mode-line-modified-face nil
                        :foreground (my-solarized-color 'magenta)
                        :box (append '(:line-width 1)
                                     `(:color ,(my-solarized-color 'magenta))))

    (set-face-attribute 'mode-line-read-only-face nil
                        :foreground (my-solarized-color 'blue)
                        :box (append '(:line-width 1)
                                     `(:color ,(my-solarized-color 'blue))))

    (set-face-attribute 'mode-line-narrowed-face nil
                        :foreground (my-solarized-color 'cyan)
                        :box (append '(:line-width 1)
                                     `(:color ,(my-solarized-color 'cyan))))

    (set-face-attribute 'mode-line-mc-face nil
                        :foreground (my-solarized-color 'base1)
                        :box (append '(:line-width 1)
                                     `(:color ,(my-solarized-color 'base1))))

    ;; *** flyspell

    (set-face-attribute 'flyspell-incorrect nil
                        :foreground 'unspecified
                        :background 'unspecified
                        :bold t
                        :underline "OrangeRed")

    (set-face-attribute 'flyspell-duplicate nil
                        :foreground 'unspecified
                        :background 'unspecified
                        :bold t
                        :underline "OrangeRed")

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

;; ** web-mode

(defprepare "web-mode"
  (add-to-list 'auto-mode-alist
               '("\\.s?html?\\(\\.[a-zA-Z_]+\\)?\\'" . web-mode)))

(deflazyconfig '(web-mode) "web-mode")

;; ** whitespace

(defconfig 'whitespace

  ;; activate

  (global-whitespace-mode 1)

  ;; matching

  (setq whitespace-style
        '(face tabs spaces space-mark tab-mark))

  (setq whitespace-space-regexp "\\(\x3000+\\)")

  (setq whitespace-display-mappings
        '((space-mark ?\x3000 [?□])
          (tab-mark ?\t [?\xBB ?\t])))
  )

;; ** yasnippet

(defprepare "yasnippet"
  (delayed-require 'yasnippet))

(deflazyconfig
  '(yas-expand
    yas-expand-oneshot-snippet
    yas-register-oneshot-snippet) "yasnippet"

    ;; *** snippets directory

    (setq yas-snippet-dirs (cons my:snippets-directory '()))

    ;; *** enable yasnippet

    (yas-global-mode 1)
    (call-interactively 'yas-reload-all)

    ;; *** allow nested snippets

    (setq yas-triggers-in-field t)

    ;; *** use dabbrev as fallback

    (setq yas-fallback-behavior '(apply dabbrev-expand . nil))

    ;; *** use ido-prompt

    (custom-set-variables '(yas-prompt-functions '(yas-ido-prompt)))

    ;; anything-prompt also looks nice :
    ;; http://d.hatena.ne.jp/sugyan/20120111/1326288445

    ;; *** oneshot snippet

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

    ;; *** keybind

    (define-key yas-minor-mode-map (kbd "TAB") nil) ; auto-complete
    (define-key yas-minor-mode-map (kbd "<tab>") nil) ; auto-complete

    (define-key yas-keymap (kbd "TAB") nil) ; auto-complete
    (define-key yas-keymap (kbd "<tab>") nil) ; auto-complete
    (key-chord-define yas-keymap "df" 'yas-next-field-or-maybe-expand)
    (key-chord-define yas-keymap "jk" 'yas-next-field-or-maybe-expand)

    ;; *** (sentinel)
    )

;; ** zencoding

(deflazyconfig '(zencoding-mode) "zencoding"
  (setq zencoding-indent 2)
  (define-key zencoding-mode-keymap (kbd "C-j") nil)
  (define-key zencoding-mode-keymap (kbd "<C-return>") nil)
  ;; override yasnippet
  (defpostload "key-chord"
    (key-chord-define zencoding-mode-keymap "df" 'zencoding-expand-line)
    (key-chord-define zencoding-mode-keymap "jk" 'zencoding-expand-line)))

(defprepare "zencoding"
  (defpostload "sgml-mode"
    (add-hook 'sgml-mode-hook 'zencoding-mode))
  (defpostload "web-mode"
    (add-hook 'web-mode-hook 'zencoding-mode)))

;; ** zlc

(defconfig 'zlc)

;; * global keybindings
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
(global-set-key (kbd "M-<f4>") 'save-buffers-kill-emacs)

;; Ctrl-x
(global-set-key (kbd "C-x C-c") 'save-buffers-kill-emacs)
(global-set-key (kbd "C-x C-0") 'kmacro-end-macro)
(global-set-key (kbd "C-x C-9") 'kmacro-start-macro)
(global-set-key (kbd "C-x RET") 'kmacro-end-and-call-macro) ; C-x C-m

;; Overwrite
(defprepare "smex"
  (global-set-key (kbd "M-x") 'smex))
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
(global-set-key (kbd "M-P") 'my-up-list)
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
(global-set-key (kbd "M-v") 'my-visible-register)
(global-set-key (kbd "M-j") 'list-bookmarks)

;; Ctrl-x
(global-set-key (kbd "C-x C-j") 'bookmark-set)

;; Overwrite
(defprepare "iy-go-to-char"
  (global-set-key (kbd "<oem-pa1>") 'iy-go-to-char) ; US
  (global-set-key (kbd "C-<oem-pa1>") 'iy-go-to-char-backward)
  (global-set-key (kbd "<nonconvert>") 'iy-go-to-char) ; JP
  (global-set-key (kbd "C-<nonconvert>") 'iy-go-to-char-backward))
(defprepare "point-undo"
  (global-set-key (kbd "M--") 'point-undo))
(defprepare "anything"
  (global-set-key (kbd "M-j") 'my-anything-jump))

;; **** scroll

;; Ctrl-
(global-set-key (kbd "C-u") 'scroll-down)
(global-set-key (kbd "C-v") 'scroll-up)
(global-set-key (kbd "C-l") 'recenter)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-u") 'beginning-of-buffer)
(global-set-key (kbd "C-M-v") 'end-of-buffer)
(global-set-key (kbd "C-M-l") 'retop)

;; Meta-Shift-
(global-set-key (kbd "M-L") 'recenter)

;; Overwrite
(defprepare "pager"
  (global-set-key (kbd "C-v") 'pager-page-down)
  (global-set-key (kbd "C-u") 'pager-page-up))

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
(global-set-key (kbd "<left>") 'my-move-region-left)
(global-set-key (kbd "<right>") 'my-move-region-right)
(global-set-key (kbd "<up>") 'my-move-region-up)
(global-set-key (kbd "<down>") 'my-move-region-down)
(global-set-key (kbd "C-SPC") 'set-mark-command)
(global-set-key (kbd "C-M-SPC") 'exchange-point-and-mark)
(global-set-key (kbd "C-<return>") 'cua-set-rectangle-mark)

;; Overwrite
(defprepare "expand-region"
  (global-set-key (kbd "<S-oem-pa1>") 'my-change-command))
(defprepare "multiple-cursors"
  (global-set-key (kbd "C-a") 'my-mc/mark-next-dwim)
  (global-set-key (kbd "C-M-a") 'my-mc/mark-all-dwim-or-skip-this))
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
(global-set-key (kbd "C-M-k") 'my-kill-line-backward)
(global-set-key (kbd "C-M-d") 'kill-word)
(global-set-key (kbd "C-M-h") 'backward-kill-word)

;; Meta-Shift-
(global-set-key (kbd "M-W") 'my-yank-sexp)
(global-set-key (kbd "M-K") 'kill-line)
(global-set-key (kbd "M-D") 'kill-sexp)
(global-set-key (kbd "M-H") 'backward-kill-sexp)
(global-set-key (kbd "M-Y") 'my-replace-sexp)

;; Meta-
(global-set-key (kbd "M-y") 'yank-pop)

;; Overwrite
(defprepare "browse-kill-ring"
  (global-set-key (kbd "M-y") 'browse-kill-ring))
(defprepare "hungry-delete"
  (global-set-key (kbd "C-d") 'hungry-delete))
(defprepare "yasnippet"
  (global-set-key (kbd "C-M-y") 'yas-expand-oneshot-snippet))
(defprepare "paredit"
  (global-set-key (kbd "M-K") 'my-paredit-kill))

;; **** newline, indent, format

;; Ctrl-
(global-set-key (kbd "TAB") 'indent-for-tab-command) ; C-i
(global-set-key (kbd "C-o") 'open-line)
(global-set-key (kbd "RET") 'newline-and-indent) ; C-m

;; Ctrl-Meta-
(global-set-key (kbd "C-M-i") 'fill-paragraph)
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
(global-set-key (kbd "C-s") 'isearch-forward-regexp)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-r") 'replace-regexp)
(global-set-key (kbd "C-M-s") 'isearch-backward-regexp)

;; Meta-
(global-set-key (kbd "M-s") 'hi-lock-rehighlight)

;; Overwrite
(defprepare "phi-search"
  (global-set-key (kbd "C-s") 'phi-search)
  (global-set-key (kbd "C-M-s") 'phi-search-backward))
(defprepare "phi-replace"
  (global-set-key (kbd "C-r") 'phi-replace-query)
  (global-set-key (kbd "C-M-r") 'phi-replace))
(defprepare "all"
  (global-set-key (kbd "M-s") 'my-all-command))

;; **** other edit commands

;; Ctrl-
(global-set-key (kbd "C-t") 'backward-transpose-words)
(global-set-key (kbd "C-;") 'comment-dwim)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-t") 'backward-transpose-lines)

;; Meta-
(global-set-key (kbd "M-h") 'my-shrink-whitespaces)

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
  (global-set-key (kbd "M-C") 'paredit-convolute-sexp)
  (global-set-key (kbd "M-:") 'paredit-comment-dwim)
  (global-set-key (kbd "M-\"") 'paredit-meta-doublequote))

;; *** file, directory, shell
;; **** browsing

;; Meta-
(global-set-key (kbd "M-d") 'dired)
(global-set-key (kbd "M-f") 'find-file)
(global-set-key (kbd "M-g") 'rgrep)     ; require "grep"
(global-set-key (kbd "M-r") 'ido-recentf-open)

;; Ctrl-x
(global-set-key (kbd "C-x DEL") 'ff-find-other-file) ; C-x C-h
(global-set-key (kbd "C-x C-d") 'dired)

;; Overwrite
(defprepare "nav"
  (global-set-key (kbd "M-d") 'my-nav-toggle))
(defprepare "traverselisp"
  (global-set-key (kbd "M-g") 'traverse-deep-rfind))

;; **** shell command

;; Meta-
(global-set-key (kbd "M-i") 'shell)

;; Overwrite
(defprepare "shell-pop"
  (global-set-key (kbd "M-i") 'shell-pop))

;; *** help

(define-prefix-command 'help-map)

(global-set-key (kbd "<f1>") 'help-map)
(global-set-key (kbd "M-?") 'help-map)

(define-key 'help-map (kbd "b") 'describe-bindings)
(define-key 'help-map (kbd "k") 'describe-key)
(define-key 'help-map (kbd "m") 'describe-mode)
(define-key 'help-map (kbd "f") 'describe-function)
(define-key 'help-map (kbd "v") 'describe-variable)
(define-key 'help-map (kbd "a") 'describe-face)

;; *** others

;; ignore some bindings

(global-set-key (kbd "M-<kanji>") 'ignore)

;; insert commands

(global-set-key (kbd "C-q") 'quoted-insert)
(global-set-key (kbd ",") 'my-smart-comma)

;; scratch notes

(defprepare "scratch-palette"
  (global-set-key (kbd "M-w") 'scratch-palette-popup))
(defprepare "scratch-pop"
  (global-set-key (kbd "M-q") 'scratch-pop))

;; minor-modes

(global-set-key (kbd "<escape>") 'vi-mode)
(global-set-key (kbd "M-t") 'orgtbl-mode)
(global-set-key (kbd "M-a") 'artist-mode)

;; misc

(global-set-key (kbd "C-x C-l") 'add-change-log-entry)
(global-set-key (kbd "C-x C-t") 'toggle-truncate-lines)
(global-set-key (kbd "C-x C-p") 'toggle-read-only)
(global-set-key (kbd "M-n") 'my-narrow-to-region-or-widen)
(global-set-key (kbd "C-x C-=") 'text-scale-adjust)

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
  (key-chord-define-global "fj" 'backward-transpose-chars)
  (key-chord-define-global "fn" 'my-downcase-previous-word)
  (key-chord-define-global "fp" 'my-upcase-previous-word)
  (key-chord-define-global "fm" 'capitalize-word)

  ;; Overwrite
  (defprepare "yasnippet"
    (key-chord-define-global "df" 'yas-expand)
    (key-chord-define-global "jk" 'yas-expand))
  (defprepare "ace-jump-mode"
    (key-chord-define-global ",." 'ace-jump-word-mode))
  )

;; ** keycombo

(defpostload "key-combo"

  (key-combo-define-global (kbd "C-j")
                           '(back-to-indentation beginning-of-line))

  (defprepare "yasnippet"
    (key-combo-define-global (kbd "C-M-w")
                             '(kill-ring-save yas-register-oneshot-snippet)))
  )

;; * ------------------------------
