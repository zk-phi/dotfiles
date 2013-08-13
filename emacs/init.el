;; init.el (for e23.3) | 2013 zk_phi

(eval-when-compile (require 'cl))

;; + docs
;; +--+ notes, todos

;; - sexpwise navigation and show-smartparens-mode in smartparens is
;;   super smart but noticalably slow (so is currently not used).

;; - multiple-cursors conflicts with key-combo, threfore key-combo is
;;   temporally disabled while multiple-cursors-mode is on

;; - indent-guide-mode seems to be buggy, so is disabled currently

;; - key-combo conflicts with auto-complete in some conditions (reported)

;; - hilit-chg does not work ?

;; +--+ cheat sheet
;;    +--+ global
;;       +--- format

;; Format
;; |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
;;    |     |     |     |     |     |     |     |     |     |     |     |     |
;;       |     |     |     |     |     |     |     |     |     |     |     |
;;          |     |     |     |     |     |     |     |     |     |     |

;;       +--- Ctrl-

;; C-_
;; |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  | Undo|     |     |     |
;;    | Quot| Cut | End |Rplce|TrsWd| Yank| PgUp| Tab | Open| U p |  *  |     |
;;       |MCNxt|Serch|Delte|Right| Quit| B S | Home|CutLn|Centr|Comnt|     |
;;          | Fold|  *  |  *  | PgDn| Left| Down|Retrn|MrkPg|     |     |

;;       +--- Ctrl-Meta-

;; C-M-_
;; |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  | Redo|     |     |     |
;;    |     | Copy|EdDef|RplAl|TrsLn|YankS|BgBuf| Fill|NNLin|BPgph|  *  |     |
;;       |MCAll|SrchB|KilWd|FWord|Abort|BKlWd|BgDef|KlPgh|Cntr0|  -  |     |
;;          |HidAl|     |     |EdBuf|BWord|NPgph|NLCom|MrkAl|     |     |

;;       +--- Meta-

;; M-_
;; |AlWnd|SpWnd|Blnce|Follw|     |     |     |SwWnd|PvWnd|NxWnd|LstCg|     |     |     |
;;    |Scrtc|Palet| Eval|Recnt|Table|YankP|Untab|Shell|Opcty|EvalP|     |     |
;;       |Artst| All | Dir | File| Grep|Shrnk| Jump|KlWnd| Goto|     |     |
;;          |     |Comnd|Cmpil| VReg|Buffr|Narrw|DMcro| Howm|     |     |

;;       +--- Meta-Shift-

;; M-Shift-
;; |     |     |     |     |     |     |     | Barf|Wrap(|Slurp| Undo|     |     |     |
;;    |     |CpSex|EvalR|Raise|TrsSx| Yank|RaisB|IdntX| Open|UpSex|     |     |
;;       |     |SpltS|KlSex|FwSex| Quit|KlSex|JoinS|KillX|Centr|CmntX|Wrap"|
;;          |     |     |     | Mark|BwSex|DnSex|Retrn|MkSex|     |     |

;;       +--- Ctrl-x Ctrl-

;; C-x C-_
;; |     |     |     |     |     |     |     |     |BgMcr|EdMcr|     |Scale|     |     |
;;    |     |Write|Encod|Revrt|Trnct|     |     |Spell|     |RdOly|     |     |
;;       |Align| Save|Dired|FindF|     |FHead|     |KilBf|CgLog|     |     |
;;          |     |     |Close|     |     |     |ExMcr|     |     |     |

;;       +--- others

;; -    <f1> : help prefix
;; -  M-<f4> : kill-emacs

;; -     TAB : indent / ac-expand
;; -     ESC : vi-mode
;; -   NConv : dabbrev-expand / yas-expand
;; -   C-RET : cua-set-rectangle-mark
;; -   C-SPC : set-mark-command / exchange-point-and-mark

;;    +--- key-combo

;; key-combo
;;
;; - C-M-w -> C-M-w :
;;        kill-ring-save -> register-oneshot-snippet
;;
;; -   C-j ->   C-j :
;;        back-to-indentation -> beginning-of-line

;;    +--- key-chord

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

;;    +--+ orgtbl-mode override
;;       +--- Ctrl-

;; C-_
;; |     | Edit|     |     |     |     |     |     |     |     |     |ColFm|     |     |
;;    |     |RcCut|     |     |TrRow|RcPst|     |FwCel|InRow|     |     |     |
;;       |     |     |     |     | Exit|     |     |     |     |     |     |
;;          |     |     |     |     |     |     |FwRow|     |     | Sort|

;;       +--- Ctrl-Meta-

;; C-M-_
;; |     |     |     |     |     |     |     |     |     |     |     |CelFm|     |     |
;;    |     |     |     |     |TrCol|AFill|     |InCol|InHrl|     |     |     |
;;       |     |     |     |FwCel|     |     |     |     |     |     |     |
;;          |     |     |     |     |BwCel|     |HrFwR|     |     |     |

;;       +--- Meta-

;; M-_
;; |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
;;    |     |     | Eval|     |     |     |     |     |     |     |     |     |
;;       |     |     |     |     |     |     |     |     |     |     |     |
;;          |     |     |     |     |     |     |     |     |     |     |

;; + codes
;; +--+ 0x00. init for init
;;    +--+ environment
;;       +--- system

(when (not (boundp 'my-home-system-p))
  (defconst my-home-system-p nil)
  (message "!! [init] WARNING: site-start.el does not match"))

(when (not my-home-system-p)
  (message "!! [init] WARNING: this is not my home system"))

(when (not (string-match "^23\." emacs-version))
  (message "!! [init] WARNING: emacs version is not 23.X"))

(when (not (eq 'windows-nt system-type))
  (message "!! [init] WARNING: system type is not windows-nt"))

;;       +--- customs

(defconst my:skip-checking-libraries my-home-system-p)

;;       +--- directories

(defconst my:init-directory "~/.emacs.d/")

(defconst my:dat-directory (concat my:init-directory "dat/"))
(defconst my:howm-directory (concat my:init-directory "howm/"))
(defconst my:eshell-directory (concat my:init-directory "eshell/"))
(defconst my:backup-directory (concat my:init-directory "backups/"))
(defconst my:snippets-directory (concat my:init-directory "snippets/"))
(defconst my:dictionary-directory (concat my:init-directory "ac-dict/"))

;;       +--- files

(defconst my:smex-save-file (concat my:dat-directory "smex.dat"))
(defconst my:mc-list-file (concat my:dat-directory "mc-list.dat"))
(defconst my:ditaa-jar-file (concat my:dat-directory "ditaa.jar"))
(defconst my:ac-history-file (concat my:dat-directory "ac-comphist.dat"))

;; system-specific files

(defconst my:ido-save-file (concat my:dat-directory "ido_" system-name ".dat"))
(defconst my:scratch-file (concat my:dat-directory "scratch_" system-name ".dat"))
(defconst my:recentf-file (concat my:dat-directory "recentf_" system-name ".dat"))
(defconst my:howm-keyword-file (concat my:dat-directory "howm-keys_" system-name ".dat"))
(defconst my:howm-history-file (concat my:dat-directory "howm-history_" system-name ".dat"))

;;       +--- dropbox integration

(defconst my:dropbox-directory
  (if my-home-system-p "~/../../Dropbox/"))

(defconst my:howm-import-directory
  (if my-home-system-p (concat my:dropbox-directory "howm_import/")))

(defconst my:howm-export-file
  (if my-home-system-p (concat my:dropbox-directory "howm_schedule.txt")))

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

;; +--+ 0x10. system, GUI
;;    +--- configurations

(fset 'yes-or-no-p 'y-or-n-p)

(setq frame-title-format                    "%b - Emacs"
      redisplay-dont-pause                  t
      completion-ignore-case                t
      read-file-name-completion-ignore-case t)

(when (fboundp 'set-message-beep)
  (set-message-beep 'silent))

;;    +--- [bytecomp.el] automatically byte-compile init.el

;; reference | http://www.bookshelf.jp/soft/meadow_18.html#SEC170

(add-hook 'after-save-hook
          (lambda()
            (let ((file (buffer-file-name)))
              (if (and file (string-match "init\\.el$" file))
                  (byte-compile-file file)))))

;;    +--- [frame.el] toggle-opacity

;; reference | http://d.hatena.ne.jp/IMAKADO/20090215/1234699972

(deflazyconfig '(toggle-opacity) "frame"
  (defun toggle-opacity()
    "toggle opacity"
    (interactive)
    (let ((current-alpha
           (or (cdr (assoc 'alpha (frame-parameters))) 100)))
      (set-frame-parameter nil 'alpha
                           (if (= current-alpha 100) 66 100)))))

;;    +--+ [ido.el] ido settings
;;       +--- (prelude)

(defconfig 'ido

  ;;     +--- ido save-file

  (setq ido-save-directory-list-file my:ido-save-file)

  ;;     +--- enable ido-mode

  (ido-mode t)
  (ido-everywhere t)

  ;;     +--- enable regexp

  (setq ido-enable-regexp t)

  ;;     +--- dwim complete command

  (defun my-ido-spc-or-next ()
    (interactive)
    (call-interactively
     (cond ((= (length ido-matches) 1) 'ido-exit-minibuffer)
           ((= (length ido-text) 0) 'ido-next-match)
           (t 'ido-restrict-to-matches))))

  (defun my-ido-exit-or-select ()
    (interactive)
    (call-interactively
     (if (= (length ido-matches) 0) 'ido-select-text
       'ido-exit-minibuffer)))

  ;;     +--- keymap

  ;; reference | http://github.com/milkypostman/dotemacs/blob/master/init.el

  (defun my-ido-hook ()
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
    (define-key ido-completion-map (kbd "TAB") 'my-ido-spc-or-next)
    (define-key ido-completion-map (kbd "<S-tab>") 'ido-prev-match)
    (define-key ido-completion-map (kbd "<backtab>") 'ido-prev-match)
    (define-key ido-completion-map (kbd "SPC") 'my-ido-spc-or-next)
    (define-key ido-completion-map (kbd "RET") 'my-ido-exit-or-select))

  (add-hook 'ido-minibuffer-setup-hook 'my-ido-hook)

  ;;     +--- (sentinel)
  )

;;    +--- [simple.el] print more on eval-expression

(setq eval-expression-print-length nil
      eval-expression-print-level  5)

;;    +--- [startup.el] inhibit startup messages

(defpostload "startup"
  (setq inhibit-startup-screen  t
        inhibit-startup-message t
        initial-scratch-message ""))

;;    +--- (flx-ido.el) use "flx" matching in ido

(defpostload "ido"
  (defconfig 'flx-ido
    (flx-ido-mode 1)))

;;    +--- (key-chord.el) key-chord settings

(defconfig 'key-chord

  (key-chord-mode 1)

  ;; make key-chord able to disable buffer-locally
  (make-variable-buffer-local 'key-chord-mode)
  (make-variable-buffer-local 'input-method-function)

  ;; disable in vi-mode
  (defpostload "vi"
    (defadvice vi-mode (after disable-key-chord activate)
      (setq key-chord-mode        nil
            input-method-function nil))
    (defadvice vi-goto-insert-state (after disable-key-chord activate)
      (setq key-chord-mode        t
            input-method-function 'key-chord-input-method)))

  ;; disable in view-mode
  (defpostload "view"
    (defadvice view-mode (after disable-key-chord activate)
      (setq key-chord-mode        nil
            input-method-function nil)))
  )

;;    +--+ (key-combo.el) key-combo settings
;;       +--- (prelude)

(defconfig 'key-combo

  ;;     +--- enable key-combo

  (global-key-combo-mode 1)

  ;;     +--- disable while in multiple-cursors-mode

  ;; key-combo commands are not executed with fake cursors (so disable)
  ;; key-combo doesn't seem to be compatible with "input-method"s
  ;; auto-complete should be disabled while key-combo is executing
  (defadvice key-combo-post-command-function (around mc-combo activate)
    (unless (or (and (boundp 'multiple-cursors-mode)
                     multiple-cursors-mode)
                current-input-method)
      ad-do-it))

  ;;     +--- (sentinel)
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

;;    +--- (ido-ubiquitous.el) enable ido-ubiquitous

(defpostload "ido"
  (defconfig 'ido-ubiquitous
    (ido-ubiquitous-mode)))

;;    +--- (smex.el) autoload smex

(deflazyconfig '(smex) "smex"
  (setq smex-save-file my:smex-save-file)
  (smex-initialize))

;; +--+ 0x11. windows
;;    +--- swap windows

;; reference | http://www.bookshelf.jp/soft/meadow_30.html#SEC400

(defun my-swap-windows ()
  "Swap two screens, with cursor in the same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))

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
    (my-split-window-horizontally-4
     (delete-window-n 3)
     (setq this-command 'my-split-window-horizontally-0))
    (my-split-window-horizontally-3
     (delete-window-n 2)
     (split-window-horizontally-n 4)
     (setq this-command 'my-split-window-horizontally-4))
    (my-split-window-horizontally-2
     (delete-window-n 2)
     (split-window-horizontally-n 2)
     (split-window-horizontally-n 2)
     (setq this-command 'my-split-window-horizontally-3))
    (my-split-window-horizontally-1
     (delete-window-n 1)
     (split-window-horizontally-n 3)
     (setq this-command 'my-split-window-horizontally-2))
    (my-split-window-horizontally-0
     (split-window-horizontally-n 2)
     (setq this-command 'my-split-window-horizontally-1))
    (my-split-window-vertically-2
     (delete-window-n 2)
     (setq this-command 'my-split-window-vertically-0))
    (my-split-window-vertically-1
     (delete-window-n 1)
     (split-window-vertically-n 3)
     (setq this-command 'my-split-window-vertically-2))
    (my-split-window-vertically-0
     (split-window-vertically-n 2)
     (setq this-command 'my-split-window-vertically-1))
    (t
     (if (> (my-window-width) (* 2 (window-height)))
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
  (automargin-mode 1))

;;    +--- (popwin.el) enable popwin

(defconfig 'popwin

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

  (setq display-buffer-function 'popwin:display-buffer)
  )

;;    +--- (pager.el) autoload pager

(deflazyconfig
  '(pager-row-up
    pager-row-down
    pager-page-up
    pager-page-down) "pager")

;;    +--- (smooth-scrolling.el) enable smooth-scrolling

(defconfig 'smooth-scrolling
  (setq smooth-scroll-margin 3))

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
    (insert-file-contents my:scratch-file)))

(add-hook 'kill-emacs-hook 'my-scratch-save)
(add-hook 'after-init-hook 'my-scratch-restore)

;;    +--- toggle-narrowing

;; enable narrowing
(put 'narrow-to-region 'disabled nil)

(defun my-is-narrowed-p ()
  "Returns if the buffer is narrowed"
  (or (not (= (point-min) 1)) (not (= (1+ (buffer-size)) (point-max)))))

(defun my-toggle-narrowing (s e)
  "If the buffer is narrowed, widen. Otherwise, narrow to region."
  (interactive "r")
  (if (my-is-narrowed-p) (widen) (narrow-to-region s e)))

;;    +--- (uniquify.el) enable uniquify

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
    (save-buffer) (kill-buffer) (delete-window))

  (defun my-add-change-log-entry ()
    (interactive)
    (split-window-vertically (* (/ (window-height) 3) 2))
    (other-window -1)
    (add-change-log-entry))

  (define-key change-log-mode-map (kbd "C-x C-s") 'my-change-log-save-and-kill)
  )

;;    +--+ [files.el] backup/auto-save files
;;       +--- (prelude)

(defconfig 'files

  ;;     +--- backup

  ;; backup directory

  (setq backup-directory-alist
        `( ("\\.*$" . ,(expand-file-name my:backup-directory))) )

  ;; version control
  ;; reference | http://aikotobaha.blogspot.jp/2010/07/emacs.html

  (setq version-control     t
        kept-new-versions   10
        kept-old-versions   1
        delete-old-versions t)

  ;; make backup even when VC is enabled

  (setq vc-make-backup-files t)

  ;;     +--- auto-save

  (setq auto-save-default      t
        delete-auto-save-files t)

  ;;     +--- (sentinel)
  )

;;    +--- [recentf.el] open recent files with ido

(deflazyconfig '(ido-recentf-open) "recentf"

  (defconfig 'ido)

  (setq recentf-save-file       my:recentf-file
        recentf-max-saved-items 100)

  (recentf-mode 1)

  ;; auto-save recentf-list / delayed cleanup
  ;; reference | http://d.hatena.ne.jp/tomoya/20110217/1297928222

  (run-with-idle-timer 20 t 'recentf-save-list)
  (setq recentf-auto-cleanup 60)

  ;; find recent file with ido completion
  ;; reference | http://www.masteringemacs.org/articles/2011/01/27/find-files-faster-recent-files-package/

  (defun ido-recentf-open ()
    "Use `ido-completing-read' to \\[find-file] a recent file"
    (interactive)
    (if (find-file
         (ido-completing-read "Find recent file: " recentf-list))
        (message "Opening file...")
      (message "Aborting")))
  )

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

;; +--+ 0x20. jumping around
;;    +--- visible-register

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

;;    +--+ [isearch.el] isearch settings
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
    (call-interactively 'isearch-forward-regexp)
    (when (use-region-p)
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

;;    +--- (ace-jump-mode.el) autoload ace-jump-mode

(deflazyconfig '(ace-jump-word-mode) "ace-jump-mode"
  (add-hook 'ace-jump-mode-end-hook 'recenter))

;;    +--- (all.el) all-mode settings

(deflazyconfig '(my-all-command) "all"

  (defun my-all-command ()
    (interactive)
    (delete-other-windows)
    (call-interactively 'all)
    (other-window 1))

  (defun my-all-exit ()
    (interactive)
    (kill-buffer)
    (delete-window))

  (defun my-all-next-line ()
    (interactive)
    (forward-line 1)
    (save-selected-window (all-mode-goto)))

  (defun my-all-previous-line ()
    (interactive)
    (forward-line -1)
    (save-selected-window (all-mode-goto)))

  (define-key all-mode-map (kbd "C-g") 'my-all-exit)
  (define-key all-mode-map (kbd "C-n") 'my-all-next-line)
  (define-key all-mode-map (kbd "C-p") 'my-all-previous-line)
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

  (defvar anything-window-height-fraction 0.6)

  (defun anything-split-window (buf)
    (split-window (selected-window)
                  (round (* (window-height) anything-window-height-fraction)))
    (other-window 1)
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
  '(phi-search phi-search-backward) "phi-search"
  (define-key phi-search-mode-map (kbd "C-M-s") 'phi-search-again-or-previous))

(deflazyconfig
  '(phi-replace phi-replace-query) "phi-replace"
  (setq phi-replace-weight 0)
  (define-key phi-replace-mode-map (kbd "C-u") 'phi-replace-scroll-down))

;;    +--- (point-undo.el) load point-undo

;; point-undo must be loaded before it actually be invoked
(defconfig 'point-undo)

;; +--+ 0x21. regions, kill-ring
;;    +--- eval region or last-sexp

(defun my-eval-sexp-dwim ()
  "eval-last-sexp or eval-region"
  (interactive)
  (call-interactively (if (use-region-p) 'eval-region
                        'eval-last-sexp)))

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

;;    +--- exchange-point-and-mark with set-mark

(dolist (command '(set-mark-command cua-set-mark))
  (eval
   `(defadvice ,command (around auto-exchange-point-and-mark activate)
      "if set-mark-command is called more than twice, exchange-point-and-mark"
      (if (not (and (interactive-p)
                    transient-mark-mode
                    mark-active))
          ad-do-it
        (setq this-command 'exchange-point-and-mark)
        (call-interactively 'exchange-point-and-mark)))))

;;    +--+ exchange-region
;;       +--- variables

(defvar exchange-region-pending-overlay nil)
(make-variable-buffer-local 'exchange-region-pending-overlay)

(defvar exchange-pending-face 'cursor)

;;       +--- exchange-region triggers

(dolist (command '(yank cua-paste))
  (eval
   `(defadvice ,command (around exchange-region-start activate)
      (if (and (interactive-p)
               (eq last-command 'kill-region))
          (progn
            (setq exchange-region-pending-overlay
                  (make-overlay (point) (1+ (point))))
            (overlay-put exchange-region-pending-overlay
                         'face exchange-pending-face))
        (progn
          (when exchange-region-pending-overlay
            (delete-overlay exchange-region-pending-overlay)
            (setq exchange-region-pending-overlay nil))
          ad-do-it)))))

;;       +--- execute exchange-region

(dolist (command '(kill-region cua-cut-region))
  (eval
   `(defadvice ,command (around exchange-region-exec activate)
      (if (not (and (interactive-p) transient-mark-mode mark-active
                    exchange-region-pending-overlay))
          ad-do-it
        (let* ((str (buffer-substring (region-beginning) (region-end)))
               (pending-pos (overlay-start exchange-region-pending-overlay))
               (pos (+ (region-beginning)
                       (if (< pending-pos (point)) (length str) 0))))
          (delete-region (region-beginning) (region-end))
          (goto-char (overlay-start exchange-region-pending-overlay))
          (delete-overlay exchange-region-pending-overlay)
          (setq exchange-region-pending-overlay nil)
          (insert str)
          (goto-char pos)
          (setq this-command 'kill-region))))))

;;    +--- [cua-base.el] rectangle mark

(defconfig 'cua-base

  (setq cua-enable-cua-keys nil)
  (cua-mode 1)

  ;; disable shift-region
  (defadvice cua--pre-command-handler-1 (around disable-shift-region activate)
    (flet ((this-single-command-raw-keys () nil))
      (let ((window-system t))
        ad-do-it)))
  )

;;    +--- [delsel.el] enable delete-selection

(defconfig 'delsel
  (delete-selection-mode 1))

;;    +--- [simple.el] some settings about regions
;;       +--- disable shift-region

(setq shift-select-mode nil)

;;       +--- kill whole line with kill-region

;; kill/copy whole line when no region is active
;; reference | http://dev.ariel-networks.com/Members/matsuyama/tokyo-emacs-02/

(defun copy-line (&optional arg)
  (interactive "p")
  (copy-region-as-kill
   (line-beginning-position)
   (line-beginning-position (1+ (or arg 1))))
  (message "Line copied"))

(defadvice kill-region (around kill-line-or-kill-region activate)
  (if (and (interactive-p) (not (use-region-p)))
      (kill-whole-line)
    ad-do-it))

(defadvice kill-ring-save (around kill-line-or-kill-region activate)
  (if (and (interactive-p) (not (use-region-p)))
      (copy-line)
    ad-do-it))

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
  (define-key browse-kill-ring-mode-map (kbd "j") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "C-p") 'browse-kill-ring-previous)
  (define-key browse-kill-ring-mode-map (kbd "k") 'browse-kill-ring-previous)
  (define-key browse-kill-ring-mode-map (kbd "C-g") 'browse-kill-ring-quit))

;;    +--- (expand-region.el) autoload expand-region

(deflazyconfig '(er/expand-region) "expand-region")

;; +--+ 0x22. whitespaces, newlines
;;    +--- shrink-spaces

(defun my-shrink-whitespaces ()
  "shrink adjacent whitespaces or newlines in dwim way"
  (interactive)
  (let ((bol (save-excursion (back-to-indentation) (point)))
        (eol (point-at-eol)))
    (cond ((= bol eol)
           (skip-chars-backward "\s\t\n")
           (delete-region (point)
                          (progn (skip-chars-forward "\s\t\n") (point)))
           (insert "\n")
           (when (char-after)
             (save-excursion (insert "\n"))))
          ((= (point) bol)
           (delete-region (point)
                          (progn (skip-chars-backward "\s\t\n") (point))))
          ((= (point) eol)
           (delete-region (point)
                          (progn (skip-chars-forward "\s\t\n") (point))))
          (t
           (skip-chars-backward "\s\t")
           (delete-region (point)
                          (progn (skip-chars-forward "\s\t") (point)))
           (insert " ")))))

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
  (call-interactively 'open-line)
  (save-excursion (forward-line)
                  (indent-according-to-mode)))

;;    +--- auto indent on yank

(defvar my-auto-indent-inhibit-modes
  '(fundamental-mode org-mode text-mode ahk-mode latex-mode))

(defadvice yank (around my-auto-indent activate)
  (if (member major-mode my-auto-indent-inhibit-modes)
      ad-do-it
    (indent-region (point) (progn ad-do-it (point)))))

;; for cua-mode buffers
(defadvice cua-paste (around my-auto-indent activate)
  (if (member major-mode my-auto-indent-inhibit-modes)
      ad-do-it
    (indent-region (point) (progn ad-do-it (point)))))

;; shrink indents on kill-line
;; reference | http://www.emacswiki.org/emacs/AutoIndentation

(defadvice kill-line (before my-auto-indent activate)
  (when (member major-mode my-auto-indent-inhibit-modes)
    (when (and (eolp) (not (bolp)))
      (forward-char 1)
      (just-one-space 0)
      (backward-char 1))))

;;    +--- [simple.el] delete-trailing-whitespace on save

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defadvice delete-trailing-whitespace (around echo-trailing-ws activate)
  "report that trailing whitespaces are deleted"
  (when (not (string= (buffer-string)
                      (progn ad-do-it (buffer-string))))
    (message "trailing whitespace deleted")
    (sit-for 0.4)))

;;    +--- [whitespace.el] visible whitespaces

(defconfig 'whitespace

  (global-whitespace-mode)

  (setq whitespace-space-regexp "\\(\x3000+\\)")

  (setq whitespace-style
        '(face tabs spaces space-mark tab-mark))

  (setq whitespace-display-mappings
        '((space-mark ?\x3000 [?□])
          (tab-mark ?\t [?\xBB ?\t])))
  )

;;    +--- (hungry-delete.el) delete all adjacent spaces

(defconfig 'hungry-delete)

;; hungry-backspace in hungry-delete.el, eats current-buffer even when
;; minibuffer is active. So use backward-delete-char-untabify instead.
(setq backward-delete-char-untabify-method 'hungry)

;; +--+ 0x23. manipulate "thing"s
;;    +--- split camelCase words

;; reference | http://smallsteps.seesaa.net/article/123661899.html

(define-category ?U "Upper case")
(define-category ?L "Lower case")

(modify-category-entry '(?A . ?Z) ?U)
(modify-category-entry '(?a . ?z) ?U)

(add-to-list 'word-separating-categories (cons ?L ?U))

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
        (t
         (transpose-chars -1)
         (forward-char))))

;; +--+ 0x24. expressions, parens
;;    +--- eval-and-replace-sexp

(defun my-eval-and-replace-sexp ()
  "Evaluate the sexp at point and replace it with its value"
  (interactive)
  (let ((value (eval-last-sexp nil)))
    (kill-sexp -1)
    (insert (format "%S" value))))

;;    +--+ [lisp.el] some sexpwise operations
;;       +--- utilities

(defun my-sexpwise-operations-available-p ()
  "check if the point is not in string literals and comments"
  (let ((quick-syntax-info (syntax-ppss)))
    (and (not (nth 3 quick-syntax-info))
         (not (nth 4 quick-syntax-info)))))

(defun my-beginning-of-sexp-p ()
  (and (my-sexpwise-operations-available-p)
       (= (point)
          (save-excursion
            (if (condition-case err (forward-sexp) (error t))
                -1
              (or (ignore-errors (backward-sexp) (point))
                  -1))))))

(defun my-end-of-sexp-p ()
  (and (my-sexpwise-operations-available-p)
       (= (point)
          (save-excursion
            (if (condition-case err (backward-sexp) (error t))
                -1
              (or (ignore-errors (forward-sexp) (point))
                  -1))))))

;;       +--- commands

(defun my-mark-sexp ()
  (interactive)
  (if (my-end-of-sexp-p) (mark-sexp -1)
    (mark-sexp 1)))

(defun my-yank-sexp ()
  (interactive)
  (save-excursion
    (my-mark-sexp)
    (call-interactively 'kill-ring-save)))

(defun my-transpose-sexps ()
  (interactive)
  (transpose-sexps -1))

(defun my-down-list ()
  (interactive)
  (if (my-end-of-sexp-p) (down-list -1)
    (down-list 1)))

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

(defun my-reindent-sexp ()
  (interactive)
  (save-excursion
    (my-mark-sexp)
    (indent-for-tab-command)))

(defun my-overwrite-sexp ()
  (interactive)
  (my-mark-sexp)
  (delete-region (region-beginning)
                 (region-end))
  (call-interactively 'yank))

;;    +--- [paren.el] enable show-paren-mode

(defconfig 'paren

  (show-paren-mode)
  (make-variable-buffer-local 'show-paren-mode)

  (setq show-paren-delay 0)
  )

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
;;       +--- utilities

(defpostload "paredit"

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
  )

;;       +--+ automatically splice with delete-char
;;          +--- commands

(deflazyconfig
  '(my-paredit-delete-forward
    my-paredit-delete-backward
    my-paredit-delete-worward-word
    my-paredit-delete-backward-word) "paredit"

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
    )

;;          +--- keybinds

(defprepare "paredit"

  ;; use my-delete-forward/backward commands on lisp-mode
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

;;       +--- other settings

(deflazyconfig
  '(my-paredit-kill
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
                              (when (= (char-after) ?\s)
                                (delete-char 1)))))
        ;; lisp modes
        ;; => automatically insert SPC just after "("
        ad-do-it
        (when (my-beginning-of-sexp-p)
          (save-excursion (just-one-space)))))
    )

;;    +--- (rainbow-delimiters.el) enable rainbow-delimiters

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

;;    +--+ (smartparens.el) smartparens settings
;;       +--- (prelude)

(defconfig 'smartparens-config

  ;;     +--- configures

  (setq sp-autoinsert-if-followed-by-same 0
        sp-autoinsert-if-followed-by-word t
        sp-autoescape-string-quote        t
        sp-highlight-pair-overlay         nil
        ;; => see also "my-paredit-delete-xxx"
        sp-autodelete-pair                t
        sp-autodelete-wrap                t
        )

  ;;     +--- enable smartparens

  (smartparens-global-mode)

  ;;     +--- add japanese parens

  (dolist (pair '(("（" . "）") ("「" . "」") ("｛" . "｝")
                  ("［" . "］") ("【" . "】") ("『" . "』")
                  ("〔" . "〕")))
    (funcall 'sp-pair (car pair) (cdr pair)))

  ;;     +--- automatically insert " " between sexps

  (defadvice sp-insert-pair (after sp-autospace-for-lisp activate)
    (when (and (member major-mode
                       '(lisp-mode emacs-lisp-mode scheme-mode
                                   lisp-interaction-mode))
               (= (char-before) ?\()
               (= (char-after) ?\)))
      (when (save-excursion (backward-char) (my-end-of-sexp-p))
        (save-excursion (backward-char) (insert " ")))
      (when (save-excursion (forward-char) (my-beginning-of-sexp-p))
        (save-excursion (forward-char) (insert " ")))))

  ;;     +--- disable autoinsert in vi-mode

  (defpostload "vi"
    (defadvice sp--self-insert-command (around vi-disable-sp activate)
      (let ((buffer-read-only (eq major-mode 'vi-mode)))
        ad-do-it)))

  ;;     +--- (sentinel)
  )

;; +--+ 0x25. abbrevs, snippets
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
  (call-interactively 'dabbrev-expand)
  (insert " "))

;;    +--+ (key-combo.el) smartchr-like commands
;;       +--- (prelude)

(defpostload "key-combo"

  ;;     +--- smartchr for C-like languages

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
    (key-combo-define-local (kbd "+") '(" + " "++"))
    (key-combo-define-local (kbd "+=") " += ")
    ;; vv conflict with electric-case vv
    (key-combo-define-local (kbd "-") '(" - " "--" "-"))
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

  ;;     +--- smartchr for C

  (defun my-install-c-smartchr ()
    ;; pointers
    (key-combo-define-local (kbd "&") '("&" " && " " & "))
    (key-combo-define-local (kbd "*") '(" * " "*"))
    (key-combo-define-local (kbd "->") "->")
    ;; include
    (key-combo-define-local (kbd "<") '(" < " " << " "<"))
    (key-combo-define-local (kbd ">") '(" > " " >> " ">"))
    ;; triary operation
    (key-combo-define-local (kbd "?") '( " ? `!!' : " "?")))

  (defpostload "cc-mode"
    (add-hook 'c-mode-hook 'my-install-c-smartchr))

  ;;     +--- smartchr for Java

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

  ;;     +--- smartchr for promela

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

  ;;     +--- smartchr for lisp-like languages

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

  ;;     +--- smartchr for emacs-lisp

  (defun my-install-elisp-smartchr ()
    (key-combo-define-local (kbd "#") '("#" ";;;###autoload")))

  (defpostload "lisp-mode"
    (add-hook 'emacs-lisp-mode-hook 'my-install-elisp-smartchr))

  ;;     +--- smartchr for html

  (defun my-html-sp-or-smart-lt ()
    "smart insertion of brackets for sgml languages"
    (interactive)
    (if (use-region-p)
        (if (and (boundp 'smartparens-mode) smartparens-mode)
            (call-interactively       ; wrap with a tag (by smartparens)
             'sp--self-insert-command)
          (let ((beg (region-beginning)) ; wrap with <>
                (end (region-end)))
            (deactivate-mark)
            (save-excursion
              (goto-char beg)
              (insert "<")
              (goto-char (+ 1 end))
              (insert ">"))))
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
    (key-combo-define-local (kbd "+") '(" + " " ++ " " +++ "))
    (key-combo-define-local (kbd "-") '(" - " "-")) ; maybe unary
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
    (key-combo-define-local (kbd "+") '(" + " "+"))
    (key-combo-define-local (kbd "-") '(" - " "-"))
    (key-combo-define-local (kbd "*") '(" * " "*")))

  (defpostload "coq"
    (add-hook 'coq-mode-hook 'my-install-coq-smartchr))

  ;;     +--- smartchr for LMNtal

  (defun my-lmntal-smart-pipes ()
    "insert pipe surrounded by spaces"
    (interactive)
    (if (looking-back "\\[")
        (insert "| ")
      (insert (concat (unless (looking-back " ") " ")
                      "|"
                      (unless (looking-at " ") " ")))))

  (defun my-lmntal-smart-thrashes ()
    (interactive)
    (if (looking-back "}")
        (insert "/")
      (insert (concat (unless (looking-back " ") " ")
                      "/"
                      (unless (looking-at " ") " ")))))

  (defun my-install-lmntal-smartchr ()
    ;; comments, periods
    (key-combo-define-local (kbd "%") "% ")
    (key-combo-define-local (kbd "//") "// ")
    ;; (key-combo-define-local (kbd "/*") "/*\n`!!'\n*/")
    ;; toplevel
    (key-combo-define-local (kbd ":-") " :- ")
    (key-combo-define-local (kbd "|") '(my-lmntal-smart-pipes))
    ;; arithmetic
    (key-combo-define-local (kbd "+") " + ")
    (key-combo-define-local (kbd "-") " - ")
    (key-combo-define-local (kbd "*") " * ")
    (key-combo-define-local (kbd "/") '(my-lmntal-smart-thrashes))
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

;;    +--+ (auto-complete.el) auto-complete settings
;;       +--- (prelude)

(defconfig 'auto-complete-config

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

  ;;     +--- auto-complete sources

  (setq-default ac-sources
                '(ac-source-dictionary
                  ac-source-words-in-same-mode-buffers))

  ;; ac-source-symbols is very very nice but buggy
  (defun my-ac-elisp-sources ()
    (setq ac-sources
          '(ac-source-filename
            ac-source-dictionary
            ac-source-words-in-buffer
            ac-source-functions
            ac-source-variables
            ac-source-features)))

  (defpostload "lisp-mode"
    (add-hook 'emacs-lisp-mode-hook 'my-ac-elisp-sources)
    (add-hook 'lisp-interaction-mode-hook 'my-ac-elisp-sources))

  (defun my-ac-css-sources ()
    (setq ac-sources
          '(ac-source-filename
            ac-source-css-property
            ac-source-dictionary
            ac-source-words-in-same-mode-buffers)))

  (defpostload "css-mode"
    (add-hook 'css-mode-hook 'my-ac-css-sources))

  (defun my-ac-eshell-sources ()
    (setq ac-sources
          '(ac-source-files-in-current-dir
            ac-source-words-in-same-mode-buffers)))

  (defpostload "eshell"
    (add-hook 'eshell-mode-hook 'my-ac-eshell-sources))

  ;;     +--- minor adjustments

  (setq ac-auto-start     t
        ac-dwim           t
        ac-delay          0
        ac-auto-show-menu 0.8
        ac-disable-faces  nil)

  ;;     +--- (sentinel)
  )

;;    +--+ (yasnippet.el) yasnippet settings
;;       +--- load yasnippet in idle-time

(defprepare "yasnippet"
  (idle-require 'yasnippet))

;;       +--- (prelude)

(deflazyconfig
  '(yas-expand
    my-yas-expand-oneshot
    my-yas-register-oneshot) "yasnippet"

    ;;   +--- snippets directory

    (setq yas-snippet-dirs (list my:snippets-directory))

    ;;   +--- enable yasnippet

    (yas-global-mode 1)
    (call-interactively 'yas-reload-all)

    ;;   +--- allow nested snippets

    (setq yas-triggers-in-field t)

    ;;   +--- use dabbrev as fallback

    (setq yas-fallback-behavior '(apply my-dabbrev-expand . nil))

    ;;   +--- use ido-prompt

    (custom-set-variables '(yas-prompt-functions '(yas-ido-prompt)))

    ;;   +--- oneshot snippet

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
                     "Press \\[my-yas-expand-oneshot] to expand.")))

    ;;   +--- fix fallback behavior

    ;; let fallback-behavior be return-nil while expanding snippets

    (add-hook 'yas-before-expand-snippet-hook
              (lambda()
                (setq yas-fallback-behavior 'return-nil)))

    (add-hook 'yas-after-exit-snippet-hook
              (lambda()
                (setq yas-fallback-behavior '(apply my-dabbrev-expand . nil))))

    ;;   +--- keybinds

    (define-key yas-minor-mode-map (kbd "TAB") nil)   ; auto-complete
    (define-key yas-minor-mode-map (kbd "<tab>") nil) ; auto-complete

    (define-key yas-keymap (kbd "TAB") nil)   ; auto-complete
    (define-key yas-keymap (kbd "<tab>") nil) ; auto-complete

    (define-key yas-keymap (kbd "<oem-pa1>") 'yas-next-field-or-maybe-expand)
    (define-key yas-keymap (kbd "<muhenkan>") 'yas-next-field-or-maybe-expand)
    (define-key yas-keymap (kbd "<nonconvert>") 'yas-next-field-or-maybe-expand)

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

;; +--+ 0x30. programming modes
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
    (define-key map (kbd "C-M-j") nil))

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
        lmntal-unyo-directory "~/Work/LMNtal/LaViT2_6_2/lmntal/unyo1_1_1/"))

;;    +--- (prolog-mode.el) prolog-mode settings

(defprepare "prolog"
  (add-to-list 'auto-mode-alist '("\\.swi$" . prolog-mode)))

(deflazyconfig '(prolog-mode) "prolog"
  (define-key prolog-mode-map (kbd "M-a") nil)
  (define-key prolog-mode-map (kbd "M-q") nil)
  (define-key prolog-mode-map (kbd "M-RET") nil)
  (define-key prolog-mode-map (kbd "C-M-h") nil)
  (define-key prolog-mode-map (kbd "C-M-e") nil)
  (define-key prolog-mode-map (kbd "C-M-n") nil)
  (define-key prolog-mode-map (kbd "C-M-p") nil)
  (define-key prolog-mode-map (kbd "M-e") nil))

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
    (unless (string-match
             "}" (buffer-substring (point) (point-at-eol)))
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

;; +--+ 0x31. other modes
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

  ;; disable key-combo locally (otherwise C-M-w is overriden)
  (defpostload "key-combo"
    (defadvice key-combo-post-command-function (around artist-combo activate)
      (unless artist-mode
        ad-do-it)))

  ;;     +--- (sentinel)
  )

;;    +--+ [calendar.el] calendar settings for howm
;;       +--- (prelude)

(defpostload "calendar"

  ;;     +--- exit calendar and kill buffer

  (defun my-calendar-exit ()
    (interactive)
    (calendar-exit)
    (kill-buffer "*Calendar*"))

  ;;     +--- insert date in "howm" format

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

  ;;     +--- keybinds

  (define-key calendar-mode-map (kbd "RET") 'my-insert-day)
  (define-key calendar-mode-map (kbd "C-g") 'my-calendar-exit)

  ;;     +--- (sentinel)
  )

;;    +--- [dired.el] dired settings

(defpostload "dired"

  ;; show summary on startup

  (add-hook 'dired-mode-hook 'dired-summary)

  ;; add "[Dired]" on dired mode buffer
  ;; reference | http://qiita.com/items/13585a5711d62e9800ef

  (add-hook 'dired-mode-hook
            (lambda ()
              (rename-buffer (concat "[Dired]" (buffer-name)) t)))
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
      (when (and (boundp 'shell-pop-internal-mode-buffer)
                 (string= (buffer-name) shell-pop-internal-mode-buffer))
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
    (print file)
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
;;       +--- (prelude)

(defpostload "vi"

  ;;     +--- do not put cursor at eol

  (defun my-vi-maybe-backward-char ()
    (when (and (eolp) (not (bolp)) (not mark-active))
      (backward-char)))

  (defun my-vi-forward-char ()
    (interactive)
    (unless (= (if mark-active
                   (point-at-eol)
                 (1- (point-at-eol)))
               (point))
      (call-interactively 'forward-char)))

  (defun my-vi-previous-line ()
    (interactive)
    (previous-line 1)
    (my-vi-maybe-backward-char))

  (defun my-vi-next-line ()
    (interactive)
    (next-line 1)
    (my-vi-maybe-backward-char))

  (defun my-vi-end-of-line ()
    (interactive)
    (end-of-line)
    (my-vi-maybe-backward-char))

  (defun my-vi-backward-char ()
    (interactive)
    (unless (bolp)
      (call-interactively 'backward-char)))

  (defadvice vi-mode (after vi-maybe-backward-char activate)
    (my-vi-maybe-backward-char))

  (define-key vi-com-map "h" 'my-vi-backward-char)
  (define-key vi-com-map "j" 'my-vi-next-line)
  (define-key vi-com-map "k" 'my-vi-previous-line)
  (define-key vi-com-map "l" 'my-vi-forward-char)
  (define-key vi-com-map "$" 'my-vi-end-of-line)

  ;;     +--- redo+ integration

  (defprepare "redo+"
    (define-key vi-com-map "\C-r" 'redo)
    (define-key vi-com-map "u" 'undo-only))

  ;;     +--- vi-like paren-matching

  (defadvice show-paren-function (around vi-show-paren activate)
    (if (eq major-mode 'vi-mode)
        (save-excursion (forward-char) ad-do-it)
      ad-do-it))

  ;;     +--- make cursor "box" while in vi-mode

  (defadvice vi-mode (after make-cursor-box-while-vi activate)
    (setq cursor-type 'box))

  (defadvice vi-goto-insert-state (after make-cursor-box-while-vi activate)
    (setq cursor-type 'bar))

  ;;     +--- keybinds

  (define-key vi-com-map (kbd "v") 'set-mark-command)

  ;;     +--- (sentinel)
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

    ;; global-hl-line-mode must be made buffer-local
    (setq global-hl-line-mode nil)

    ;; show-paren-mode must be made buffer-local
    (setq show-paren-mode nil)
    )

  (add-hook 'view-mode-hook 'my-view-mode-hook)

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
        howm-menu-schedule-days        60
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

  (defun my-howm-import-from-dir (dir)
    (when dir
      (mapc (lambda (filename)
              (let ((abs-path (concat dir filename)))
                (howm-remember)
                (insert-file-contents abs-path)
                (beginning-of-buffer)
                (if (not (y-or-n-p (format "import %s ? " filename)))
                    (howm-remember-discard)
                  (let ((howm-template
                         (concat "* メモ " filename "\n\n%cursor")))
                    (howm-remember-submit)
                    (delete-file abs-path)))))
            (delq nil
                  (mapcar (lambda (file) (and (file-regular-p (concat dir file)) file))
                          (directory-files dir))))))

  (add-hook 'howm-menu-hook
            (lambda()
              (my-howm-import-from-dir my-howm-import-directory)))

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

  (defvar my-howm-export-file my:howm-export-file)

  (defun my-howm-export-to-file (filename)
    (with-temp-file filename
      ;; dropbox App can open only utf-8 documents
      (set-buffer-file-coding-system 'utf-8)
      (insert (format "* Howm Schedule %s ~ %s *\n"
                      (howm-reminder-today)
                      (howm-reminder-today howm-menu-schedule-days)))
      (insert (howm-menu-reminder))
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
  (define-key howm-mode-map (kbd "M-c") 'calendar)

  ;; howm menu
  (define-key howm-menu-mode-map (kbd "q") 'my-howm-exit)

  ;; howm remember
  (define-key howm-remember-mode-map (kbd "C-g") 'howm-remember-discard)
  (define-key howm-remember-mode-map (kbd "C-x C-s") 'howm-remember-submit)

  ;;     +--- (sentinel)
  )

;; +--+ 0x32. coding assistants
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

;;    +--- *COMMENT* (indent-guide.el) enable indent-guide

;; (defconfig 'indent-guide
;;   (indent-guide-global-mode))

;;    +--- (outline-magic.el) outline-cycle-dwim

(defprepare "outline-magic"
  (defpostload "outline"

    (defun outline-cycle-dwim ()
      (interactive)
      (if (or (outline-on-heading-p) (= (point) 1))
          (outline-cycle)
        (indent-for-tab-command)))

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

;; +--+ 0x32. other commands
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
          (call-interactively 'mc/edit-lines)
        (setq this-command 'mc/mark-next-like-this)
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

    ;;   +--- cua hacks

    ;; add not only "killed-rectangle" but "cua--last-killed-rectangle"

    (defconfig 'cua-rect

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
      )

    ;;   +--- (sentinel)
    )

;;    +--- (nav.el) autoload nav

(defprepare "nav"
  (idle-require 'nav))

(deflazyconfig '(my-nav-toggle) "nav"

  (defun my-nav-toggle ()
    (interactive)
    ;; if the left margin (perhaps createed by automargin)
    ;; is larger than nav-width, open nav there.
    (let ((nav-width
           (max nav-width
                (- (or (car (window-margins)) 0) 3))))
      (nav-toggle))
    (message "o-pen u-p c-opy m-ove d-elete n-ew SPC-index"))

  (define-key nav-mode-map (kbd "C-g") 'nav-unsplit-window-horizontally)
  (define-key nav-mode-map (kbd "M-d") 'nav-unsplit-window-horizontally)
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

;;    +--- (redo+.el) load redo+

(defconfig 'redo+)

;; +--+ 0xf0. keybinds
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
(global-set-key (kbd "M-b") 'switch-to-buffer)

;; Ctrl-x
(global-set-key (kbd "C-x C-w") 'write-file)
(global-set-key (kbd "C-x C-s") 'save-buffer)
(global-set-key (kbd "C-x C-k") 'kill-buffer)
(global-set-key (kbd "C-x C-e") 'set-buffer-file-coding-system)
(global-set-key (kbd "C-x C-r") 'revert-buffer-with-coding-system)

;;          +--- frame, window

;; Meta-
(global-set-key (kbd "M-0") 'next-multiframe-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'my-split-window)
(global-set-key (kbd "M-3") 'balance-windows)
(global-set-key (kbd "M-4") 'follow-delete-other-windows-and-split)
(global-set-key (kbd "M-8") 'my-swap-windows)
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
(global-set-key (kbd "C-j") 'move-beginning-of-line)
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

;;       +--+ edit
;;          +--- undo, redo

;; Ctrl-
(global-set-key (kbd "C--") '("redo+" undo-only undo))

;; Ctrl-Meta-
(global-set-key (kbd "C-M--") '("redo+" redo repeat-complex-command))

;; Meta-Shift-
(global-set-key (kbd "M-_") 'undo)

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
(global-set-key (kbd "C-<return>") 'cua-set-rectangle-mark)

;;          +--- kill, yank

;; when "DEL" is defined,
;; backward-delete-char on minibuffer sometimes doesn't work

;; Ctrl-
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "C-d") '("hungry-delete" hungry-delete delete-char))
;; (global-set-key (kbd "DEL") 'backward-delete-char-untabify) ; C-h
(global-set-key (kbd "C-y") 'yank)

;; Ctrl-Meta-
(global-set-key (kbd "C-M-w") 'kill-ring-save)
(global-set-key (kbd "C-M-k") 'my-kill-line-backward)
(global-set-key (kbd "C-M-d") 'kill-word)
(global-set-key (kbd "C-M-h") 'backward-kill-word)
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
(global-set-key (kbd "C-M-o") 'my-next-opened-line)
(global-set-key (kbd "C-M-m") 'indent-new-comment-line)

;; Meta-
(global-set-key (kbd "M-u") 'untabify)

;; Meta-Shift-
(global-set-key (kbd "M-I") 'my-reindent-sexp)
(global-set-key (kbd "M-O") 'my-open-line-and-indent)
(global-set-key (kbd "M-M") '("paredit" paredit-newline newline-and-indent))

;; Ctrl-x
(global-set-key (kbd "C-x C-a") 'align)

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
(global-set-key (kbd "M-(") '("paredit" paredit-wrap-round))
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
(global-set-key (kbd "M-d") '("nav" my-nav-toggle dired))
(global-set-key (kbd "M-f") 'find-file)
(global-set-key (kbd "M-g") '("traverselisp" traverse-deep-rfind rgrep))
(global-set-key (kbd "M-r") 'ido-recentf-open)

;; Ctrl-x
(global-set-key (kbd "C-x DEL") 'ff-find-other-file) ; C-x C-h
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C-x C-f") 'find-file)

;;          +--- shell command

;; Meta-
(global-set-key (kbd "M-i") '("shell-pop" shell-pop eshell))

;;       +--- help

(define-prefix-command 'help-map)

(global-set-key (kbd "<f1>") 'help-map)
(global-set-key (kbd "M-?") 'help-map)

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
(global-set-key (kbd "C-x C-p") 'toggle-read-only)
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
      (key-chord-define phi-search-mode-map "hj" 'phi-search-again-or-next)
      (key-chord-define phi-search-mode-map "fg" 'phi-search-again-or-previous)))
  (defprepare "ace-jump-mode"
    (key-chord-define-global "jl" 'ace-jump-word-mode))
  )

;;    +--- keycombo

(defpostload "key-combo"

  (key-combo-define-global (kbd "C-j")
                           '(back-to-indentation beginning-of-line))

  (defprepare "yasnippet"
    (key-combo-define-global (kbd "C-M-w")
                             '(kill-ring-save my-yas-register-oneshot)))
  )

;; +--+ 0xf1. appearance
;;    +--- configurations

(setq-default truncate-lines       t
              line-move-visual     t
              cursor-type          'bar
              indicate-empty-lines t)

;;    +--- font

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
   ;;       +--- window position

   " "
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
       'face 'mode-line-bright-face)))

   ;;       +--- linum

   (:propertize ":" face mode-line-dark-face)
   (:propertize "%4l" face mode-line-bright-face)

   ;;       +--- colnum

   (:propertize ":" face mode-line-dark-face)
   (:eval
    (propertize "%2c" 'face
                (if (>= (current-column) 80)
                    'mode-line-warning-face
                  'mode-line-bright-face)))

   ;;       +--- indicators

   " "
   (:eval
    (if (or (/= (point-min) 1) (/= (point-max) (1+ (buffer-size))))
        (propertize "n" 'face 'mode-line-narrowed-face)
      (propertize "n" 'face 'mode-line-dark-face)))
   (:eval
    (if buffer-read-only
        (propertize "%%" 'face 'mode-line-read-only-face)
      (propertize "%%" 'face 'mode-line-dark-face)))
   (:eval
    (if (buffer-modified-p)
        (propertize "*" 'face 'mode-line-modified-face)
      (propertize "*" 'face 'mode-line-dark-face)))
   (:eval
    (if (and (boundp 'multiple-cursors-mode) multiple-cursors-mode)
        (propertize (format "%02d" (mc/num-cursors))
                    'face 'mode-line-mc-face)
      (propertize "00" 'face 'mode-line-dark-face)))

   ;;       +--- directory / file name

   "  "
   (:propertize "%[" face mode-line-dark-face)
   (:eval
    (propertize (my-shorten-directory 10)
                'face 'mode-line-dark-face))
   (:propertize "%b" face mode-line-highlight-face)
   (:propertize "%]" face mode-line-dark-face)

   ;;       +--- major-mode / coding system

   "  "
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
     (format " %s" (symbol-name buffer-file-coding-system))
     'face 'mode-line-dark-face))

   ;;       +--- others

   "  "
   (global-mode-string global-mode-string)
   (:propertize " %-" face mode-line-dark-face)

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

;; reference | http://stackoverflow.com/questions/9990370/how-to-disable-hl-line-feature-in-specified-mode

(defconfig 'hl-line
  (global-hl-line-mode 1)
  (make-variable-buffer-local 'global-hl-line-mode))

;;    +--- [menu-bar.el] disable menu-bar

(defpostload "menu-bar"
  (menu-bar-mode -1))

;;    +--- [scroll-bar.el] disable scroll-bar

(defpostload "scroll-bar"
  (scroll-bar-mode -1))

;;    +--- [tool-bar.el] disable tool-bar

(defpostload "tool-bar"
  (tool-bar-mode -1))

;;    +--- [time.el] display time in mode-line

(defconfig 'time
  (setq display-time-string-forms '(24-hours ":" minutes))
  (display-time))

;;    +--- (page-break-lines.el) enable page-break-lines

(defconfig 'page-break-lines
  (global-page-break-lines-mode))

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
    ;;         (base01          "#586e75") ; region, comment
    ;;         (base00          "#657b83") ;
    ;;         (base0           "#839496") ; foreground, cursor
    ;;         (base1           "#93a1a1") ; modeline active (fg)
    ;;         (base2           "#eee8d5") ;
    ;;         (base3           "#fdf6e3") ;
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
    ;;         (base01          "#666666") ; region, comment
    ;;         (base00          "#ffffff") ;
    ;;         (base0           "#b8b8a3") ; foreground, cursor
    ;;         (base1           "#a8b8b3") ; modeline active (fg)
    ;;         (base2           "#ffffff") ;
    ;;         (base3           "#ffffff") ;
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
          '((base03          "#ffffff") ;
            (lmntal-name     "#fdfdfd") ; for lmntal-mode (bg)
            (flymake-err     "#fff0e9") ; flymake highlight
            (base02          "#ede9e2") ; inactive modeline
            (modeline-active "#ddd9f2") ; active modeline
            (modeline-record "#fdd9d2") ; recording modeline
            (base01          "#4d4d4d") ; modeline active (fg)
            (base00          "#4d4d4d") ; foreground, cursor
            (base0           "#ffffff") ;
            (base1           "#697799") ; region, comment
            (base2           "#ede9e2") ; hl-line
            (base3           "#f6f2eb") ; background
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

      (set-face-foreground 'ace-jump-face-foreground
                           (my-solarized-color 'base3))

      (set-face-foreground 'ace-jump-face-background
                           (my-solarized-color 'base01))
      )

    ;;   +--- font-lock

    (defpostload "font-lock"

      ;; highlight regexp symbols
      ;; reference | http://pastelwill.jp/wiki/doku.php?id=emacs:init.el

      (set-face-foreground 'font-lock-regexp-grouping-backslash
                           (my-solarized-color 'orange))

      (set-face-foreground 'font-lock-regexp-grouping-construct
                           (my-solarized-color 'orange))
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
                          :foreground (my-solarized-color 'yellow)
                          :background 'unspecified)

      (set-face-attribute 'whitespace-tab nil
                          :foreground (my-solarized-color 'yellow)
                          :background 'unspecified)
      )

    ;;   +--- lmntal-mode

    (defpostload "lmntal-mode"
     (set-face-background 'lmntal-name-face
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

    (defpostload "phi-search"
      (set-face-background 'phi-search-match-face
                           (my-solarized-color 'modeline-active))
      (set-face-background 'phi-search-selection-face
                           (my-solarized-color 'modeline-record)))

    ;;   +--- (sentinel)
    ))

;;    +--- *COMMENT* (sublimity.el) load sublimity

;; (defconfig 'sublimity
;;   (sublimity-global-mode 1)
;;   (sublimity-scroll))

;; + (sentinel)
