;; init.el (for Emacs 23.3) | 2013 zk_phi

;; following plug-ins are not updated for long time :
;; - solarized ... settings for modeline colors conflicts

(eval-when-compile (require 'cl))

;; + cheat sheet
;; +--+ global
;;    +--- format

;; Format
;; |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
;;    |     |     |     |     |     |     |     |     |     |     |     |     |
;;       |     |     |     |     |     |     |     |     |     |     |     |
;;          |     |     |     |     |     |     |     |     |     |     |

;;    +--- Ctrl-

;; C-_
;; |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  | Undo|     |     |     |
;;    | Quot| Cut | End |Rplce|TrsWd| Yank| PgUp| Tab | Open| U p |  *  |     |
;;       |MCNxt|Serch|Delte|Right| Quit| B S | Home|CutLn|Centr|Comnt|     |
;;          | Fold|  *  |  *  | PgDn| Left| Down|Retrn|MrkPg|     |     |

;;    +--- Ctrl-Meta-

;; C-M-_
;; |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  | Redo|     |     |     |
;;    |     | Copy|EdDef|RplAl|TrsLn|YankS|BgBuf| Fill|NlBet|BPgph|  *  |     |
;;       |MCAll|SrchB|KilWd|FWord|Abort|BKlWd|BgDef|KlPgh|Cntr0|  -  |     |
;;          |HidAl|     |     |EdBuf|BWord|NPgph|NNLin|MrkAl|     |     |

;;    +--- Meta-

;; M-_
;; |AlWnd|SpWnd|Blnce|Follw|     |     |     |SwWnd|PvWnd|NxWnd|LstCg|     |     |     |
;;    |Scrtc|Palet| Eval|Recnt|Table|YankP|UndoT|Shell|Opcty|EvalP|     |     |
;;       |Artst| All |Dired| File| Grep|Shrnk| Jump|KlWnd| Goto|     |     |
;;          |     |Comnd|Cmpil| VReg|Buffr|Narrw|DMcro| Howm|     |     |

;;    +--- Meta-Shift-

;; M-Shift-
;; |     |     |     |     |     |     |     | Barf|Wrap(|Slurp| Undo|     |     |     |
;;    |     |CpSex|EvalR|Raise|TrsSx| Yank|RaisB|IdntX| Open|UpSex|     |     |
;;       |     |SpltS|KlSex|FwSex| Quit|KlSex|JoinS|KillX|Centr|CmntX|Wrap"|
;;          |     |     |     | Mark|BwSex|DnSex|Retrn|MkSex|     |     |

;;    +--- Ctrl-x Ctrl-

;; C-x C-_
;; |     |     |     |     |     |     |     |     |BgMcr|EdMcr|     |Scale|     |     |
;;    |     |Write|Encod|Revrt|Trnct|     |Untab|Spell|     |RdOly|     |     |
;;       |     | Save|     |     |     |FHead|     |KilBf|CgLog|     |     |
;;          |     |     |Close|     |Bffrs|     |ExMcr|     |     |     |

;;    +--- others

;; -    <f1> : help prefix
;; -  M-<f4> : kill-emacs

;; -     TAB : indent / ac-expand
;; -     ESC : vi-mode
;; -   NConv : dabbrev-expand / yas-expand
;; -   C-RET : phi-rectangle-set-mark-command
;; -   C-SPC : set-mark-command / exchange-point-and-mark

;; +--- key-chord

;; key-chord
;;
;; - fj : transpose-chars
;; - hh : capitalize word
;; - jj : upcase word
;; - kk : downcase word
;;
;; - cv : scroll-down
;; - df : iy-go-to-char-backward
;; - fg : phi-search-backward
;; - hj : phi-search
;; - jk : iy-go-to-char
;; - nm : scroll-up
;;
;; - jl : ace-jump-mode
;; - vv : vi-mode

;; +--+ orgtbl-mode override
;;    +--- Ctrl-

;; C-_
;; |     | Edit|     |     |     |     |     |     |     |     |     |ColFm|     |     |
;;    |     |RcCut|     |     |TrRow|RcPst|     |FwCel|InRow|     |     |     |
;;       |     |     |     |     | Exit|     |     |     |     |     |     |
;;          |     |     |     |     |     |     |FwRow|     |     | Sort|

;;    +--- Ctrl-Meta-

;; C-M-_
;; |     |     |     |     |     |     |     |     |     |     |     |CelFm|     |     |
;;    |     |     |     |     |TrCol|AFill|     |InCol|InHrl|     |     |     |
;;       |     |     |     |FwCel|     |     |     |     |     |     |     |
;;          |     |     |     |     |BwCel|     |HrFwR|     |     |     |

;;    +--- Meta-

;; M-_
;; |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
;;    |     |     | Eval|     |     |     |     |     |     |     |     |     |
;;       |     |     |     |     |     |     |     |     |     |     |     |
;;          |     |     |     |     |     |     |     |     |     |     |

;; + codes
;; +--+ 0x00. init for init
;;    +--+ environment
;;       +--- customs

(defconst my:home-system-p (when (boundp 'my:home-system-p)
                             my:home-system-p))

(defconst my:skip-checking-libraries my:home-system-p
  "when non-nil, Emacs assumes all dependencies are provided")

(defconst my:skip-warnings nil
  "when non-nil Emacs does not warn differences of system")

;;       +--- system

(unless my:skip-warnings

  (unless my:home-system-p
    (message "!! [init] WARNING: this is not my home system")
    (sit-for 0.2))

  (unless (string-match "^23\." emacs-version)
    (message "!! [init] WARNING: emacs version is not 23.X")
    (sit-for 0.2))

  (unless (eq 'windows-nt system-type)
    (message "!! [init] WARNING: system type is not windows-nt")
    (sit-for 0.2))
  )

;;       +--- directories

(defconst my:init-directory "~/.emacs.d/")

(defconst my:dat-directory (concat my:init-directory "dat/"))
(defconst my:lib-directory (concat my:init-directory "lib/"))
(defconst my:howm-directory (concat my:init-directory "howm/"))
(defconst my:backup-directory (concat my:init-directory "backups/"))
(defconst my:snippets-directory (concat my:init-directory "snippets/"))
(defconst my:dictionary-directory (concat my:init-directory "ac-dict/"))

;;       +--- files

(defconst my:ditaa-jar-file (concat my:lib-directory "ditaa.jar"))
(defconst my:smex-save-file (concat my:dat-directory "smex.dat"))
(defconst my:mc-list-file (concat my:dat-directory "mc-list.dat"))
(defconst my:ac-history-file (concat my:dat-directory "ac-comphist.dat"))

;; system-specific files/directories

(defconst my:ido-save-file (concat my:dat-directory "ido_" system-name ".dat"))
(defconst my:scratch-file (concat my:dat-directory "scratch_" system-name ".dat"))
(defconst my:recentf-file (concat my:dat-directory "recentf_" system-name ".dat"))
(defconst my:eshell-directory (concat my:init-directory "dat/eshell_" system-name "/"))
(defconst my:howm-keyword-file (concat my:dat-directory "howm-keys_" system-name ".dat"))
(defconst my:howm-history-file (concat my:dat-directory "howm-history_" system-name ".dat"))

;;       +--- dropbox integration

(defconst my:dropbox-directory
  (if my:home-system-p "~/../../Dropbox/"))

(defconst my:howm-import-directory
  (if my:home-system-p (concat my:dropbox-directory "howm_import/")))

(defconst my:howm-export-file
  (if my:home-system-p (concat my:dropbox-directory "howm_schedule.txt")))

;;    +--+ macros / utilities
;;       +--- locate libraries

;; cache lists of (not) found libraries

(defvar my-found-libraries nil)
(defvar my-not-found-libraries nil)

(defadvice load (after add-to-found-list activate)
  (unless my:skip-checking-libraries
    (if (null ad-return-value)
        (add-to-list 'my-not-found-libraries (ad-get-arg 0))
      (add-to-list 'my-found-libraries (ad-get-arg 0)))))

;; check if the library exists

(defun my-library-exists (lib)
  (or my:skip-checking-libraries
      (cond ((member lib my-found-libraries) t)
            ((member lib my-not-found-libraries) nil)
            ((locate-library lib) (add-to-list 'my-found-libraries lib))
            (t (add-to-list 'my-not-found-libraries lib) nil))))

;;       +--- benchmark for init

;; an utility function for benchmark
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
          (lambda ()
            (message ">> [init] TOTAL: %d msec"
                     (my-init-ellapsed-time my-benchmark-start))))

;;       +--- safe-load / config macros

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

;;       +--- enhanced global-set-key

;; save the original definition of global-set-key

(defun original-global-set-key (key command))
(fset 'original-global-set-key (symbol-function 'global-set-key))

;; redefine global-set-key

(defun global-set-key (key command)
  (if (and (listp command) (stringp (car command)))
      (funcall 'original-global-set-key key
               (if (my-library-exists (car command))
                   (cadr command) (or (caddr command) 'ignore)))
    (funcall 'original-global-set-key key command)))

;;       +--- delayed load in idle time

;; a list of libraries that should be loaded in idle-time

(defvar my-idle-require-list nil)

(defmacro idle-require (ft)
  `(progn
     (add-to-list 'my-idle-require-list ,ft)
     (message "-- [init] %s: ... will be loaded in idle-time" ,ft)))

;; when emacs has been idle for this 15 seconds, load them

(defvar my-idle-require-delay 15)

(run-with-idle-timer my-idle-require-delay nil
                     (lambda ()
                       (dolist (feat my-idle-require-list)
                         (if (require feat nil t)
                             (message "<< [init] %s: loaded" feat)
                           (message "XX [init] %s: not found" feat)))))

;; +--+ 0x10. system, UI
;;    +--- configurations

(defalias 'yes-or-no-p 'y-or-n-p)

(setq frame-title-format                    "%b - Emacs++"
      completion-ignore-case                t
      read-file-name-completion-ignore-case t
      gc-cons-threshold                     20000000
      message-log-max                       1000
      enable-local-variables                :safe
      echo-keystrokes                       0.1
      delete-by-moving-to-trash             t)

(when (fboundp 'set-message-beep)
  (set-message-beep 'silent))

;; use disabled commands
(dolist (command '(narrow-to-region
                   dired-find-alternate-file
                   upcase-region downcase-region))
  (put command 'disabled nil))

;;    +--- [w32vars.el] use clipboard

(setq x-select-enable-clipboard t)

;;    +--- [ls-lisp.el] use "ls" in all platforms

(defconfig 'ls-lisp
  (setq ls-lisp-use-insert-directory-program nil
        ls-lisp-dirs-first t))

;;    +--- [mule-cmds.el] use "japanese" input-method

(setq default-input-method "japanese")

;;    +--- [bytecomp.el] automatically byte-compile init.el

;; reference | http://www.bookshelf.jp/soft/meadow_18.html#SEC170

(add-hook 'after-save-hook
          (lambda()
            (let ((file (buffer-file-name)))
              (if (and file (string-match "init\\.el$" file))
                  (byte-compile-file file)))))

;;    +--- [frame.el] toggle-opacity

;; reference | http://d.hatena.ne.jp/IMAKADO/20090215/1234699972

(defun toggle-opacity ()
  "toggle opacity"
  (interactive)
  (let ((current-alpha
         (or (cdr (assoc 'alpha (frame-parameters))) 100)))
    (set-frame-parameter nil 'alpha
                         (if (= current-alpha 100) 66 100))))

;;    +--+ [ido.el] (flx-ido.el) ido settings
;;       +--+ (prelude)

(defprepare "ido"

  ;;     +--- "ido-everywhere" manually

  ;; basically the same as "ido-everywhere"
  (setq read-file-name-function 'ido-read-file-name
        read-buffer-function 'ido-read-buffer)

  ;;     +--- use ido for all "completing-read"s

  ;; based on "ido-hacks.el"

  (put 'elp-instrument-package 'ido 'ignore)

  (defvar ido-hacks-completing-read-recursive nil)
  (defun my-completing-read-with-ido (prompt collection &optional
                                             predicate require-match initial-input
                                             hist def inherit-input-method)
    (if (or (symbolp collection)
            (and (symbolp this-command)
                 (eq (get this-command 'ido) 'ignore))
            ;; ido does not support inherit-input-method
            inherit-input-method
            ;; recursive completing-read
            ido-hacks-completing-read-recursive
            ;; called from ido-read-internal
            (and (listp collection)
                 (equal '("dummy" . 1) (car collection))))
        (completing-read-default prompt collection predicate require-match
                                 initial-input hist def inherit-input-method)
      ;; based on "ido-completing-read"
      (let ((ido-hacks-completing-read-recursive t)
            (ido-current-directory nil)
            (ido-directory-nonreadable nil)
            (ido-directory-too-big nil)
            (ido-context-switch-command (or (and (symbolp this-command)
                                                 (get this-command
                                                      'ido-context-switch-command))
                                            'ignore))
            (ido-choice-list (let ((completions
                                    (all-completions "" collection predicate)))
                               (when (or (hash-table-p collection)
                                         (arrayp collection))
                                 completions))))
        (ido-read-internal 'list prompt hist def require-match initial-input))))

  (setq completing-read-function 'my-completing-read-with-ido)

  ;;     +--- (sentinel)
  )

;;       +--- (prelude)

(deflazyconfig
  '(ido-switch-buffer
    ido-write-file ido-find-file
    ido-dired ido-read-file-name
    ido-read-buffer ido-read-internal) "ido"

    ;;   +--- settings

    (setq ido-enable-regexp                      t
          ido-auto-merge-work-directories-length nil
          ido-save-directory-list-file           my:ido-save-file)

    (put 'dired-do-rename 'ido nil)       ; "'ignore" by default

    ;;   +--- enable ido-mode

    (ido-mode t)

    ;;   +--- super flex matching

    (defun my-make-super-flex-keywords (str)
      (flet ((shuffle-list (lst)
                           (when (>= (length lst) 2)
                             (cons `(,(cadr lst) ,(car lst) . ,(cddr lst))
                                   (mapcar (lambda (l) (cons (car lst) l))
                                           (shuffle-list (cdr lst)))))))
        (mapcar (lambda (lst) (mapconcat 'char-to-string lst ""))
                (shuffle-list (string-to-list str)))))

    (defun my-mix-lists (lists)
      (when (setq lists (delq nil lists))
        (nconc (mapcar 'car lists)
               (my-mix-lists (mapcar 'cdr lists)))))

    (defun my-super-flx-ido-match (query items)
      (my-mix-lists
       (mapcar (lambda (str) (flx-ido-match str items))
               (my-make-super-flex-keywords query))))

    ;;   +--- better matching

    ;; a hack to enable flex-matching ONLY WHEN no items exactly matched
    (defconfig 'flx-ido
      (defadvice ido-set-matches-1 (around flx-ido-set-matches-1 activate)
        ;; try to search prefix
        (let ((ido-enable-prefix t)) ad-do-it)
        (unless ad-return-value
          ;; if not found, try to search arbitrary substring
          (let ((ido-enable-prefix nil)) ad-do-it)
          ;; if not found, try flex matching
          (unless ad-return-value
            (catch :too-big
              (setq ad-return-value (flx-ido-match ido-text (ad-get-arg 0)))
              ;; if not found, try super-flex matching
              (unless ad-return-value
                (setq ad-return-value
                      (my-super-flx-ido-match ido-text (ad-get-arg 0)))))))))

    ;;   +--- dwim complete command

    (defun my-ido-spc-or-next ()
      (interactive)
      (funcall
       (cond ((= (length ido-matches) 1) 'ido-exit-minibuffer)
             ((= (length ido-text) 0) 'ido-next-match)
             (t 'ido-restrict-to-matches))))

    (defun my-ido-exit-or-select ()
      (interactive)
      (funcall
       (if (= (length ido-matches) 0)
           'ido-select-text
         'ido-exit-minibuffer)))

    ;;   +--- keymap

    ;; reference | http://github.com/milkypostman/dotemacs/blob/master/init.el

    (defun my-ido-hook ()
      (define-key ido-completion-map (kbd "C-n") 'ido-prev-work-directory)
      (define-key ido-completion-map (kbd "C-p") 'ido-next-work-diredctory)
      (define-key ido-completion-map (kbd "TAB") 'my-ido-spc-or-next)
      (define-key ido-completion-map (kbd "<S-tab>") 'ido-prev-match)
      (define-key ido-completion-map (kbd "<backtab>") 'ido-prev-match)
      (define-key ido-completion-map (kbd "SPC") 'my-ido-spc-or-next)
      (define-key ido-completion-map (kbd "RET") 'my-ido-exit-or-select)
      (define-key ido-completion-map (kbd "C-SPC") 'ido-select-text)
      (define-key ido-completion-map (kbd "C-<return>") 'ido-select-text))

    (add-hook 'ido-minibuffer-setup-hook 'my-ido-hook)

    ;;   +--- (sentinel)
    )

;;    +--- [simple.el] print more on eval-expression

(setq eval-expression-print-length nil
      eval-expression-print-level  5)

;;    +--- [simple.el] save clipboard to kill-ring

(setq save-interprogram-paste-before-kill t)

;;    +--- [startup.el] inhibit startup messages

(setq inhibit-startup-screen  t
      inhibit-startup-message t
      initial-scratch-message "")

;;    +--- (key-chord.el) key-chord settings

(defconfig 'key-chord
  (key-chord-mode 1))

;;    +--+ (key-combo.el) key-combo settings

(defconfig 'key-combo

  (global-key-combo-mode 1)

  ;; disable in multiple-cursors-mode
  (defpostload "multiple-cursors"
    (defadvice key-combo-post-command-function (around mc-combo activate)
      (unless (or multiple-cursors-mode current-input-method)
        ad-do-it)))
  )

;;    +--- (maxframe.el) maximize frame on startup

(defconfig 'maxframe

  ;; send X messages
  (when (string= window-system "x")
    (defadvice maximize-frame (after x-maximize-frame activate)
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                             '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                             '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))))

  (add-hook 'window-setup-hook 'maximize-frame)
  )

;;    +--- (smex.el) autoload smex

(deflazyconfig '(smex) "smex"
  (setq smex-save-file my:smex-save-file)
  (smex-initialize))

;; +--+ 0x11. windows
;;    +--- rotate windows

;; reference | https://github.com/milkypostman/dotemacs

(defun my-rotate-windows ()
  (interactive)
  (let ((windows (window-list))
        win1 win2 tmp)
    (dotimes (i (1- (length windows)))
      (setq win1 (nth i windows)
            win2 (nth (1+ i) windows))
      (setq tmp (window-buffer win1))
      (set-window-buffer win1 (window-buffer win2))
      (set-window-buffer win2 tmp))))

;;    +--- retop

(defun my-retop ()
  (interactive) (recenter 0))

;;    +--+ [window.el] split windows smartly
;;       +--+ utils
;;          +--- get window size including margins

(defun my-window-width (&optional window)
  "returns the window size including margins"
  (let ((margins (window-margins window))
        (width (window-width window)))
    (+ width
       (or (car margins) 0)
       (or (cdr margins) 0))))

;;          +--- split many windows

(defun split-window-horizontally-n (n)
  (cond
   ((< n 2)                             ; do nothing
    nil)
   ((= (mod n 2) 0)                     ; (n/2) | (n/2)
    (split-window-horizontally)
    (next-multiframe-window)
    (split-window-horizontally-n (/ n 2))
    (previous-multiframe-window)
    (split-window-horizontally-n (/ n 2)))
   (t                                   ; (n-1) | 1
    (split-window-horizontally (- (my-window-width)
                                  (/ (my-window-width) n)))
    (split-window-horizontally-n (1- n)))
   ))

(defun split-window-vertically-n (n)
  (cond
   ((< n 2)                             ; do nothing
    nil)
   ((= (mod n 2) 0)                     ; (n/2) | (n/2)
    (split-window-vertically)
    (select-window (next-window))
    (split-window-vertically-n (/ n 2))
    (select-window (previous-window))
    (split-window-vertically-n (/ n 2)))
   (t                                   ; (n-1) | 1
    (split-window-vertically (- (window-height) (/ (window-height) n)))
    (split-window-vertically-n (1- n)))
   ))

;;          +--- delete many windows

(defun delete-window-n (n)
  (when (> n 0)
    (delete-window)
    (delete-window-n (1- n))))

;;       +--- commands

;; split window smartly
;; reference | http://d.hatena.ne.jp/yascentur/20110621/1308585547
;;           | http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part16

(defun my-split-window ()
  "split windows smartly"
  (interactive)
  (case last-command
    ((my-split-window-horizontally-4)
     (delete-window-n 3)
     (setq this-command 'my-split-window-horizontally-0))
    ((my-split-window-horizontally-3)
     (delete-window-n 2)
     (split-window-horizontally-n 4)
     (setq this-command 'my-split-window-horizontally-4))
    ((my-split-window-horizontally-2)
     (delete-window-n 2)
     (split-window-horizontally-n 2)
     (split-window-horizontally-n 2)
     (setq this-command 'my-split-window-horizontally-3))
    ((my-split-window-horizontally-1)
     (delete-window-n 1)
     (split-window-horizontally-n 3)
     (setq this-command 'my-split-window-horizontally-2))
    ((my-split-window-horizontally-0)
     (split-window-horizontally-n 2)
     (setq this-command 'my-split-window-horizontally-1))
    ((my-split-window-vertically-2)
     (delete-window-n 2)
     (setq this-command 'my-split-window-vertically-0))
    ((my-split-window-vertically-1)
     (delete-window-n 1)
     (split-window-vertically-n 3)
     (setq this-command 'my-split-window-vertically-2))
    ((my-split-window-vertically-0)
     (split-window-vertically-n 2)
     (setq this-command 'my-split-window-vertically-1))
    (t
     (if (> (my-window-width)
            (* 3 (window-height)))
         (progn (split-window-horizontally-n 2)
                (setq this-command 'my-split-window-horizontally-1))
       (progn (split-window-vertically-n 2)
              (setq this-command 'my-split-window-vertically-1))))))

;;    +--- [follow.el] disable follow-mode on delete-other-windows

(defadvice delete-other-windows (after auto-disable-follow activate)
  (when (and (boundp 'follow-mode)
             follow-mode)
    (follow-mode -1)))

;;    +--- (automargin.el) enable automargin

(defconfig 'automargin
  (automargin-mode 1)
  (setq automargin-target-width 120))

;;    +--- (popwin.el) enable popwin

(defconfig 'popwin
  (setq popwin:special-display-config
        '(
          ("ChangeLog")
          ("*howm-remember*")
          ("*Buffer List*")
          ("*Kill Ring*")
          ("*Help*")
          ("*Warnings*")
          ("*Shell Command Output*")
          ;; if *Compile-Log* is selected immediately, it fails!!
          ("*Compile-Log*" :noselect t)
          ("*compilation*" :noselect t)
          ("*Completions*" :noselect t)
          ("*Backtrace*" :noselect t)
          ))

  (popwin-mode 1)
  )

;;    +--- (pager.el) autoload pager

;; "scroll-preserve-screen-position" is not enough.
(deflazyconfig
  '(pager-row-up
    pager-row-down
    pager-page-up
    pager-page-down) "pager")

;;    +--- (smooth-scrolling.el) enable smooth-scrolling

(defconfig 'smooth-scrolling
  (setq smooth-scroll-margin 3))

;;    +--- (winpoint.el) remember point per window

(defconfig 'winpoint
  (winpoint-mode 1))

;; +--+ 0x12. buffers
;;    +--- make *scratch* parsistent

;; reference | http://www.bookshelf.jp/soft/meadow_29.html#SEC392

(defun my-clean-scratch ()
  (with-current-buffer "*scratch*"
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (message "*scratch* is cleaned up.")))

(defun my-make-scratch ()
  (unless (get-buffer "*scratch*")
    (generate-new-buffer "*scratch*")
    (message "new *scratch* is created.")
    (my-clean-scratch)))

;; clean scratch instead of killing it
(add-hook 'kill-buffer-query-functions
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (my-clean-scratch) nil)
              t)))

;; create another *scratch* when saved
(add-hook 'after-save-hook 'my-make-scratch)

;;    +--- save *scratch* across sessions

(defun my-scratch-save ()
  (with-current-buffer "*scratch*"
    (write-region 1 (1+ (buffer-size)) my:scratch-file)))

(defun my-scratch-restore ()
  (with-current-buffer "*scratch*"
    (when (file-exists-p my:scratch-file)
      (insert-file-contents my:scratch-file))))

(add-hook 'kill-emacs-hook 'my-scratch-save)
(add-hook 'after-init-hook 'my-scratch-restore)

;;    +--- toggle-narrowing

(defun my-toggle-narrowing ()
  "If the buffer is narrowed, widen. Otherwise, narrow to region."
  (interactive)
  (cond ((use-region-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((buffer-narrowed-p)
         (widen))
        (t
         (error "there is no active region"))))

;;    +--- [uniquify.el] enable uniquify

(defconfig 'uniquify
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets
        uniquify-ignore-buffers-re "*[^*]+*"))

;; +--+ 0x13. files
;;    +--- coding-system

(prefer-coding-system 'utf-8)

;; on Windows, use Shift-JIS for file names
;; reference | http://sakito.jp/emacs/emacsshell.html

(when (string= window-system "w32")
  (setq locale-coding-system 'sjis)
  (setq file-name-coding-system 'sjis))

;;    +--- do not use tabs

(setq-default indent-tabs-mode nil
              tab-width        4)

;;    +--- delete file with no contents

;; reference | http://www.bookshelf.jp/soft/meadow_24.html#SEC265

(defun delete-file-if-no-contents ()
  (when (and (buffer-file-name (current-buffer))
             (= 0 (buffer-size)))
    (when (y-or-n-p "Delete file and kill buffer ? ")
      (delete-file (buffer-file-name (current-buffer)))
      (kill-buffer (current-buffer)))))

(add-hook 'after-save-hook 'delete-file-if-no-contents)

;;    +--- [add-log.el] add-change-log-entry

(deflazyconfig '(my-add-change-log-entry) "add-log"

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

  (define-key change-log-mode-map (kbd "C-x C-s") 'my-change-log-save-and-kill)
  (define-key change-log-mode-map (kbd "C-g") 'my-change-log-save-and-kill)
  )

;;    +--+ [files.el] backup/auto-save files
;;       +--- backup

;; backup directory

(setq backup-directory-alist
      `( ("\\.*$" . ,(expand-file-name my:backup-directory))) )

;; version control
;; reference | http://aikotobaha.blogspot.jp/2010/07/emacs.html

(setq version-control     t
      kept-new-versions   20
      kept-old-versions   2
      delete-old-versions t)

;; make backup even when VC is enabled

(setq vc-make-backup-files t)

;;       +--- auto-save

(setq auto-save-default      t
      delete-auto-save-files t)

;;    +--- [files.el] open files as root

(defun my-should-open-as-root-p (file)
  (and
   ;; the owner is Mr.Root
   (eq 0 (nth 2 (file-attributes file)))
   ;; write-protected
   (not (file-writable-p file))))

(defadvice find-file (around my-find-file-as-root activate)
  (let ((file (ad-get-arg 0)))
    (if (and (my-should-open-as-root-p file)
             (y-or-n-p "Open as root ? "))
        (find-file (concat "/sudo:root@localhost:" file))
      ad-do-it)))

;;    +--- [files.el] automatically make directories

(defun my-make-directory-before-save ()
  (when buffer-file-name
    (let ((dir (file-name-directory buffer-file-name)))
      (when (and (not (file-exists-p dir))
                 (y-or-n-p (format "Directory does not exist. Create it? ")))
        (make-directory dir t)))))

(add-hook 'before-save-hook 'my-make-directory-before-save)

;;    +--+ [recentf.el] ido-recentf-open

(defprepare "recentf"
  (defvar recentf-save-file my:recentf-file))

(defpostload "recentf"
  (setq recentf-max-saved-items 100
        recentf-auto-cleanup    10
        recentf-exclude         '("/[^/]*\\<tmp\\>[^/]*/" "/[^/]*\\<backup\\>[^/]*/"
                                  "~$" "^#[^#]*#$" "/ssh:" "/sudo:" "/GitHub/" "/palette/"
                                  "\\.elc$" "\\.howm$" "\\.dat$")))

(defprepare "ido"
  (deflazyconfig '(ido-recentf-open) "recentf"

    (recentf-mode 1)

    ;; auto-save recentf-list / delayed cleanup
    ;; reference | http://d.hatena.ne.jp/tomoya/20110217/1297928222
    (run-with-idle-timer 30 t 'recentf-save-list)

    ;; find recent file with ido completion
    ;; reference | http://www.masteringemacs.org/articles/2011/01/27/find-files-faster-recent-files-package/
    (defun ido-recentf-open ()
      "Use `ido-completing-read' to \\[find-file] a recent file"
      (interactive)
      (if (find-file
           (ido-completing-read "Find recent file: " recentf-list))
          (message "Opening file...")
        (message "Aborting")))
    ))

;;    +--- (traverselisp.el) autoload traverselisp

(deflazyconfig '(traverse-deep-rfind) "traverselisp"
  (define-key traverse-mode-map (kbd "C-p") 'traverse-go-backward)
  (define-key traverse-mode-map (kbd "C-n") 'traverse-go-forward)
  (define-key traverse-mode-map (kbd "C-g") 'traverse-quit))

;; +--+ 0x14. utilities
;;    +--+ url-encode
;;       +--- functions

(defun my-url-encode-string (str &optional encoding)
  (let ((encoding (or encoding 'utf-8)))
    (url-hexify-string (encode-coding-string str encoding))))

(defun my-url-decode-string (str &optional encoding)
  (let ((encoding (or encoding 'utf-8)))
    (decode-coding-string (url-unhex-string str) encoding)))

;;       +--- commands

(defun my-url-decode-region (beg end)
  (interactive "r")
  (let ((str (buffer-substring beg end)))
    (delete-region beg end)
    (insert (my-url-decode-string str 'utf-8))))

(defun my-url-encode-region (beg end)
  (interactive "r")
  (let ((str (buffer-substring beg end)))
    (delete-region beg end)
    (insert (my-url-encode-string str 'utf-8))))

;;    +--- mojibake

(defun my-restore-iso2022-mojibake (str)
  (with-temp-buffer
    (save-excursion (insert str))
    (let ((case-fold-search nil))
      (while (search-forward-regexp "[^#]B" nil t)
        (save-excursion
          (goto-char (match-beginning 0))
          (insert ""))))
    (decode-coding-string (buffer-string) 'iso-2022-jp)))

(defun my-restore-iso2022-mojibake-region (beg end)
  (interactive "r")
  (let ((str (buffer-substring beg end)))
    (delete-region beg end)
    (insert (my-restore-iso2022-mojibake str))))

;;    +--- [regexp-opt.el] regexp-opt fix

(defpostload "regexp-opt"

  ;; (possible) fix for emacs 23
  (defadvice regexp-opt (after fix-regexp-opt-symbols activate)
    (setq ad-return-value
          (if (eq (ad-get-arg 1) 'symbols)
              (concat "\\_<" ad-return-value "\\_>")
            ad-return-value)))
  )

;;    +--- (htmlize.el) load htmlize with org

;; htmlize is used by "org-export-as-html"
(defpostload "org"
  (defconfig 'htmlize))

;; +--+ 0x15. jumping around
;;    +--- next/previous-blank-line

(defun my-next-blank-line ()
  (interactive)
  (when (eobp) (error "end of buffer"))
  (unless (ignore-errors
            (search-forward-regexp "[^\s\t\n]")
            (search-forward-regexp "^[\s\t]*$"))
    (goto-char (point-max))))

(defun my-previous-blank-line ()
  (interactive)
  (when (bobp) (error "beginning of buffer"))
  (unless (ignore-errors
            (search-backward-regexp "[^\s\t\n]")
            (search-backward-regexp "^[\s\t]*$"))
    (goto-char (point-min))))

;;    +--- smart bol command

(defun my-smart-bol ()
  "beginning-of-line or back-to-indentation"
  (interactive)
  (let ((command (if (eq last-command 'back-to-indentation)
                     'beginning-of-line
                   'back-to-indentation)))
    (setq this-command command)
    (funcall command)))

;;    +--+ [isearch.el] isearch settings
;;       +--- do not use lax-whitespace (for Emacs>=24)

(defpostload "isearch"
  (setq isearch-lax-whitespace nil))

;;       +--- isearch in japanese on windows

;; reference | http://d.hatena.ne.jp/myhobby20xx/20110228/1298865536

(defpostload "isearch"
  (when (string= window-system "w32")

    (defun w32-isearch-update ()
      (interactive)
      (isearch-update))

    (define-key isearch-mode-map [compend] 'w32-isearch-update)
    (define-key isearch-mode-map [kanji] 'isearch-toggle-input-method)
    ))

;;       +--- isearch with the region

(defun my-isearch-forward ()
  (interactive)
  (when (not isearch-mode)
    (call-interactively 'isearch-forward-regexp) ; must be interactive
    (when (use-region-p)
      (let ((string
             (buffer-substring (region-beginning) (region-end))))
        (deactivate-mark)
        (isearch-yank-string string)))))

(defun my-isearch-backward ()
  (interactive)
  (when (not isearch-mode)
    (call-interactively 'isearch-backward-regexp) ; must be interactive
    (when (and (called-interactively-p 'any)
               transient-mark-mode mark-active)
      (let ((string
             (buffer-substring (region-beginning) (region-end))))
        (deactivate-mark)
        (isearch-yank-string string)))))

;;    +--- (ace-jump-mode.el) autoload ace-jump-mode

(deflazyconfig '(ace-jump-word-mode) "ace-jump-mode"
  (add-hook 'ace-jump-mode-end-hook 'recenter))

;;    +--- (all.el) all-mode settings

(deflazyconfig '(my-all-command) "all"

  (defvar my-all-previous-position nil)

  (defun my-all-command ()
    (interactive)
    (delete-other-windows)
    (setq my-all-previous-position (point))
    (call-interactively 'all)           ; must be interactive
    (other-window 1))

  (defun my-all-exit ()
    (interactive)
    (kill-buffer)
    (delete-window)
    (goto-char my-all-previous-position))

  (defun my-all-next-line ()
    (interactive)
    (next-line)
    (save-selected-window (all-mode-goto)))

  (defun my-all-previous-line ()
    (interactive)
    (previous-line)
    (save-selected-window (all-mode-goto)))

  (define-key all-mode-map (kbd "C-n") 'my-all-next-line)
  (define-key all-mode-map (kbd "C-p") 'my-all-previous-line)
  (define-key all-mode-map (kbd "C-g") 'my-all-exit)
  )

;;    +--+ (anything.el) anything-jump command
;;       +--- prepare highlight-changes-mode

(defprepare "hilit-chg"
  (add-hook 'find-file-hook 'highlight-changes-mode))

(deflazyconfig '(highlight-changes-mode) "hilit-chg"

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

;;       +--+ anything-jump
;;          +--- (prelude)

(deflazyconfig '(my-anything-jump) "anything"

  ;;        +--- force anything split window

  ;; reference | http://emacs.g.hatena.ne.jp/k1LoW/20090713/1247496970

  (defun anything-split-window (buf)
    (select-window
     (split-window (selected-window)
                   (/ (* (window-height) 3) 5)))
    (switch-to-buffer buf))

  (setq anything-display-function 'anything-split-window)

  ;;        +--- execute parsistent-action on move

  ;; reference | http://shakenbu.org/yanagi/d/?date=20120213

  (add-hook 'anything-move-selection-after-hook
            (lambda()
              (if (member (cdr (assq 'name (anything-get-current-source)))
                          '("Imenu" "Visible Bookmarks"
                            "Changes" "Flymake"))
                  (anything-execute-persistent-action))))

  ;;        +--+ anything source for hilit-chg
  ;;           +--- (prelude)

  (defpostload "hilit-chg"

    ;;         +--- search for the next change (from to)

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

    ;;         +--- get candidate

    (defun my-change-buffer nil)

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

    ;;         +--- provide source

    (defvar anything-source-highlight-changes-mode
      '((name . "Changes")
        (init . (lambda () (setq my-change-buffer (current-buffer))))
        (candidates . my-change-candidates)
        (action . (lambda (num) (goto-char num)))
        (multiline)))

    ;;         +--- (sentinel)
    )

  ;;        +--+ anything source for flymake
  ;;           +--- (prelude)

  ;; reference | http://d.hatena.ne.jp/kiris60/20091003

  (defpostload "flymake"

    ;;         +--- get errorlines from flymake

    (defvar my-flymake-candidates nil)

    (defun my-flymake-candidates ()
      (mapcar
       (lambda (err)
         (let* ((type (flymake-ler-type err))
                (text (flymake-ler-text err))
                (line (flymake-ler-line err)))
           (cons (propertize
                  (format "[%s] %s" line text)
                  'face (if (equal type "e") 'flymake-errline 'flymake-warnline))
                 err)))
       my-flymake-candidates))

    ;;         +--- provide anything-source

    (defvar anything-c-source-flymake
      '((name . "Flymake")
        (init . (lambda ()
                  (setq my-flymake-candidates
                        (loop for err-info in flymake-err-info
                              for err = (nth 1 err-info)
                              append err))))
        (candidates . my-flymake-candidates)
        (action
         . (("Goto line" .
             (lambda (candidate)
               (goto-line (flymake-ler-line candidate) anything-current-buffer)))))))

    ;;         +--- (sentinel)
    )

  ;;        +--- anything source for imenu

  ;; reference | http://www.emacswiki.org/cgi-bin/wiki/AnythingSources

  (defconfig 'imenu

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
    )

  ;;        +--- anything-jump

  (defun my-anything-jump ()
    "My 'anything'."
    (interactive)
    (anything
     :sources (list (and (boundp 'anything-source-highlight-changes-mode)
                         anything-source-highlight-changes-mode)
                    (and (boundp 'anything-c-source-flymake)
                         anything-c-source-flymake)
                    anything-c-source-imenu)
     :input nil ;; (thing-at-point 'symbol)
     :prompt "symbol : "))

  ;;        +--- (sentinel)
  )

;;    +--- (iy-go-to-char.el) autoload iy-go-to-char

(deflazyconfig
  '(iy-go-to-char iy-go-to-char-backward) "iy-go-to-char")

;;    +--- (phi-search.el) autoload phi-search

(deflazyconfig
  '(phi-search phi-search-backward) "phi-search")

(deflazyconfig
  '(phi-replace phi-replace-query) "phi-replace")

;;    +--- (point-undo.el) load point-undo

;; point-undo must be loaded before it actually be invoked
(defconfig 'point-undo)

;; +--+ 0x16. regions, kill-ring
;;    +--- eval region or last-sexp

(defun my-eval-sexp-dwim ()
  "eval-last-sexp or eval-region"
  (interactive)
  (if (use-region-p)
      (eval-region (region-beginning) (region-end))
    (call-interactively 'eval-last-sexp))) ; must be interactive

;;    +--+ move-region
;;       +--- utility

;; reference | http://www.pitecan.com/tmp/move-region.el

(defun my-move-region (command)
  "move region with the given command"
  (if (and transient-mark-mode mark-active)
      (let (m)
        (kill-region (mark) (point))
        (call-interactively command)
        (setq m (point))
        (yank)
        (set-mark m)
        (setq deactivate-mark nil))
    (call-interactively command)))

;;       +--- commands

(dolist (pair '((my-move-region-up . previous-line)
                (my-move-region-down . next-line)
                (my-move-region-left . backward-char)
                (my-move-region-right . forward-char)))
  (eval `(defun ,(car pair) ()
           (interactive)
           (my-move-region ',(cdr pair)))))

;;    +--- [delsel.el] enable delete-selection

(defconfig 'delsel
  (delete-selection-mode 1))

;;    +--- [simple.el] some settings about regions
;;       +--- disable shift-region

(setq shift-select-mode nil)

;;       +--- kill-line-backward

;; reference | http://emacsredux.com/blog/2013/04/08/kill-line-backward/

(defun my-kill-line-backward ()
  (interactive)
  (kill-line 0)
  (indent-according-to-mode))

;;    +--- (browse-kill-ring.el) browse-kill-ring settings

(deflazyconfig '(browse-kill-ring) "browse-kill-ring"
  (setq browse-kill-ring-highlight-current-entry t)
  (define-key browse-kill-ring-mode-map (kbd "C-n") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "C-p") 'browse-kill-ring-previous)
  (define-key browse-kill-ring-mode-map (kbd "C-g") 'browse-kill-ring-quit)
  (define-key browse-kill-ring-mode-map (kbd "j") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "k") 'browse-kill-ring-previous)
  (define-key browse-kill-ring-mode-map (kbd "<escape>") 'browse-kill-ring-quit))

;;    +--- (expand-region.el) autoload expand-region

(deflazyconfig '(er/expand-region) "expand-region")

;;    +--+ (phi-rectangle.el) rectangle-mark
;;       +--- (prelude)

(defconfig 'phi-rectangle

  ;;     +--- swap-region

  (defvar swap-region-pending-overlay nil)
  (make-variable-buffer-local 'swap-region-pending-overlay)

  (defvar swap-pending-face 'cursor)

  (defadvice phi-rectangle-yank (around swap-region-start activate)
    (if (eq last-command 'kill-region)
        (progn
          (setq swap-region-pending-overlay
                (make-overlay (point) (1+ (point))))
          (overlay-put swap-region-pending-overlay
                       'face swap-pending-face))
      (progn
        (when swap-region-pending-overlay
          (delete-overlay swap-region-pending-overlay)
          (setq swap-region-pending-overlay nil))
        ad-do-it)))

  (defadvice phi-rectangle-kill-region (around swap-region-exec activate)
    (if (not (and (use-region-p)
                  swap-region-pending-overlay))
        ad-do-it
      (let* ((str (buffer-substring (region-beginning) (region-end)))
             (pending-pos (overlay-start swap-region-pending-overlay))
             (pos (+ (region-beginning)
                     (if (< pending-pos (point)) (length str) 0))))
        (delete-region (region-beginning) (region-end))
        (goto-char (overlay-start swap-region-pending-overlay))
        (delete-overlay swap-region-pending-overlay)
        (setq swap-region-pending-overlay nil)
        (insert str)
        (goto-char pos)
        (setq this-command 'kill-region))))

  ;;     +--- oneshot-snippet

  (defprepare "yasnippet"
    (defadvice phi-rectangle-kill-ring-save (around yas-oneshot-save activate)
      (if (and (called-interactively-p 'any)
               (eq last-command this-command))
          (call-interactively 'my-yas-register-oneshot)
        ad-do-it)))

  (deflazyconfig
    '(my-yas-expand-oneshot
      my-yas-register-oneshot) "yasnippet"

      ;; reference | http://d.hatena.ne.jp/rubikitch/20090702/1246477577

      (defvar my-yas-oneshot-snippet nil)

      (defun my-yas-expand-oneshot ()
        (interactive)
        (if my-yas-oneshot-snippet
            (yas-expand-snippet my-yas-oneshot-snippet (point) (point) nil)
          (message "oneshot-snippet is not registered")))

      (defun my-yas-register-oneshot (start end)
        (interactive "r")
        (setq my-yas-oneshot-snippet (buffer-substring-no-properties start end))
        (delete-region start end)
        (my-yas-expand-oneshot)
        (message "%s" (substitute-command-keys
                       "Press \\[my-yas-expand-oneshot] to expand."))))

  ;;     +--- auto indent

  (defvar my-auto-indent-inhibit-modes
    '(fundamental-mode org-mode text-mode ahk-mode latex-mode eshell-mode
                       lmntal-slimcode-mode))

  (defvar my-auto-indent-limit 5000)

  (defun my-auto-indent-function (beg end)
    (if (> (- end beg) my-auto-indent-limit)
        (progn
          (message "auto-indent canceled.")
          (sit-for 0.4))
      (indent-region beg end)))

  (defadvice phi-rectangle-yank (around my-auto-indent activate)
    (if (not (member major-mode my-auto-indent-inhibit-modes))
        (my-auto-indent-function (point) (progn ad-do-it (point)))
      ad-do-it))

  (defadvice my-overwrite-sexp (around my-auto-indent activate)
    (if (not (member major-mode my-auto-indent-inhibit-modes))
        (my-auto-indent-function (point) (progn ad-do-it (point)))
      ad-do-it))

  ;;     +--- exchange-point-and-mark with set-mark

  (dolist (command '(set-mark-command phi-rectangle-set-mark-command))
    (eval
     `(defadvice ,command (around exchange-mark activate)
        "if set-mark-command is called more than twice, exchange-point-and-mark"
        (if (not (or phi-rectangle-mark-active mark-active))
            ad-do-it
          (setq this-command 'exchange-point-and-mark)
          (exchange-point-and-mark)))))

  ;;     +--- visible-register

  (defvar my-visible-register nil)

  (defun my-visible-register ()
    "store the cursor position, or back to the stored position"
    (interactive)
    (if my-visible-register
        (progn
          (goto-char (overlay-start my-visible-register))
          (delete-overlay my-visible-register)
          (setq my-visible-register nil))
      (setq my-visible-register (make-overlay (point) (1+ (point))))
      (overlay-put my-visible-register 'face 'cursor)))

  (dolist (command '(set-mark-command phi-rectangle-set-mark-command))
    (eval
     `(defadvice ,command (around visible-register activate)
        (if (eq this-command last-command)
            (progn (deactivate-mark)
                   (my-visible-register))
          ad-do-it))))

  ;;     +--- (sentinel)
  )

;; +--+ 0x17. whitespaces, newlines
;;    +--- shrink-spaces

(defun my-maybe-insert-space ()
  (and (looking-at "[^])}]")
       (looking-back "[^[({]")
       (insert " ")))

(defun my-shrink-whitespaces ()
  "shrink adjacent whitespaces or newlines in a dwim way"
  (interactive)
  (let ((bol (save-excursion (back-to-indentation)
                             (point)))
        (eol (point-at-eol))
        (bos (save-excursion (skip-chars-backward "\s\t\n")
                             (point)))
        (eos (save-excursion (skip-chars-forward "\s\t\n")
                             (point))))
    (cond ((= bol eol)                  ; blank-line: shrink => join
           (if (< (- (line-number-at-pos eos)
                     (line-number-at-pos bos)) 3)
               (progn
                 (delete-region bos eos)
                 (my-maybe-insert-space))
             (delete-region bos
                            (save-excursion (goto-char eos)
                                            (point-at-bol)))
             (insert "\n")
             (when (char-after)
               (save-excursion (insert "\n")))))
          ((<= (point) bol)             ; bol: fix indentation => join
           (when (= (point)
                    (progn (call-interactively indent-line-function)
                           (point)))
             (delete-region bos (point))
             (my-maybe-insert-space)))
          ((= (point) eol)              ; eol: delete trailing ws => join
           (if (not (= (point) bos))
               (delete-region (point) bos)
             (delete-region (point) eos)
             (my-maybe-insert-space)))
          (t                            ; otherwise: just-one-space
           (just-one-space)))))

;;    +--- next-opened-line

(defun my-next-opened-line ()
  "open line below, and put the cursor there"
  (interactive)
  (end-of-line)
  (newline-and-indent))

;;    +--- open-line-and-indent

(defun my-open-line-and-indent ()
  "open line with indentation"
  (interactive)
  (open-line 1)
  (save-excursion (forward-line)
                  (indent-according-to-mode)))

;;    +--- new-line-between

;; reference | https://github.com/milkypostman/dotemacs

(defun my-new-line-between ()
  (interactive)
  (newline)
  (save-excursion
    (newline)
    (indent-for-tab-command))
  (indent-for-tab-command))

;;    +--- [simple.el] delete-trailing-whitespace on save

(defun my-delete-trailing-whitespace-before-save ()
  (when (not (string= (buffer-string)
                      (progn (delete-trailing-whitespace)
                             (buffer-string))))
    (message "trailing whitespace deleted")
    (sit-for 0.4)))

(add-hook 'before-save-hook 'my-delete-trailing-whitespace-before-save)

;;    +--- [simple.el] shrink indents on kill-line

;; reference | http://www.emacswiki.org/emacs/AutoIndentation

(defadvice kill-line (around shrink-indent activate)
  (if (or (not (eolp)) (bolp))
      ad-do-it
    ad-do-it
    (save-excursion (just-one-space))))

;;    +--- [whitespace.el] visible whitespaces

(defprepare "whitespace"
  (add-hook 'find-file-hook 'whitespace-mode))

(deflazyconfig '(whitespace-mode) "whitespace"

  (setq whitespace-space-regexp "\\(\x3000+\\)")

  (setq whitespace-style
        '(face tabs spaces space-mark tab-mark))

  (setq whitespace-display-mappings
        '((space-mark ?\x3000 [?□])
          (tab-mark ?\t [?\xBB ?\t])))
  )

;;    +--- (electric-align.el) enable electric-align

(defconfig 'electric-align

  (electric-align-global-mode 1)

  ;; disable in comments and strings
  (add-to-list 'electric-align-disable-conditions
               '(let ((syntax-info (syntax-ppss)))
                  (or (nth 3 syntax-info)
                      (nth 4 syntax-info)
                      (member (get-text-property (point) 'face)
                              '(font-lock-comment-face
                                font-lock-comment-delimiter-face)))))
  )

;; +--+ 0x18. manipulate "thing"s
;;    +--- downcase/upcase/capitalize word(s)

(defvar my-up/downcase-count nil)

(defun my-capitalize-word-dwim ()
  (interactive)
  (if (looking-at "[a-z]")
      (capitalize-word 1)
    (capitalize-word -1)))

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

;;    +--- [subword.el] split camelCase words

(defconfig 'subword
  (subword-mode 1))

;;    +--- [simple.el] backward transpose commands

(defun backward-transpose-words ()
  (interactive)
  (transpose-words -1))

(defun backward-transpose-lines ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (end-of-line))

(defun backward-transpose-chars ()
  (interactive)
  (cond ((looking-back "->")
         (delete-char -2)
         (insert "<-"))
        ((looking-back "<-")
         (delete-char -2)
         (insert "->"))
        ((looking-back "<=")
         (delete-char -2)
         (insert ">"))
        ((looking-back ">=")
         (delete-char -2)
         (insert "<"))
        ((looking-back "<")
         (delete-char -1)
         (insert ">="))
        ((looking-back ">")
         (delete-char -1)
         (insert "<="))
        (t
         (transpose-chars -1)
         (forward-char))))

;; +--+ 0x19. expressions, parens
;;    +--- eval-and-replace-sexp

(defun my-eval-and-replace-sexp ()
  "Evaluate the sexp at point and replace it with its value"
  (interactive)
  (let ((value (eval-last-sexp nil)))
    (kill-sexp -1)
    (insert (format "%S" value))))

;;    +--- manipulate Japanese parens

(dolist (pair '((?（ . ?）) (?｛ . ?｝) (?「 . ?」) (?［ . ?］)
                (?【 . ?】) (?〈 . ?〉) (?《 . ?》) (?『 . ?』)))
  (modify-syntax-entry (car pair)
                       (concat "(" (char-to-string (cdr pair))))
  (modify-syntax-entry (cdr pair)
                       (concat ")" (char-to-string (car pair)))))

;;    +--+ [lisp.el] some sexpwise operations
;;       +--- commands

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
     (if (or (not back)
             (and forward (< forward back))) 1 -1))))

(defun my-down-list ()
  (interactive)
  (let* ((back-list (save-excursion
                      (and (search-backward-regexp "\\s)" nil t)
                           (point))))
         (back-list (and back-list (- (point) back-list)))
         (back-str (save-excursion
                     (and (search-backward-regexp "\\s\"" nil t)
                          (point))))
         (back-str (and back-str (- (point) back-str)))
         (for-list (save-excursion
                     (and (search-forward-regexp "\\s(" nil t)
                          (point))))
         (for-list (and for-list (- for-list (point))))
         (for-str (save-excursion
                    (and (search-forward-regexp "\\s\"" nil t)
                         (point))))
         (for-str (and for-str (- for-str (point)))))
    (case (cdar (sort `((,back-list . back-list)
                        (,back-str . back-str)
                        (,for-list . for-list)
                        (,for-str . for-str))
                      (lambda (a b)
                        (when (and (car a) (car b))
                          (< (car a) (car b))))))
      ((back-list) (backward-char back-list))
      ((back-str) (backward-char back-str))
      ((for-list) (forward-char for-list))
      ((for-str) (forward-char for-str)))))

(defun my-yank-sexp ()
  (interactive)
  (save-excursion
    (my-mark-sexp)
    (kill-ring-save (region-beginning) (region-end))))

(defun my-transpose-sexps ()
  (interactive)
  (transpose-sexps -1))

(defun my-up-list ()
  "handy version of up-list for interactive use"
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

(defun my-indent-defun ()
  (interactive)
  (save-excursion
    (mark-defun)
    (indent-region (region-beginning) (region-end))))

(defun my-overwrite-sexp ()
  (interactive)
  (my-mark-sexp)
  (delete-region (region-beginning)
                 (region-end))
  (yank))

;;    +--- [paren.el] enable show-paren-mode

(defconfig 'paren
  (show-paren-mode)
  (setq show-paren-delay 0))

;;    +--- (phi-autopair.el) enable autopair-mode

(defconfig 'phi-autopair
  (phi-autopair-global-mode 1))

;;    +--- (cedit.el) cedit settings

(defprepare "paredit"

  (deflazyconfig
    '(cedit-or-paredit-slurp
      cedit-wrap-brace
      cedit-or-paredit-barf
      cedit-or-paredit-splice-killing-backward
      cedit-or-paredit-raise) "cedit")

  (defpostload "cc-mode"
    (defprepare "cedit"
      (dolist (map (list c-mode-map c++-mode-map
                         objc-mode-map java-mode-map))
        (define-key map (kbd "M-)") 'cedit-or-paredit-slurp)
        (define-key map (kbd "M-{") 'cedit-wrap-brace)
        (define-key map (kbd "M-*") 'cedit-or-paredit-barf)
        (define-key map (kbd "M-U") 'cedit-or-paredit-splice-killing-backward)
        (define-key map (kbd "M-R") 'cedit-or-paredit-raise))))

  (defpostload "promela-mode"
    (define-key promela-mode-map (kbd "M-)") 'cedit-or-paredit-slurp)
    (define-key promela-mode-map (kbd "M-{") 'cedit-wrap-brace)
    (define-key promela-mode-map (kbd "M-*") 'cedit-or-paredit-barf)
    (define-key promela-mode-map (kbd "M-U") 'cedit-or-paredit-splice-killing-backward)
    (define-key promela-mode-map (kbd "M-R") 'cedit-or-paredit-raise))
  )

;;    +--- (hl-paren.el) enable highlight-parentheses

(defconfig 'highlight-parentheses

  (define-globalized-minor-mode global-highlight-parentheses-mode
    highlight-parentheses-mode
    (lambda () (highlight-parentheses-mode 1)))

  (global-highlight-parentheses-mode)
  )

;;    +--+ (paredit.el) paredit settings

(deflazyconfig
  '(my-paredit-kill
    my-paredit-wrap-round
    paredit-newline
    paredit-forward-barf-sexp
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
      (if (nth 3 (syntax-ppss))
          (kill-region (point)
                       (progn (skip-chars-forward "^\"")
                              (point)))
        (kill-region (point)
                     (progn (while (ignore-errors (forward-sexp 1) t))
                            (point)))))

    (defun my-paredit-wrap-round ()
      (interactive)
      (unless (<= (point)
                  (save-excursion
                    (forward-sexp)
                    (search-backward-regexp "\\_<\\|\\s(\\|\\s\"")
                    (point)))
        (search-backward-regexp "\\_<\\|\\s(\\|\\s\""))
      (paredit-wrap-round)
      (when (and (member major-mode
                         '(lisp-mode emacs-lisp-mode scheme-mode
                                     lisp-interaction-mode))
                 (not (member (char-after) '(?\) ?\s ?\t ?\n))))
        (save-excursion (insert " "))))
    )

;;    +--- (rainbow-delimiters.el) enable rainbow-delimiters

(deflazyconfig
  '(rainbow-delimiters-mode) "rainbow-delimiters")

(defprepare "rainbow-delimiters"
  (defpostload "lisp-mode"
    (add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
    (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
    (add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode))
  (defpostload "scheme"
    (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)))

;; +--+ 0x1a. abbrevs, snippets
;;    +--- smartchr-like commands

(defun my-smart-comma ()
  "insert comma followed by a space."
  (interactive)
  (cond ((not (eq last-command 'my-smart-comma))
         (insert ", "))
        ((= (char-before) ?\s)
         (delete-char -1))
        (t
         (insert " "))))

;;    +--- [dabbrev.el] dabbrev followed by a space

(defun my-dabbrev-expand ()
  "expand dabbrev and insert SPC"
  (interactive)
  (when (eq this-command last-command)
    (delete-char -1))
  (dabbrev-expand nil)
  (unless (looking-back " ") (insert " ")))

;;    +--+ (key-combo.el) smartchr-like commands
;;       +--- (prelude)

(defpostload "key-combo"

  ;;     +--- smart-unary commands

  (defun my-generate-smart-unary-command (name str)
    (eval
     `(defun ,(intern (concat "my-smart-" name)) ()
        (interactive)
        (if (looking-back "[])a-zA-Z0-9_] *")
            (let ((back (unless (looking-back " ") " "))
                  (forward (unless (looking-at " ") " ")))
              (insert (concat back ,str forward)))
          (insert ,str)))))

  (my-generate-smart-unary-command "plus" "+")
  (my-generate-smart-unary-command "minus" "-")

  ;;     +--+ smartchr for C-like languages
  ;;        +--- common settings

  (defun my-c-smart-braces ()
    "smart insertion of braces for C-like laguages"
    (interactive)
    (cond ((use-region-p)               ; wrap with {}
           (let* ((beg (region-beginning))
                  (end (region-end))
                  (one-liner (= (line-number-at-pos beg)
                                (line-number-at-pos end))))
             (deactivate-mark)
             (goto-char beg)
             (insert (if one-liner "{ " "{\n"))
             (goto-char (+ 2 end))
             (insert (if one-liner " }" "\n}"))
             (indent-region beg (point))))
          ((looking-back "\s")          ; insert {`!!'}
           (insert "{  }")
           (backward-char 2))
          (t                            ; insert {\n`!!'\n}
           (unless (= (point)
                      (save-excursion (back-to-indentation) (point)))
             (insert "\n"))
           (indent-region (point) (progn (insert "{\n\n}") (point)))
           (forward-line -1)
           (indent-according-to-mode))))

  (defun my-install-c-common-smartchr ()
    ;; add / sub / mul / div
    (key-combo-define-local (kbd "+") '(my-smart-plus "++"))
    (key-combo-define-local (kbd "+=") " += ")
    ;; vv conflict with electric-case vv
    (key-combo-define-local (kbd "-") '(my-smart-minus "--"))
    ;; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
    (key-combo-define-local (kbd "/*") "/* `!!' */")
    (key-combo-define-local (kbd "{") '(my-c-smart-braces "{ `!!' }")))

  (defpostload "cc-mode"
    (add-hook 'c-mode-common-hook 'my-install-c-common-smartchr))

  (defpostload "promela-mode"
    (add-hook 'promela-mode-hook 'my-install-c-common-smartchr))

  ;;        +--- C settings

  (defun my-c-smart-angles ()
    (interactive)
    (if (looking-back "#include *")
        (progn
          (insert "<>")
          (backward-char 1))
      (let ((back (unless (looking-back " ") " "))
            (forward (unless (looking-at " ") " ")))
        (insert (concat back "<" forward)))))

  (defun my-c-generate-smart-pointer-command (name str)
    (eval
     `(defun ,(intern (concat "my-c-smart-" name)) ()
        (interactive)
        (if (or (not (looking-back "[0-9a-zA-Z_)] *"))
                ;; declaration
                (and (looking-back "\\_<\\([a-z_]*\\)\\_> *")
                     (eq 'font-lock-type-face
                         (get-text-property (match-beginning 1) 'face)))
                ;; cast
                (and (looking-back "([][)(,*a-z_ ]*) *")
                     (save-excursion
                       (condition-case nil
                           (let ((beg (match-beginning 0)))
                             (while (and (search-backward-regexp "[a-z_]+" beg)
                                         (not (text-property-not-all
                                               (match-beginning 0) (match-end 0)
                                               'face 'font-lock-type-face)))))
                         (error t)))))
            (insert ,str)
          (let ((back (unless (looking-back " ") " "))
                (forward (unless (looking-at " ") " ")))
            (insert (concat back ,str forward)))))))

  (my-c-generate-smart-pointer-command "star" "*")
  (my-c-generate-smart-pointer-command "and" "&")

  (defun my-install-c-smartchr ()
    ;; pointers
    (key-combo-define-local (kbd "&") '(my-c-smart-and " && "))
    (key-combo-define-local (kbd "*") '(my-c-smart-star))
    (key-combo-define-local (kbd "->") "->")
    ;; include
    (key-combo-define-local (kbd "<") '(my-c-smart-angles " << "))
    ;; triary operation
    (key-combo-define-local (kbd "?") '( " ? `!!' : " "?")))

  (defpostload "cc-mode"
    (add-hook 'c-mode-hook 'my-install-c-smartchr))

  ;;        +--- Java settings

  (defun my-install-java-smartchr ()
    ;; javadoc comment
    (key-combo-define-local (kbd "/**") "/**\n`!!'\n*/")
    ;; one-liner comment
    (key-combo-define-local (kbd "/") '(" / " "//"))
    ;; ad-hoc polymorphism
    (key-combo-define-local (kbd "<") '(" < " "<" " << "))
    (key-combo-define-local (kbd ">") '(" > " ">" " >> ")))

  (defpostload "cc-mode"
    (add-hook 'java-mode-hook 'my-install-java-smartchr))

  ;;        +--- promela settings

  (defun my-promela-smart-colons ()
    "insert two colons followed by a space, and reindent"
    (interactive)
    (insert (concat "::"
                    (if (looking-at " ") "" " ")))
    (save-excursion (promela-indent-line)))

  (defun my-install-promela-smartchr ()
    ;; guards
    (key-combo-define-local (kbd "->") " -> ")
    (key-combo-define-local (kbd ":") '(":" my-promela-smart-colons))
    ;; LTL
    (key-combo-define-local (kbd "<>") "<>")
    (key-combo-define-local (kbd "[]") "[]")
    ;; does not work ...
    ;; (key-combo-define-local (kbd "do") "do\n`!!'\nod")
    ;; (key-combo-define-local (kbd "if") "if\n`!!'\nfi")
    )

  (defpostload "promela-mode"
    (add-hook 'promela-mode-hook 'my-install-promela-smartchr))

  ;;     +--+ smartchr for lispy languages
  ;;        +--- common settings

  (defun my-lisp-smart-point ()
    (interactive)
    (if (looking-back "[0-9]")
        (insert ".")
      (let ((back (unless (looking-back " ") " "))
            (forward (unless (looking-at " ") " ")))
        (insert (concat back "." forward)))))

  (defun my-install-lisp-common-smartchr ()
    (key-combo-define-local (kbd ".") '(my-lisp-smart-point))
    (key-combo-define-local (kbd ";") ";; ")
    (key-combo-define-local (kbd "=") '("=" "equal" "eq")))

  (defpostload "lisp-mode"
    (add-hook 'lisp-mode-hook 'my-install-lisp-common-smartchr)
    (add-hook 'emacs-lisp-mode-hook 'my-install-lisp-common-smartchr)
    (add-hook 'lisp-interaction-mode-hook 'my-install-lisp-common-smartchr))

  (defpostload "scheme"
    (add-hook 'scheme-mode-hook 'my-install-lisp-common-smartchr))

  ;;        +--- emacs-lisp settings

  (defun my-install-elisp-smartchr ()
    (key-combo-define-local (kbd "#") '("#" ";;;###autoload")))

  (defpostload "lisp-mode"
    (add-hook 'emacs-lisp-mode-hook 'my-install-elisp-smartchr))

  ;;     +--- smartchr for html

  (defun my-html-sp-or-smart-lt ()
    "smart insertion of brackets for sgml languages"
    (interactive)
    (if (use-region-p)
        (let ((beg (region-beginning)) ; wrap with <>
              (end (region-end)))
          (deactivate-mark)
          (save-excursion
            (goto-char beg)
            (insert "<")
            (goto-char (+ 1 end))
            (insert ">")))
      (insert "<>")                     ; insert <`!!'>
      (backward-char)))

  (defun my-install-html-smartchr ()
    (key-combo-define-local (kbd "<") '(my-html-sp-or-smart-lt "&lt;" "<"))
    (key-combo-define-local (kbd "<!") "<!-- `!!' -->")
    (key-combo-define-local (kbd ">") '("&gt;" ">"))
    (key-combo-define-local (kbd "&") '("&amp;" "&")))

  (defpostload "sgml-mode"
    (add-hook 'html-mode-hook 'my-install-html-smartchr))

  ;;     +--- smartchr for haskell

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
    (key-combo-define-local (kbd ">") '(" > " " >> " " >>> "))
    (key-combo-define-local (kbd "<=") " <= ")
    (key-combo-define-local (kbd ">=") " >= ")
    ;; operation
    (key-combo-define-local (kbd "+") '(my-smart-plus " ++ " " +++ "))
    (key-combo-define-local (kbd "-") '(my-smart-minus))
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
    (key-combo-define-local (kbd "=<") " =< ") ; necessary to make =<< work
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

  (defpostload "haskell-mode"
    (add-hook 'haskell-mode-hook 'my-install-haskell-smartchr)
    (add-hook 'literate-haskell-mode-hook 'my-install-haskell-smartchr))

  ;;     +--- smartchr for coq

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

  (defun my-install-coq-smartchr ()
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
    (key-combo-define-local (kbd "+") '(my-smart-plus))
    (key-combo-define-local (kbd "-") '(my-smart-minus))
    (key-combo-define-local (kbd "*") " * ")
    (key-combo-define-local (kbd "/") " / "))

  (defpostload "coq"
    (add-hook 'coq-mode-hook 'my-install-coq-smartchr))

  ;;     +--+ smartchr for prolog-like languages
  ;;        +--- common settings

  (defun my-prolog-smart-pipes ()
    "insert pipe surrounded by spaces"
    (interactive)
    (if (looking-back "\\[")
        (insert "| ")
      (insert (concat (unless (looking-back " ") " ")
                      "|"
                      (unless (looking-at " ") " ")))))

  (defun my-install-prolog-common-smartchr ()
    ;; comments, periods
    (key-combo-define-local (kbd "%") '("% " "%% "))
    ;; toplevel
    (key-combo-define-local (kbd ":-") " :- ")
    (key-combo-define-local (kbd "|") '(my-prolog-smart-pipes))
    ;; arithmetic
    (key-combo-define-local (kbd "+") '(my-smart-plus))
    (key-combo-define-local (kbd "-") '(my-smart-minus))
    (key-combo-define-local (kbd "*") " * ")
    (key-combo-define-local (kbd "/") " / "))

  (defpostload "lmntal-mode"
    (add-hook 'lmntal-mode-hook 'my-install-prolog-common-smartchr))
  (defpostload "prolog"
    (add-hook 'prolog-mode-hook 'my-install-prolog-common-smartchr))

  ;;        +--- LMNtal settings

  (defun my-lmntal-smart-thrashes ()
    (interactive)
    (if (looking-back "}")
        (insert "/")
      (insert (concat (unless (looking-back " ") " ")
                      "/"
                      (unless (looking-at " ") " ")))))

  (defun my-install-lmntal-smartchr ()
    ;; comments, periods
    (key-combo-define-local (kbd "//") "// ")
    ;; (key-combo-define-local (kbd "/*") "/*\n`!!'\n*/")
    ;; eq neq
    (key-combo-define-local (kbd "=") " = ")
    (key-combo-define-local (kbd "!=") " \\= ")
    (key-combo-define-local (kbd "\\=") " \\= ")
    ;; cmpint
    (key-combo-define-local (kbd "=:=") " =:= ")
    (key-combo-define-local (kbd "==") " =:= ")
    (key-combo-define-local (kbd "=\\=") " =\\= ")
    (key-combo-define-local (kbd "!==") " =\\= ")
    (key-combo-define-local (kbd "<") " < ")
    (key-combo-define-local (kbd ">") " > ")
    (key-combo-define-local (kbd "=<") " =< ")
    (key-combo-define-local (kbd "<=") " =< ")
    (key-combo-define-local (kbd ">=") " >= ")
    ;; cmpfloat
    (key-combo-define-local (kbd "=:=.") " =:=. ")
    (key-combo-define-local (kbd "==.") " =:=. ")
    (key-combo-define-local (kbd "=\\=.") " =\\=. ")
    (key-combo-define-local (kbd "!==.") " =\\=. ")
    (key-combo-define-local (kbd "<.") " <. ")
    (key-combo-define-local (kbd ">.") " >. ")
    (key-combo-define-local (kbd "=<.") " =<. ")
    (key-combo-define-local (kbd "<=.") " =<. ")
    (key-combo-define-local (kbd ">=.") " >=. "))

  (defpostload "lmntal-mode"
    (add-hook 'lmntal-mode-hook 'my-install-lmntal-smartchr))

  ;;     +--- (sentinel)
  )

;;    +--+ (auto-complete.el) (ac-c-headers.el) auto-complete settings
;;       +--- (prelude)

(defconfig 'auto-complete

  ;;     +--- enable auto-complete

  (global-auto-complete-mode 1)

  (setq ac-modes
        (append '(ahk-mode haskell-mode literate-haskell-mode
                           prolog-mode scala-mode dos-mode
                           promela-mode hydla-mode lmntal-mode
                           coq-mode)
                ac-modes))

  ;;     +--- auto-complete dictionary

  (add-to-list 'ac-dictionary-directories my:dictionary-directory)
  (setq ac-comphist-file my:ac-history-file)

  ;;     +--+ auto-complete sources
  ;;        +--- default

  (setq-default ac-sources
                '(ac-source-dictionary
                  ac-source-words-in-same-mode-buffers))

  ;;        +--- c/c++

  (defpostload "cc-mode"
    (defconfig 'ac-c-headers

      (defun my-ac-c-sources ()
        (setq ac-sources '(ac-source-c-headers
                           ac-source-words-in-same-mode-buffers
                           ac-source-dictionary
                           ac-source-c-header-symbols)))

      (add-hook 'c-mode-hook 'my-ac-c-sources)
      (add-hook 'c++-mode-hook 'my-ac-c-sources)
      ))

  ;;        +--- elisp

  (defpostload "lisp-mode"

    ;; ac-source-symbols is very nice but buggy
    (defun my-ac-elisp-sources ()
      (setq ac-sources '(ac-source-filename
                         ac-source-words-in-same-mode-buffers
                         ac-source-dictionary
                         ac-source-functions
                         ac-source-variables
                         ac-source-features)))

    (add-hook 'emacs-lisp-mode-hook 'my-ac-elisp-sources)
    (add-hook 'lisp-interaction-mode-hook 'my-ac-elisp-sources)
    )

  ;;        +--- eshell

  (defvar my-ac-eshell-sources
    '(ac-source-files-in-current-dir
      ac-source-words-in-same-mode-buffers))

  (defun my-ac-eshell-sources ()
    (setq ac-sources my-ac-eshell-sources))

  (defpostload "eshell"
    (add-hook 'eshell-mode-hook 'my-ac-eshell-sources))

  ;;     +--- minor adjustments

  (setq ac-auto-start     t
        ac-dwim           t
        ac-delay          0
        ac-auto-show-menu 0.8
        ac-disable-faces  nil)

  (define-key ac-completing-map (kbd "S-<tab>") 'ac-previous)

  ;;     +--- (sentinel)
  )

;;    +--+ (yasnippet.el) yasnippet settings
;;       +--- load yasnippet in idle-time

(defprepare "yasnippet"
  (idle-require 'yasnippet))

;;       +--- (prelude)

(deflazyconfig '(yas-expand) "yasnippet"

  ;;   +--- snippets directory

  (setq yas-snippet-dirs (list my:snippets-directory))

  ;;   +--- enable yasnippet

  (yas-global-mode 1)
  (yas-reload-all)

  ;;   +--- allow nested snippets

  (setq yas-triggers-in-field t)

  ;;   +--- use dabbrev as fallback

  (setq yas-fallback-behavior '(apply my-dabbrev-expand . nil))

  ;;   +--- use ido-prompt

  (defprepare "ido"
    (custom-set-variables '(yas-prompt-functions '(yas-ido-prompt))))

  ;;   +--- fix fallback behavior

  ;; let fallback-behavior be return-nil while expanding snippets

  (add-hook 'yas-before-expand-snippet-hook
            (lambda()
              (setq yas-fallback-behavior 'return-nil)))

  (add-hook 'yas-after-exit-snippet-hook
            (lambda()
              (setq yas-fallback-behavior '(apply my-dabbrev-expand . nil))))

  ;;   +--- commands

  ;; reference | https://github.com/magnars/.emacs.d/

  (defun my-yas/goto-end-of-active-field ()
    (interactive)
    (let* ((snippet (car (yas--snippets-at-point)))
           (position (yas--field-end (yas--snippet-active-field snippet))))
      (if (= (point) position)
          (move-end-of-line 1)
        (goto-char position))))

  (defun my-yas/goto-start-of-active-field ()
    (interactive)
    (let* ((snippet (car (yas--snippets-at-point)))
           (position (yas--field-start (yas--snippet-active-field snippet))))
      (if (= (point) position)
          (move-beginning-of-line 1)
        (goto-char position))))

  ;;   +--- keybinds

  (define-key yas-minor-mode-map (kbd "TAB") nil)   ; auto-complete
  (define-key yas-minor-mode-map (kbd "<tab>") nil) ; auto-complete

  (define-key yas-keymap (kbd "TAB") nil)   ; auto-complete
  (define-key yas-keymap (kbd "<tab>") nil) ; auto-complete

  (define-key yas-keymap (kbd "<oem-pa1>") 'yas-next-field-or-maybe-expand)
  (define-key yas-keymap (kbd "<muhenkan>") 'yas-next-field-or-maybe-expand)
  (define-key yas-keymap (kbd "<nonconvert>") 'yas-next-field-or-maybe-expand)

  (define-key yas-keymap (kbd "C-j") 'my-yas/goto-start-of-active-field)
  (define-key yas-keymap (kbd "C-e") 'my-yas/goto-end-of-active-field)

  ;;   +--- (sentinel)
  )

;;    +--- (zencoding.el) enable zencoding in sgml-mode

(deflazyconfig '(zencoding-mode) "zencoding"

  (setq zencoding-indent 2)
  (define-key zencoding-mode-keymap (kbd "C-j") nil)
  (define-key zencoding-mode-keymap (kbd "<C-return>") nil)

  ;; override yasnippet triggers
  (define-key zencoding-mode-keymap (kbd "<oem-pa1>") 'zencoding-expand-line)
  (define-key zencoding-mode-keymap (kbd "<muhenkan>") 'zencoding-expand-line)
  (define-key zencoding-mode-keymap (kbd "<nonconvert>") 'zencoding-expand-line)
  )

(defprepare "zencoding"
  (defpostload "sgml-mode"
    (add-hook 'sgml-mode-hook 'zencoding-mode)))

;; +--+ 0x1b. programming modes
;;    +--+ [cc-mode.el] cc-mode settings
;;       +--- (prelude)

(defpostload "cc-mode"

  ;;     +--+ coding style for C
  ;;        +--- (prelude)

  ;; reference | http://www.cozmixng.org/webdav/kensuke/site-lisp/mode/my-c.el

  (defconst my-c-style
    '(
      ;;    +--- offset

      (c-basic-offset . 4)
      (c-comment-only-line-offset . 0)

      ;;    +--- block comment line prefix

      ;; /*
      ;;  *    <- BLOCK-COMMENT-PREFIX
      ;;  */

      (c-block-comment-prefix . "* ")

      ;;    +--- echo syntactic information

      (c-echo-syntactic-information-p . t)

      ;;    +--- indenet with "TAB"

      (c-tab-always-indent . t)

      ;;    +--- electrric newline criteria for ";" and ","

      (c-hanging-semi&comma-criteria
       . (
          ;; for(i=0; i<N; i++){}    <- DO NOT HANG THESE SEMIs
          c-semi&comma-inside-parenlist

          ;; inline int method(){ foo(); bar(); }    <- DO NOT HANG THESE SEMIs
          c-semi&comma-no-newlines-for-oneline-inliners
          ))

      ;;    +--+ electric newline around "{" and "}"
      ;;       +--- (prelude)

      (c-hanging-braces-alist
       . (
          ;;   +--- function symbols

          ;; int fun()
          ;; {    <- DEFUN-OPEN
          ;;     ...
          ;; }    <- DEFUN-CLOSE

          (defun-open before after) (defun-close before after)

          ;;   +--- class related symbols

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

          ;;   +--- conditional construct symbols

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

          ;;   +--- switch statement symbols

          ;; switch(var)
          ;; {
          ;;   case 1:
          ;;     {    <- STATEMENT-CASE-OPEN
          ;;      ...
          ;;     }
          ;;   ...
          ;; }

          (statement-case-open before after) ; case label

          ;;   +--- brace list symbols

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

          ;;   +--- external scope symbols

          ;; extern "C"
          ;; {    <- EXTERN-LANG-OPEN
          ;;     ...
          ;; }    <- EXTERN-LANG-CLOSE

          (extern-lang-open before after) (extern-lang-close before after)
          (namespace-open) (namespace-close)     ; disable
          (module-open) (module-close)           ; disable
          (composition-open) (composition-close) ; disable

          ;;   +--- java symbols

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

          ;;   +--- (sentinel)
          ))

      ;;    +--+ electric newline around ":"
      ;;       +--- (prelude)

      (c-hanging-colons-alist
       . (
          ;;   +--- switch statement symbols

          ;; switch(var)
          ;;   {
          ;;   case 1:    <- CASE-LABEL
          ;;     ...
          ;;   default:
          ;;     ...
          ;;   }

          (case-label after)

          ;;   +--- literal symbols

          ;; int fun()
          ;; {
          ;;     ...
          ;;
          ;;   label:    <- LABEL
          ;;     ...
          ;; }

          (label after)

          ;;   +--- class related symbols

          ;; class Class : public ClassA, ClassB    <- INHER-INTRO
          ;; {
          ;;   public:    <- ACCESS-LABEL
          ;;     Class() : m1(0), m2(1)    <- MEMBER-INIT-INTRO
          ;;     ...
          ;; }

          (inher-intro)                 ; disable
          (member-init-intro)           ; disable
          (access-label after)

          ;;   +--- (sentinel)
          ))

      ;;    +--+ offsets
      ;;       +--- (prelude)

      (c-offsets-alist
       . (
          ;;   +--- function symbols

          ;; int    <- TOPMOST-INTRO
          ;; main()    <- TOPMOST-INTRO-CONT
          ;; {    <- DEFUN-OPEN
          ;;     a = 1 + 2    <- DEFUN-BLOCK-INTRO  --+
          ;;           - 3;    <- STATEMENT-CONT      +-- STATEMENT
          ;;     ...                                --+
          ;; }    <- DEFUN-CLOSE

          (topmost-intro . 0) (topmost-intro-cont . c-lineup-topmost-intro-cont)
          (defun-open . 0) (defun-block-intro . +) (defun-close . 0)
          (statement . 0) (statement-cont . c-lineup-math)

          ;;   +--- class related symbols

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

          ;;   +--- conditional construct symbols

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

          ;;   +--- switch statement symbols

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

          ;;   +--- brace list symbols

          ;; struct pairs[] =
          ;; {    <- BRACE-LIST-OPEN
          ;;     { 1, 2 },    <- BRACE-LIST-INTRO  --+
          ;;     {    <- BRACE-ENTRY-OPEN            +-- BRACE-LIST-ENTRY
          ;;       3, 4                              |
          ;;     }    <- BRACE-LIST-CLOSE          --+
          ;; }    <- BRACE-LIST-CLOSE

          (brace-list-open . 0) (brace-list-intro . +) (brace-list-close . 0)
          (brace-list-entry . 0) (brace-entry-open . 0)

          ;;   +--- external scope symbols

          ;; extern "C"
          ;; {    <- EXTERN-LANG-OPEN
          ;;     ...    <- INEXTERN-LANG
          ;; }    <- EXTERN-LANG-CLOSE

          (extern-lang-open . 0) (inextern-lang . +) (extern-lang-close . 0)
          (composition-open . 0) (incomposition . +) (composition-close . 0)
          (namespace-open . 0) (innamespace . +) (namespace-close . 0)
          (module-open . 0) (inmodule . +) (module-close . 0)

          ;;   +--- paren list symbols

          ;; function1(
          ;;     a,    <- ARGLIST-INTRO
          ;;     b     <- ARGLIST-CONT
          ;;     );    <- ARGLIST-CLOSE

          ;; function2( a,
          ;;            b );    <- ARGLIST-CONT-NONEMPTY

          (arglist-intro . +) (arglist-close . 0)
          (arglist-cont c-lineup-gcc-asm-reg 0)
          (arglist-cont-nonempty c-lineup-gcc-asm-reg c-lineup-arglist)

          ;;   +--- literal symbols

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

          ;;   +--- multiline macro symbols

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

          ;;   +--- objective-c method symbols

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

          ;;   +--- java symbols

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

          ;;   +--- statement block symbols

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

          ;;   +--- K&R symbols

          ;; int fun(a, b, c)
          ;;   int a;    <- KNR-ARGDECL-INTRO
          ;;   int b;  --+-- KNR-ARGDECL
          ;;   int c;  --+
          ;; {
          ;;     ...
          ;; }

          (knr-argdecl-intro . *) (knr-argdecl . 0)

          ;;   +--- (sentinel)
          ))

      ;;    +--- clean ups

      (c-cleanup-list
       . (
          brace-catch-brace               ; } <-catch <-{
          empty-defun-braces              ; fun(){ <-}
          defun-close-semi                ; } <-;
          list-close-comma                ; } <-,
          scope-operator                  ; : <-:
          one-liner-defun                 ; fun() <-{ <-stmt; <-}
          ))

      ;;    +--- (sentinel)
      ))

  ;;        +--- entry my style

  (c-add-style "phi" my-c-style)

  ;;     +--- coding style diff for java

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

  ;;     +--- keybinds

  (dolist (map (list c-mode-map c++-mode-map
                     objc-mode-map java-mode-map))
    (define-key map (kbd ",") nil)
    (define-key map (kbd "C-d") nil)
    (define-key map (kbd "C-M-a") nil)
    (define-key map (kbd "C-M-e") nil)
    (define-key map (kbd "M-e") nil)
    (define-key map (kbd "M-j") nil)
    (define-key map (kbd "C-M-h") nil)
    (define-key map (kbd "C-M-j") nil)
    (define-key map (kbd "DEL") nil)
    (define-key map (kbd "C-c C-g") 'c-guess))

  ;;     +--- settings

  (defun my-c-mode-common-hook ()
    (setq c-auto-newline t)
    (c-set-style "phi"))

  (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
  (add-hook 'java-mode-hook 'my-java-style-init)

  ;;     +--- (sentinel)
  )

;;    +--- [lisp-mode.el] lisp-mode settings

(add-to-list 'auto-mode-alist
             '("\\.cl$" . common-lisp-mode))

(defpostload "lisp-mode"
  (dolist (map (list lisp-mode-map
                     emacs-lisp-mode-map
                     lisp-interaction-mode-map))
    (define-key map (kbd "M-TAB") nil)
    (define-key map (kbd "C-j") nil)))

;;    +--- [sgml-mode.el] sgml-mode settings

(defpostload "sgml-mode"

  ;; some libraries crash because of abnormal
  ;; "mode-name" format of sgml-mode
  (defun my-sgml-mode-name-fix ()
    (when (listp mode-name)
      (setq mode-name (caddr mode-name))))

  (add-hook 'sgml-mode-hook 'my-sgml-mode-name-fix)
  )

;;    +--- [tex-mode.el] tex-mode settings

(defpostload "tex-mode"
  (add-hook 'latex-mode-hook 'auto-fill-mode)
  (define-key latex-mode-map (kbd "C-j") nil)
  (define-key latex-mode-map (kbd "C-M-i") nil))

;;    +--- [prolog-mode.el] prolog-mode settings

(defprepare "prolog"
  (add-to-list 'auto-mode-alist '("\\.swi$" . prolog-mode)))

(deflazyconfig '(prolog-mode) "prolog"
  (define-key prolog-mode-map (kbd "C-c C-c") 'inferior-prolog-load-file)
  (defpostload "popwin"
    (add-to-list 'popwin:special-display-config '("*prolog*"))))

;;    +--- (ahk-mode.el) ahk-mode settings

(defprepare "ahk-mode"
  (add-to-list 'auto-mode-alist
               '("\\.ahk$" . ahk-mode)))

(deflazyconfig '(ahk-mode) "ahk-mode"
  ;; ahk-mode-map must be set by hooks ?
  (defun my-ahk-mode-hook ()
    (define-key ahk-mode-map (kbd "C-j") nil)
    (define-key ahk-mode-map (kbd "C-h") nil))
  (add-hook 'ahk-mode-hook 'my-ahk-mode-hook))

;;    +--- (dos-mode.el) dos-mode settings

(defprepare "dos-mode"
  (add-to-list  'auto-mode-alist
                '("\\.bat$" . dos-mode)))

(deflazyconfig '(dos-mode) "dos-mode")

;;    +--- (haskell-mode.el) haskell-mode settings

(defprepare "haskell-mode"
  (add-to-list 'auto-mode-alist
               '("\\.hs$" . haskell-mode))
  (add-to-list 'auto-mode-alist
               '("\\.lhs$" . literate-haskell-mode)))

(deflazyconfig
  '(haskell-mode literate-haskell-mode) "haskell-mode"

  ;; FOR INSTALLATION :
  ;; (let ((generated-autoload-file
  ;;        "../site-lisp/plugins/haskell-mode/haskell-mode-autoloads.el"))
  ;;   (update-directory-autoloads "../site-lisp/plugins/haskell-mode/"))
  (require 'haskell-mode-autoloads)

  (defun my-haskell-mode-hook ()
    (turn-on-haskell-indent)
    (turn-on-haskell-doc-mode))

  (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
  )

;;    +--- (hydla-mode.el) hydla-mode settings

(defprepare "hydla-mode"
  (add-to-list 'auto-mode-alist
               '("\\.hydla$" . hydla-mode)))

(deflazyconfig '(hydla-mode) "hydla-mode")

;;    +--- (lmntal-mode.el) lmntal-mode settings

(defprepare "lmntal-mode"
  (add-to-list 'auto-mode-alist
               '("\\.lmn$" . lmntal-mode)))

(deflazyconfig '(lmntal-mode) "lmntal-mode"
  (setq lmntal-lmntal-directory "~/Work/LMNtal/LaViT2_6_2/lmntal/"
        lmntal-unyo-directory "~/Work/LMNtal/LaViT2_6_2/lmntal/unyo1_1_1/")
  (defconfig 'lmntal-hlground))

;;    +--- (promela-mode.el) promela-mode settings

(deflazyconfig '(promela-mode) "promela-mode"

  (setq promela-selection-indent 0
        promela-block-indent 4)

  (set-face-attribute 'promela-fl-send-poll-face nil
                      :foreground 'unspecified
                      :background 'unspecified
                      :inverse-video 'unspecified
                      :bold t)

  (defun my-promela-electric-semi ()
    (interactive)
    (insert ";")
    (unless (string-match "}"
                          (buffer-substring (point) (point-at-eol)))
      (promela-indent-newline-indent)))

  (define-key promela-mode-map (kbd ";") 'my-promela-electric-semi)
  (define-key promela-mode-map (kbd "C-m") 'promela-indent-newline-indent)
  )

(defprepare "promela-mode"
  (add-to-list 'auto-mode-alist '("\\.pml$" . promela-mode)))

;;    +--- (scala-mode.el) scala-mode settings

(defprepare "scala-mode"
  (add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode)))

(deflazyconfig '(scala-mode) "scala-mode")


;;    +--- (proof-general) coq-mode settings

(defprepare "proof-site"
  (add-to-list 'auto-mode-alist '("\\.v$" . coq-mode)))

(deflazyconfig '(coq-mode) "proof-site"

  (setq proof-shrink-windows-tofit       t
        proof-splash-enable              nil
        proof-electric-terminator-enable t
        proof-keep-response-history      t)

  (defadvice proof-electric-terminator (before reindent-terminator activate)
    (open-line 1)
    (indent-for-tab-command))

  (defun my-proof-process-buffer ()
    (interactive)
    (goto-char (point-max))
    (proof-goto-point))
  )

(defpostload "coq"

  (define-key coq-mode-map (kbd "C-m") 'reindent-then-newline-and-indent)
  (define-key coq-mode-map (kbd "C-c C-c") 'proof-interrupt-process)
  (define-key coq-mode-map (kbd "C-c C-n") 'proof-assert-next-command-interactive)
  (define-key coq-mode-map (kbd "C-c C-p") 'proof-undo-last-successful-command)
  (define-key coq-mode-map (kbd "C-c C-u") 'proof-retract-buffer)
  (define-key coq-mode-map (kbd "C-c C-v") 'my-proof-process-buffer)
  (define-key coq-mode-map (kbd "C-c C-e") 'proof-goto-end-of-locked)
  (define-key coq-mode-map (kbd "C-c C-<return>") 'proof-goto-point)

  (define-key coq-mode-map (kbd "M-a") nil) ; backward-command
  (define-key coq-mode-map (kbd "M-e") nil) ; forward-command
  (define-key coq-mode-map (kbd "M-n") nil) ; next-matching-input
  (define-key coq-mode-map (kbd "M-p") nil) ; previous-matching-input
  )

;; +--+ 0x1c. other modes
;;    +--+ [artist.el] more commands for artist-mode
;;       +--- (prelude)

;; reference | http://d.hatena.ne.jp/tamura70/20100125/ditaa

(defpostload "artist"

  ;;     +--- line-draw commands

  (defun picture-line-draw-str (h v str)
    (cond ((/= h 0) (cond ((string= str "|") "+") ((string= str "+") "+") (t "-")))
          ((/= v 0) (cond ((string= str "-") "+") ((string= str "+") "+") (t "|")))
          (t str)))

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

  ;;     +--- line-delete commands

  (defun picture-line-delete-str (h v str)
    (cond ((/= h 0) (cond ((string= str "|") "|") ((string= str "+") "|") (t " ")))
          ((/= v 0) (cond ((string= str "-") "-") ((string= str "+") "-") (t " ")))
          (t str)))

  (defun picture-line-delete-right (n)
    (interactive "p") (picture-line-draw n 0 1 t))

  (defun picture-line-delete-left (n)
    (interactive "p") (picture-line-draw n 0 -1 t))

  (defun picture-line-delete-up (n)
    (interactive "p") (picture-line-draw n -1 0 t))

  (defun picture-line-delete-down (n)
    (interactive "p") (picture-line-draw n 1 0 t))

  ;;     +--- region-move commands

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

  ;;     +--- rectangle copy command

  (defun my-picture-copy-rectangle (start end)
    (interactive "r")
    (setq picture-killed-rectangle (extract-rectangle start end)))

  ;;     +--- keymap

  (define-key artist-mode-map (kbd "<right>") 'picture-line-draw-right)
  (define-key artist-mode-map (kbd "<left>") 'picture-line-draw-left)
  (define-key artist-mode-map (kbd "<up>") 'picture-line-draw-up)
  (define-key artist-mode-map (kbd "<down>") 'picture-line-draw-down)

  (define-key artist-mode-map (kbd "C-<right>") 'picture-line-delete-right)
  (define-key artist-mode-map (kbd "C-<left>")  'picture-line-delete-left)
  (define-key artist-mode-map (kbd "C-<up>") 'picture-line-delete-up)
  (define-key artist-mode-map (kbd "C-<down>") 'picture-line-delete-down)

  (define-key artist-mode-map (kbd "M-<right>") 'picture-region-move-right)
  (define-key artist-mode-map (kbd "M-<left>")  'picture-region-move-left)
  (define-key artist-mode-map (kbd "M-<up>")    'picture-region-move-up)
  (define-key artist-mode-map (kbd "M-<down>")  'picture-region-move-down)

  (define-key artist-mode-map (kbd "C-r") 'picture-draw-rectangle)
  (define-key artist-mode-map (kbd "C-w") 'picture-clear-rectangle)
  (define-key artist-mode-map (kbd "C-M-w") 'my-picture-copy-rectangle)
  (define-key artist-mode-map (kbd "C-y") 'picture-yank-rectangle)

  (define-key artist-mode-map (kbd ">") 'picture-self-insert)
  (define-key artist-mode-map (kbd "<") 'picture-self-insert)

  ;;     +--- (sentinel)
  )

;;    +--+ [dired.el] (idired.el) dired settings
;;       +--- (prelude)

(deflazyconfig '(my-dired-default-directory) "dired"

  ;;     +--- command

  (defun my-dired-default-directory ()
    (interactive)
    (dired default-directory))

  ;;     +--- settings

  (setq dired-dwim-target          t
        dired-auto-revert-buffer   t
        dired-recursive-copies     'always
        dired-recursive-deletes    'top
        dired-keep-marker-copy     nil
        dired-keep-marker-symlink  nil
        dired-keep-marker-hardlink nil
        dired-keep-marker-rename   t)

  ;;     +--- disable indent-guide

  (defadvice indent-guide-show (around disable-in-dired activate)
    (unless (eq major-mode 'dired-mode)
      ad-do-it))

  ;;     +--- use idired-mode

  (defconfig 'idired
    (add-hook 'dired-mode-hook 'idired-mode))

  ;;     +--- hooks

  (defun my-dired-mode-hook ()
    (rename-buffer (concat "[Dired]" (buffer-name)) t)
    ;; disable key-chord
    (setq-local key-chord-mode nil)
    (setq-local input-method-function nil))
  (add-hook 'dired-mode-hook 'my-dired-mode-hook)

  ;;     +--- (sentinel)
  )

;;    +--- [buff-menu.el] buffer-menu settings

(defpostload "buff-menu"

  (defun my-Buffer-menu-mode-hook ()
    ;; disable key-chord
    (setq-local key-chord-mode nil)
    (setq-local input-method-function nil))
  (add-hook 'Buffer-menu-mode-hook 'my-Buffer-menu-mode-hook)

  (define-key Buffer-menu-mode-map (kbd "RET") 'Buffer-menu-select)
  (define-key Buffer-menu-mode-map (kbd "j") 'next-line)
  (define-key Buffer-menu-mode-map (kbd "k") 'previous-line)
  (define-key Buffer-menu-mode-map (kbd "l") 'Buffer-menu-select)
  (define-key Buffer-menu-mode-map (kbd "o") 'Buffer-menu-other-window)
  (define-key Buffer-menu-mode-map (kbd "v") 'Buffer-menu-view)
  (define-key Buffer-menu-mode-map (kbd "s") 'Buffer-menu-save)
  (define-key Buffer-menu-mode-map (kbd "m") 'Buffer-menu-delete)
  (define-key Buffer-menu-mode-map (kbd "d") 'Buffer-menu-execute)
  (define-key Buffer-menu-mode-map (kbd "u") 'Buffer-menu-unmark)
  (define-key Buffer-menu-mode-map (kbd "5") 'Buffer-menu-toggle-read-only)
  (define-key Buffer-menu-mode-map (kbd "b") 'Buffer-menu-bury)
  (define-key Buffer-menu-mode-map (kbd "f") 'Buffer-menu-toggle-files-only)
  )

;;    +--+ [eshell.el] eshell settings
;;       +--- (prelude)

(defpostload "eshell"

  ;;     +--- eshell directory

  (setq eshell-directory-name my:eshell-directory)

  ;;     +--+ aliases
  ;;        +--- "emacs" : find-file with emacs

  ;; reference | http://www.emacswiki.org/cgi-bin/wiki?EshellFunctions

  (defun eshell/emacs (&optional file)
    "Open a file in emacs. Some habits die hard."
    (let ((dir default-directory))
      ;; if the cursor is in the shell-pop buffer, pop-out it
      (when (and (boundp 'shell-pop-last-shell-buffer-name)
                 (string= (buffer-name) shell-pop-last-shell-buffer-name))
        (shell-pop-out))
      ;; open file or bury buffer
      (if file
          (find-file (concat dir file))
        (bury-buffer))))

  ;;        +--- "open" : open with application (for Windows)

  ;; reference | http://www.bookshelf.jp/soft/meadow_25.html

  (when (string= window-system "w32")
    (defun eshell/open (&optional file)
      "win-start the current line's file."
      (interactive)
      (unless (null file)
        (w32-shell-execute "open" (expand-file-name file)))))

  ;;     +--- adjustments

  ;; eshell-mode-map does not work (?)
  (defun my-eshell-mode-hook ()
    (local-set-key (kbd "C-j") 'eshell-bol))

  (add-hook 'eshell-mode-hook 'my-eshell-mode-hook)

  ;;     +--- (sentinel)
  )

;;    +--- [hexl.el] open binary files with hexl-mode

;; reference | http://www.bookshelf.jp/soft/meadow_23.html#SEC236

(defun my-file-binary-p (file &optional full)
  "if optional FULL is nil, check only for the first 1000-byte."
  (let ((coding-system-for-read 'binary)
        (enable-emultibyte-characters nil))
    (with-temp-buffer
      (insert-file-contents file nil 0 (if full nil 1000))
      (goto-char (point-min))
      (and (re-search-forward "[\000-\010\016-\032\034-\037]" nil t)
           t))))

(defadvice find-file (around my-find-hexl-file activate)
  (let ((file (ad-get-arg 0)))
    (if (and (ignore-errors (my-file-binary-p file))
             (y-or-n-p "Open with hexl-find-file ? "))
        (hexl-find-file file)
      ad-do-it)))

;;    +--+ [org.el] org-mode settings
;;       +--- (prelude)

(defpostload "org"

  ;;     +--- use ditaa.jar

  (setq org-ditaa-jar-path (expand-file-name my:ditaa-jar-file))

  ;;     +--- startup

  (add-hook 'org-mode-hook 'auto-fill-mode)
  (add-hook 'org-mode-hook 'iimage-mode)

  (setq org-startup-folded             t
        org-startup-indented           t
        org-startup-with-inline-images t)

  ;;     +--- insert src dwim

  (defun my-org-insert-quote-dwim ()
    (interactive)
    (let ((str (and (use-region-p)
                    (buffer-substring (region-beginning) (region-end))))
          (mode (read-from-minibuffer "mode ? ")))
      (when str
        (delete-region (region-beginning) (region-end)))
      (insert "#+begin_src " mode "\n")
      (save-excursion (insert "\n#+end_src" (if str "" "\n")))
      (org-edit-src-code)
      (when str
        (insert str)
        (org-edit-src-exit))))

  ;;     +--- keymap

  (define-key org-mode-map (kbd "C-x '") 'my-org-insert-quote-dwim)
  (define-key org-mode-map (kbd "C-c '") 'org-edit-special)
  (define-key org-mode-map (kbd "M-RET") 'org-insert-heading)
  (define-key org-mode-map (kbd "TAB") 'org-cycle)
  (define-key org-mode-map (kbd "C-y") 'org-yank)
  (define-key org-mode-map (kbd "C-k") 'org-kill-line)
  (define-key org-mode-map (kbd "C-j") 'org-beginning-of-line)
  (define-key org-mode-map (kbd "C-e") 'org-end-of-line)

  (define-key org-mode-map (kbd "M-a") nil)   ; org-backward-sentence
  (define-key org-mode-map (kbd "M-TAB") nil) ; org-complete
  (define-key org-mode-map (kbd "C-,") nil)   ; org-agenda-files
  (define-key org-mode-map (kbd "C-a") nil)   ; org-beginning-of-line
  (define-key org-mode-map (kbd "C-j") nil)   ; org-return-indent
  (define-key org-mode-map (kbd "M-e") nil)   ; org-forward-sentence

  ;;     +--- (sentinel)
  )

;;    +--+ [org-table.el] orgtbl-mode settings
;;       +--- (prelude)

(defpostload "org-table"

  ;;     +--- kill whole row with "org-table-cut-region"

  ;; reference | http://dev.ariel-networks.com/Members/matsuyama/tokyo-emacs-02/

  (defadvice org-table-cut-region (around cut-region-or-kill-row activate)
    (if (and (interactive-p) transient-mark-mode (not mark-active))
        (org-table-kill-row)
      ad-do-it))

  ;;     +--- enable overlay while editing formulas

  (defadvice org-table-eval-formula (around table-formula-helper activate)
    "enable overlays while editing formulas"
    (unless org-table-coordinate-overlays
      (org-table-toggle-coordinate-overlays))
    (unwind-protect ad-do-it
      (org-table-toggle-coordinate-overlays)))

  (defadvice orgtbl-mode (around overlay-reset activate)
    "if overlays are active, remove them instead of leaving orgtbl-mode"
    (if org-table-coordinate-overlays
        (org-table-toggle-coordinate-overlays)
      ad-do-it))

  ;;     +--- my commands

  (defun my-orgtbl-hard-next-field ()
    (interactive)
    (org-table-insert-column)
    (org-table-next-field))

  (defun my-orgtbl-open-row ()
    (interactive)
    (save-excursion
      (org-table-insert-row '(4))))

  (defun my-orgtbl-eval-column-formula ()
    (interactive)
    (org-table-eval-formula))

  (defun my-orgtbl-eval-field-formula ()
    (interactive)
    (org-table-eval-formula '(4)))

  (defun my-orgtbl-recalculate ()
    (interactive)
    (org-table-recalculate '(16)))

  ;;     +--+ keybinds
  ;;        +--- (prelude)

  (add-hook
   'orgtbl-mode-hook
   (lambda ()

     ;;     +--- motion

     (define-key orgtbl-mode-map (kbd "C-f") 'forward-char)
     (define-key orgtbl-mode-map (kbd "C-M-f") 'org-table-next-field)
     (define-key orgtbl-mode-map (kbd "C-b") 'backward-char)
     (define-key orgtbl-mode-map (kbd "C-M-b") 'org-table-previous-field)

     (define-key orgtbl-mode-map (kbd "C-n") 'next-line)
     (define-key orgtbl-mode-map (kbd "C-M-n") 'next-line)
     (define-key orgtbl-mode-map (kbd "C-p") 'previous-line)
     (define-key orgtbl-mode-map (kbd "C-M-p") 'previous-line)

     ;;     +--- region

     (define-key orgtbl-mode-map (kbd "C-w") 'org-table-cut-region)
     (define-key orgtbl-mode-map (kbd "C-M-w") 'org-table-copy-region)

     (define-key orgtbl-mode-map (kbd "C-y") 'org-table-paste-rectangle)
     (define-key orgtbl-mode-map (kbd "C-M-y") 'org-table-copy-down)

     ;;     +--- newline and indent

     (define-key orgtbl-mode-map (kbd "C-i") 'org-table-next-field)
     (define-key orgtbl-mode-map (kbd "C-M-i") 'my-orgtbl-hard-next-field)

     (define-key orgtbl-mode-map (kbd "C-o") 'my-orgtbl-open-row)
     (define-key orgtbl-mode-map (kbd "C-M-o") 'org-table-insert-hline)

     (define-key orgtbl-mode-map (kbd "C-m") 'org-table-next-row)
     (define-key orgtbl-mode-map (kbd "C-M-m") 'org-table-hline-and-move)

     ;;     +--- transpose

     (define-key orgtbl-mode-map (kbd "C-t") 'org-table-move-row-up)
     (define-key orgtbl-mode-map (kbd "C-M-t") 'org-table-move-column-left)

     ;;     +--- others

     (define-key orgtbl-mode-map (kbd "C-=") 'my-orgtbl-eval-column-formula)
     (define-key orgtbl-mode-map (kbd "C-M-=") 'my-orgtbl-eval-field-formula)

     (define-key orgtbl-mode-map (kbd "C-/") 'org-table-sort-lines)
     (define-key orgtbl-mode-map (kbd "C-2") 'org-table-edit-field)

     (define-key orgtbl-mode-map (kbd "M-e") 'my-orgtbl-recalculate)

     (define-key orgtbl-mode-map (kbd "C-g") 'orgtbl-mode)

     ;;     +--- (sentinel)
     ))

  ;;     +--- (sentinel)
  )

;;    +--+ [vi.el] vi-mode settings

(defpostload "vi"

  ;; undo-tree integration

  (defprepare "undo-tree"
    (define-key vi-com-map "\C-r" 'undo-tree-redo)
    (define-key vi-com-map "u" 'undo-tree-undo))

  ;; vi-like paren-matching

  (defadvice show-paren-function (around vi-show-paren activate)
    (if (eq major-mode 'vi-mode)
        (save-excursion (forward-char) ad-do-it)
      ad-do-it))

  ;; make cursor "box" while in vi-mode

  (defadvice vi-mode (after make-cursor-box-while-vi activate)
    (setq cursor-type 'box))

  (defadvice vi-goto-insert-state (after make-cursor-box-while-vi activate)
    (setq cursor-type 'bar))

  ;; disable key-chord

  (defpostload "key-chord"
    (defadvice vi-mode (after disable-key-chord activate)
      (setq-local key-chord-mode nil)
      (setq-local input-method-function nil))
    (defadvice vi-goto-insert-state (after disable-key-chord activate)
      (kill-local-variable 'key-chord-mode)
      (kill-local-variable 'input-method-function)))

  ;; keybinds

  (define-key vi-com-map (kbd "v") 'set-mark-command)
  )

;;    +--+ [view.el] view-mode settings
;;       +--- (prelude)

(defpostload "view"

  ;;     +--- "kindl"y view

  ;; reference | http://d.hatena.ne.jp/nitro_idiot/20130215/1360931962

  (defun my-view-mode-hook ()

    (setq line-spacing 0.3)
    (setq cursor-type 'hbar)

    (let ((buffer-face-mode-face
           '(:family "Times New Roman"
                     :height 125 :width semi-condensed)))
      (buffer-face-mode 1))

    (setq-local global-hl-line-mode nil)
    (setq-local show-paren-mode nil)
    (setq-local key-chord-mode nil)
    (setq-local input-method-function nil)
    )

  (add-hook 'view-mode-hook 'my-view-mode-hook)

  ;;     +--- disable indent-guide

  (defpostload "indent-guide"
    (defadvice indent-guide-show (around disable-in-view-mode activate)
      (unless view-mode ad-do-it)))

  ;;     +--- keybinds

  (defconfig 'vi
    (setcdr view-mode-map (cdr (copy-keymap vi-com-map)))
    (define-key view-mode-map (kbd "C-g") nil)
    (define-key view-mode-map (kbd "C-c") nil))

  (defprepare "pager"
    (define-key view-mode-map (kbd "C-n") 'pager-row-down)
    (define-key view-mode-map (kbd "j") 'pager-row-down)
    (define-key view-mode-map (kbd "C-p") 'pager-row-up)
    (define-key view-mode-map (kbd "k") 'pager-row-up))

  ;;     +--- (sentinel)
  )

;;    +--- [help-mode.el] help-mode settings

(defpostload "help-mode"
  (add-hook 'help-mode-hook 'view-mode))

;;    +--- [compile.el] compilation-mode settings

(defpostload "compile"
  (define-key compilation-shell-minor-mode-map (kbd "C-M-p") nil)
  (define-key compilation-shell-minor-mode-map (kbd "C-M-n") nil)
  (define-key compilation-shell-minor-mode-map (kbd "C-M-p") nil)
  (define-key compilation-shell-minor-mode-map (kbd "C-M-p") nil))

;;    +--+ (howm.el) howm settings
;;       +--- load howm in idle-time

(defprepare "howm"
  (idle-require 'howm))

;;       +--- (prelude)

(deflazyconfig '(howm-menu-or-remember) "howm"

  ;;     +--- howm directories, files

  (setq howm-directory        my:howm-directory
        howm-keyword-file     my:howm-keyword-file
        howm-history-file     my:howm-history-file
        howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")

  ;;     +--- howm menu

  (setq howm-menu-lang                 'en
        howm-menu-schedule-days-before 0
        howm-menu-schedule-days        185
        howm-menu-todo-num             50)

  (setq howm-menu-reminder-separators
        '((-1000 . "\n// dead")
          (-1 . "\n// today")
          (0 . "\n// upcoming")
          (nil . "\n// someday")))

  ;;     +--- open howm files with org-mode

  (add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))

  ;;     +--- kill howm-list buffer automatically

  (setq howm-view-summary-persistent nil)

  ;;     +--- auto-update reminder

  (setq howm-action-lock-forward-save-buffer t)

  ;;     +--- template

  (setq howm-view-title-header    "*"
        howm-template-date-format "[%Y-%m-%d]"
        howm-template             "* %date %cursor\n")

  ;;     +--- remove noisy faces

  (set-face-background 'howm-reminder-today-face nil)
  (set-face-background 'howm-reminder-tomorrow-face nil)

  ;;     +--- import notes from dropbox

  (defvar my-howm-import-directory my:howm-import-directory)

  (defun my-howm-import ()
    (when my-howm-import-directory
      (dolist (file (directory-files my-howm-import-directory))
        (let ((abs-path (concat my-howm-import-directory file)))
          (when (file-regular-p abs-path)
            (howm-remember)
            (insert-file-contents abs-path)
            (beginning-of-buffer)
            (if (not (y-or-n-p (format "import %s ?" file)))
                (howm-remember-discard)
              (let ((howm-template (concat "* " (howm-reminder-today)
                                           "-100 " file "\n\n%cursor")))
                (howm-remember-submit)
                (delete-file abs-path))))))))

  (add-hook 'howm-menu-hook 'my-howm-import)

  ;;     +--+ commands
  ;;        +--- save and kill howm buffer

  (defun my-howm-kill-buffer ()
    (interactive)
    (when (and (buffer-file-name)
               (string-match "\\.howm" (buffer-file-name)))
      (let ((buf (buffer-name)))
        (save-buffer)
        ;; codes below are added to avoid
        ;; confliction with "delete-file-if-no-contents"
        ;; - kill only when the buffer exists
        (when (string= (buffer-name) buf) (kill-buffer))
        ;; - reflesh menu
        (howm-menu))))

  ;;        +--- export schedule to dropbox and kill howm

  (require 'calendar)

  (defvar my-howm-export-file my:howm-export-file)

  (defun my-calendar-generate-string ()
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
         (buffer-substring-no-properties (point-min) (point-max))))))

  (defun my-howm-export-to-file (filename)
    (with-temp-file filename
      ;; dropbox App can open only utf-8 documents
      (set-buffer-file-coding-system 'utf-8)
      (insert (format "* Howm Schedule %s ~ %s *\n\n"
                      (howm-reminder-today)
                      (howm-reminder-today howm-menu-schedule-days))
              (my-calendar-generate-string)
              "\n"
              (howm-menu-reminder))
      (message "successfully exported")))

  (defun my-howm-exit ()
    (interactive)
    ;; export to dropbox
    (when my-howm-export-file
      (my-howm-export-to-file my-howm-export-file))
    ;; kill all howm buffers
    (mapc
     (lambda(b) (when (cdr (assq 'howm-mode (buffer-local-variables b)))
                  (kill-buffer b)))
     (buffer-list)))

  ;;        +--- open howm-remember and automatically yank

  (defun howm-menu-or-remember ()
    (interactive)
    (if (use-region-p)
        (let ((str (buffer-substring (region-beginning) (region-end))))
          (howm-remember)
          (insert str))
      (howm-menu)))

  ;;     +--- keybinds

  ;; .howm file buffers
  (define-key howm-mode-map (kbd "C-x C-s") 'my-howm-kill-buffer)
  (define-key howm-mode-map (kbd "M-c") 'howm-insert-date)

  ;; howm menu
  (define-key howm-menu-mode-map (kbd "q") 'my-howm-exit)

  ;; howm remember
  (define-key howm-remember-mode-map (kbd "C-g") 'howm-remember-discard)
  (define-key howm-remember-mode-map (kbd "C-x C-s") 'howm-remember-submit)

  ;;     +--- (sentinel)
  )

;; +--+ 0x1d. coding assistants
;;    +--- [compile.el] scroll compilation output automatically

(defpostload "compile"
  (setq compilation-scroll-output t))

;;    +--- [eldoc.el] enable eldoc

(deflazyconfig '(turn-on-eldoc-mode) "eldoc"
  (setq eldoc-idle-delay 0.1
        eldoc-echo-area-use-multiline-p nil))

(defprepare "eldoc"
  (defpostload "lisp-mode"
    (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
    (add-hook 'lisp-interaction-mode 'turn-on-eldoc-mode)))

;;    +--- [find-file.el] search /MinGW/include/ for headers

(defpostload "find-file"
  (when (string= (window-system) "w32")
    (add-to-list 'cc-search-directories "C:/MinGW/include/")))

;;    +--+ [flymake.el] flymake settings
;;       +--- activate flymake

(defprepare "flymake"
  (add-hook 'c-mode-hook 'flymake-find-file-hook))

;;       +--- (prelude)

(deflazyconfig '(flymake-find-file-hook) "flymake"

  ;;     +--- turn-off flymake if failed

  ;; reference | http://moimoitei.blogspot.jp/2010/05/flymake-in-emacs.html

  (defadvice flymake-can-syntax-check-file (after turn-off-flymake activate)
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

  ;;     +--- display warnings under cursor

  ;; reference | http://tech.kayac.com/archive/emacs.html

  (defun my-flymake-display-err-minibuf-for-current-line ()
    "Displays the error/warning for the current line in the minibuffer"
    (interactive)
    (let* ((line-no (flymake-current-line-no))
           (line-err-info-list
            (nth 0 (flymake-find-err-info flymake-err-info line-no)))
           (count (length line-err-info-list)))
      (while (> count 0)
        (when line-err-info-list
          (let* ((text
                  (flymake-ler-text (nth (1- count) line-err-info-list)))
                 (line
                  (flymake-ler-line (nth (1- count) line-err-info-list))))
            (message "[%s] %s" line text)))
        (setq count (1- count)))))

  (defadvice previous-line (after my-display-error-on-previous-line activate)
    (when flymake-mode
      (my-flymake-display-err-minibuf-for-current-line)))

  (defadvice next-line (after my-display-error-on-next-line activate)
    (when flymake-mode
      (my-flymake-display-err-minibuf-for-current-line)))

  ;;     +--+ settings for each languages
  ;;        +--- template

  ;; reference | http://www.gfd-dennou.org/member/uwabami/cc-env/Emacs/flymake_config.html

  (defun flymake-simple-generic-init (cmd &optional opts)
    (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                        'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list cmd (append opts (list local-file)))))

  ;;        +--- setting for C (gcc)

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.c\\'"
                 (lambda () (flymake-simple-generic-init
                             "gcc"
                             '("-fsyntax-only" "-ansi" "-pedantic" "-Wall"
                               "-W" "-Wextra" "-Wunreachable-code")))))

  ;;     +--- (sentinel)
  )

;;    +--- [hideshow.el] indicators for hidden lines

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

;;    +--- [imenu.el] enable auto-rescan of imenu

(defpostload "imenu"
  (setq imenu-auto-rescan t))

;;    +--- [ispell.el] use aspell.exe for ispell

(defpostload "ispell"

  ;; use "aspell.exe"
  (setq ispell-program-name "aspell"
        ispell-extra-args '("--sug-mode=ultra"))

  ;; do not spell-check KANJIs
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]"))
  )

;;    +--- (c-eldoc.el) enable c-eldoc

(deflazyconfig '(c-turn-on-eldoc-mode) "c-eldoc"

  ;; try MinGW on Windows
  (when (string= window-system "w32")
    (setq c-eldoc-includes    "-I./ -I../ -I\"C:/MinGW/include\""
          c-eldoc-cpp-command "C:/MinGW/bin/cpp"))

  (setq c-eldoc-buffer-regenerate-time 15)
  )

(defprepare "c-eldoc"
  (defpostload "cc-mode"
    (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)
    (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)))

;;    +--- (fold-dwim.el) hide some blocks

(deflazyconfig '(fold-dwim-toggle fold-dwim-hide-all) "fold-dwim"

  (defadvice fold-dwim-hide (before enable-hs-before-fold activate)
    (unless hs-minor-mode
      (hs-minor-mode 1)))

  (defadvice fold-dwim-hide-all (before enable-hs-before-fold activate)
    (unless hs-minor-mode
      (hs-minor-mode 1)))
  )

;;    +--- (indent-guide.el) enable indent-guide

;; (defconfig 'indent-guide
;;   (indent-guide-global-mode))

;;    +--- (outline-magic.el) outline-cycle-dwim

(defprepare "outline-magic"
  (defpostload "outline"

    (defun outline-cycle-dwim ()
      (interactive)
      (if (or (outline-on-heading-p) (= (point) 1))
          (outline-cycle)
        (call-interactively (global-key-binding "\t"))))

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
      (setq this-command 'outline-cycle-toc))))

;;    +--- (outlined-elisp-mode.el) outlined-elisp-mode settings

(defprepare "outlined-elisp-mode"
  (add-hook 'emacs-lisp-mode-hook 'outlined-elisp-find-file-hook))

(deflazyconfig
  '(outlined-elisp-find-file-hook
    outlined-elisp-mode) "outlined-elisp-mode"
    (setq outlined-elisp-regexp "^[\s\t]*;;[\s]+\\+[+-]*\s"
          outlined-elisp-trigger-pattern "^;;\s\\+\s"))

;;    +--- (rainbow-mode.el) enable rainbow-mode

(deflazyconfig '(rainbow-mode) "rainbow-mode")

(defprepare "rainbow-mode"
  (add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
  (defpostload "css-mode"
    (add-hook 'css-mode-hook 'rainbow-mode)))

;;    +--- (smart-compile.el) smart-compile settings

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

;; +--+ 0x1e. other commands
;;    +--- (dmacro.el) autoload dmacro

(defprepare "dmacro"
  (defun dmacro-exec ()
    (interactive)
    (let ((*dmacro-key* (this-single-command-keys)))
      (load "dmacro")
      ;; dmacro-exec is overriden here
      (call-interactively 'dmacro-exec))))

;;    +--+ (multiple-cursors.el) multiple-cursors settings
;;       +--- (prelude)

(deflazyconfig
  '(my-mc/mark-next-dwim
    my-mc/mark-all-dwim-or-skip-this) "multiple-cursors"

    ;;   +--- mc-list file

    (setq mc/list-file my:mc-list-file)
    (ignore-errors (load mc/list-file))

    ;;   +--+ dwim commands
    ;;      +--- load and fix mc-mark-more

    ;; (mc--in-defun) sometimes seems not work (why?)
    ;; so make him return always non-nil

    (defconfig 'mc-mark-more
      (dolist (fun '(mc/mark-all-like-this-in-defun
                     mc/mark-all-words-like-this-in-defun
                     mc/mark-all-symbols-like-this-in-defun))
        (eval
         `(defadvice ,fun (around fix-restriction activate)
            (flet ((mc--in-defun () t)) ad-do-it)))))

    ;;      +--- a fix for require

    ;; reference | https://github.com/milkypostman/dotemacs

    (defadvice require (around require-advice activate)
      (save-excursion (let (deactivate-mark) ad-do-it)))

    (defadvice load (around require-advice activate)
      (save-excursion (let (deactivate-mark) ad-do-it)))

    ;;      +--- utilities

    (defun my-mc/marking-words-p ()
      (ignore-errors
        (and (use-region-p)
             (save-excursion
               (= (goto-char (region-end))
                  (progn (backward-word) (forward-word) (point))))
             (save-excursion
               (= (goto-char (region-beginning))
                  (progn (forward-word) (backward-word) (point)))))))

    ;;      +--- mc/mark-next-dwim

    (defun my-mc/mark-next-dwim ()
      "call mc/mark-next-like-this or mc/edit-lines"
      (interactive)
      (if (and (use-region-p)
               (string-match "\n" (buffer-substring (region-beginning)
                                                    (region-end))))
          (mc/edit-lines)
        (setq this-command 'mc/mark-next-like-this) ; used by the command below
        (mc/mark-next-like-this 1)))

    ;;      +--- mc/mark-all-dwim

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
                ((and (boundp 'mc--no-region-and-in-sgmlish-mode)
                      (mc--no-region-and-in-sgmlish-mode)
                      (mc--on-tag-name-p))
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

    ;;   +--- (sentinel)
    )

;;    +--- (scratch-palette.el) autoload scratch-palette

(deflazyconfig '(scratch-palette-popup) "scratch-palette"
  (define-key scratch-palette-minor-mode-map (kbd "M-w") 'scratch-palette-kill))

;;    +--- (scratch-pop.el) autoload scratch-pop

(deflazyconfig '(scratch-pop) "scratch-pop")

;;    +--- (sudden-death.el) autoload sudden-death

;; ＿人人人人人人人人＿
;; ＞  sudden-death  ＜
;; ￣ＹＹＹＹＹＹＹＹ￣

(deflazyconfig '(sudden-death) "sudden-death")

;;    +--- (shell-pop.el) shell-pop settings

;; use eshell
(deflazyconfig '(shell-pop) "shell-pop"
  (setq shell-pop-internal-mode        "eshell"
        shell-pop-internal-mode-buffer "*eshell*"
        shell-pop-internal-mode-func   '(lambda () (eshell))))

;;    +--- (simple-demo.el) autoload simple-demo

(deflazyconfig '(simple-demo-set-up) "simple-demo"
  (setq simple-demo-highlight-face 'compilation-warning))

;;    +--- (undo-tree.el) enable undo-tree

(defconfig 'undo-tree
  (global-undo-tree-mode 1)
  (define-key undo-tree-visualizer-mode-map (kbd "j") 'undo-tree-visualize-redo)
  (define-key undo-tree-visualizer-mode-map (kbd "k") 'undo-tree-visualize-undo)
  (define-key undo-tree-visualizer-mode-map (kbd "l") 'undo-tree-visualize-switch-branch-right)
  (define-key undo-tree-visualizer-mode-map (kbd "h") 'undo-tree-visualize-switch-branch-left)
  (define-key undo-tree-visualizer-mode-map (kbd "RET") 'undo-tree-visualizer-quit)
  (define-key undo-tree-visualizer-mode-map (kbd "C-g") 'undo-tree-visualizer-abort)
  (define-key undo-tree-visualizer-mode-map (kbd "q") 'undo-tree-visualizer-abort))

;; +--+ 0x20. keybinds
;;    +--- keyboard translations

;; by default ...
;; - C-m is RET
;; - C-i is TAB
;; - C-[ is ESC

(keyboard-translate ?\C-h ?\C-?)

;;    +--- disable mouse buttons

;; (global-set-key (kbd "<mouse-1>") 'ignore)
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

;; (global-set-key (kbd "<wheel-down>") 'ignore)
;; (global-set-key (kbd "<wheel-up>") 'ignore)

;;    +--+ keyboard
;;       +--+ fundamental
;;          +--- prefix arguments

;; Ctrl-
(global-set-key (kbd "C-1") 'digit-argument)
(global-set-key (kbd "C-2") 'digit-argument)
(global-set-key (kbd "C-3") 'digit-argument)
(global-set-key (kbd "C-4") 'digit-argument)
(global-set-key (kbd "C-5") 'digit-argument)
(global-set-key (kbd "C-6") 'digit-argument)
(global-set-key (kbd "C-7") 'digit-argument)
(global-set-key (kbd "C-8") 'digit-argument)
(global-set-key (kbd "C-9") 'digit-argument)
(global-set-key (kbd "C-0") 'digit-argument)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-1") 'digit-argument)
(global-set-key (kbd "C-M-2") 'digit-argument)
(global-set-key (kbd "C-M-3") 'digit-argument)
(global-set-key (kbd "C-M-4") 'digit-argument)
(global-set-key (kbd "C-M-5") 'digit-argument)
(global-set-key (kbd "C-M-6") 'digit-argument)
(global-set-key (kbd "C-M-7") 'digit-argument)
(global-set-key (kbd "C-M-8") 'digit-argument)
(global-set-key (kbd "C-M-9") 'digit-argument)
(global-set-key (kbd "C-M-0") 'digit-argument)

;; Meta-Shift-
(global-set-key (kbd "M-!") 'digit-argument)
(global-set-key (kbd "M-@") 'digit-argument)
(global-set-key (kbd "M-#") 'digit-argument)
(global-set-key (kbd "M-$") 'digit-argument)
(global-set-key (kbd "M-%") 'digit-argument)
(global-set-key (kbd "M-^") 'digit-argument)
(global-set-key (kbd "M-&") 'digit-argument)
(global-set-key (kbd "M-*") 'digit-argument)
(global-set-key (kbd "M-(") 'digit-argument)
(global-set-key (kbd "M-)") 'digit-argument)

;;          +--- emacs

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
(global-set-key (kbd "M-x") '("smex" smex execute-extended-command))
(global-set-key (kbd "M-m") '("dmacro" dmacro-exec call-last-kbd-macro))

;; Ctrl-x
(global-set-key (kbd "C-x C-c") 'save-buffers-kill-emacs)
(global-set-key (kbd "C-x C-0") 'kmacro-end-macro)
(global-set-key (kbd "C-x C-9") 'kmacro-start-macro)
(global-set-key (kbd "C-x RET") 'kmacro-end-and-call-macro) ; C-x C-m

;; Others
(global-set-key (kbd "M-<f4>") 'save-buffers-kill-emacs)

;;          +--- buffer

;; Meta-
(global-set-key (kbd "M-b") '("ido" ido-switch-buffer switch-to-buffer))

;; Ctrl-x
(global-set-key (kbd "C-x C-w") '("ido" ido-write-file write-file))
(global-set-key (kbd "C-x C-s") 'save-buffer)
(global-set-key (kbd "C-x C-b") 'list-buffers)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-e") 'set-buffer-file-coding-system)
(global-set-key (kbd "C-x C-r") 'revert-buffer-with-coding-system)

;;          +--- frame, window

;; Meta-
(global-set-key (kbd "M-0") 'next-multiframe-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'my-split-window)
(global-set-key (kbd "M-3") 'balance-windows)
(global-set-key (kbd "M-4") 'follow-delete-other-windows-and-split)
(global-set-key (kbd "M-8") 'my-rotate-windows)
(global-set-key (kbd "M-9") 'previous-multiframe-window)
(global-set-key (kbd "M-o") 'toggle-opacity)
(global-set-key (kbd "M-k") 'delete-window)

;;       +--+ motion
;;          +--- cursor

;; Ctrl-
(global-set-key (kbd "C-b") 'backward-char)
(global-set-key (kbd "C-p") 'previous-line)
(global-set-key (kbd "C-n") 'next-line)
(global-set-key (kbd "C-f") 'forward-char)
(global-set-key (kbd "M--") '("point-undo" point-undo))

;; Ctrl-Meta-
(global-set-key (kbd "C-M-b") 'backward-word)
(global-set-key (kbd "C-M-p") 'my-previous-blank-line)
(global-set-key (kbd "C-M-n") 'my-next-blank-line)
(global-set-key (kbd "C-M-f") 'forward-word)

;; Meta-
(global-set-key (kbd "M-v") 'my-visible-register)

;; Meta-Shift-
(global-set-key (kbd "M-B") 'backward-sexp)
(global-set-key (kbd "M-P") 'my-up-list)
(global-set-key (kbd "M-N") 'my-down-list)
(global-set-key (kbd "M-F") 'forward-sexp)

;;          +--- jump

;; Ctrl-
(global-set-key (kbd "C-j") 'my-smart-bol)
(global-set-key (kbd "C-e") 'move-end-of-line)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-j") 'beginning-of-defun)
(global-set-key (kbd "C-M-e") 'end-of-defun)

;; Meta-
(global-set-key (kbd "M-l") 'goto-line)
(global-set-key (kbd "M-j") '("anything" my-anything-jump))

;;          +--- scroll

;; Ctrl-
(global-set-key (kbd "C-u") '("pager" pager-page-up scroll-down))
(global-set-key (kbd "C-v") '("pager" pager-page-down scroll-up))
(global-set-key (kbd "C-l") 'recenter)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-u") 'beginning-of-buffer)
(global-set-key (kbd "C-M-v") 'end-of-buffer)
(global-set-key (kbd "C-M-l") 'my-retop)

;; Meta-Shift-
(global-set-key (kbd "M-L") 'recenter)

;; Ctrl-x
(global-set-key (kbd "C-x C-u") 'untabify)

;;       +--+ edit
;;          +--- undo, redo

;; Ctrl-
(global-set-key (kbd "C--") '("undo-tree" undo-tree-undo undo))

;; Ctrl-Meta-
(global-set-key (kbd "C-M--") '("undo-tree" undo-tree-redo repeat-complex-command))

;; Meta-Shift-
(global-set-key (kbd "M-_") '("undo-tree" undo-tree-undo undo))

;;          +--- mark, region

;; Ctrl-
(global-set-key (kbd "C-,") '("expand-region" er/expand-region mark-word))
(global-set-key (kbd "C-a") '("multiple-cursors" my-mc/mark-next-dwim))
(global-set-key (kbd "C-M-a") '("multiple-cursors" my-mc/mark-all-dwim-or-skip-this))

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
(global-set-key (kbd "C-<return>") '("phi-rectangle" phi-rectangle-set-mark-command))

;;          +--- kill, yank

;; when "DEL" is defined,
;; backward-delete-char on minibuffer sometimes doesn't work

;; Ctrl-
(global-set-key (kbd "C-w") '("phi-rectangle" phi-rectangle-kill-region kill-region))
(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "C-d") '("phi-autopair" phi-autopair-delete-forward delete-char))
;; (global-set-key (kbd "DEL") '("phi-autopair" phi-autopair-delete-backward backward-delete-char-untabify)) ; C-h
(global-set-key (kbd "C-y") '("phi-rectangle" phi-rectangle-yank yank))

;; Ctrl-Meta-
(global-set-key (kbd "C-M-w") '("phi-rectangle" phi-rectangle-kill-ring-save kill-ring-save))
(global-set-key (kbd "C-M-k") 'my-kill-line-backward)
(global-set-key (kbd "C-M-d") '("phi-autopair" phi-autopair-delete-forward-word kill-word))
(global-set-key (kbd "C-M-h") '("phi-autopair" phi-autopair-delete-backward-word backward-kill-word))
(global-set-key (kbd "C-M-y") '("yasnippet" my-yas-expand-oneshot))

;; Meta-Shift-
(global-set-key (kbd "M-W") 'my-yank-sexp)
(global-set-key (kbd "M-K") '("paredit" my-paredit-kill kill-line))
(global-set-key (kbd "M-D") 'kill-sexp)
(global-set-key (kbd "M-H") 'backward-kill-sexp)
(global-set-key (kbd "M-Y") 'my-overwrite-sexp)

;; Meta-
(global-set-key (kbd "M-y") '("browse-kill-ring" browse-kill-ring yank-pop))

;;          +--- newline, indent, format

;; Ctrl-
(global-set-key (kbd "TAB") 'indent-for-tab-command) ; C-i
(global-set-key (kbd "C-o") 'my-open-line-and-indent)
(global-set-key (kbd "RET") 'newline-and-indent) ; C-m

;; Ctrl-Meta-
(global-set-key (kbd "C-M-i") 'fill-paragraph)
(global-set-key (kbd "C-M-o") 'my-new-line-between)
(global-set-key (kbd "C-M-m") 'my-next-opened-line)

;; Meta-
(global-set-key (kbd "M-u") '("undo-tree" undo-tree-visualize))

;; Meta-Shift-
(global-set-key (kbd "M-I") 'my-indent-defun)
(global-set-key (kbd "M-O") 'my-open-line-and-indent)
(global-set-key (kbd "M-M") '("paredit" paredit-newline newline-and-indent))

;;          +--- search, replace

;; Ctrl-
(global-set-key (kbd "C-r") '("phi-replace" phi-replace-query query-replace-regexp))
(global-set-key (kbd "C-s") '("phi-search" phi-search isearch-forward-regexp))

;; Ctrl-Meta-
(global-set-key (kbd "C-M-r") '("phi-replace" phi-replace replace-regexp))
(global-set-key (kbd "C-M-s") '("phi-search" phi-search-backward isearch-backward-regexp))

;; Meta-
(global-set-key (kbd "M-s") '("all" my-all-command))

;;          +--- other edit commands

;; Ctrl-
(global-set-key (kbd "C-t") 'backward-transpose-words)
(global-set-key (kbd "C-;") 'comment-dwim)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-t") 'backward-transpose-lines)

;; Meta-
(global-set-key (kbd "M-h") 'my-shrink-whitespaces)
(global-set-key (kbd "M-*") '("paredit" paredit-forward-barf-sexp))
(global-set-key (kbd "M-(") '("paredit" my-paredit-wrap-round))
(global-set-key (kbd "M-)") '("paredit" paredit-forward-slurp-sexp))
(global-set-key (kbd "M-R") '("paredit" paredit-raise-sexp))
(global-set-key (kbd "M-U") '("paredit" paredit-splice-sexp-killing-backward))
(global-set-key (kbd "M-S") '("paredit" paredit-split-sexp))
(global-set-key (kbd "M-J") '("paredit" paredit-join-sexps))
(global-set-key (kbd "M-C") '("paredit" paredit-convolute-sexp))
(global-set-key (kbd "M-\"") '("paredit" paredit-meta-doublequote))

;; Meta-Shift-
(global-set-key (kbd "M-T") 'my-transpose-sexps)
(global-set-key (kbd "M-:") '("paredit" paredit-comment-dwim comment-dwim))

;; Others
(global-set-key (kbd "<oem-pa1>") '("yasnippet" yas-expand my-dabbrev-expand))
(global-set-key (kbd "<muhenkan>") '("yasnippet" yas-expand my-dabbrev-expand))
(global-set-key (kbd "<nonconvert>") '("yasnippet" yas-expand my-dabbrev-expand))

;;       +--+ file, directory, shell
;;          +--- browsing

;; Meta-
(global-set-key (kbd "M-d") 'my-dired-default-directory)
(global-set-key (kbd "M-f") '("ido" ido-find-file find-file))
(global-set-key (kbd "M-g") '("traverselisp" traverse-deep-rfind rgrep))
(global-set-key (kbd "M-r") 'ido-recentf-open)

;; Ctrl-x
(global-set-key (kbd "C-x C-d") '("ido" ido-dired dired))
(global-set-key (kbd "C-x DEL") 'ff-find-other-file) ; C-x C-h

;;          +--- shell command

;; Meta-
(global-set-key (kbd "M-i") '("shell-pop" shell-pop eshell))

;;       +--- help

(define-prefix-command 'help-map)

(global-set-key (kbd "<f1>") 'help-map)
(global-set-key (kbd "M-?") 'help-map)

(define-key help-map (kbd "<f1>") 'info)
(define-key help-map (kbd "b") 'describe-bindings)
(define-key help-map (kbd "k") 'describe-key)
(define-key help-map (kbd "m") 'describe-mode)
(define-key help-map (kbd "f") 'describe-function)
(define-key help-map (kbd "v") 'describe-variable)
(define-key help-map (kbd "a") 'describe-face)

;;       +--- others

;; input method

(global-set-key (kbd "M-`") 'toggle-input-method)
(global-set-key (kbd "M-<kanji>") 'ignore)

;; insert commands

(global-set-key (kbd "C-q") 'quoted-insert)
(global-set-key (kbd ",") 'my-smart-comma)

;; scratch notes

(global-set-key (kbd "M-w") '("scratch-palette" scratch-palette-popup))
(global-set-key (kbd "M-q") '("scratch-pop" scratch-pop))

;; code folding

(global-set-key (kbd "C-z") '("fold-dwim" fold-dwim-toggle))
(global-set-key (kbd "C-M-z") '("fold-dwim" fold-dwim-hide-all))

;; minor-modes

(global-set-key (kbd "<escape>") 'vi-mode)
(global-set-key (kbd "ESC ESC") 'vi-mode)
(global-set-key (kbd "M-t") 'orgtbl-mode)
(global-set-key (kbd "M-a") 'artist-mode)

;; misc

(global-set-key (kbd "M-n") 'my-toggle-narrowing)
(global-set-key (kbd "M-,") '("howm" howm-menu-or-remember))
(global-set-key (kbd "M-c") '("smart-compile" smart-compile compile))
(global-set-key (kbd "C-x C-l") 'my-add-change-log-entry)
(global-set-key (kbd "C-x C-t") 'toggle-truncate-lines)
(global-set-key (kbd "C-x C-p") 'read-only-mode)
(global-set-key (kbd "C-x C-=") 'text-scale-adjust)
(global-set-key (kbd "C-x C-i") 'ispell-region)

;;    +--- keychord

(defpostload "key-chord"

  ;; Default
  (key-chord-define-global "fj" 'backward-transpose-chars)
  (key-chord-define-global "hh" 'my-capitalize-word-dwim)
  (key-chord-define-global "jj" 'my-upcase-previous-word)
  (key-chord-define-global "kk" 'my-downcase-previous-word)

  (key-chord-define-global "fg" 'isearch-backward-regexp)
  (key-chord-define-global "hj" 'isearch-forward-regexp)
  (key-chord-define-global "cv" 'scroll-up)
  (key-chord-define-global "nm" 'scroll-down)
  (key-chord-define-global "vv" 'vi-mode)

  ;; with libraries
  (defprepare "pager"
    (key-chord-define-global "cv" 'pager-page-up)
    (key-chord-define-global "nm" 'pager-page-down))
  (defprepare "iy-go-to-char"
    (key-chord-define-global "jk" 'iy-go-to-char)
    (key-chord-define-global "df" 'iy-go-to-char-backward))
  (defprepare "phi-search"
    (key-chord-define-global "hj" 'phi-search)
    (key-chord-define-global "fg" 'phi-search-backward)
    (defpostload "phi-search"
      (key-chord-define phi-search-default-map "hj" 'phi-search-again-or-next)
      (key-chord-define phi-search-default-map "fg" 'phi-search-again-or-previous)))
  (defprepare "ace-jump-mode"
    (key-chord-define-global "jl" 'ace-jump-word-mode))
  )

;; +--+ 0x30. appearance
;;    +--- configurations

(setq-default truncate-lines       t
              line-move-visual     t
              cursor-type          'bar
              indicate-empty-lines t)

;;    +--- font

;; reference | http://macemacsjp.sourceforge.jp/matsuan/FontSettingJp.html

(when my:home-system-p

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

;;    +--+ the mode-line-format
;;       +--- make faces

(dolist (face '(mode-line-bright-face
                mode-line-dark-face
                mode-line-highlight-face
                mode-line-special-mode-face
                mode-line-warning-face
                mode-line-modified-face
                mode-line-read-only-face
                mode-line-narrowed-face
                mode-line-mc-face))
  (make-face face)
  (set-face-attribute face nil
                      :inherit 'mode-line-face))

;;       +--- utility functions

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

;;       +--+ the mode-line-format
;;          +--- (prelude)

(setq-default
 mode-line-format
 '(
   " "

   ;;       +--- window position

   (:eval
    (if mark-active
        (let ((rows (count-lines (region-beginning) (region-end))))
          (propertize (if (not (= rows 1))
                          (format "%3d" rows)
                        (format "%3d" (- (region-end) (region-beginning))))
                      'face 'mode-line-warning-face))
      (propertize
       (let ((perc (/ (* 100 (point)) (point-max))))
         (if (= perc 100) "EOF" (format "%2d%%%%" perc)))
       'face 'mode-line-dark-face)))

   ;;       +--- linum

   (:propertize " :" face mode-line-bright-face)
   (:propertize "%5l" face mode-line-dark-face)

   ;;       +--- colnum

   (:propertize " :" face mode-line-bright-face)
   (:eval
    (propertize "%3c" 'face
                (if (>= (current-column) 80)
                    'mode-line-warning-face
                  'mode-line-dark-face)))

   ;;       +--- indicators

   (:propertize " >> " face mode-line-bright-face)
   (:eval
    (if (or (/= (point-min) 1) (/= (point-max) (1+ (buffer-size))))
        (propertize "n" 'face 'mode-line-narrowed-face)
      (propertize "n" 'face 'mode-line-bright-face)))
   (:eval
    (if buffer-read-only
        (propertize "%%" 'face 'mode-line-read-only-face)
      (propertize "%%" 'face 'mode-line-bright-face)))
   (:eval
    (if (buffer-modified-p)
        (propertize "*" 'face 'mode-line-modified-face)
      (propertize "*" 'face 'mode-line-bright-face)))
   (:eval
    (if (and (boundp 'multiple-cursors-mode) multiple-cursors-mode)
        (propertize (format "%02d" (mc/num-cursors))
                    'face 'mode-line-mc-face)
      (propertize "00" 'face 'mode-line-bright-face)))

   ;;       +--- directory / file name

   (:propertize " " face mode-line-bright-face)
   (:propertize "%[" face mode-line-bright-face)
   (:eval
    (propertize (my-shorten-directory 10)
                'face 'mode-line-dark-face))
   (:propertize "%b" face mode-line-highlight-face)
   (:propertize "%]" face mode-line-bright-face)

   ;;       +--- major-mode / coding-system

   (:propertize " << " face mode-line-bright-face)
   (:eval (cond
           ((and (boundp 'artist-mode) artist-mode)
            (propertize "*Artist*" 'face 'mode-line-special-mode-face))
           ((and (boundp 'orgtbl-mode) orgtbl-mode)
            (propertize "*OrgTbl*" 'face 'mode-line-special-mode-face))
           (t
            (propertize mode-name 'face 'mode-line-dark-face))))
   (:propertize mode-line-process face mode-line-highlight-face)
   (:eval
    (propertize
     (format " (%s)" (symbol-name buffer-file-coding-system))
     'face 'mode-line-bright-face))

   ;;       +--- others

   (:propertize " << " face mode-line-bright-face)
   (:propertize global-mode-string face mode-line-dark-face)

   ;;       +--- (sentinel)
   ))

;;    +--- change mode-line color while recording

(defvar my-mode-line-background '("#194854" . "#594854"))

(defadvice kmacro-start-macro (after my-recording-mode-line activate)
  (set-face-background 'mode-line (cdr my-mode-line-background))
  (add-hook 'post-command-hook 'my-recording-mode-line-end))

(defun my-recording-mode-line-end ()
  (unless defining-kbd-macro
    (set-face-background 'mode-line (car my-mode-line-background))
    (remove-hook 'post-command-hook 'my-recording-mode-line-end)))

;;    +--- [hl-line.el] enable hl-line-mode

(defconfig 'hl-line
  (global-hl-line-mode 1))

;;    +--- [menu-bar.el] disable menu-bar

(defpostload "menu-bar"
  (menu-bar-mode -1))

;;    +--- [scroll-bar.el] disable scroll-bar

(defpostload "scroll-bar"
  (scroll-bar-mode -1))

;;    +--- [tool-bar.el] disable tool-bar

(defpostload "tool-bar"
  (tool-bar-mode -1))

;;    +--- [time.el] show current time in modeline

(defconfig 'time
  (setq display-time-string-forms '(24-hours ":" minutes))
  (display-time-mode 1))

;;    +--- [frame.el] do not blink cursor

(defpostload "frame"
  (blink-cursor-mode -1))

;;    +--- (color-theme.el) load color-theme

(defconfig 'color-theme)

;;    +--+ (solarized.el) solarized as a color-scheme-scheme
;;       +--- (prelude)

(defpostload "color-theme"
  (defconfig 'color-theme-solarized

    ;;   +--+ palettes
    ;;      +--- lookup function

    (defun my-solarized-color (name)
      "lookup a color from solarized-colors"
      (cadr (assq name solarized-colors)))

    ;;      +--- *COMMENT* "solarized" default palette

    ;; (setq solarized-colors
    ;;       '((base03          "#002b36") ; background
    ;;         (lmntal-name     "#003944") ; for lmntal-mode (bg)
    ;;         (flymake-err     "#402b36") ; flymake highlight
    ;;         (base02          "#073642") ; hl-line, inactive modeline
    ;;         (modeline-active "#194854") ; active modeline
    ;;         (modeline-record "#594854") ; recording modeline
    ;;         (base01          "#586e75") ; region, comment, ace-jump base
    ;;         (base00          "#657b83") ;
    ;;         (base0           "#839496") ; foreground, cursor
    ;;         (base1           "#93a1a1") ; modeline active (fg)
    ;;         (base2           "#eee8d5") ;
    ;;         (base3           "#fdf6e3") ; ace-jump match
    ;;         (yellow          "#b58900") ; type, highlight
    ;;         (orange          "#cb4b16") ; preprocessor, regexp group
    ;;         (red             "#dc322f") ; warning, mismatch
    ;;         (magenta         "#d33682") ; visited link
    ;;         (violet          "#6c71c4") ; link
    ;;         (blue            "#268bd2") ; function, variable name
    ;;         (cyan            "#2aa198") ; string, showparen, minibuffer
    ;;         (green           "#859900") ; keyword, builtin, constant
    ;;         ))
    ;; (color-theme-solarized-dark)

    ;;      +--- *COMMENT* "jellybeans" inspired palette

    ;; (setq solarized-colors
    ;;       '((base03          "#202020") ; background
    ;;         (lmntal-name     "#2c2c2c") ; for lmntal-mode (bg)
    ;;         (flymake-err     "#3a2020") ; flymake highlight
    ;;         (base02          "#292929") ; hl-line, inactive modeline
    ;;         (modeline-active "#393939") ; active modeline
    ;;         (modeline-record "#593939") ; recording modeline
    ;;         (base01          "#666666") ; region, comment, ace-jump base
    ;;         (base00          "#ffffff") ;
    ;;         (base0           "#b8b8a3") ; foreground, cursor
    ;;         (base1           "#a8b8b3") ; modeline active (fg)
    ;;         (base2           "#ffffff") ;
    ;;         (base3           "#ffffff") ; ace-jump match
    ;;         (yellow          "#ffb964") ; type, highlight
    ;;         (orange          "#8fbfdc") ; preprocessor, regexp group
    ;;         (red             "#a04040") ; warning, mismatch
    ;;         (magenta         "#b05080") ; visited link
    ;;         (violet          "#805090") ; link
    ;;         (blue            "#fad08a") ; function, variable name
    ;;         (cyan            "#99ad6a") ; string, showparen, minibuffer
    ;;         (green           "#8fbfdc") ; keyword, builtin, constant
    ;;         ))
    ;; (color-theme-solarized-dark)

    ;;      +--- "mesa" inspired palette

    (setq solarized-colors
          '((base03          "#ee0000") ; ace-jump match
            (lmntal-name     "#efefef") ; for lmntal-mode (bg)
            (flymake-err     "#ffefe8") ; flymake highlight
            (base02          "#f2ede6") ; inactive modeline
            (modeline-active "#dcd7f0") ; active modeline
            (modeline-record "#fdd9d2") ; recording modeline
            (base01          "#4d4d4d") ; modeline active (fg)
            (base00          "#4d4d4d") ; foreground, cursor
            (base0           "#ffffff") ;
            (base1           "#697799") ; region, comment, ace-jump base
            (base2           "#f2ede6") ; hl-line
            (base3           "#faf5ee") ; background
            (yellow          "#3388dd") ; type, highlight
            (orange          "#ac3d1a") ; preprocessor, regexp group
            (red             "#dd2222") ; warning, mismatch
            (magenta         "#8b008b") ; visited link
            (violet          "#00b7f0") ; link
            (blue            "#1388a2") ; function, variable name
            (cyan            "#104e8b") ; string, showparen, minibuffer
            (green           "#00688b") ; keyword, builtin, constant
            ))
    (color-theme-solarized-light)

    ;;   +--- ace-jump-mode

    (defpostload "ace-jump-mode"
      (case (frame-parameter nil 'background-mode)

        (dark (set-face-foreground 'ace-jump-face-foreground
                                   (my-solarized-color 'base3))
              (set-face-foreground 'ace-jump-face-background
                                   (my-solarized-color 'base01)))

        (light (set-face-foreground 'ace-jump-face-foreground
                                    (my-solarized-color 'base03))
               (set-face-foreground 'ace-jump-face-background
                                    (my-solarized-color 'base1)))

        ))

    ;;   +--- font-lock

    (defpostload "font-lock"

      ;; highlight regexp symbols
      ;; reference | http://pastelwill.jp/wiki/doku.php?id=emacs:init.el

      (set-face-foreground 'font-lock-regexp-grouping-backslash
                           (my-solarized-color 'red))

      (set-face-foreground 'font-lock-regexp-grouping-construct
                           (my-solarized-color 'red))
      )

    ;;   +--- highlight-parentheses

    ;; the last color is ignored
    ;; because of a bug in highlight-parentheses

    (defpostload "highlight-parentheses"

      (hl-paren-set 'hl-paren-colors nil)

      (hl-paren-set 'hl-paren-background-colors
                    (list (my-solarized-color 'modeline-active) "#000000"))
      )

    ;;   +--- paren

    (defpostload "paren"

      (set-face-attribute 'show-paren-match-face nil
                          :underline t
                          :bold t)

      (set-face-attribute 'show-paren-mismatch-face nil
                          :underline t
                          :bold t)
      )

    ;;   +--- flymake

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

    ;;   +--- whitespace

    (defpostload "whitespace"

      (set-face-attribute 'whitespace-space nil
                          :foreground (my-solarized-color 'modeline-active)
                          :background 'unspecified)

      (set-face-attribute 'whitespace-tab nil
                          :foreground (my-solarized-color 'modeline-active)
                          :background 'unspecified)
      )

    ;;   +--- lmntal-mode

    (defpostload "lmntal-mode"
      (set-face-background 'lmntal-link-name-face
                           (my-solarized-color 'lmntal-name)))

    ;;   +--- modeline

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

    (set-face-attribute 'mode-line-warning-face nil
                        :foreground (my-solarized-color 'base03)
                        :background (my-solarized-color 'yellow))

    (set-face-attribute 'mode-line-special-mode-face nil
                        :foreground (my-solarized-color 'cyan)
                        :weight 'bold)

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

    ;;   +--- phi-search

    (defpostload "phi-search-core"
      (set-face-background 'phi-search-match-face
                           (my-solarized-color 'modeline-active))
      (set-face-background 'phi-search-selection-face
                           (my-solarized-color 'modeline-record)))

    ;;   +--- indent-guide

    (defpostload "indent-guide"
      (case (frame-parameter nil 'background-mode)
        (dark (set-face-foreground 'indent-guide-face
                                   (my-solarized-color 'base01)))
        (light (set-face-foreground 'indent-guide-face
                                    (my-solarized-color 'base1)))
        ))

    ;;   +--- traverselisp

    (defpostload "traverselisp"
      (set-face-background 'traverse-overlay-face
                           (my-solarized-color 'base02)))

    ;;   +--- (sentinel)
    ))

;;    +--- (sublimity.el) load sublimity

(defconfig 'sublimity
  (sublimity-global-mode 1)
  (sublimity-scroll)
  (setq sublimity-scroll-weight 6
        sublimity-scroll-drift-length 4))

;; + (sentinel)
