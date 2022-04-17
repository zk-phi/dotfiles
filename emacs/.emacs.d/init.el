;;; -*- lexical-binding: t -*-
;; init.el (for Emacs 28.1) | 2012- zk_phi

(eval-when-compile
  (require 'setup)
  (require 'subr-x)
  (require 'cl-macs)
  (setq setup-silent t
        ;; setup-delay-with-threads t
        setup-delay-interval 0.5
        setup-enable-gc-threshold-hacks t
        ;; setup-use-profiler t
        ;; setup-use-load-history-tracker t
        setup-disable-magic-file-name t))
(setup-initialize)

;; + Cheat Sheet :
;; + | global

;; |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  |  -  |  =  |  `  |
;;    |  Q  |  W  |  E  |  R  |  T  |  Y  |  U  |  I  |  O  |  P  |  [  |  ]  |
;;       |  A  |  S  |  D  |  F  |  G  |  H  |  J  |  K  |  L  |  ;  |  '  |  \  |
;;          |  Z  |  X  |  C  |  V  |  B  |  N  |  M  |  ,  |  .  |  /  |

;; C-* (Basic commands)
;; | A 1 | A 2 | A 3 | A 4 | A 5 | A 6 | A 7 | A 8 | A 9 | A 0 | Undo|Zoom+|     |
;;    | Quot| Cut |EdLin|Rplce|TrsWd| Yank| PgUp|(TAB)| Open|BwLin|(ESC)|     |
;;       |MCNxt|Serch|Delte|FwChr| Quit|(B S)|BgLin|KilLn|ReCnt|Comnt|     |     |
;;          |     | C-x | C-c | PgDn|BwChr|FwLin|(RET)| Mark| Incl|     |

;; C-M-* (Modded commands)
;; | A 1 | A 2 | A 3 | A 4 | A 5 | A 6 | A 7 | A 8 | A 9 | A 0 | Redo|Zoom-|     |
;;    |     | Copy|EdDef|RplAl|TrsLn|YnkSn|BgBuf| Fill|OpBtw|BPgph|(ESC)|     |
;;       |MCAll|SrcBw|KilWd|FwWrd|Abort|BwKWd|BgDef|BwKLn|ReTop|     |     |     |
;;          |     |EvDef| Calc|EdBuf|BwWrd|FPgph|FwRet|MrkAl|     |     |

;; M-Shift-* (Sexpwise commands)
;; |     |     |     |     |     |     |     | Barf|Wrap(|Slurp| Undo|     |     |
;;    |     |CpyEx|EvlRp|Raise|TrsEx|YnkRp|Splce|IndEx| Open|UpExp|Wrap[|     |
;;       |     |SplEx|KlExp|FwExp| Quit|KilEx|JoiEx|BwKEx|ReCnt|CmtEx|Wrap"|     |
;;          |     |     |Convo|     |BwExp|DnExp|Retrn|MrkEx|     |     |

;; M-* (Other Commands 1)
;; |KlAWn|MkWnd|RszWn|     |     |     |     |TrWnd|PvWnd|NxWnd|JmpBk|     |     |
;;    |Scrat|Palet| Eval|Recnt|     |YankP|UndoT|Shell|Opcty|EvlPr|     |     |
;;       |Artst|GrpFl|Dired|FFile|GrpDr|Shrnk|iMenu|KlWnd|GotoL|     |     |     |
;;          |     | M-x |Cmpil|     |SwBuf|Narrw|DMcro|     |     |     |

;; C-x C-* (Other commands 2)
;; |     |     |     |     |     |     |     |     |BgMcr|EdMcr|     | Diff|     |
;;    |     |Write|Encod|Revrt|Trnct|     |Untab|     |     |Rstor|(ESC)|     |
;;       |     | Save|     |FFFlt|     | Xref|     |KilBf|     |     |     |     |
;;          |     |Rname|Close|     |BfLst|     |RnMcr|  DL |     |     |

;; key-chord
;;
;; - fj : transpose-chars
;; - hh : capitalize word
;; - kk : upcase word
;; - jj : downcase word

;; special keys
;;
;; -   <f1> : help prefix
;; - M-<f4> : kill-emacs
;;
;; -   TAB : indent / complete
;; - C-RET : phi-rectangle-set-mark-command
;; - C-SPC : set-mark-command / visible-register / exchange-point-and-mark

;; + Code :
;; + | Constants
;;   + system

;; Load some constant definitions from site-constants.el, to use
;; during compile.
(eval-when-compile
  (when (locate-library "site-constants")
    (load "site-constants"))
  (defconst my-additional-include-directories
    (when (boundp 'my-additional-include-directories) my-additional-include-directories)
    "List of directories counted as additional info directory.")
  (defconst my-additional-info-directories
    (when (boundp 'my-additional-info-directories) my-additional-info-directories)
    "List of directories counted as additional include directory.")
  (defconst my-secret-words
    (when (boundp 'my-secret-words) my-secret-words)
    "List of secret words to be hidden.")
  (defconst my-emacs-C-source-directory
    (when (boundp 'my-emacs-C-source-directory) my-emacs-C-source-directory)
    "/path/to/emacs/src"))

;;   + path to library files

(defconst my-snippets-directory
  (!when (file-exists-p "~/.emacs.d/snippets/")
    "~/.emacs.d/snippets/")
  "Dictionary directory for yasnippet.")

;;   + path to data files

;; Directory

(eval-and-compile
  (defconst my-dat-directory "~/.emacs.d/dat/"
    "Directory to save datas in."))

(defconst my-eww-download-directory
  "~/.emacs.d/dat/eww_download/"
  "Directory to download files in.")

;; make sure that my-dat-directory exists
(eval-when-compile
  (unless (file-exists-p my-dat-directory)
    (make-directory my-dat-directory)))

;; Common History Datas

(defconst my-mc-list-file
  (! (concat my-dat-directory "mc-list"))
  "File to save the list of multiple-cursors compatible commands.")

;; System-specific History Datas

(defconst my-auto-save-list-directory
  (! (concat my-dat-directory "auto-save-list_" (system-name) "/"))
  "Directory to save auto-save-list(s) in.")

(defconst my-palette-directory
  (! (concat my-dat-directory "palette_" (system-name) "/"))
  "Directory to save scratch-palette(s).")

(defconst my-backup-directory
  (! (concat my-dat-directory "backups_" (system-name) "/"))
  "Directory to save backup files.")

(defconst my-undo-tree-history-directory
  (! (concat my-dat-directory "undo-tree_" (system-name) "/"))
  "Directory to save undo-tree history.")

(defconst my-scratch-pop-directory
  (! (concat my-dat-directory "scratch_pop_" (system-name) "/"))
  "File to save scratch.")

(defconst my-savehist-history-file
  (! (concat my-dat-directory "savehist_" (system-name)))
  "Fileto save minibuffer history.")

(defconst my-company-history-file
  (! (concat my-dat-directory "company_" (system-name)))
  "File to save company-statistics history.")

(defconst my-company-same-mode-buffers-history-file
  (! (concat my-dat-directory "company-smb_" (system-name)))
  "File to save company-same-mode-buffers history.")

(defconst my-company-symbol-after-symbol-history-file
  (! (concat my-dat-directory "company-sas_" (system-name)))
  "File to save company-symbol-after-symbol history.")

(defconst my-recentf-file
  (! (concat my-dat-directory "recentf_" (system-name)))
  "File to save recentf history.")

(defconst my-save-place-file
  (! (concat my-dat-directory "save-place_" (system-name)))
  "File to save save-place datas.")

;; + | Utilities

(defvar my-lispy-modes
  '(lisp-mode emacs-lisp-mode scheme-mode))
(setup-hook 'change-major-mode-after-body-hook
  (when (apply 'derived-mode-p my-lispy-modes)
    (run-hooks 'my-lispy-mode-common-hook)))

(defvar my-listy-modes
  '(tabulated-list-mode dired-mode))
(setup-hook 'change-major-mode-after-body-hook
  (when (apply 'derived-mode-p my-listy-modes)
    (run-hooks 'my-listy-mode-common-hook)))

(defun my-open-file (file)
  (!cond ((eq system-type 'windows-nt)
          (w32-shell-execute "open" file))
         ((eq system-type 'darwin)
          (shell-command (concat "open '" file "'")))
         (t
          (error "unsupported system"))))

(setup-lazy
  '(my-read-font-family
    my-generate-random-str
    my-make-color-name) "cmd_utils")

;; + | System
;;   + *scratch* utilities [scratch-pop]
;;   + | backup/popup scratches

(setup "scratch-pop"
  (setq scratch-pop-backup-directory   my-scratch-pop-directory
        scratch-pop-initial-major-mode 'emacs-lisp-mode)
  (scratch-pop-restore-scratches 1)
  (setup-hook 'kill-emacs-hook 'scratch-pop-backup-scratches)
  (setup-after "popwin"
    (setq scratch-pop-popup-function 'popwin:popup-buffer)))

;;   + | make *scratch* persistent

;; reference | http://www.bookshelf.jp/soft/meadow_29.html#SEC392

(defun my-clean-scratch ()
  (with-current-buffer "*scratch*"
    (erase-buffer)
    (funcall initial-major-mode)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (message "*scratch* is cleaned up.")))

;; clean scratch instead of killing it
(!-
 (setup-hook 'kill-buffer-query-functions
   (or
    ;; unless *scratch* is being killed, it's okay to kill
    (not (string= "*scratch*" (buffer-name)))
    ;; otherwise, clean *scratch* instead of killing it
    (when (y-or-n-p "Erase *scratch* buffer ? ")
      (my-clean-scratch)
      nil))))

;; make a new scratch buffer on save
(!-
 (setup-hook 'after-save-hook
   (unless (get-buffer "*scratch*")
     (generate-new-buffer "*scratch*")
     (my-clean-scratch))))

;;   + hooks for save/open

;; query delete empty files instead of saving it
;; reference | http://www.bookshelf.jp/soft/meadow_24.html#SEC265
(!-
 (setup-hook 'after-save-hook
   (let ((filename (buffer-file-name (current-buffer))))
     (when (and filename
                (file-exists-p filename)
                (= 0 (buffer-size)))
       (when (y-or-n-p "Delete file and kill buffer ? ")
         (delete-file (buffer-file-name (current-buffer)))
         (kill-buffer (current-buffer)))))))

;; delete-trailing-whitespace on save
(!-
 (setup-hook 'before-save-hook
   (when (not (string= (buffer-string)
                       (progn (delete-trailing-whitespace)
                              (buffer-string))))
     (message "trailing whitespace deleted")
     (sit-for 0.4))))

;; query switch to root
(setup-hook 'find-file-hook
  (when (and (eq 0 (nth 2 (file-attributes buffer-file-name)))
             (not (file-writable-p buffer-file-name))
             (y-or-n-p "Switch to root ? "))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;; make a parent directory on find-file
(setup-hook 'find-file-hook
  (when buffer-file-name
    (let ((dir (file-name-directory buffer-file-name)))
      (when (and (not (file-exists-p dir))
                 (y-or-n-p "Directory does not exist. Create it? "))
        (make-directory dir t)))))

;;   + Misc: core
;;   + | system

(define-key query-replace-map (kbd "SPC") nil) ; do not accept SPC in y-or-n-p

(setq frame-title-format                    "Emacs"
      frame-resize-pixelwise                t
      completion-ignore-case                t
      read-file-name-completion-ignore-case t
      create-lockfiles                      nil
      message-log-max                       1000
      enable-local-variables                :safe
      echo-keystrokes                       0.1
      delete-by-moving-to-trash             t
      scroll-preserve-screen-position       t
      line-spacing                          0
      use-short-answers                     t
      ;; select.el
      select-enable-clipboard               t
      ;; mule-cmds.el
      default-input-method                  "japanese"
      ;; startup.el
      inhibit-startup-screen                t
      initial-scratch-message               ""
      initial-major-mode                    'fundamental-mode
      ;; simple.el
      eval-expression-print-length          nil
      eval-expression-print-level           10
      shift-select-mode                     nil
      save-interprogram-paste-before-kill   t
      yank-excluded-properties              t
      delete-trailing-lines                 t
      ;; files.el
      magic-mode-alist                      nil
      interpreter-mode-alist                nil
      ;; mouse.el
      mouse-drag-and-drop-region            t)

(setq-default tab-width             4
              truncate-lines        nil
              line-move-visual      t
              cursor-type           'bar
              fill-column           100
              ;; files.el
              require-final-newline t)

;; prefer SPC to indent
(indent-tabs-mode -1)

;; use UTF-8 as the default coding system
(prefer-coding-system 'utf-8-unix)

;; on Windows, use Shift-JIS for file names
;; reference | http://sakito.jp/emacs/emacsshell.html
(!when (eq system-type 'windows-nt)
  (setq locale-coding-system    'sjis
        file-name-coding-system 'sjis))

;; unlock some disabled commands
(!-
 (!foreach '(narrow-to-region
             dired-find-alternate-file
             upcase-region
             downcase-region)
   (put ,it 'disabled nil)))

;; handle non-ascii parens
(!foreach '((?\( . ?\)) (?\[ . ?\]) (?\{ . ?\})
            (?\（ . ?\）) (?\｛ . ?\｝) (?\「 . ?\」)
            (?\［ . ?\］) (?\【 . ?\】) (?\〈 . ?\〉)
            (?\《 . ?\》) (?\『 . ?\』))
  (modify-syntax-entry ,(car it) ,(concat "(" (char-to-string (cdr it))))
  (modify-syntax-entry ,(cdr it) ,(concat ")" (char-to-string (car it)))))

;; dont let the cursor go into minibuffer prompt
(setq minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook 'cursor-intangible-mode)

;; truncate minibuffer
(setup-hook 'minibuffer-setup-hook
  (setq truncate-lines t))

;; make keyboard-quit quiet
;; reference | https://github.com/maginemu/dotfiles/blob/master/emacs.d/init.el
(setq ring-bell-function
      (lambda ()
        (unless (memq this-command '(minibuffer-keyboard-quit keyboard-quit))
          (ding))))

;; utility function to set font
(defun my-set-fontset-font (family targets &optional rescale-rate add)
  "TARGETS can be a, or a list of, either charset-scripts (listed
in charset-script-alist), charsets (listed in charset-list), or a
cons of two integers which defines a range of the codepoints."
  (let ((font-spec (font-spec :family family)))
    (when rescale-rate
      (push (cons font-spec rescale-rate) face-font-rescale-alist))
    (unless (and (consp targets) (listp (cdr targets)))
      (setq targets (list targets)))
    (dolist (target targets)
      (set-fontset-font t target font-spec nil add))))

;; font settings (mac)
;; reference | http://macemacsjp.sourceforge.jp/matsuan/FontSettingJp.html
(!when (eq system-type 'darwin)
  ;; ascii
  (!cond
   ;; https://github.com/zk-phi/nasia
   ((member "nasia" (font-family-list))
    (set-face-attribute 'default nil :family "nasia" :height 140))
   ;; https://github.com/zk-phi/code8903
   ((member "code8903" (font-family-list))
    (set-face-attribute 'default nil :family "code8903" :height 130))
   (t
    (set-face-attribute 'default nil :family "Monaco" :height 130)))
  ;; unicode (fallback)
  (!cond
   ((member "nasia" (font-family-list))
    (my-set-fontset-font "nasia" 'unicode nil))
   ((member "code8903" (font-family-list))
    (my-set-fontset-font "code8903" 'unicode nil))
   ((member "SawarabiGothic phi" (font-family-list))
    (my-set-fontset-font "SawarabiGothic phi" 'unicode nil)))
  ;; unicode (emoji)
  (my-set-fontset-font "Apple Color Emoji" 'unicode 0.95 'prepend))

;; font settings (windows)
(!when (eq system-type 'windows-nt)
  (!cond
   ((and (member "Source Code Pro" (font-family-list))
         (member "Unifont" (font-family-list))
         (member "Symbola" (font-family-list))
         (member "VLゴシック phi" (font-family-list))
         (member "さわらびゴシック phi" (font-family-list)))
    (set-face-attribute 'default nil :family "Source Code Pro" :height 90) ; base
    (my-set-fontset-font "Unifont" 'unicode) ; unicode (fallback 4)
    ;; (my-set-fontset-font "Arial Unicode MS" 'unicode nil 'prepend) ; unicode (fallback 3)
    (my-set-fontset-font "Symbola" 'unicode nil 'prepend) ; unicode (fallback 2)
    (my-set-fontset-font "VLゴシック phi" 'unicode nil 'prepend) ; unicode (fallback)
    (my-set-fontset-font "さわらびゴシック phi" '(han kana) nil 'prepend)))) ; unicode (japanese)

;; do not treat symbols specially when determining font
(setq use-default-font-for-symbols nil)

;; settings for the byte-compiler
(eval-when-compile
  (setq byte-compile-warnings t))

;; make the main frame maximized by default
(push '(fullscreen . maximized) default-frame-alist)

;; enable transparent titlebar on darwin systems
(!when (eq window-system 'ns)
  (push '(ns-transparent-titlebar . t) default-frame-alist))

;; get PATH from shell (during compile)
(eval-when-compile
  (defconst my-exec-path
    (with-temp-buffer
      (and (ignore-errors
             (save-excursion
               (call-process (getenv "SHELL") nil t nil "-l" "-c" "echo $PATH")))
           (buffer-substring (point-min) (point-at-eol))))))
(!when my-exec-path
  (setenv "PATH" (! my-exec-path))
  (setq exec-path (! (split-string my-exec-path ":"))))

;;   + | backup, autosave

;; backup directory
(setq backup-directory-alist
      `(("" . ,(expand-file-name my-backup-directory))))

;; version control
;; reference | http://aikotobaha.blogspot.jp/2010/07/emacs.html
(setq version-control      t
      kept-new-versions    200
      kept-old-versions    10
      delete-old-versions  t
      vc-make-backup-files t)

;; use auto-save
(setq auto-save-default          t
      auto-save-list-file-prefix my-auto-save-list-directory
      delete-auto-save-files     t)

;; delete old back-ups
;; reference | https://github.com/Silex/emacs-config/
(!-
 (defun my-delete-old-backups ()
   (let ((threshold (* (/ 365 2) 24 60 60))
         (current (float-time (current-time)))
         (hash (make-hash-table :test 'equal))
         basename)
     ;; put all files in a hash-table
     (dolist (file (directory-files my-backup-directory t))
       (setq basename (file-name-sans-versions file))
       (puthash basename (cons file (gethash basename hash)) hash))
     ;; map over the hash-table
     (maphash
      (lambda (key files)
        ;; exclude non-backup files (like ".", "..")
        (setq files (delq nil (mapcar (lambda (f)
                                        (when (backup-file-name-p f) f))
                                      files)))
        (when (and files
                   (> (- current
                         (apply 'max (mapcar (lambda (f)
                                               ;; modification time of file "f"
                                               (float-time (nth 5 (file-attributes f))))
                                             files)))
                      threshold))
          (dolist (file files)
            (message "deleting old backup: %s" (file-name-base file))
            (delete-file file))))
      hash))
   (message "Old backups deleted."))
 (run-with-idle-timer 30 nil 'my-delete-old-backups))

;;   + Misc: built-ins
;;   + | buffers / windows

(setup "saveplace"
  (setq save-place-file my-save-place-file)
  (save-place-mode)
  ;; open invisible automatically
  (define-advice save-place-find-file-hook (:after (&rest _))
    (mapc (lambda (ov)
            (let ((ioit (overlay-get ov 'isearch-open-invisible-temporary)))
              (cond (ioit (funcall ioit ov nil))
                    ((overlay-get ov 'isearch-open-invisible)
                     (overlay-put ov 'invisible nil)))))
          (overlays-at (point)))))

(setup-after "uniquify"
  (setq uniquify-buffer-name-style 'post-forward))

;;   + | compilation

;; setting for compilation result buffer
(setup-after "compile"
  (setq compilation-scroll-output  'first-error
        compilation-ask-about-save nil)
  (setup-after "popwin"
    (push '("*compilation*" :noselect t) popwin:special-display-config))
  (setup-keybinds compilation-shell-minor-mode-map
    '("C-M-p" "C-M-n" "C-M-p" "C-M-p") nil))

;;   + | files

;; use elisp implementation of "ls"
(setup-after "dired"
  (setup "ls-lisp"
    (setq ls-lisp-use-insert-directory-program nil
          ls-lisp-dirs-first                   t)))

;; add include directories
(setup-after "find-file"
  (setq cc-search-directories
        (nconc (! my-additional-include-directories) cc-search-directories)))

(setup-after "help-fns"
  (setq find-function-C-source-directory (! my-emacs-C-source-directory)))

;;   + | edit

;; electric newline
(setup "electric"
  (electric-layout-mode 1))

;; delete selection on insert like modern applications
(!-
 (setup "delsel"
   (delete-selection-mode 1)))

(setup-after "newcomment"
  (setq comment-empty-lines t))

;;   + | vcs

;; disable vcs integration
(setq vc-handled-backends nil)

;;   + | others

(setup-after "help-fns"
  ;; auto load autoloaded functions with describe-function
  (setq help-enable-symbol-autoload t)
  ;; workaround "can't find library" issue with .el.gz files (Brew Cask Emacs 28.1)
  (auto-compression-mode 1))

;;   + Misc: plug-ins
;;   + | buffers / windows

(!-
 (setup "smooth-scrolling"
   (smooth-scrolling-mode 1)
   (setq smooth-scroll-margin 3)))

(setup-expecting "popwin"
  (defvar popwin:special-display-config nil) ; disable default settings
  (!-
   (setup "popwin"
     (setq popwin:reuse-window nil
           popwin:special-display-config
           (nconc '(("*Warnings*")
                    ("*Shell Command Output*")
                    ("*Compile-Log*" :noselect t) ; when selected compilation may fail ?
                    ("*Backtrace*")
                    ("*Completions*" :noselect t))
                  popwin:special-display-config))
     (popwin-mode 1))))

;;   + | mark / region

(setup-lazy
  '(phi-rectangle-set-mark-command
    phi-rectangle-kill-region
    phi-rectangle-yank
    phi-rectangle-kill-ring-save) "phi-rectangle"
  (setq phi-rectangle-collect-fake-cursors-kill-rings 'rectangle))

;; load mark-hacks
(!-
 (setup "mark-hacks"
   (mark-hacks-register-set-mark-command 'set-mark-command)
   (mark-hacks-register-yank-command 'my-overwrite-sexp)
   (setup-expecting "phi-rectangle"
     :fallback (progn
                 (mark-hacks-register-yank-command 'yank)
                 (mark-hacks-register-kill-command 'kill-region)
                 (mark-hacks-register-copy-command 'kill-ring-save))
     (mark-hacks-register-set-mark-command 'phi-rectangle-set-mark-command)
     (mark-hacks-register-yank-command 'phi-rectangle-yank)
     (mark-hacks-register-kill-command 'phi-rectangle-kill-region)
     (mark-hacks-register-copy-command 'phi-rectangle-kill-ring-save))))

;;   + | files

;; an Elisp implementation of "rgrep"
(setup-lazy
  '(phi-grep-in-directory phi-grep-in-file phi-grep-find-file-flat) "phi-grep"
  (setq phi-grep-enable-syntactic-regex nil))

;;   + | edit

(setup "phi-autopair"
  (nconc phi-autopair-lispy-modes my-lispy-modes)
  (phi-autopair-global-mode 1)
  (setup-after "company"
    (push 'phi-autopair-open company-begin-commands)))

(setup-lazy '(electric-align-mode) "electric-align"
  :prepare (setup-hook 'prog-mode-hook 'electric-align-mode)
  (setq electric-align-shortcut-commands '(my-smart-comma))
  (setup-after "company"
    (push 'electric-align-SPC company-begin-commands)))

;; not "electric-spacing" hosted in MELPA, but my own one
(setup-lazy '(electric-spacing-mode) "electric-spacing"
  (setq electric-spacing-regexp-pairs
        '(("\\cA\\|\\cC\\|\\ck\\|\\cK\\|\\cH" . "[\\\\{[($0-9A-Za-z]")
          ("[]\\\\})$0-9A-Za-z]" . "\\cA\\|\\cC\\|\\ck\\|\\cK\\|\\cH"))))

(setup-lazy '(jaword-mode) "jaword")

(setup-lazy '(subword-mode) "subword"
  :prepare (setup-hook 'prog-mode-hook 'subword-mode))

;; TODO: company equivalent of
;; - ac-c-headers
;; - ac-c-header-symbols
;; - ac-source-dictionary
;; - web-mode-ac-sources-alist
;; maybe ?
(!-
 (setup "company"
   (defun company-my-current-file-name (command &optional arg &rest ignored)
     "`company-mode' for current file name."
     (interactive (list 'interactive))
     (cl-case command
       (interactive (company-begin-backend 'company-my-current-file-name))
       (prefix (and buffer-file-name
                    (not (file-remote-p buffer-file-name))
                    (company-grab-symbol)))
       (candidates (all-completions arg (list (file-name-base buffer-file-name))))))
   (setq company-idle-delay 0
         company-require-match 'never
         company-dabbrev-downcase nil
         company-minimum-prefix-length 2
         company-selection-wrap-around t
         company-tooltip-align-annotations t
         company-transformers
         '(company-sort-by-occurrence
           company-sort-by-backend-importance
           company-sort-prefer-same-case-prefix)
         company-backends
         '(company-files
           (company-css :with company-dabbrev-code company-my-current-file-name)
           (company-keywords :with company-dabbrev-code company-my-current-file-name)
           (company-capf :with company-dabbrev-code company-my-current-file-name)
           (company-dabbrev-code :with company-my-current-file-name)
           company-dabbrev))
   (setup "company-same-mode-buffers"
     (setq company-same-mode-buffers-history-file my-company-same-mode-buffers-history-file
           company-backends
           ;; NOTE: `company-css' is deprecated in Emacs>=26 since
           ;; `css-mode' now supports CAPF. But I want to enable
           ;; `company-css' since `web-mode' does not support CAPF.
           '(company-files
             (company-css :with company-same-mode-buffers company-my-current-file-name)
             (company-keywords :with company-same-mode-buffers company-my-current-file-name)
             (company-same-mode-buffers :with company-my-current-file-name)
             company-dabbrev))
     (company-same-mode-buffers-initialize))
   (setup "company-symbol-after-symbol"
     (setq company-symbol-after-symbol-history-file my-company-symbol-after-symbol-history-file)
     (push 'company-symbol-after-symbol (cdr company-backends))
     (company-symbol-after-symbol-initialize))
   (setup "git-complete-company"
     (push 'git-complete-company-omni-backend company-backends)
     (push 'git-complete-company-whole-line-backend company-backends)
     ;; invoke (git-complete-)company when expand-dwim fails
     (setq my-expand-dwim-fallback        'company-manual-begin
           git-complete-limit-extension   t
           git-complete-grep-function
           (!if (executable-find "rg") 'git-complete-ripgrep 'git-complete-git-grep))
     (push '(web-mode "jsx" "js" "tsx" "ts" "scss" "css" "html" "html.ep")
           git-complete-major-mode-extensions-alist))
   (setup "company-dwim"
     (setq company-frontends
           '(company-pseudo-tooltip-unless-just-one-frontend
             company-dwim-frontend
             company-echo-metadata-frontend)))
   (setup "company-statistics"
     (setq company-statistics-file my-company-history-file)
     (push 'company-sort-by-statistics company-transformers)
     (company-statistics-mode))
   (setup "company-anywhere")
   (global-company-mode)
   (setup-keybinds company-active-map
     "C-p" '("company-dwim" company-dwim-select-previous company-select-previous)
     "C-n" '("company-dwim" company-dwim-select-next company-select-next)
     "C-u" 'company-previous-page
     "C-v" 'company-next-page
     "C-s" 'company-filter-candidates
     "TAB" '("company-dwim" company-dwim company-complete-common-or-cycle)
     "RET" 'company-complete-selection
     "<S-tab>" 'company-select-previous
     '("<f1>" "<tab>" "<return>") nil)
   (setup-keybinds company-search-map
     "C-p" 'company-search-repeat-backward
     "C-n" 'company-search-repeat-forward)))

;;   + | keyboards

;; not key-chord in MELPA but my own fork of key-chord
(!-
 (setup "key-chord"
   (setup-silently (key-chord-mode 1))
   (setq key-chord-safety-interval-forward 0.55)))

(setup-lazy '(key-combo-mode key-combo-define-local) "key-combo"
  ;; input-method (and multiple-cursors) is incompatible with key-combo
  (define-advice key-combo-post-command-function (:before-until (&rest _))
    (or current-input-method
        (bound-and-true-p multiple-cursors-mode))))
(defun my-unary (str)
  "a utility macro that generates smart insertion commands for
unary operators which can also be binary."
  `(lambda ()
     (interactive)
     (if (and (looking-back "[])\"a-zA-Z0-9_] *" (point-at-bol))
              (not (looking-back "\\(return\\|my\\|our\\) *" (point-at-bol))))
         (let ((back (unless (= (char-before) ?\s) " "))
               (forward (unless (= (char-after) ?\s) " ")))
           (insert (concat back ,str forward)))
       (insert ,str))))

;;   + | coding

(setup-lazy '(guess-style-guess-all) "guess-style"
  :prepare (setup-hook 'prog-mode-hook
             (run-with-idle-timer 0 nil 'guess-style-guess-all)))

;; org-like folding via outline-mode
(setup-lazy '(outline-minor-mode) "outline")
(setup-expecting "outline"
  (defvar my-outline-minimum-heading-len 10000) ; define as a global variable to suppress warning
  (setup-hook 'find-file-hook
    (when (and buffer-file-name (string-match "init\\.el" buffer-file-name))
      (outline-minor-mode 1)
      (setq-local outline-regexp (concat "^\\(\s*" (regexp-quote comment-start)
                                         "[" (regexp-quote comment-start) "]*\\)"
                                         "\s?\\(\s*\\++\\)\s")
                  outline-level  (lambda ()
                                   (setq-local my-outline-minimum-heading-len
                                               (min my-outline-minimum-heading-len
                                                    (- (match-end 0) (match-beginning 0))))
                                   (- (match-end 0) (match-beginning 0)
                                      my-outline-minimum-heading-len)))))
  (setup-lazy '(my-outline-cycle-dwim) "outline-magic"
    :prepare (setup-after "outline"
               (setup-keybinds outline-minor-mode-map "TAB" 'my-outline-cycle-dwim))
    (defun my-outline-cycle-dwim ()
      (interactive)
      (if (or (outline-on-heading-p) (= (point) 1))
          (outline-cycle)
        (call-interactively (global-key-binding "\t"))))
    ;; skip "subtree"
    (define-advice outline-cycle (:after (&rest _))
      ;; change "folded -> children -> subtree"
      ;; to "folded -> children -> folded -> ..."
      (when (eq this-command 'outline-cycle-children)
        (setq this-command 'outline-cycle))
      ;; change "overview -> contents -> show all"
      ;; to "overview -> show all -> overview -> ..."
      (when (eq this-command 'outline-cycle-overview)
        (setq this-command 'outline-cycle-toc)))))

(!-
 (setup "commentize-conflict"
   (dolist (buf (buffer-list))
     (with-current-buffer buf
       (when (derived-mode-p 'prog-mode)
         (commentize-conflict-mode))))
   (setup-hook 'prog-mode-hook 'commentize-conflict-mode)))

;;   + | others

(setup-after "orderless"

  (defun my-matcher-partial-flex (str)
    (unless (string= str "")
      (let ((lst (split-string str "" t)))
        (concat "\\<\\(" (car lst) "\\)"
                (mapconcat (lambda (s)
                             (concat "\\(?:.*?\\Sw\\)??\\(" (regexp-quote s) "\\)"))
                           (cdr lst)
                           "")))))

  (orderless-define-completion-style my-orderless-literal
    (orderless-matching-styles '(orderless-literal)))

  (orderless-define-completion-style my-orderless-partial-flex
    (orderless-matching-styles '(my-matcher-partial-flex)))

  (orderless-define-completion-style my-orderless-flex
    (orderless-matching-styles '(orderless-flex)))

  (setq completion-styles '(my-orderless-literal my-orderless-partial-flex my-orderless-flex basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion))))
  )

;; + | Commands
;;   + web browser [eww]

(setup-lazy '(eww) "eww"

  (setq eww-search-prefix      "http://search.yahoo.co.jp/search?p="
        eww-download-directory my-eww-download-directory
        eww-header-line-format nil)

  ;; disable colors by default
  ;; Reference | http://rubikitch.com/2014/11/19/eww-nocolor/
  (defvar my-eww-enable-colors nil)
  (define-advice shr-colorize-region (:before-while (&rest _))
    my-eww-enable-colors)
  (define-advice eww-colorize-region (:before-while (&rest _))
    my-eww-enable-colors)
  (defun my-eww-enable-colors ()
    "Enable colors in this eww buffer."
    (interactive)
    (setq-local my-eww-enable-colors t)
    (eww-reload))

  ;; disable sublimity-attractive-centering
  (setup-after "sublimity-attractive"
    (setup-hook 'eww-mode-hook
      (setq-local sublimity-attractive-centering-width nil)
      (set-window-margins (selected-window) nil nil)))

  ;; disable key-chord
  (setup-after "key-chord"
    (setup-hook 'eww-mode-hook
      (setq-local key-chord-mode        nil
                  input-method-function nil)))

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
    "j"   'my-scroll-up-by-row
    "k"   'my-scroll-down-by-row
    "C-f" 'scroll-up-command
    "C-b" 'scroll-down-command
    " "   'scroll-up-command
    "DEL" 'scroll-down-command
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
    "H"   'eww-list-histories
    "R"   'eww-readable)
  )

;;   + vertico completing-read interface [vertico, marginalia, orderless]

(setup-lazy '(vertico--advice) "vertico"
  :prepare (progn
             ;; taken from vertico-mode
             (advice-add 'completing-read-default :around 'vertico--advice)
             (advice-add 'completing-read-multiple :around 'vertico--advice))
  (setq vertico-cycle t
        vertico-resize nil
        vertico-count 8
        vertico-multiline '("\n" . "…"))

  ;; load orderless and if available
  (setup "orderless")
  (setup "marginalia" (marginalia-mode))

  ;; enable sorting
  (setup "savehist"
    (setq savehist-file my-savehist-history-file)
    (savehist-mode))

  (setup-lazy
    '(my-vertico-spc-or-enter
      vertico-directory-enter
      vertico-directory-delete-char
      vertico-directory-delete-word) "vertico-directory"
    (defun my-vertico-spc-or-enter ()
      (interactive)
      (if (= vertico--total 1)
          (vertico-directory-enter)
        (insert " "))))

  (setup-keybinds vertico-map
    "C-n"   'vertico-next
    "C-p"   'vertico-previous
    "C-M-n" 'vertico-next-group
    "C-M-p" 'vertico-previous-group
    "DEL"   '("vertico-directory" vertico-directory-delete-char)
    "C-M-h" '("vertico-directory" vertico-directory-delete-word)
    "SPC"   '("vertico-directory" my-vertico-spc-or-enter)
    "RET"   '("vertico-directory" vertico-directory-enter))
  )

;;   + consult and recentf [consult, recentf]
;;     + configure recentf

(setup-expecting "recentf"
  (defvar recentf-save-file my-recentf-file))

(setup-lazy '(recentf-open-files) "recentf"
  (recentf-mode 1)
  (setq recentf-max-saved-items 500
        recentf-exclude '("/[^/]*\\<tmp\\>[^/]*/" "/[^/]*\\<backup\\>[^/]*/"
                          "~$" "^#[^#]*#$" "^/[^/]*:" "/GitHub/" "\\.emacs\\.d/dat/"
                          "\\.elc$" "\\.dat$" "/deprecated/")))

;;     + improved completing-read commands

(setup-lazy
  '(consult-recent-file
    consult-yank-pop
    consult-completing-read-multiple) "consult"
  ;; enable enhanced version of completing-read-multiple
  :prepare (advice-add 'completing-read-multiple :override 'consult-completing-read-multiple)
  ;; disable auto-preview except for yank-pop
  (setq consult-preview-key nil)
  (consult-customize consult-yank-pop :preview-key 'any))

(setup-lazy '(consult-imenu) "consult-imenu")

(setup-after "xref"
  (setup "consult-xref"
    (setq xref-show-definitions-function 'consult-xref)))

;;   + yasnippet settings [yasnippet]

(setup-lazy
  '(yas--expand-or-prompt-for-template) "yasnippet"
  :prepare (setup-in-idle "yasnippet")

  (setq yas-triggers-in-field t
        yas-snippet-dirs      (list my-snippets-directory)
        yas-verbosity         3)

  (yas-reload-all)
  (yas-global-mode 1)

  ;; navigate inside fields
  ;; reference | https://github.com/magnars/.emacs.d/
  (defun my-yas/goto-end-of-active-field ()
    (interactive)
    (let* ((snippet (car (yas-active-snippets)))
           (pos (yas--field-end (yas--snippet-active-field snippet))))
      (if (= (point) pos)
          (move-end-of-line 1)
        (goto-char pos))))
  (defun my-yas/goto-start-of-active-field ()
    (interactive)
    (let* ((snippet (car (yas-active-snippets)))
           (pos (yas--field-start (yas--snippet-active-field snippet))))
      (if (= (point) pos)
          (move-beginning-of-line 1)
        (goto-char pos))))

  ;; indent current line after expanding snippet
  (setup-hook 'yas-after-exit-snippet-hook
    (funcall indent-line-function))

  ;; keybinds
  (setup-keybinds yas-minor-mode-map
    '("TAB" "<tab>") nil)
  (setup-keybinds yas-keymap
    "C-j"            'my-yas/goto-start-of-active-field
    "C-e"            'my-yas/goto-end-of-active-field)
  )

(setup-expecting "yasnippet"

  ;; do not require-final-newline while editing yasnippet snippets
  (setup-hook 'find-file-hook
    (when (and buffer-file-name (string-match  "/snippets/" buffer-file-name))
      (setq-local require-final-newline nil)))

  (defun my-yas (name)
    `(lambda ()
       (interactive)
       (yas--expand-or-prompt-for-template
        (mapcan #'(lambda (table) (yas--fetch table ,name)) (yas--get-snippet-tables)))))
  )

;;   + multiple-cursors [multiple-cursors]

(setup-lazy
  '(my-mc/mark-next-dwim
    my-mc/mark-all-dwim-or-skip-this) "multiple-cursors"

    ;; force loading mc/list-file
    (setq mc/list-file my-mc-list-file)
    (ignore-errors (load mc/list-file))

    ;; configurations
    (setq mc/match-cursor-style nil)

    ;; keep mark active on "require" and "load"
    ;; reference | https://github.com/milkypostman/dotemacs/init.el
    (define-advice require (:around (fn &rest args))
      (save-mark-and-excursion (let (deactivate-mark) (apply fn args))))
    (define-advice load (:around (fn &rest args))
      (save-mark-and-excursion (let (deactivate-mark) (apply fn args))))

    ;; (mc--in-defun) sometimes seems not work (why?)
    ;; so make him return always non-nil
    (setup "mc-mark-more" (defun mc--in-defun () t))

    ;; dwim commnad (mark-next or edit-lines)
    (defun my-mc/mark-next-dwim ()
      "call mc/mark-next-like-this or mc/edit-lines"
      (interactive)
      (if (and (use-region-p)
               (string-match "\n" (buffer-substring (region-beginning)
                                                    (region-end))))
          (mc/edit-lines)
        (setq this-command 'mc/mark-next-like-this) ; used by the command below
        (mc/mark-next-like-this 1)))

    ;; dwim command (mark all *** like this in ***)
    (defvar my-mc/mark-all-last-executed nil)
    (defun my-mc/mark-all-dwim-or-skip-this (arg)
      (interactive "P")
      (cond (arg (mc/mark-all-like-this))
            ((eq last-command this-command)
             (cl-case my-mc/mark-all-last-executed
               ((skip)
                (mc/mark-next-like-this 0))
               ((restricted-defun)
                (setq my-mc/mark-all-last-executed 'restricted)
                (mc/mark-all-symbols-like-this)
                (message "SYMBOLS defun -> [SYMBOLS]"))
               ((words-defun)
                (setq my-mc/mark-all-last-executed 'words)
                (mc/mark-all-words-like-this)
                (message "WORDS defun -> [WORDS] -> ALL"))
               ((words)
                (setq my-mc/mark-all-last-executed 'all)
                (mc/mark-all-like-this)
                (message "WORDS defun -> WORDS -> [ALL]"))
               ((all-defun)
                (setq my-mc/mark-all-last-executed 'all)
                (mc/mark-all-like-this)
                (message "ALL defun -> [ALL]"))
               (t
                (message "no items more to mark"))))
            (t
             (cond ((eq last-command 'mc/mark-next-like-this)
                    (setq my-mc/mark-all-last-executed 'skip)
                    (mc/mark-next-like-this 0))
                   ((and (fboundp 'mc--no-region-and-in-sgmlish-mode)
                         (mc--no-region-and-in-sgmlish-mode)
                         (mc--on-tag-name-p))
                    (mc/mark-sgml-tag-pair)
                    (message "TAG PAIR"))
                   ((not (use-region-p))
                    (mc--mark-symbol-at-point)
                    (setq my-mc/mark-all-last-executed 'restricted-defun)
                    (mc/mark-all-symbols-like-this-in-defun)
                    (message "[SYMBOLS defun] -> SYMBOLS"))
                   ((and (save-excursion  ; whole word is selected
                           (goto-char (region-beginning)) (looking-at "\\<"))
                         (save-excursion
                           (goto-char (region-end)) (looking-back "\\>" (point-at-bol))))
                    (setq my-mc/mark-all-last-executed 'words-defun)
                    (mc/mark-all-words-like-this-in-defun)
                    (message "[WORDS defun] -> WORDS -> ALL"))
                   (t
                    (setq my-mc/mark-all-last-executed 'all-defun)
                    (mc/mark-all-like-this-in-defun)
                    (message "[ALL defun] -> ALL"))))))
    )

;;   + syntax-wise operations
;;   + | expr-wise operations (lisp) [paredit] [cedit]
;;     + (lisp) lisp

(setup-lazy
  '(my-mark-sexp
    my-down-list
    my-copy-sexp
    my-transpose-sexps
    my-comment-sexp
    my-up-list
    my-indent-defun
    my-overwrite-sexp
    my-eval-sexp-dwim
    my-eval-and-replace-sexp) "cmd_sexpwise")

;;     + [paredit] paredit

(setup-lazy
  '(my-paredit-kill
    my-paredit-wrap-round
    my-paredit-wrap-square
    paredit-newline
    paredit-forward-barf-sexp
    paredit-forward-slurp-sexp
    paredit-raise-sexp
    paredit-convolute-sexp
    paredit-splice-sexp-killing-backward
    paredit-split-sexp
    paredit-join-sexps
    paredit-meta-doublequote) "paredit"

    (defun my-paredit-kill ()
      (interactive)
      (let ((beg (point))
            (syntax-info (syntax-ppss)))
        (cond ((nth 3 syntax-info)     ; in string
               (skip-syntax-forward "^\"")
               (kill-region beg (point)))
              ((= (car syntax-info) 0)  ; outside paren
               (kill-region beg (point-max)))
              (t                        ; in paren
               (up-list)
               (down-list -1)
               (kill-region beg (point))))))

    (defun my-paredit-wrap-round ()
      (interactive)
      (unless (<= (point)
                  (save-excursion
                    (forward-sexp)
                    (search-backward-regexp "\\_<\\|\\s(\\|\\s\"")
                    (point)))
        (search-backward-regexp "\\_<\\|\\s(\\|\\s\""))
      (paredit-wrap-round)
      (when (and (member major-mode my-lispy-modes)
                 (not (member (char-after) '(?\) ?\s ?\t ?\n))))
        (save-excursion (insert " "))))

    (defun my-paredit-wrap-square ()
      (interactive)
      (unless (<= (point)
                  (save-excursion
                    (forward-sexp)
                    (search-backward-regexp "\\_<\\|\\s(\\|\\s\"")
                    (point)))
        (search-backward-regexp "\\_<\\|\\s(\\|\\s\""))
      (paredit-wrap-square))
    )

;;     + [cedit] cedit

(setup-lazy
  '(cedit-or-paredit-slurp
    cedit-wrap-brace
    cedit-or-paredit-barf
    cedit-or-paredit-splice-killing-backward
    cedit-or-paredit-raise) "cedit"
    :prepare (setup-after "cc-mode"
               (dolist (keymap (list c-mode-map c++-mode-map
                                     objc-mode-map java-mode-map))
                 (setup-keybinds keymap
                   "M-)" 'cedit-or-paredit-slurp
                   "M-{" 'cedit-wrap-brace
                   "M-*" 'cedit-or-paredit-barf
                   "M-U" 'cedit-or-paredit-splice-killing-backward
                   "M-R" 'cedit-or-paredit-raise))))

;;   + | line-wise operations

(setup-lazy
  '(my-kill-line-backward
    my-next-opened-line
    my-open-line-and-indent
    my-new-line-between
    my-transpose-lines) "cmd_linewise")

;;   + | word-wise operations

(setup-lazy
  '(my-capitalize-word-dwim
    my-upcase-previous-word
    my-downcase-previous-word
    my-transpose-words) "cmd_wordwise")

;;   + Misc: core
;;   + | buffers / windows

(setup-lazy
  '(my-transpose-window-buffers
    my-kill-this-buffer
    my-resize-window
    my-retop
    my-recenter
    my-scroll-down-by-row
    my-scroll-up-by-row
    my-toggle-narrowing
    my-split-window) "cmd_window")

;;   + | jump around

(setup-lazy
  '(my-next-line
    my-previous-line
    my-smart-bol
    my-smart-eol
    my-next-blank-line
    my-previous-blank-line
    my-jump-back!) "cmd_motion")

;;   + | edit

(setup-lazy
  '(my-move-region-up
    my-move-region-down
    my-move-region-left
    my-move-region-right
    my-transpose-chars
    my-smart-comma
    my-shrink-whitespaces
    my-expand-dwim
    my-indent-or-expand-dwim
    my-map-lines-from-here) "cmd_edit")

;; shrink indentation on "kill-line"
;; reference | http://www.emacswiki.org/emacs/AutoIndentation
(define-advice kill-line (:around (fn &rest args))
  (if (or (not (eolp)) (bolp))
      (apply fn args)
    (apply fn args)
    (save-excursion (just-one-space))))

;;   + | others

(setup-lazy
  '(my-rename-current-buffer-file
    my-toggle-transparency
    my-url-decode-region
    my-url-encode-region
    my-byte-compile-dir) "cmd_other")

;;   + Misc: built-ins
;;   + | files

(setup-lazy '(my-restore-from-backup) "diff"
  (defun my--previous-backup (backup-file)
    (when (string-match "~\\([0-9]+\\)~$" backup-file)
      (let* ((version (string-to-number (match-string 1 backup-file)))
             (previous (replace-match (int-to-string (1- version)) t t backup-file 1)))
        (when (file-exists-p previous) previous))))
  (defun my-restore-from-backup ()
    (interactive)
    (cond ((null buffer-file-name)
           (error "Not a file buffer."))
          ((buffer-modified-p)
           (error "Buffer is modified."))
          (t
           (let ((original buffer-file-name)
                 (buf (current-buffer))
                 (backup (file-newest-backup buffer-file-name))
                 selected-backup)
             (when backup
               (switch-to-buffer (diff-no-select original backup)))
             (while (and backup (null selected-backup))
               (cl-case (read-char-choice "Restore this backup [n,y,q] ? " '(?n ?y ?q ? ?))
                 ((?n)  (when (setq backup (my--previous-backup backup))
                          (diff-no-select original backup)))
                 ((?y)  (setq selected-backup backup))
                 ((?q)  (setq backup nil))
                 ((?) (ignore-errors (scroll-up)))
                 ((?) (ignore-errors (scroll-down)))))
             (kill-buffer "*Diff*")
             (switch-to-buffer buf)
             (if (null selected-backup)
                 (error "No more backups found.")
               (erase-buffer)
               (insert-file-contents selected-backup)))))))

;;   + | trace changes

;; run "diff" from emacs
(setup-lazy '(ediff) "ediff"
  (setq ediff-split-window-function 'split-window-horizontally))

;;   + | assistants

;; automatically update imenu tags
(setup-after "imenu"
  (setq imenu-auto-rescan t))

;; Elisp implementation of "info"
(setup-lazy '(info-lookup-symbol) "info-look"
  (setq info-lookup-other-window-flag nil
        Info-directory-list
        (nconc (! my-additional-info-directories) Info-directory-list)))

;;   + Misc: plug-ins
;;   + | jump around

;; use "phi-search/replace" and "phi-search-mc" instead of "isearch"
(setup-lazy '(phi-replace phi-replace-query) "phi-replace")
(setup-lazy '(phi-search phi-search-backward) "phi-search"
  (setq phi-search-case-sensitive   'guess
        phi-search-use-modeline     nil
        phi-search-overlay-priority 3)
  (setup-expecting "multiple-cursors"
    (setup-lazy
      '(phi-search-mc/mark-next phi-search-mc/mark-all) "phi-search-mc"
      :prepare (setq phi-search-additional-keybinds
                     (append '(((kbd "C-a") . 'phi-search-mc/mark-next)
                               ((kbd "C-M-a") . 'phi-search-mc/mark-all))
                             phi-search-additional-keybinds)))))

;; jump-to-defiition
(setup-lazy '(dumb-jump-xref-activate) "dumb-jump"
  :prepare (setup-hook 'xref-backend-functions 'dumb-jump-xref-activate))

;;   + | edit

;; autoload expand-region
(setup-lazy '(er/expand-region) "expand-region")

;; insert import statement
(setup-lazy '(include-anywhere) "include-anywhere")

;;   + | pop-up windows

;; make and popup scratch-notes for each files
(!- (setup "scratch-palette"))
(setup-lazy '(scratch-palette-popup) "scratch-palette"
  :prepare (defvar scratch-palette-directory my-palette-directory)
  (setup-keybinds scratch-palette-minor-mode-map
    "M-w" 'scratch-palette-kill))

;;   + | trace changes

;; tree-like undo history browser
(setup-lazy
  '(undo-tree-undo
    undo-tree-visualize
    undo-tree-save-history-from-hook
    undo-tree-load-history-from-hook) "undo-tree"
  :prepare (progn
             (defvar undo-tree-map (make-sparse-keymap)) ; inhibit overriding keymap
             (setup-hook 'write-file-functions 'undo-tree-save-history-from-hook)
             (setup-hook 'find-file-hook 'undo-tree-load-history-from-hook))

  ;; save / load undo histories
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("" . ,(expand-file-name my-undo-tree-history-directory))))
  (global-undo-tree-mode 1)

  ;; delete old histories
  (defun my-delete-old-undohists ()
    (let ((threshold (* (/ 365 2) 24 60 60))
          (current (float-time (current-time))))
      (dolist (file (directory-files my-undo-tree-history-directory t))
        (when (and (file-regular-p file)
                   (> (- current (float-time (nth 5 (file-attributes file))))
                      threshold))
          (message "deleting old undohist: %s" (file-name-base file))
          (delete-file file))))
    (message "Old undohists deleted."))
  (run-with-idle-timer 30 nil 'my-delete-old-undohists)

  (setup-keybinds undo-tree-visualizer-mode-map
    "j" 'undo-tree-visualize-redo
    "k" 'undo-tree-visualize-undo
    "l" 'undo-tree-visualize-switch-branch-right
    "h" 'undo-tree-visualize-switch-branch-left
    "RET" 'undo-tree-visualizer-quit
    "C-g" 'undo-tree-visualizer-abort
    "q" 'undo-tree-visualizer-abort)
  )

;;   + | others

;; ＿人人人人人人人人＿
;; ＞  sudden-death  ＜
;; ￣ＹＹＹＹＹＹＹＹ￣
(setup-lazy '(sudden-death) "sudden-death")

;; autoload RPN calc
(setup-lazy '(rpn-calc) "rpn-calc")

;; autoload gitmole
(setup-lazy '(gitmole-interactive-blame) "gitmole")

;; autoload smart-compile
(setup-lazy '(smart-compile) "smart-compile")

;; autoload ipretty
(setup-lazy '(ipretty-last-sexp) "ipretty")

;; dynamic keyboard-macro
(setup-expecting "dmacro"
  ;; define a temporary function that loads "dmacro"
  (defun dmacro-exec ()
    (interactive)
    (defconst *dmacro-key* (this-single-command-keys))
    (load "dmacro")
    ;; dmacro-exec is overriden here
    (call-interactively 'dmacro-exec)))

;; download region as an url
(setup-lazy '(download-region-as-url) "download-region"
  (setq download-region-max-downloads 5))

;; start a HTTPd for this directory
(setup-lazy '(my-start-httpd-web-server) "simple-httpd"
  (defun my-start-httpd-web-server ()
    (interactive)
    (httpd-stop)
    (let* ((root (read-directory-name "Root Directory: " nil nil t))
           (port (read-number "Port: " 8080)))
      (setq httpd-root root
            httpd-port port)
      (httpd-start))))

(setup-lazy '(ace-link-help ace-link-info ace-link-eww) "ace-link")

(setup-lazy '(togetherly-client-start togetherly-server-start) "togetherly")

;; + | Modes
;;   + language modes
;;     + programming
;;       + lispy
;;         + (common)

;; toggle commands

(setup-lazy
  '(my-lisp-toggle-let
    my-lisp-toggle-quote
    my-lisp-toggle-bracket) "cmd_lisp")

(setup-hook 'my-lispy-mode-common-hook
  (local-set-key (kbd "C-c C-'") 'my-lisp-toggle-quote)
  (local-set-key (kbd "C-c C-8") 'my-lisp-toggle-let)
  (local-set-key (kbd "C-c C-9") 'my-lisp-toggle-bracket))

;; plugins

(setup-expecting "key-combo"
  (defun my-lisp-smart-dot ()
    (interactive)
    (insert (cond ((<= ?0 (char-before) ?9) ".")
                  ((= (char-before) ?\s) ". ")
                  (t " . "))))
  (setup-hook 'my-lispy-mode-common-hook
    (key-combo-mode 1)
    (key-combo-define-local (kbd ".") '(my-lisp-smart-dot "."))
    (key-combo-define-local (kbd ";") ";; ")))

(setup-after "rainbow-delimiters"
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (memq major-mode my-lispy-modes)
        (rainbow-delimiters-mode))))
  (setup-hook 'my-lispy-mode-common-hook 'rainbow-delimiters-mode))

;;         + Emacs Lisp [setup]

;; lisp-mode.el (loaded before init.el)
(setup-hook 'emacs-lisp-mode-hook
  :oneshot
  (font-lock-add-keywords
   'emacs-lisp-mode '(("(\\(defvar-local\\)" 1 font-lock-keyword-face)))
  (setup-keybinds emacs-lisp-mode-map '("M-TAB" "C-j") nil)
  (setup-after "smart-compile"
    (push '(emacs-lisp-mode . (emacs-lisp-byte-compile)) smart-compile-alist)
    (setup-lazy '(setup-byte-compile-file) "setup"
      :prepare (push '("init\\.el" . (setup-byte-compile-file)) smart-compile-alist)))
  (setup-after "key-chord"
    (setup-expecting "yasnippet"
      (key-chord-define-local "sk" (my-yas "kc-sk"))))
  (setup-expecting "key-combo"
    (key-combo-define-local (kbd "##") ";;;###autoload")
    (key-combo-define-local (kbd "#!") "#!/usr/bin/emacs --script")))
(!- (setup "setup"))          ; also lazy-load for syntax highlighting
(setup-after "rainbow-mode"
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (derived-mode-p 'emacs-lisp-mode)
        (rainbow-mode))))
  (setup-hook 'emacs-lisp-mode-hook 'rainbow-mode))

;;       + c-like
;;         + (common)
;;           + (prelude)

(setup-after "cc-mode"

  ;;         + settings

  (setup-keybinds c-mode-base-map "/" nil)

  ;;         + coding style

  ;; setup coding style for C-like languages
  ;; reference | http://www.cozmixng.org/webdav/kensuke/site-lisp/mode/my-c.el
  (defconst my-c-style
    '(
      ;; options
      (c-echo-syntactic-information-p . t)
      (c-tab-always-indent . t)

      ;; block comment line prefix
      ;; /*
      ;;  *    <- BLOCK-COMMENT-PREFIX
      ;;  */
      (c-block-comment-prefix . "* ")

      ;; basic offset
      (c-basic-offset . 4)
      (c-comment-only-line-offset . 0)

      ;; electric newline criteria for ";" and ","
      ;; - for(i=0; i<N; i++){}    <- DO NOT HANG THESE ";"s
      ;; - inline int method(){ foo(); bar(); }    <- DO NOT HANG THESE ";"s
      (c-hanging-semi&comma-criteria
       . (c-semi&comma-inside-parenlist
          c-semi&comma-no-newlines-for-oneline-inliners))

      ;; electric newline around "{" and "}"
      (c-hanging-braces-alist
       . (
          ;; function
          ;; - int fun()
          ;; - {    <- DEFUN-OPEN
          ;; -     ...
          ;; - }    <- DEFUN-CLOSE
          (defun-open before after) (defun-close before after)

          ;; class related
          ;; - class Class
          ;; - {    <- CLASS-OPEN
          ;; -     int member;
          ;; -     int method()
          ;; -     {    <- INLINE-OPEN
          ;; -         ...
          ;; -     }    <- INLINE-CLOSE
          ;; - }    <- CLASS-CLOSE
          (class-open before after) (class-close before after)
          (inline-open before after) (inline-close before after)

          ;; conditional
          ;; - for(;;)
          ;; - {    <- SUBSTATEMENT-OPEN
          ;; -     ...
          ;; -     {    <- BLOCK-OPEN
          ;; -       ...
          ;; -     }    <- BLOCK-CLOSE
          ;; -     ...
          ;; - }    <- BLOCK-CLOSE
          (substatement-open before after)
          (block-open before after) (block-close before after)

          ;; switch
          ;; - switch(var)
          ;; - {
          ;; -   case 1:
          ;; -     {    <- STATEMENT-CASE-OPEN
          ;; -      ...
          ;; -     }
          ;; -   ...
          ;; - }
          (statement-case-open before after) ; case label

          ;; brace list
          ;; - struct pairs[] =
          ;; - {    <- BRACE-LIST-OPEN
          ;; -     {    <- BRACE-ENTRY-OPEN
          ;; -         1, 2
          ;; -     },   <- BRACE-LIST-CLOSE
          ;; -     {
          ;; -         3, 4
          ;; -     },
          ;; - }    <- BRACE-LIST-CLOSE
          (brace-list-open)              ; disable
          (brace-entry-open)             ; disable
          (brace-list-close after)

          ;; external scope
          ;; - extern "C"
          ;; - {    <- EXTERN-LANG-OPEN
          ;; -     ...
          ;; - }    <- EXTERN-LANG-CLOSE
          (extern-lang-open before after) (extern-lang-close before after)
          (namespace-open) (namespace-close)      ; disable
          (module-open) (module-close)            ; disable
          (composition-open) (composition-close)  ; disable

          ;; Java
          ;; - public void watch(Observable o){
          ;; -     Observer obs = new Observer()
          ;; -     {    <- INEXPR-CLASS-OPEN
          ;; -         public void update(Observable o, Object obj)
          ;; -         {
          ;; -             history.addElement(obj);
          ;; -         }
          ;; -     };   <- INEXPR-CLASS-CLOSE
          ;; -     o.addObserver(obs);
          ;; - }
          (inexpr-class-open before after) (inexpr-class-close before after)
          ))

      ;; electric newline around ":"
      (c-hanging-colons-alist
       . (
          ;; switch
          ;; - switch(var)
          ;; -   {
          ;; -   case 1:    <- CASE-LABEL
          ;; -     ...
          ;; -   default:
          ;; -     ...
          ;; -   }
          (case-label after)

          ;; literal symbols
          ;; - int fun()
          ;; - {
          ;; -     ...
          ;; -
          ;; -   label:    <- LABEL
          ;; -     ...
          ;; - }
          (label after)

          ;; class related
          ;; - class Class : public ClassA, ClassB    <- INHER-INTRO
          ;; - {
          ;; -   public:    <- ACCESS-LABEL
          ;; -     Class() : m1(0), m2(1)    <- MEMBER-INIT-INTRO
          ;; -     ...
          ;; - }
          (inher-intro)                  ; disable
          (member-init-intro)            ; disable
          (access-label after)
          ))

      ;; offsets
      (c-offsets-alist
       . (
          ;; function
          ;; - int    <- TOPMOST-INTRO
          ;; - main()    <- TOPMOST-INTRO-CONT
          ;; - {    <- DEFUN-OPEN
          ;; -     a = 1 + 2    <- DEFUN-BLOCK-INTRO  --+
          ;; -           - 3;    <- STATEMENT-CONT      +-- STATEMENT
          ;; -     ...                                --+
          ;; - }    <- DEFUN-CLOSE
          (topmost-intro . 0) (topmost-intro-cont . c-lineup-topmost-intro-cont)
          (defun-open . 0) (defun-block-intro . +) (defun-close . 0)
          (statement . 0) (statement-cont . c-lineup-math)

          ;; class related
          ;; - class Class
          ;; -     : public ClassA,    <- INHER-INTRO
          ;; -     : public ClassB    <- INHER-CONT
          ;; - {    <- CLASS-OPEN
          ;; -   public:    <- ACCESS-LABEL            --+
          ;; -     Class()                               |
          ;; -         : m1(0),    <- MEMBER-INIT-INTRO  |
          ;; -         : m2(1)    <- MEMBER-INIT-CONT    |
          ;; -     {    <- INLINE-OPEN                   +-- INCLASS
          ;; -         m1.foo();                         |
          ;; -         m2.foo();                         |
          ;; -     }    <- INLINE-CLOSE                  |
          ;; -     friend class Friend;    <- FRIEND   --+
          ;; - };
          (class-open . 0) (inclass . +) (class-close . 0)
          (inher-intro . +) (inher-cont . c-lineup-multi-inher)
          (member-init-intro . +) (member-init-cont . c-lineup-multi-inher)
          (inline-open . 0) (inline-close . 0)
          (access-label . /) (friend . 0)

          ;; - ThingManager <int,
          ;; -     Framework:: Callback *,      --+-- TEMPLATE-ARGS-CONT
          ;; -     Mutex> framework_callbacks;  --+
          (template-args-cont c-lineup-template-args +)

          ;; conditional
          ;; - if(cond)
          ;; - {    <- SUBSTATEMENT-OPEN (for "if")
          ;; -     ...    <- STATEMENT-BLOCK-INTRO
          ;; -     {    <- BLOCK-OPEN
          ;; -         baz();    <- STATEMENT-BLOCK-INTRO
          ;; -     }    <- BLOCK-CLOSE
          ;; - }
          ;; - else    <- ELSE-CLAUSE
          ;; -   label:    <- SUBSTATEMENT-LABEL
          ;; -     bar();    <- SUBSTATEMENT
          (substatement-open . 0) (statement-block-intro . +)
          (substatement-label . *) (substatement . +)
          (else-clause . 0) (do-while-closure . 0) (catch-clause . 0)

          ;; switch
          ;; - switch(var)
          ;; - {
          ;; -   case 1:    <- CASE-LABEL
          ;; -     foo();    <- STATEMENT-CASE-INTRO
          ;; -     break;
          ;; -   default:
          ;; -     {    <- STATEMENT-CASE-OPEN
          ;; -       bar();
          ;; -     }
          ;; - }
          (case-label . *)
          (statement-case-intro . *) (statement-case-open . *)

          ;; brace list
          ;; - struct pairs[] =
          ;; - {    <- BRACE-LIST-OPEN
          ;; -     { 1, 2 },    <- BRACE-LIST-INTRO  --+
          ;; -     {    <- BRACE-ENTRY-OPEN            +-- BRACE-LIST-ENTRY
          ;; -       3, 4                              |
          ;; -     }    <- BRACE-LIST-CLOSE          --+
          ;; - }    <- BRACE-LIST-CLOSE
          (brace-list-open . 0) (brace-list-intro . +) (brace-list-close . 0)
          (brace-list-entry . 0) (brace-entry-open . 0)

          ;; external scope
          ;; - extern "C"
          ;; - {    <- EXTERN-LANG-OPEN
          ;; -     ...    <- INEXTERN-LANG
          ;; - }    <- EXTERN-LANG-CLOSE
          (extern-lang-open . 0) (inextern-lang . +) (extern-lang-close . 0)
          (composition-open . 0) (incomposition . +) (composition-close . 0)
          (namespace-open . 0) (innamespace . +) (namespace-close . 0)
          (module-open . 0) (inmodule . +) (module-close . 0)

          ;; paren list
          ;; - function1(
          ;; -     a,    <- ARGLIST-INTRO
          ;; -     b     <- ARGLIST-CONT
          ;; -     );    <- ARGLIST-CLOSE
          ;; - function2( a,
          ;; -            b );    <- ARGLIST-CONT-NONEMPTY
          (arglist-intro . +) (arglist-close . 0)
          (arglist-cont c-lineup-gcc-asm-reg 0)
          (arglist-cont-nonempty c-lineup-gcc-asm-reg c-lineup-arglist)

          ;; literal
          ;; - /*    <- COMMENT-INTRO
          ;; -  */   <- C
          (comment-intro c-lineup-knr-region-comment c-lineup-comment)
          (c . c-lineup-C-comments)

          ;; - void fun()
          ;; - throw (int)    <- FUNC-DECL-CONT
          ;; - {
          ;; -     char* str = "a multiline\
          ;; - string";    <- STRING
          ;; -     ...
          ;; -   label:    <- LABEL
          ;; -     {    <- BLOCK-OPEN
          ;; -         foo();
          ;; -     }    <- BLOCK-CLOSE
          ;; - }
          (func-decl-cont . *)
          (string . c-lineup-dont-change) (label . *)
          (block-open . 0) (block-close . 0)

          ;; - cout << "Hello, "
          ;; -      << "World!\n";    <- STREAM-OP
          (stream-op . c-lineup-streamop)

          ;; multiline macro
          ;; - int main()
          ;; - {
          ;; -     ...
          ;; -   #ifdef DEBUG    <-  CPP-MACRO
          ;; -     ...
          ;; -   #define swap(A, B) \
          ;; -       {              \    <- CPP-DEFINE-INTRO  --+
          ;; -         int t = A;   \                           |
          ;; -         A = B;       \                           +-- CPP-MACRO-CONT
          ;; -         B = t;       \                           |
          ;; -       }              \                         --+
          ;; -     ...
          ;; - }
          (cpp-macro . /) ;; (cpp-macro . [0])
          (cpp-macro-cont . +)
          (cpp-define-intro c-lineup-cpp-define +)

          ;; objective-c
          ;; - - (void)setWidth: (int)width    <- OBJC-METHOD-INTRO
          ;; -           height: (int)height    <- OBJC-METHOD-ARGS-CONT
          ;; - {
          ;; -     [object setWidth: 10
          ;; -             height: 10];    <- OBJC-METHOD-CALL-CONT
          ;; - }
          (objc-method-intro . 0)
          (objc-method-args-cont . c-lineup-ObjC-method-args)
          (objc-method-call-cont c-lineup-ObjC-method-call-colons
                                 c-lineup-ObjC-method-call +)

          ;; Java
          ;; -  @Test
          ;; -  public void watch()    <- ANNOTATION-TOP-CONT
          ;; -  {
          ;; -      @NonNull
          ;; -      Observer obs = new Observer()    <- ANNOTATION-VAR-CONT
          ;; -          {    <- INEXPR-CLASS
          ;; -              public void update(Observable o, Object obj)
          ;; -              {
          ;; -                  history.addElement(arg);
          ;; -              }
          ;; -          };    <- INEXPR-CLASS
          ;; -      o.addObserver(obs);
          ;; - }
          (annotation-top-cont . 0) (annotation-var-cont . 0)
          (inexpr-class . +)

          ;; statement block
          ;; - int res = ({
          ;; -         int t;    <- INEXPR-STATEMENT
          ;; -         if(a<10) t = foo();
          ;; -         else t = bar();
          ;; -         t;
          ;; -     });    <- INEXPR-STATEMENT
          (inexpr-statement . +)

          ;; - string s = map (backtrace() [-2] [3..],
          ;; -                 lambda
          ;; -                     (mixed arg)    <- LAMBDA-INTRO-CONT
          ;; -                 {    <- INLINE-OPEN           --+
          ;; -                     return sprintf("%t", arg);  +-- INLAMBDA
          ;; -                 }    <- INLINE-CLOSE          --+
          ;; -                 ) * ", " + "\n";
          ;; - return catch {
          ;; -         write(s + "\n");  --+-- INEXPR-STATEMENT
          ;; -     };                    --+
          (lambda-intro-cont . +) (inlambda . c-lineup-inexpr-block)

          ;; K&R
          ;; - int fun(a, b, c)
          ;; -   int a;    <- KNR-ARGDECL-INTRO
          ;; -   int b;  --+-- KNR-ARGDECL
          ;; -   int c;  --+
          ;; - {
          ;; -     ...
          ;; - }
          (knr-argdecl-intro . *) (knr-argdecl . 0)
          ))

      ;; clean-ups
      (c-cleanup-list
       . (
          brace-catch-brace              ; } <-catch <-{
          empty-defun-braces             ; fun(){ <-}
          defun-close-semi               ; } <-;
          list-close-comma               ; } <-,
          scope-operator                 ; : <-:
          one-liner-defun                ; fun() <-{ <-stmt; <-}
          ))
      ))

  (c-add-style "phi" my-c-style)

  (setup-hook 'c-mode-common-hook
    (setq c-auto-newline t))

  ;;         + key-combo

  (setup-expecting "key-combo"
    (defun my-c-smart-braces ()
      "smart insertion of braces for C-like laguages"
      (interactive)
      (cond ((use-region-p)              ; wrap with {}
             (let* ((beg (region-beginning))
                    (end (region-end))
                    (one-liner (= (line-number-at-pos beg) (line-number-at-pos end))))
               (deactivate-mark)
               (goto-char beg)
               (insert (if one-liner "{ " "\n{"))
               (goto-char (+ 2 end))
               (insert (if one-liner " }" "\n}"))
               (indent-region beg (point))))
            ((= (char-before) ?\s)         ; insert {`!!'}
             (indent-region (point) (progn (insert "{  }") (point)))
             (backward-char 2))
            (t                           ; insert {\n`!!'\n}
             (unless (= (point)
                        (save-excursion (back-to-indentation) (point)))
               (insert "\n"))
             (indent-region (point) (progn (insert "{\n\n}") (point)))
             (forward-line -1)
             (indent-according-to-mode))))
    (defun my-install-c-common-smartchr ()
      ;; add / sub / mul / div
      (key-combo-define-local (kbd "+") `(,(my-unary "+") "++"))
      (key-combo-define-local (kbd "+=") " += ")
      ;; vv conflict with electric-case vv
      (key-combo-define-local (kbd "-") `(,(my-unary "-") "--"))
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
      (key-combo-define-local (kbd ">>=") " >>= ")
      (key-combo-define-local (kbd "<<=") " <<= ")
      (key-combo-define-local (kbd "^") " ^ ")
      ;; conflicts with "C-="
      ;; (key-combo-define-local (kbd "^=") " ^= ")
      ;; others
      (key-combo-define-local (kbd "/*") "/* `!!' */")
      (key-combo-define-local (kbd "{") '(my-c-smart-braces "{ `!!' }"))))

  ;;         + (sentinel)
  )

;;         + C, C++, Objetive-C

(setup-after "cc-mode"

  (dolist (keymap (list c-mode-map c++-mode-map objc-mode-map))
    (setup-keybinds keymap
      "C-c C-g"                            'c-guess
      '("," "C-d" "C-M-a" "C-M-e"
        "M-e" "M-j" "C-M-h" "C-M-j" "DEL") nil))

  (setup-hook 'c-mode-hook
    (c-set-style "phi"))

  (setup-after "smart-compile"
    (push `(c-mode . "gcc -ansi -pedantic -Wall -W -Wextra -Wunreachable-code %f")
          smart-compile-alist))

  (setup-expecting "key-combo"
    (defun my-c-smart-angles ()
      (interactive)
      (if (looking-back "#include *" (point-at-bol))
          (progn
            (insert "<>")
            (backward-char 1))
        (let ((back (unless (= (char-before) ?\s) " "))
              (forward (unless (= (char-after) ?\s) " ")))
          (insert (concat back "<" forward)))))
    (defun my-c-smart-pointer (str)
      (eval `(lambda ()
               (interactive)
               (if (or
                    (not (looking-back "[0-9a-zA-Z_)] *"))
                    ;; declaration
                    (and (looking-back "\\_<\\([a-z_]*\\)\\_> *")
                         (eq 'font-lock-type-face
                             (get-text-property (match-beginning 1) 'face)))
                    ;; cast
                    (and (looking-back "([][)(,*a-z_ ]*) *")
                         (save-excursion
                           (let ((beg (match-beginning 0)))
                             (while (and (search-backward-regexp "[a-z_]+" beg t)
                                         (not (text-property-not-all
                                               (match-beginning 0) (match-end 0)
                                               'face 'font-lock-type-face))))))))
                   (insert ,str)
                 (let ((back (unless (= (char-before) ?\s) " "))
                       (forward (unless (= (char-after) ?\s) " ")))
                   (insert (concat back ,str forward)))))))
    (setup-hook 'c-mode-hook 'key-combo-mode)
    (setup-hook 'c-mode-hook
      :oneshot
      (my-install-c-common-smartchr)
      ;; pointers
      (key-combo-define-local (kbd "&") `(,(my-c-smart-pointer "&") " && "))
      (key-combo-define-local (kbd "*") `(,(my-c-smart-pointer "*")))
      (key-combo-define-local (kbd "->") "->")
      ;; include
      (key-combo-define-local (kbd "<") '(my-c-smart-angles " << "))
      ;; triary operation
      (key-combo-define-local (kbd "?") '( " ? `!!' : " "?"))))
  )

;;         + Java

(setup-after "cc-mode"

  ;; add some modifications for the coding style
  (setup-hook 'java-mode-hook
    (c-set-style "phi")
    (setq c-hanging-braces-alist
          '((defun-open after) (defun-close before after)
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

  (setup-after "smart-compile"
    (push '(java-mode . "javac -Xlint:all -encoding UTF-8 %f") smart-compile-alist))

  (setup-expecting "key-combo"
    (setup-hook 'java-mode-hook 'key-combo-mode)
    (setup-hook 'java-mode-hook
      :oneshot
      (my-install-c-common-smartchr)
      ;; javadoc comment
      (key-combo-define-local (kbd "/**") "/**\n`!!'\n*/")
      ;; one-liner comment
      (key-combo-define-local (kbd "/") '(" / " "//"))
      ;; ad-hoc polymorphism
      (key-combo-define-local (kbd "<") '(" < " "<" " << "))
      (key-combo-define-local (kbd ">") '(" > " ">" " >> "))))

  (setup-keybinds java-mode-map
    "C-c C-g"                            'c-guess
    '("," "C-d" "C-M-a" "C-M-e"
      "M-e" "M-j" "C-M-h" "C-M-j" "DEL") nil)
  )

;;         + SCAD

;; *NOTE* "scad-mode.el" provides "scad" feature (!!!)
;; So it's not good idea to specify "scad-mode" as a package name here.
(setup-lazy '(scad-mode) "scad-preview"
  :prepare (push '("\\.scad$" . scad-mode) auto-mode-alist)
  (setup-keybinds scad-mode-map
    "C-c C-p" 'scad-preview-mode
    "C-c C-r" 'scad-preview-rotate
    "C-c C-c" 'scad-preview-export
    "<f5>"    'scad-preview-refresh))

;;         + glsl

(setup-lazy '(glsl-mode) "glsl-mode"
  :prepare (push '("\\.\\(glsl\\|[vf]s\\)$" . glsl-mode) auto-mode-alist)
  (setup-hook 'glsl-mode-hook
    (c-set-style "phi")))

;;       + perl-like
;;         + Perl (cperl-mode)

(setup-lazy '(cperl-mode) "cperl-mode"
  :prepare (push '("\\.\\(?:t\\|p[lm]\\|psgi\\)$" . cperl-mode) auto-mode-alist)

  ;; setup indent style and electricity
  (setq cperl-indent-level               4
        cperl-continued-statement-offset 4
        cperl-close-paren-offset         -4
        cperl-lineup-step                1
        cperl-indent-parens-as-block     t
        cperl-auto-newline               t
        cperl-electric-keywords          t)

  ;; disable auto-fix features
  (setq cperl-break-one-line-blocks-when-indent nil
        cperl-fix-hanging-brace-when-indent     nil
        cperl-merge-trailing-else               nil
        cperl-indent-region-fix-constructs      nil)

  ;; setup syntax highlight
  (setq cperl-font-lock                            t
        cperl-highlight-variables-indiscriminately t
        cperl-invalid-face                         'default)
  (make-face 'cperl-scope-face)
  (make-face 'cperl-hash-key-face)
  (set-face-attribute 'cperl-scope-face nil :inherit 'font-lock-type-face)
  (set-face-attribute 'cperl-hash-key-face nil :inherit 'default)
  (font-lock-add-keywords
   'cperl-mode '(("\\_<\\(?:local\\|our\\|my\\)\\_>" . 'cperl-scope-face)))
  (font-lock-add-keywords
   'cperl-mode
   '(("[\[ \t{,(]\\(-?[a-zA-Z0-9_:]+\\)[ \t]*=>" 1 'cperl-hash-key-face t)
     ("\\([]}\\\\%@>*&]\\|\\$[a-zA-Z0-9_:]*\\)[ \t]*{[ \t]*\\(-?[a-zA-Z0-9_:]+\\)[ \t]*}"
      (2 'cperl-hash-key-face t)
      ("\\=[ \t]*{[ \t]*\\(-?[a-zA-Z0-9_:]+\\)[ \t]*}" nil nil (1 'cperl-hash-key-face t))))
   t)
  (push '(cperl-mode . 1) font-lock-maximum-decoration)

  ;; make basic sigils part of a symbol
  (modify-syntax-entry ?$ "_" cperl-mode-syntax-table)
  (modify-syntax-entry ?% "_" cperl-mode-syntax-table)
  (modify-syntax-entry ?@ "_" cperl-mode-syntax-table)

  ;; make $# NOT comment starter ($ is turned into a symbol character
  ;; from an escaping character above)
  (setup-hook 'cperl-mode-hook
    (setq-local syntax-propertize-function
                (lambda (start end)
                  (goto-char start)
                  (setq cperl-syntax-done-to start)
                  (save-excursion (cperl-fontify-syntactically end))
                  (while (search-forward "$#" end t)
                    (cperl-modify-syntax-type (1- (point)) (string-to-syntax "_")))))
    (with-silent-modifications
      (funcall syntax-propertize-function (point-min) (point-max))))

  (setup-keybinds cperl-mode-map
    "TAB" nil                           ; do not override TAB behavior
    "C-c C-l" 'cperl-lineup
    '("{" "[" "(" "<" "}" "]" ")" "C-j" "DEL" "C-M-q" "C-M-\\" "C-M-|") nil)

  (setup-after "key-chord"
    (setup-expecting "yasnippet"
      (setup-hook 'cperl-mode-hook
        :oneshot
        (key-chord-define-local "sk" (my-yas "kc-sk")) ; skeleton (package/script)
        )))

  (setup-expecting "key-combo"
    (setup-hook 'cperl-mode-hook 'key-combo-mode)
    (setup-hook 'cperl-mode-hook
      :oneshot
      ;; arithmetic
      (key-combo-define-local (kbd "+") `(,(my-unary "+") "++"))
      (key-combo-define-local (kbd "-") `(,(my-unary "-") "--"))
      (key-combo-define-local (kbd "*") `(,(my-unary "*") " ** "))
      (key-combo-define-local (kbd "^") " ^ ")
      (key-combo-define-local (kbd "%") `(" %" " % "))
      (key-combo-define-local (kbd "/") '(" / " " // "))
      (key-combo-define-local (kbd "&") '(" & " " && "))
      (key-combo-define-local (kbd "|") '(" | " " || "))
      (key-combo-define-local (kbd ".") '(" . " " .. " " ... "))
      ;; comparison
      (key-combo-define-local (kbd "=") '(" = " " == "))
      (key-combo-define-local (kbd ">") '(" > " " >> "))
      (key-combo-define-local (kbd "<") '(" < " " << "))
      (key-combo-define-local (kbd "<=") " <= ")
      (key-combo-define-local (kbd ">=") " >= ")
      (key-combo-define-local (kbd "<=>") " <=> ") ; not working
      (key-combo-define-local (kbd "!=") " != ")
      (key-combo-define-local (kbd "=~") " =~ ")
      (key-combo-define-local (kbd "~=") " =~ ")
      (key-combo-define-local (kbd "!~") " !~ ")
      ;; substitution
      (key-combo-define-local (kbd "**=") " **= ")
      (key-combo-define-local (kbd ".=") " .= ")
      (key-combo-define-local (kbd "/=") " /= ")
      (key-combo-define-local (kbd "//=") " //= ")
      (key-combo-define-local (kbd "%=") " %= ")
      (key-combo-define-local (kbd "&=") " &= ")
      (key-combo-define-local (kbd "|=") " |= ")
      ;; conflicts with "C-="
      ;; (key-combo-define-local (kbd "^=") " ^= ")
      (key-combo-define-local (kbd "<<=") " <<= ")
      (key-combo-define-local (kbd ">>=") " >>= ")
      (key-combo-define-local (kbd "&&=") " &&= ")
      (key-combo-define-local (kbd "||=") " ||= ")
      (key-combo-define-local (kbd "+=") " += ")
      (key-combo-define-local (kbd "-=") " -= ")
      (key-combo-define-local (kbd "*=") " *= ")
      ;; other
      (key-combo-define-local (kbd ",") '(", " " => " ", "))
      (key-combo-define-local (kbd "->") "->")
      (key-combo-define-local (kbd "=>") " => ")
      (key-combo-define-local (kbd "qw") "qw/`!!'/")
      (key-combo-define-local (kbd "qr") "qr/`!!'/")
      (key-combo-define-local (kbd "?") " ? `!!' : ")))
  )

;;       + prolog-ilke
;;         + (common)

(setup-lazy '(my-install-prolog-common-smartchr) "key-combo"
  (defun my-prolog-smart-pipes ()
    "insert pipe surrounded by spaces"
    (interactive)
    (if (= (char-before) ?\[)
        (insert "| ")
      (insert (concat (unless (= (char-before) ?\s) " ")
                      "|"
                      (unless (= (char-after) ?\s) " ")))))
  (defun my-install-prolog-common-smartchr ()
    ;; comments, periods
    (key-combo-define-local (kbd "%") '("% " "%% "))
    ;; toplevel
    (key-combo-define-local (kbd ":-") " :- ")
    (key-combo-define-local (kbd "|") '(my-prolog-smart-pipes))
    ;; cmp
    (key-combo-define-local (kbd "=") " = ")
    (key-combo-define-local (kbd "!=") " \\= ")
    (key-combo-define-local (kbd "\\=") " \\= ")
    (key-combo-define-local (kbd "<") " < ")
    (key-combo-define-local (kbd ">") " > ")
    (key-combo-define-local (kbd "=<") " =< ")
    (key-combo-define-local (kbd "<=") " =< ")
    (key-combo-define-local (kbd ">=") " >= ")
    (key-combo-define-local (kbd "=\\=") " =\\= ")
    (key-combo-define-local (kbd "!==") " =\\= ")
    (key-combo-define-local (kbd "=:=") " =:= ")
    (key-combo-define-local (kbd "==") " =:= ")
    ;; arithmetic
    (key-combo-define-local (kbd "+") (my-unary "+"))
    (key-combo-define-local (kbd "-") (my-unary "-"))
    (key-combo-define-local (kbd "*") " * ")))

;;         + Prolog

(setup-lazy '(prolog-mode) "prolog"
  :prepare (push '("\\.\\(?:pro\\|swi\\)$" . prolog-mode) auto-mode-alist)

  (setup-keybinds prolog-mode-map
    "C-c C-l" 'prolog-consult-file
    "C-c C-e" 'my-prolog-consult-dwim
    "C-c C-s" 'my-run-prolog-other-window
    "C-c C-t" 'prolog-trace-on
    '("M-a" "M-e" "M-q"
      "C-M-a" "C-M-e" "C-M-c"
      "C-M-h" "C-M-n" "C-M-p"
      "C-M-h" "C-M-e" "C-M-a"
      "C-M-c" "C-M-n" "C-M-n")
    nil)

  (defun my-run-prolog-other-window ()
    (interactive)
    (with-selected-window (split-window-vertically -10)
      (switch-to-buffer (get-buffer-create "*prolog*"))
      (prolog-mode-variables)
      (prolog-ensure-process))
    (when buffer-file-name
      (prolog-consult-file)))

  (defun my-prolog-consult-dwim ()
    (interactive)
    (if (use-region-p)
        (prolog-consult-region (region-beginning) (region-end))
      (prolog-consult-predicate)))

  (setup-expecting "key-combo"
    (setup-hook 'prolog-mode-hook 'key-combo-mode)
    (setup-hook 'prolog-mode-hook
      :oneshot
      (my-install-prolog-common-smartchr)
      ;; control
      (key-combo-define-local (kbd "->") " -> ")
      (key-combo-define-local (kbd "--") " -- ") ; to make --> work
      (key-combo-define-local (kbd "-->") " --> ")
      (key-combo-define-local (kbd "?-") " ?- ")
      (key-combo-define-local (kbd ";") "; ")
      (key-combo-define-local (kbd "*-") " *- ") ; to make *-> work
      (key-combo-define-local (kbd "*->") " *-> ")
      (key-combo-define-local (kbd ":=") " := ")
      ;; cmp
      (key-combo-define-local (kbd "===") " == ")
      (key-combo-define-local (kbd "!===") " \\== ")
      (key-combo-define-local (kbd "@=") " =@= ")
      (key-combo-define-local (kbd "=@=") " =@= ")
      (key-combo-define-local (kbd "@!=") " \\=@= ")
      (key-combo-define-local (kbd "\\=@=") " \\=@= ")
      (key-combo-define-local (kbd "@<") " @< ")
      (key-combo-define-local (kbd "@>") " @> ")
      (key-combo-define-local (kbd "@<=") " @=< ")
      (key-combo-define-local (kbd "@=<") " @=< ")
      (key-combo-define-local (kbd "@>=") " @>= ")
      (key-combo-define-local (kbd ":") " : ")
      (key-combo-define-local (kbd ":<") " >:< ")
      (key-combo-define-local (kbd ">:<") " >:< ")
      ;; ops
      (key-combo-define-local (kbd "/\\") " /\\ ")
      (key-combo-define-local (kbd "\\/") " \\/ ")
      (key-combo-define-local (kbd "<<") " << ")
      (key-combo-define-local (kbd ">>") " >> ")
      (key-combo-define-local (kbd "**") " ** ")
      (key-combo-define-local (kbd "^") " ^ ")
      (key-combo-define-local (kbd "/") " / ")
      (key-combo-define-local (kbd "//") " // "))))

;;       + esolangs
;;         + Brainfuck

(setup-lazy '(bfbuilder-mode) "bfbuilder"
  :prepare (push '("\\.bf" . bfbuilder-mode) auto-mode-alist))

;;       + other
;;         + Lua

(setup-lazy '(lua-mode) "lua-mode"
  :prepare (push '("\\.lua$" . lua-mode) auto-mode-alist)
  (setq lua-indent-level 2))

;;         + Nim

(setup-lazy '(nim-mode) "nim-mode"
  :prepare (push '("\\.nim$" . nim-mode) auto-mode-alist)
  (setup-after "phi-autopair"
    (push (cons 'nim-mode nim-indent-offset) phi-autopair-indent-offset-alist))
  (setup-after "smart-compile"
    (push `(nim-mode . "nim c %f") smart-compile-alist)))

;;         + shell

(setup-lazy '(shell-script-mode) "sh-script"
  :prepare (push '("\\.z?sh$" . shell-script-mode) auto-mode-alist))

;;     + web
;;       + web-mode

(setup-lazy '(web-mode) "web-mode"
  :prepare (progn
             (push '("\\.html?[^/]*$" . web-mode) auto-mode-alist)
             (push '("\\.[tj]sx?$" . web-mode) auto-mode-alist)
             (push '("\\.s?css$" . web-mode) auto-mode-alist)
             (push '("\\.ejs$" . web-mode) auto-mode-alist)
             (push '("\\.njk$" . web-mode) auto-mode-alist)
             (push '("\\.vue$" . web-mode) auto-mode-alist)
             (push '("\\.json$" . web-mode) auto-mode-alist))

  (defun my-web-mode-electric-semi ()
    (interactive)
    (let ((lang (web-mode-language-at-pos)))
      (cond ((and (or (string= lang "javascript")
                      (and (string= lang "jsx") (not (web-mode-jsx-is-html))))
                  (looking-at "[\s\t]*$"))
             (insert ";\n")
             (funcall indent-line-function)
             (back-to-indentation))
            (t
             (insert ";")))))

  (setup-keybinds web-mode-map
    ";"     'my-web-mode-electric-semi
    "C-c '" 'web-mode-element-close
    "C-;"   'web-mode-comment-or-uncomment
    "M-;"   nil)

  (setq web-mode-script-padding                   nil
        web-mode-style-padding                    nil
        web-mode-markup-indent-offset             2
        web-mode-css-indent-offset                2
        web-mode-code-indent-offset               2
        web-mode-attr-indent-offset               4
        web-mode-enable-control-block-indentation nil
        web-mode-enable-auto-quoting              nil
        web-mode-enable-front-matter-block        t)
  (push '("lineup-calls" . nil) web-mode-indentation-params)

  ;; fix single-quote pairing
  (modify-syntax-entry ?\' "\"" web-mode-syntax-table)

  ;; tweak JSX syntax highlight
  (copy-face 'web-mode-html-attr-name-face 'web-mode-hash-key-face)
  (setq web-mode-javascript-font-lock-keywords
        (nconc
         '(;; labels
           ("case[\s\t]+\\([^:]+[^:\s\t]\\)[\s\t]*:" 1 'web-mode-constant-face)
           ;; hash-keys
           ("\\(?:^\\|,\\)[\s\t]*\\([A-z0-9_]+\\??\\)[\s\t]*:" 1 'web-mode-hash-key-face)
           ;; method decls / lambda expressions
           ("\\(?:\\(function\\)\\|\\([A-z0-9_]+\\)\\)[\s\t]*\\((\\)[A-z0-9_\s\t,=/*]*)[\s\t\n]*{"
            (1 'web-mode-keyword-face nil t)
            (2 'web-mode-function-name-face nil t)
            ("\\([A-z0-9_]+\\)\\(?:[^,]*\\)?[,)]"
             (goto-char (match-end 3)) nil (1 'web-mode-variable-name-face)))
           ;; type name
           ("\\(?:type\\)[\s\t]*\\([A-z0-9_]+\\)" 1 'web-mode-type-face)
           ;; import stmt
           ("\\(import\\)[\s\t]*\\([{A-z0-9_*]\\(?:[A-z0-9_,*\s\t]*[A-z0-9_}]\\)?\\)[\s\t]*\\(from\\)"
            (1 'web-mode-keyword-face)
            (2 'web-mode-variable-name-face)
            (3 'web-mode-keyword-face)))
         web-mode-javascript-font-lock-keywords))

  ;; fix autopairing (closing > for HTML tags are inserted by
  ;; phi-autopair, thus we do not need them inserted by web-mode too)
  (push '("mojolicious" . (("<% " . " %")
                           ("<%=" . " | %")
                           ("<%%" . " | %")
                           ("<%#" . " | %")))
        web-mode-engines-auto-pairs)

  (setup-after "rainbow-mode"
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (derived-mode-p 'web-mode)
          (rainbow-mode))))
    (setup-hook 'web-mode-hook 'rainbow-mode))

  (setup-after "smart-compile"
    (push '(web-mode . (browse-url-of-buffer)) smart-compile-alist))

  (setup-after "key-chord"
    (setup-expecting "yasnippet"

      ;; utilities called from snippets
      (defun my-web-html-title ()
        (save-excursion
          (goto-char (point-min))
          (if (search-forward-regexp "<title>\\([^<]+\\)</title>" nil t)
              (match-string 1)
            "Page title")))
      (defun my-web-html-description ()
        (save-excursion
          (goto-char (point-min))
          (if (search-forward-regexp "name=\"description\" content=\"\\([^\"]+\\)\"" nil t)
              (match-string 1)
            "Hogehoge")))
      (defun my-optional-meta-prefix (name str)
        (if (string= str "") "" (concat "<meta name=\"" name "\" content=\"")))
      (defun my-optional-meta-suffix (str)
        (if (string= str "") "" "\">\n    "))

      (setup-hook 'web-mode-hook
        :oneshot
        (key-chord-define-local "sk" (my-yas "kc-sk")) ; html/skeleton
        (key-chord-define-local "jq" (my-yas "kc-jq")) ; html/head/libraries/jquery
        (key-chord-define-local "bo" (my-yas "kc-bo")) ; html/head/libraries/bootstrap
        (key-chord-define-local "vu" (my-yas "kc-vu")) ; html/head/libraries/vue
        (key-chord-define-local "fa" (my-yas "kc-fa")) ; html/head/favicon
        (key-chord-define-local "ap" (my-yas "kc-ap")) ; html/head/apple_touch_icon
        (key-chord-define-local "st" (my-yas "kc-st")) ; html/head/stylesheet
        (key-chord-define-local "og" (my-yas "kc-og")) ; html/head/OGP
        (key-chord-define-local "sc" (my-yas "kc-sc")) ; html/head/script
        )))

  (setup "key-combo-web"
    (setup-hook 'web-mode-hook 'key-combo-mode)
    (setup-hook 'web-mode-hook
      :oneshot
      ;; css combos
      (key-combo-web-define "css" (kbd "+") " + ")
      (key-combo-web-define "css" (kbd ">") " > ")
      (key-combo-web-define "css" (kbd "~") " ~ ")
      ;; conflicts with "C-="
      ;; (key-combo-web-define "css" (kbd "^=") " ^= ")
      (key-combo-web-define "css" (kbd "$=") " $= ")
      (key-combo-web-define "css" (kbd "*=") " *= ")
      (key-combo-web-define "css" (kbd "=") " = ")
      ;; js combos
      (key-combo-web-define "javascript" (kbd "<") " < ")
      (key-combo-web-define "javascript" (kbd "&") '(" & " " && "))
      (key-combo-web-define "javascript" (kbd "=") '(" = " " == " " === ")) ; = not working ?
      (key-combo-web-define "javascript" (kbd "=>") " => ")
      ;; ts combos
      (key-combo-web-define "typescript" (kbd "<") '(" < " "<`!!'>"))
      (key-combo-web-define "typescript" (kbd "&") '(" & " " && "))
      (key-combo-web-define "typescript" (kbd "=") '(" = " " == " " === "))
      (key-combo-web-define "typescript" (kbd "=>") " => ")
      ;; jsx combos
      (key-combo-web-define "jsx" (kbd "<") '(" < " "<`!!'>")) ; press twice to start jsx-html
      (key-combo-web-define "jsx" (kbd "&") '(" & " " && "))
      (key-combo-web-define "jsx" (kbd "</") 'web-mode-element-close)
      (key-combo-web-define "jsx-html" (kbd "<") '("<`!!'>" "<"))
      ;; html combos
      (key-combo-web-define "html" (kbd "<") '("<`!!'>" "&lt;" "<"))
      (key-combo-web-define "html" (kbd "<!") "<!DOCTYPE `!!'>")
      (key-combo-web-define "html" (kbd ">") '("&gt;" ">"))
      (key-combo-web-define "html" (kbd "&") '("&amp;" "&"))))
  )

;;     + configuration
;;       + Dockerfile

(setup-lazy '(dockerfile-mode) "dockerfile-mode"
  :prepare (push '("Dockerfile$" . dockerfile-mode) auto-mode-alist))

;;       + generic-mode

(setup-lazy
  '(apache-conf-generic-mode
    apache-log-generic-mode
    samba-generic-mode
    fvwm-generic-mode
    x-resource-generic-mode
    xmodmap-generic-mode
    hosts-generic-mode
    inf-generic-mode
    ini-generic-mode
    reg-generic-mode
    mailagent-rules-generic-mode
    prototype-generic-mode
    pkginfo-generic-mode
    vrml-generic-mode
    java-manifest-generic-mode
    alias-generic-mode
    rc-generic-mode
    rul-generic-mode
    mailrc-generic-mode
    inetd-conf-generic-mode
    etc-services-generic-mode
    etc-passwd-generic-mode
    etc-fstab-generic-mode
    etc-sudoers-generic-mode
    named-boot-generic-mode
    resolve-conf-generic-mode
    spice-generic-mode
    ibis-generic-mode
    astap-generic-mode) "generic-x"

    (setq auto-mode-alist
          (nconc
           '(
             ("\\(?:srm\\|httpd\\|access\\)\\.conf\\'" . apache-conf-generic-mode)
             ("access_log\\'" . apache-log-generic-mode)
             ("smb\\.conf\\'" . samba-generic-mode)
             ("\\.fvwm2?rc\\'" . fvwm-generic-mode)
             ("\\.X\\(?:defaults\\|resources\\|environment\\)\\'" . x-resource-generic-mode)
             ("\\.ad\\'" . x-resource-generic-mode)
             ("[xX]modmap\\(rc\\)?\\'" . xmodmap-generic-mode)
             ("[hH][oO][sS][tT][sS]\\'" . hosts-generic-mode)
             ("\\.[iI][nN][fF]\\'" . inf-generic-mode)
             ("\\.[iI][nN][iI]\\'" . ini-generic-mode)
             ("\\.[rR][eE][gG]\\'" . reg-generic-mode)
             ("\\.rules\\'" . mailagent-rules-generic-mode)
             ("prototype\\'" . prototype-generic-mode)
             ("pkginfo\\'" . pkginfo-generic-mode)
             ("\\.wrl\\'" . vrml-generic-mode)
             ("[mM][aA][nN][iI][fF][eE][sS][tT]\\.[mM][fF]\\'" . java-manifest-generic-mode)
             ("alias\\'" . alias-generic-mode)
             ("\\.[rR][cC]\\'" . rc-generic-mode)
             ("\\.[rR][uU][lL]\\'" . rul-generic-mode)
             ("\\.mailrc\\'" . mailrc-generic-mode)
             ("/etc/inetd.conf\\'" . inetd-conf-generic-mode)
             ("/etc/services\\'" . etc-services-generic-mode)
             ("/etc/group\\'" . etc-passwd-generic-mode)
             ("/etc/[v]*fstab\\'" . etc-fstab-generic-mode)
             ("/etc/sudoers\\'" . etc-sudoers-generic-mode)
             ("/etc/named.boot\\'" . named-boot-generic-mode)
             ("/etc/resolv[e]?.conf\\'" . resolve-conf-generic-mode)
             ("\\.?:[sS][pP]\\(?:[iI]\\(?:[cC][eE]\\)?\\)?\\'" . spice-generic-mode)
             ("\\.[iI][nN][cC]\\'" . spice-generic-mode)
             ("\\.[iI][bB][sS]\\'" . ibis-generic-mode)
             ("\\.[aA]\\(?:[pP]\\|[sS][xX]\\|[sS][tT][aA][pP]\\)\\'" . astap-generic-mode)
             ("\\.[pP][sS][pP]\\'" . astap-generic-mode)
             ("\\.[dD][eE][cC][kK]\\'" . astap-generic-mode)
             ("\\.[gG][oO][dD][aA][tT][aA]" . astap-generic-mode)
             ("/etc/\\(?:modules.conf\\|conf.modules\\)" . etc-modules-conf-generic-mode)
             )
           auto-mode-alist))
    )

;;     + other markup
;;       + (common)

(define-minor-mode my-auto-kutoten-mode
  "Auto 句読点 mode。"
  :init-value nil
  :global nil
  :keymap (let ((kmap (make-sparse-keymap)))
            (define-key kmap "、" "，")
            (define-key kmap "。" "．")
            kmap)
  (when (and my-auto-kutoten-mode
             (save-excursion
               (goto-char (point-min))
               (not (and (search-forward "，" nil t)
                         (search-forward "．" nil t)))))
    (my-auto-kutoten-mode -1)))

;; text-mode.el (loaded before init.el)
(setup-hook 'text-mode-hook 'my-auto-kutoten-mode)
(setup-hook 'text-mode-hook
  :oneshot
  (setup-keybinds text-mode-map "C-M-i" nil))
(setup-expecting "electric-spacing"
  (setup-hook 'text-mode-hook 'electric-spacing-mode))
(setup-expecting "jaword"
  (setup-hook 'text-mode-hook 'jaword-mode))
(setup-after "mark-hacks"
  (push 'text-mode mark-hacks-auto-indent-inhibit-modes))

;;       + org-mode

(setup-after "org"

  (setup-hook 'org-mode-hook 'iimage-mode)
  (setup-hook 'org-mode-hook 'turn-on-auto-fill)

  (setq org-startup-folded             t
        org-startup-indented           t
        org-startup-with-inline-images t
        org-src-fontify-natively       t
        org-src-tab-acts-natively      t)

  (defun my-org-edit-special ()
    (interactive)
    (condition-case nil
        (org-edit-special)
      (error
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
           (org-edit-src-exit))))))

  (setup-keybinds org-mode-map
    "C-c '" 'my-org-edit-special
    "M-RET" 'org-insert-heading
    "TAB"   'org-cycle
    "C-y"   'org-yank
    "C-k"   'org-kill-line
    "C-j"   'org-beginning-of-line
    "C-e"   'org-end-of-line
    '("M-a" "M-TAB" "C-," "C-a" "C-j" "M-e" ) nil)
  )

;;       + latex-mode [magic-latex-buffer]

(setup-expecting "tex-mode"
  (push '("\\.tex$" . latex-mode) auto-mode-alist))

(setup-after "tex-mode"
  (push "Verbatim" tex-verbatim-environments)
  (push "BVerbatim" tex-verbatim-environments)
  (push "lstlisting" tex-verbatim-environments)
  (setup-hook 'latex-mode-hook
    (outline-minor-mode 1)
    (setq-local outline-regexp "\\\\\\(sub\\)*section\\>"
                outline-level  (lambda () (- (outline-level) 7))))
  (setup-keybinds latex-mode-map
    "C-c C-'" 'latex-close-block
    '("C-j" "C-M-i" "<C-return>") nil)
  (setup-lazy '(magic-latex-buffer) "magic-latex-buffer"
    :prepare (setup-hook 'latex-mode-hook 'magic-latex-buffer)
    (setq magic-latex-enable-inline-image nil))
  )

;;       + gfm-mode [markdown-mode]

(setup-lazy '(gfm-mode) "markdown-mode"
  :prepare (push '("\\.m\\(ark\\)?d\\(own\\)?$" . gfm-mode) auto-mode-alist)
  (setup-keybinds gfm-mode-map
    '("M-n" "M-p" "M-{" "M-}" "C-M-i") nil
    "TAB" 'markdown-cycle))

;;   + hexl-mode

;; query switch to hexl-mode on find-file
(setup-hook 'find-file-hook
  (when (and (save-excursion
               (goto-char (point-min))
               ;; check if the file is binary data
               (re-search-forward "[\000-\010\016-\032\034-\037]" 1000 t))
             (y-or-n-p "Open with hexl-mode ? "))
    (hexl-mode)))

;;   + artist-mode
;;     + (prelude)

;; reference | http://d.hatena.ne.jp/tamura70/20100125/ditaa

(setup-after "artist"

  ;;   + line-draw commands

  (defun my-picture-line-draw-str (h v str)
    (cond ((/= h 0)
           (cond ((string= str "|") "+")
                 ((string= str "+") "+") (t "-")))
          ((/= v 0)
           (cond ((string= str "-") "+")
                 ((string= str "+") "+") (t "|")))
          (t
           str)))

  (defun my-picture-line-draw (num v h del)
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
                (if del (my-picture-line-delete-str h v str)
                  (my-picture-line-draw-str h v str)))
          (picture-clear-column (string-width str))
          (picture-update-desired-column nil)
          (picture-insert (string-to-char new-str) 1)))
      (setq picture-vertical-step old-v)
      (setq picture-horizontal-step old-h)))

  (defun my-picture-line-draw-right (n)
    (interactive "p")
    (my-picture-line-draw n 0 1 nil))

  (defun my-picture-line-draw-left (n)
    (interactive "p")
    (my-picture-line-draw n 0 -1 nil))

  (defun my-picture-line-draw-up (n)
    (interactive "p")
    (my-picture-line-draw n -1 0 nil))

  (defun my-picture-line-draw-down (n)
    (interactive "p")
    (my-picture-line-draw n 1 0 nil))

  ;;   + line-delete commands

  (defun my-picture-line-delete-str (h v str)
    (cond ((/= h 0)
           (cond ((string= str "|") "|")
                 ((string= str "+") "|") (t " ")))
          ((/= v 0)
           (cond ((string= str "-") "-")
                 ((string= str "+") "-") (t " ")))
          (t
           str)))

  (defun my-picture-line-delete-right (n)
    (interactive "p")
    (my-picture-line-draw n 0 1 t))

  (defun my-picture-line-delete-left (n)
    (interactive "p")
    (my-picture-line-draw n 0 -1 t))

  (defun my-picture-line-delete-up (n)
    (interactive "p")
    (my-picture-line-draw n -1 0 t))

  (defun my-picture-line-delete-down (n)
    (interactive "p")
    (my-picture-line-draw n 1 0 t))

  ;;   + region-move commands

  (defun my-picture-region-move (start end num v h)
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

  (defun my-picture-region-move-right (start end num)
    (interactive "r\np")
    (my-picture-region-move start end num 0 1))

  (defun my-picture-region-move-left (start end num)
    (interactive "r\np")
    (my-picture-region-move start end num 0 -1))

  (defun my-picture-region-move-up (start end num)
    (interactive "r\np")
    (my-picture-region-move start end num -1 0))

  (defun my-picture-region-move-down (start end num)
    (interactive "r\np")
    (my-picture-region-move start end num 1 0))

  ;;   + rectangle copy command

  (defun my-picture-copy-rectangle (start end)
    (interactive "r")
    (setq picture-killed-rectangle (extract-rectangle start end)))

  ;;   + keymap

  (setup-keybinds artist-mode-map
    "<right>"   'my-picture-line-draw-right
    "<left>"    'my-picture-line-draw-left
    "<up>"      'my-picture-line-draw-up
    "<down>"    'my-picture-line-draw-down
    "C-<right>" 'my-picture-line-delete-right
    "C-<left>"  'my-picture-line-delete-left
    "C-<up>"    'my-picture-line-delete-up
    "C-<down>"  'my-picture-line-delete-down
    "M-<right>" 'my-picture-region-move-right
    "M-<left>"  'my-picture-region-move-left
    "M-<up>"    'my-picture-region-move-up
    "M-<down>"  'my-picture-region-move-down
    "C-r"       'picture-draw-rectangle
    "C-w"       'picture-clear-rectangle
    "C-M-w"     'my-picture-copy-rectangle
    "C-y"       'picture-yank-rectangle
    ">"         'picture-self-insert
    "<"         'picture-self-insert)

  ;;   + (sentinel)
  )

;;   + reading modes

(setup-after "debug"
  (setup-expecting "vi"
    (setup-hook 'debugger-mode-hook 'my-kindly-view-mode)))

(setup-after "help-mode"
  (setup-after "popwin"
    (push '("*Help*") popwin:special-display-config))
  (setup-expecting "vi"
    (setup-hook 'help-mode-hook 'my-kindly-view-mode)
    (setup-keybinds help-mode-map
      "g" nil
      "h" 'help-go-back
      "l" 'help-go-forward
      "f" '("ace-link" ace-link-help))))

(setup-after "info"
  (setup-after "popwin"
    (push '("*info*") popwin:special-display-config))
  (setup-expecting "vi"
    ;; "Info-mode-map" does not work ?
    (setup-hook 'Info-mode-hook 'my-kindly-view-mode)
    (setup-keybinds Info-mode-map
      "RET"      'Info-follow-nearest-node
      "SPC"      'Info-next-reference
      "DEL"      'Info-prev-reference
      "h"        'Info-history-back
      "l"        'Info-history-forward
      "u"        'Info-up
      "q"        'Info-exit
      "f"        '("ace-link" ace-link-info)
      '("g" "n") nil)))

;;   + tabulated
;;     + common

;; disable key-chord in listy modes
(setup-after "key-chord"
  (setup-hook 'my-listy-mode-common-hook
    (setq-local key-chord-mode        nil
                input-method-function nil)))

(setup-expecting "stripe-buffer"
  (setup-hook 'my-listy-mode-common-hook 'my-stripe-buffer))

(setup-hook 'my-listy-mode-common-hook
  (setup-keybinds (current-local-map)
    "j" 'next-line
    "k" 'previous-line))

;; tabulated-list.el (loaded before init.el)
(setup-hook 'tabulated-list-mode-hook
  :oneshot
  (setup-keybinds tabulated-list-mode-map
    "," 'tabulated-list-sort))

;;     + dired [find-dired-lisp] [phi-search-dired] [dired-explore]

;; NOTE: dired is not a submode of tabulated-list-mode
(setup-lazy '(my-dired-default-directory) "dired"

  ;; settings

  (setq dired-dwim-target          t
        dired-auto-revert-buffer   t
        dired-recursive-copies     'always
        dired-recursive-deletes    'top
        dired-keep-marker-copy     nil
        dired-keep-marker-symlink  nil
        dired-keep-marker-hardlink nil
        dired-keep-marker-rename   t)

  ;; add "[Dired]" prefix to buffer names
  (setup-hook 'dired-mode-hook
    (rename-buffer (concat "[Dired]" (buffer-name)) t)
    ;; use '*' instead of 'D'
    (add-hook 'post-command-hook
              (lambda () (dired-change-marks ?D dired-marker-char)) nil t))

  ;; plugins

  (setup "find-dired-lisp"
    (require 'find-dired)               ; dependency (find-ls-option)
    (setup-keybinds dired-mode-map "f" 'find-dired-lisp))

  (setup-lazy '(phi-search-dired) "phi-search-dired")
  (setup-lazy '(dired-explore) "dired-explore")

  ;; keybinds

  ;; dired-x modifies keybinds so load it first.
  (require 'dired-x)

  (setup-keybinds dired-mode-map
    "RET"     'my-dired-find-alternate-file
    "SPC"     'my-dired-toggle-mark
    "DEL"     'dired-unmark-backward
    "`"       'dired-flag-backup-files               ; '~'
    "1"       'dired-do-shell-command                ; '!'
    "2"       'dired-mark-symlinks                   ; '@'
    "3"       'dired-flag-auto-save-files            ; '#'
    "5"       'dired-do-query-replace-regexp         ; '%'
    "7"       'dired-do-async-shell-command          ;
    "8"       'dired-mark-executables                ; '*'
    "-"       'my-dired-do-count-lines               ;
    "="       'dired-diff                            ;
    "q"       'kill-this-buffer                      ; 'Q'uit
    "w"       'wdired-change-to-wdired-mode          ; 'W'dired
    "t"       'dired-toggle-marks                    ; 'T'oggle
    "u"       'dired-unmark-all-marks                ; 'U'nmark
    "i"       'my-dired-do-insert-subdirs            ; 'I'nsert
    "o"       'dired-find-file-other-window          ; 'O'ther-window
    "r"       'revert-buffer                         ; 'R'efresh
    "e"       'my-dired-do-convert-coding-system     ; 'E'ncoding
    "s"       'dired-do-isearch-regexp               ; 'S'earch
    "d"       'dired-do-delete                       ; 'D'elete
    "g"       'dired-flag-garbage-files              ; 'G'arbage
    "h"       'my-dired-up-directory                 ; (inspired by vi)
    "j"       'dired-next-line                       ; (inspired by vi)
    "k"       'dired-previous-line                   ; (inspired by vi)
    "l"       'my-dired-find-alternate-file          ; (inspired by vi)
    "z"       'dired-do-compress-to                  ; 'Z'ip
    "x"       'my-dired-winstart                     ; e'X'ecute
    "c"       'dired-do-copy                         ; 'C'opy
    "v"       'dired-view-file                       ; 'V'iew
    "b"       'dired-do-byte-compile                 ; 'B'ytecompile
    "n"       'dired-create-directory                ; 'N'ew
    "m"       'dired-do-rename                       ; 'M'ove
    ","       'dired-sort-toggle-or-edit             ;
    "/"       '("phi-search-dired" phi-search-dired) ; (inspired by vi)
    "C-c C-o" 'dired-do-chown                        ; 'C'hange-'O'wn
    "C-c C-m" 'dired-do-chmod                        ; 'C'hange-'M'od
    "C-c C-g" 'dired-do-chgrp                        ; 'C'hange-'G'rp
    "C-c C-s" 'dired-do-symlink                      ; 'C'reate-'S'ymlink
    "C-c C-h" 'dired-do-hardlink                     ; 'C'reate-'H'ardlink
    "C-M-u"   nil
    '("!" "@" "#" "$" "%" "^" "&" "*" "(" ")" "_" "+" "{" "}" ":" "\"" "|" "<"
      ">" "?" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P"
      "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z") '("dired-explore" dired-explore))

  ;; interactive commands

  (defun my-dired-default-directory ()
    (interactive)
    (dired default-directory))

  (defun my-dired-find-alternate-file ()
    (interactive)
    (dired-find-alternate-file))

  ;; taken from http://www.bookshelf.jp/soft/meadow_25.html#SEC276
  (defun my-dired-toggle-mark (arg)
    "Toggle the current (or next ARG) files."
    (interactive "P")
    (let ((dired-marker-char
           (if (save-excursion (beginning-of-line)
                               (= (char-after) ?\s))
               dired-marker-char ?\040)))
      (dired-mark arg)))

  ;; taken from http://www.emacswiki.org/emacs/DiredReuseDirectoryBuffer
  (defun my-dired-up-directory ()
    "like dired-up-directory but reuse current buffer"
    (interactive)
    (let* ((current-dir (dired-current-directory))
           (up-dir (file-name-directory (directory-file-name current-dir)))
           (prev-buf (current-buffer)))
      (or (dired-goto-file (directory-file-name current-dir))
          (and (cdr dired-subdir-alist)
               (dired-goto-subdir up-dir))
          (progn
            (kill-buffer prev-buf)
            (dired up-dir)
            (dired-goto-file current-dir)))))

  ;; taken from uenox-dired.el
  (defun my-dired-winstart ()
    "win-start the current line's file."
    (interactive)
    (my-open-file (dired-get-filename)))

  (setup-lazy
    '(my-dired-do-convert-coding-system
      my-dired-do-insert-subdirs
      my-dired-do-count-lines) "dired-aux" ; dired-map-over-marks-check

      (defun my-dired-do-convert-coding-system ()
        "Convert file (s) in specified coding system."
        (interactive)
        (let ((coding
               (read-coding-system
                (format "Coding system for converting file (s) (default, %s): "
                        buffer-file-coding-system)
                buffer-file-coding-system)))
          (check-coding-system coding)
          (dired-map-over-marks-check
           (lambda ()
             (let ((file (dired-get-filename))
                   (coding-system-for-write coding))
               (condition-case err
                   (with-temp-buffer
                     (insert-file-contents file)
                     (write-region (point-min) (point-max) file)
                     nil)
                 (error (dired-log "convert coding system error for %s:\n%s\n" file err)
                        err))))
           nil 'convert-coding-system t)))

      (defun my-dired-do-insert-subdirs ()
        (interactive)
        (dired-map-over-marks-check
         (lambda ()
           (let ((dirname (dired-get-filename)))
             (condition-case err
                 (progn (dired-insert-subdir dirname) nil)
               (error (dired-log "failed to insert %s:\n%s\n" dirname err)
                      err))))
         nil 'insert-subdir t))

      (defun my-dired-do-count-lines ()
        (interactive)
        (let ((num-files 0) (lines 0) (comments 0))
          (dired-map-over-marks-check
           (lambda ()
             (let ((files (list (dired-get-filename))) file)
               (while (setq file (pop files))
                 (unless (string-match "\\(?:^\\|/\\)\\.\\.?$" file)
                   (if (file-directory-p file)
                       (setq files (nconc (directory-files file t) files))
                     (with-temp-buffer
                       (insert-file-contents file)
                       (goto-char (point-min))
                       (let ((buffer-file-name file))
                         (ignore-errors (set-auto-mode)))
                       (setq lines (+ (count-lines (point-min) (point-max)) lines)
                             num-files (1+ num-files))
                       (while (ignore-errors
                                (let* ((beg (goto-char (comment-search-forward (point-max))))
                                       (beg-okay (looking-back "^[\s\t]*" (point-at-bol))))
                                  (forward-comment 1)
                                  (when (and beg-okay (looking-at "^[\s\t]*\\|[\s\t]*$"))
                                    (setq comments (+ (count-lines beg (point)) comments))))
                                t)))))))
             nil)
           nil 'count-lines t)
          (message "%d lines (including %d comment lines) in %s files."
                   lines comments num-files)))
      )
  )

;;     + Buffer-menu

;; buff-menu.el (loaded before init.el)
(setup-after "popwin"
  (push '("*Buffer List*") popwin:special-display-config))
(setup-hook 'Buffer-menu-mode-hook
  :oneshot
  (setup-keybinds Buffer-menu-mode-map
    "RET" 'Buffer-menu-select
    "SPC" 'Buffer-menu-delete
    "l"   'Buffer-menu-select
    "o"   'Buffer-menu-other-window
    "v"   'Buffer-menu-view
    "d"   'Buffer-menu-execute
    "f"   'Buffer-menu-toggle-files-only))

;;   + others
;;     + fundamental-mode

(setup-after "simple"
  (setup-after "mark-hacks"
    (push 'fundamental-mode mark-hacks-auto-indent-inhibit-modes)))

;; + | Appearance
;;   + font-lock level

(setq font-lock-maximum-decoration '((t . t)))

;;   + mode-line settings
;;   + | faces

(!foreach '(mode-line-bright-face
            mode-line-dark-face
            mode-line-annotation-face
            mode-line-highlight-face
            mode-line-special-mode-face
            mode-line-warning-face
            mode-line-modified-face
            mode-line-narrowed-face
            mode-line-mc-face
            mode-line-palette-face)
  (make-face ,it)
  (set-face-attribute ,it nil :inherit 'mode-line))

;;   + | the mode-line-format

;; scratch-palette status
(defvar-local my-palette-available-p nil)
(setup-after "scratch-palette"
  (defun my-update-palette-status ()
    (when (and buffer-file-name
               (file-exists-p (scratch-palette--file-name buffer-file-name)))
      (setq my-palette-available-p t)))
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (my-update-palette-status)))
  (setup-hook 'find-file-hook 'my-update-palette-status)
  (define-advice scratch-palette-kill (:after (&rest _))
    (my-update-palette-status)))

(defsubst my-mode-line--macro ()
  (if defining-kbd-macro
      (! (propertize "● " 'face 'mode-line-warning-face))
    ""))

(defsubst my-mode-line--linum ()
  (if (not mark-active)
      (! (propertize "%l" 'face 'mode-line-bright-face))
    (propertize (format "%d" (- (region-end) (region-beginning)))
                'face 'mode-line-highlight-face)))

;; either linum or colnum must be %-notated to be updated correctrly
(defsubst my-mode-line--colnum ()
  (if (not mark-active)
      (propertize "%c" 'face 'mode-line-bright-face)
    (propertize (format "%d" (count-lines (region-beginning) (region-end)))
                'face 'mode-line-highlight-face)))

(defsubst my-mode-line--indicators ()
  (concat
   (if (buffer-narrowed-p)
       (! (propertize "n" 'face 'mode-line-narrowed-face))
     (! (propertize "n" 'face 'mode-line-dark-face)))
   (cond (buffer-read-only (propertize "-" 'face 'mode-line-dark-face))
         ((buffer-modified-p) (! (propertize "*" 'face 'mode-line-modified-face)))
         (t (! (propertize "*" 'face 'mode-line-dark-face))))
   (if (bound-and-true-p multiple-cursors-mode)
       (propertize (format "%02d" (mc/num-cursors)) 'face 'mode-line-mc-face)
     (! (propertize "00" 'face 'mode-line-dark-face)))))

(defconst my-mode-line--filename
  (! (propertize "%b" 'face 'mode-line-highlight-face)))

(defsubst my-mode-line--palette-status ()
  (if my-palette-available-p
      (! (propertize ":p" 'face 'mode-line-palette-face))
    ""))

(defconst my-mode-line--recur-status
  (! (propertize "%]" 'face 'mode-line-dark-face)))

(defvar-local my-mode-line--mode-name-cache nil)
(defsubst my-mode-line--mode-name ()
  (cond ((bound-and-true-p artist-mode)
         (! (propertize "*Artist*" 'face 'mode-line-special-mode-face)))
        ((bound-and-true-p orgtbl-mode)
         (! (propertize "*OrgTbl*" 'face 'mode-line-special-mode-face)))
        (t
         (unless (eq (car my-mode-line--mode-name-cache) major-mode)
           (setq my-mode-line--mode-name-cache
                 (cons major-mode
                       (propertize (format-mode-line mode-name) 'face 'mode-line-annotation-face))))
         (cdr my-mode-line--mode-name-cache))))

(defsubst my-mode-line--process ()
  (propertize (format-mode-line mode-line-process) 'face 'mode-line-highlight-face))

(defsubst my-mode-line--encoding ()
  (propertize (format "%s%s"
                      (let ((type (coding-system-type buffer-file-coding-system)))
                        (if (memq type '(undecided utf-8))
                            ""
                          (concat "  " (upcase (symbol-name type)))))
                      (let ((eol-type (coding-system-eol-type buffer-file-coding-system)))
                        (if (vectorp eol-type) ?-
                          (cl-case eol-type
                            ((0) "")
                            ((1) "  CRLF")
                            ((2) "  CR")
                            (else "  ??")))))
              'face 'mode-line-annotation-face))

(defconst my-mode-line--vertical-spacer
  (! (concat (propertize " " 'display '(raise +0.25))
             (propertize " " 'display '(raise -0.25)))))

(defun my-generate-mode-line-format ()
  (let* ((lstr
          (concat (my-mode-line--macro)
                  (my-mode-line--indicators)
                  "  " my-mode-line--filename
                  (my-mode-line--palette-status)
                  my-mode-line--recur-status
                  my-mode-line--vertical-spacer))
         (rstr
          ;; use format-mode-line to get "correct" string width
          (format-mode-line
           (list (my-mode-line--mode-name)
                 (my-mode-line--process)
                 (my-mode-line--encoding)
                 "  " (my-mode-line--linum)
                 ":" (my-mode-line--colnum))))
         (lmargin
          (propertize " " 'display '((space :align-to (+ 1 left-fringe)))))
         (rmargin
          (propertize " " 'display `((space :align-to (- right-fringe ,(length rstr)))))))
    (concat lmargin lstr rmargin rstr)))

(setq-default mode-line-format '((:eval (my-generate-mode-line-format))))

;; force update mode-line every minutes
(run-with-timer 60 60 'force-mode-line-update)

;; force update mode-line when idle
(run-with-idle-timer 0.3 t 'force-mode-line-update)

;;   + "kindly-view" minor-mode

;; reference | http://d.hatena.ne.jp/nitro_idiot/20130215/1360931962
(setup-lazy '(my-kindly-view-mode) "vi"

  (defvar my-kindly-view-mode-map
    (let ((kmap (copy-keymap vi-com-map)))
      (setup-keybinds kmap
        '("j" "C-n") 'my-scroll-up-by-row
        '("k" "C-p") 'my-scroll-down-by-row
        "h"          'backward-char
        "l"          'forward-char)))

  (defvar my-kindly-unsupported-minor-modes
    '(phi-autopair-mode)
    "list of minor-modes that must be turned-off temporarily.")
  (defvar my-kindly-unsupported-global-variables
    '(global-hl-line-mode show-paren-mode
                          key-chord-mode input-method-function)
    "list of variables that must be set nil locally.")

  (defvar my-kindly-view-mode nil) ; define as a global variable to suppress warning
  (defun my-kindly-view-mode ()
    (interactive)
    (setq-local my-kindly-view-mode t
                line-spacing        0.3
                cursor-type         'bar
                face-remapping-alist
                (append face-remapping-alist
                        '((default (:family "Times New Roman" :height 1.3 :width semi-condensed)))))
    (dolist (mode my-kindly-unsupported-minor-modes)
      (when (and (boundp mode) mode) (funcall mode -1)))
    (dolist (var my-kindly-unsupported-global-variables)
      (set (make-local-variable var) nil))
    ;; use current major-mode's bindings as the minor-mode bindings
    (setq-local minor-mode-map-alist
                (cons (cons 'my-kindly-view-mode (current-local-map)) minor-mode-map-alist))
    ;; and kindly-view-mode-map as the major-mode bindings
    (use-local-map my-kindly-view-mode-map))

  ;; vi-mode hacks

  ;; vi-like paren-matching
  (setup-after "paren"
    (define-advice show-paren-function (:around (fn &rest args))
      (if (and (eq major-mode 'vi-mode)
               (looking-back "\\s)" (max 0 (- (point) 2))))
          (save-excursion (forward-char) (apply fn args))
        (apply fn args))))

  ;; make cursor "box" while in vi-mode
  (define-advice vi-mode (:after (&rest _))
    (setq cursor-type 'box))
  (define-advice vi-goto-insert-state (:after (&rest _))
    (setq cursor-type 'bar))

  ;; disable key-chord
  (setup-after "key-chord"
    (define-advice vi-mode (:after (&rest _))
      (setq-local key-chord-mode        nil
                  input-method-function nil))
    (define-advice vi-goto-insert-state (:after (&rest _))
      (kill-local-variable 'key-chord-mode)
      (kill-local-variable 'input-method-function)))
  )

;;   + prettify ansi-colored output

(setup-lazy '(ansi-color-highlighter) "ansi-color"
  (defun ansi-color-highlighter (b e)
    (ignore-errors (ansi-color-apply-on-region b e))))
(define-minor-mode ansi-color-mode
  "Apply ansi color on-the-fly."
  :init-value nil
  :lighter "Ancl"
  :global nil
  (if ansi-color-mode
      (jit-lock-register 'ansi-color-highlighter)
    (jit-lock-unregister 'ansi-color-highlighter)))

;;   + "secret-words" minor-mode

(defvar my-secret-words (! my-secret-words))

(defun my-secret-words--jit-hider (b e)
  (save-excursion
    (remove-overlays b e 'category 'my-secret-words)
    (dolist (word my-secret-words)
      (goto-char b)
      (while (search-forward-regexp word e t)
        (let* ((b (match-beginning 0))
               (e (match-end 0))
               (ov (make-overlay b e)))
          (overlay-put ov 'category 'my-secret-words)
          (overlay-put ov 'display (make-string (- e b) ?*)))))))

(defun my-secret-words--post-command ()
  (let ((ovs (overlays-at (point)))
        (message-log-max nil))
    (dolist (ov ovs)
      (when (eq (overlay-get ov 'category) 'my-secret-words)
        (message (buffer-substring (overlay-start ov) (overlay-end ov)))))))

(defgroup my-secret-words nil
  "Minor mode to hide secret words."
  :group 'emacs)

(define-minor-mode my-secret-words-mode
  "Minor mode to hide secret words in the buffer."
  :init-value nil
  :global nil
  :lighter "Secr"
  :group 'my-secret-words
  (cond (my-secret-words-mode
         (jit-lock-mode 1)
         (jit-lock-register 'my-secret-words--jit-hider)
         (add-hook 'post-command-hook 'my-secret-words--post-command nil t))
        (t
         (remove-hook 'post-command-hook 'my-secret-words--post-command t)
         (jit-lock-unregister 'my-secret-words--jit-hider)
         (remove-overlays (point-min) (point-max) 'category 'my-secret-words))))

(define-globalized-minor-mode my-global-secret-words-mode
  my-secret-words-mode
  (lambda () (my-secret-words-mode 1)))

(!when my-secret-words
  (my-global-secret-words-mode 1))

;;   + colorscheme

;; utility to mix two colors
(eval-and-compile
  (defun my-blend-colors (basecolor mixcolor percent)
    "Mix two colors."
    (require 'color)
    (cl-destructuring-bind (r g b) (color-name-to-rgb basecolor)
      (cl-destructuring-bind (r2 g2 b2) (color-name-to-rgb mixcolor)
        (let* ((x (/ percent 100.0))
               (y (- 1 x)))
          (color-rgb-to-hex (+ (* r y) (* r2 x)) (+ (* g y) (* g2 x)) (+ (* b y) (* b2 x))))))))

;; load the theme
(setup "elemental-theme")
(enable-theme 'elemental-theme)

;; utility to apply color palette to the elemental-theme
(defmacro my-elemental-theme-apply-colors
    (bg-base fg-base accent-1 accent-2 accent-3 accent-4 red orange green blue)
  (declare (indent defun))
  (let* ((brightness-bg (caddr (apply 'color-rgb-to-hsl (color-name-to-rgb bg-base))))
         (brightness-fg (caddr (apply 'color-rgb-to-hsl (color-name-to-rgb fg-base))))
         (mode          (if (< brightness-bg brightness-fg) 'dark 'light))
         (bright-bg     (my-blend-colors bg-base fg-base (if (eq mode 'dark) 15 6)))
         (brighter-bg   (my-blend-colors bg-base fg-base (if (eq mode 'dark) 30 12)))
         (darker-fg     (my-blend-colors fg-base bg-base (if (eq mode 'dark) 74 84)))
         (dark-fg       (my-blend-colors fg-base bg-base (if (eq mode 'dark) 37 42)))
         (bright-fg     (my-blend-colors fg-base bg-base (if (eq mode 'dark) -30 -12))))
    `(progn
       (custom-theme-set-variables 'elemental-theme '(frame-background-mode ',mode))
       ,(when (eq window-system 'ns)
          `(set-frame-parameter nil 'ns-appearance ',mode))
       (set-face-background 'default ,bg-base)
       (set-face-background 'cursor ,fg-base)
       (set-face-background 'elemental-bright-bg-face ,bright-bg)
       (set-face-background 'elemental-brighter-bg-face ,brighter-bg)
       (set-face-foreground 'elemental-darker-fg-face ,darker-fg)
       (set-face-foreground 'elemental-dark-fg-face ,dark-fg)
       (set-face-foreground 'default ,fg-base)
       (set-face-foreground 'elemental-bright-fg-face ,bright-fg)
       (set-face-foreground 'elemental-accent-fg-1-face ,accent-1)
       (set-face-foreground 'elemental-accent-fg-2-face ,accent-2)
       (set-face-foreground 'elemental-accent-fg-3-face ,accent-3)
       (set-face-foreground 'elemental-accent-fg-4-face ,accent-4)
       (set-face-foreground 'elemental-red-fg-face ,red)
       (set-face-foreground 'elemental-orange-fg-face ,orange)
       (set-face-foreground 'elemental-green-fg-face ,green)
       (set-face-foreground 'elemental-blue-fg-face ,blue)
       (run-hooks 'my-elemental-theme-change-palette-hook))))

(setup-expecting "elemental-theme"

  ;; ;; the solarized-dark theme
  ;; (my-elemental-theme-apply-colors
  ;;   "#002b36" "#839496" "#268bd2" "#859900" "#b58900" "#2aa198"
  ;;   "#dc322f" "#cb4b16" "#2aa198" "#268bd2")

  ;; ;; the solarized-light theme
  ;; (my-elemental-theme-apply-colors
  ;;   "#fdf6e3" "#657b83" "#268bd2" "#859900" "#b58900" "#2aa198"
  ;;   "#dc322f" "#cb4b16" "#2aa198" "#268bd2")

  ;; ;; "jellybeans" palette
  ;; ;; reference | https://github.com/nanotech/jellybeans.vim
  ;; (my-elemental-theme-apply-colors
  ;;   "#202020" "#939393" "#fad08a" "#8fbfdc" "#ffb964" "#99ad6a"
  ;;   "#a04040" "#ffb964" "#99ad6a" "#8fbfdc")

  ;; ;; "mesa" palette
  ;; ;; reference | http://emacsfodder.github.io/blog/mesa-theme/
  ;; (my-elemental-theme-apply-colors
  ;;   "#ece8e1" "#4d4d4d" "#1388a2" "#00688b" "#3388dd" "#104e8b"
  ;;   "#dd2222" "#ac3d1a" "#1388a2" "#3388dd")

  ;; ;; "tron" palette
  ;; ;; reference | https://github.com/ivanmarcin/emacs-tron-theme/
  ;; (my-elemental-theme-apply-colors
  ;;   "#000000" "#75797b" "#ec9346" "#a4cee5" "#74abbe" "#e8b778"
  ;;   "red" "orange" "#74abbe" "#a4cee5")

  ;; ;; "majapahit" palette
  ;; ;; reference | https://gitlab.com/franksn/majapahit-theme/
  ;; (my-elemental-theme-apply-colors
  ;;   "#2A1F1B" "#887f73" "#adb78d" "#d4576f" "#768d82" "#849f98"
  ;;   "#bb4e62" "#d99481" "#adb78d" "#849f98")

  ;; "planet" palette
  ;; reference | https://github.com/cmack/emacs-planet-theme/
  (my-elemental-theme-apply-colors
    "#192129" "#79828c" "#729fcf" "#c4dde8" "#e9b96e" "#649d8a"
    "#fe5450" "#e9b96e" "#649d8a" "#729fcf")

  ;; ;; "kagamine len" inspired palette (bg modified)
  ;; ;; reference | http://vocaloidcolorpalette.tumblr.com/
  ;; ;;           | http://smallwebmemo.blog113.fc2.com/blog-entry-156.html
  ;; (my-elemental-theme-apply-colors
  ;;   "#fafafa" "#7e7765" "#fda700" "#59a9d2" "#db8d2e" "#34bd7d"
  ;;   "#f47166" "#db8d2e" "#34bd7d" "#59a9d2")

  ;; ;; "ayu"
  ;; (my-elemental-theme-apply-colors
  ;;   "#fafafa" "#575f66" "#f2ae49" "#fa8d3e" "#55b4d4" "#86b300"
  ;;   "#ff8683" "#e0b776" "#649d8a" "#729fcf")

  ;; ;; "reykjavik" palette
  ;; ;; reference | https://github.com/mswift42/reykjavik-theme/
  ;; (my-elemental-theme-apply-colors
  ;;   "#112328" "#798284" "#f1c1bd" "#a3d4e8" "#c1d2b1" "#e6c2db"
  ;;   "#e81050" "#e86310" "#c1d2b1" "#a3d4e8")

  ;; ;; chillized ("monochrome" inspired palette)
  ;; ;; reference | https://github.com/fxn/monochrome-theme.el/
  ;; (my-elemental-theme-apply-colors
  ;;   "#1c1c1c" "#7d7d7d" "#c0c0c0" "#9e9e9e" "#9e9e9e" "#77889a"
  ;;   "#aa6b6b" "#9b744c" "#9e9e9e" "#77889a")

  ;; ;; sakura
  ;; (my-elemental-theme-apply-colors
  ;;   "#192129" "#7d7d7d" "#c0c0c0" "#9e9e9e" "#9e9e9e" "#F8C3CD"
  ;;   "#FB9A85" "#F8C3CD" "#B0D391" "#9e9e9e")

  ;; ;; green ("monochrome" inspired palette 3)
  ;; (my-elemental-theme-apply-colors
  ;;   "#102010" "#008000" "#00c000" "#00a000" "#00c000" "#00a000"
  ;;   "#00f000" "#00f000" "#00f000" "#00f000")

  ;; ;; pink ("monochrome" inspired palette 3)
  ;; (my-elemental-theme-apply-colors
  ;;   "#201520" "#804080" "#c060c0" "#a050a0" "#c060c0" "#a050a0"
  ;;   "#f070f0" "#f070f0" "#f070f0" "#f070f0")

  ;; ;; white ("monochrome" inspired palette 3)
  ;; (my-elemental-theme-apply-colors
  ;;   "#202020" "#808080" "#c0c0c0" "#a0a0a0" "#c0c0c0" "#c0c0c0"
  ;;   "#ed9494" "#edd694" "#94edaa" "#94eded")

  ;; ;; less colorful "planet" theme based on "monochrome"
  ;; (my-elemental-theme-apply-colors
  ;;   "#192129" "#7d7d7d" "#c0c0c0" "#9e9e9e" "#e0b776" "#649d8a"
  ;;   "#ff8683" "#e0b776" "#649d8a" "#729fcf")

  ;; ;; less colorful "planet", green and blue swapped
  ;; (my-elemental-theme-apply-colors
  ;;   "#192129" "#7d7d7d" "#c0c0c0" "#9e9e9e" "#e0b776" "#729fcf"
  ;;   "#ff8683" "#e0b776" "#649d8a" "#729fcf")

  ;; ;; icecream
  ;; ;; https://www.pinterest.jp/pin/176555247871619456
  ;; (my-elemental-theme-apply-colors
  ;;   "#192129" "#7d7d7d" "#c0c0c0" "#9e9e9e" "#fef187" "#aee2c9"
  ;;   "#f9c9cf" "#f8c3a4" "#aee2c9" "#c0c0c0")

  ;; extra mode-line faces
  (set-face-attribute
   'mode-line-bright-face nil
   :inherit 'unspecified)
  (set-face-attribute
   'mode-line-dark-face nil
   :inherit 'elemental-dark-fg-face)
  (set-face-attribute
   'mode-line-annotation-face nil
   :inherit '(elemental-dark-fg-face italic))
  (set-face-attribute
   'mode-line-highlight-face nil
   :inherit '(elemental-accent-fg-3-face bold))
  (set-face-attribute
   'mode-line-warning-face nil
   :inherit 'elemental-orange-fg-face)
  (set-face-attribute
   'mode-line-special-mode-face nil
   :inherit 'elemental-accent-fg-4-face
   :weight  'bold)
  (set-face-attribute
   'mode-line-modified-face nil
   :inherit 'elemental-red-fg-face)
  (set-face-attribute
   'mode-line-narrowed-face nil
   :inherit 'elemental-accent-fg-4-face)
  (set-face-attribute
   'mode-line-mc-face nil
   :inherit 'elemental-bright-fg-face)
  (set-face-attribute
   'mode-line-palette-face nil
   :inherit '(elemental-accent-fg-4-face bold))

  ;; "show-eof" face
  (setup-after "show-eof-mode"
    (set-face-attribute
     'show-eof-mode-marker-face nil
     :inherit 'elemental-ui-ghost))

  (setup-after "highlight-parentheses"
    (setq highlight-parentheses-colors nil
          highlight-parentheses-background-colors
          (list (face-background 'elemental-brighter-bg-face)))
    ;; re-apply colors when the palette is changed
    (setup-hook 'my-elemental-theme-change-palette-hook
      (setq highlight-parentheses-background-colors
            (list (face-background 'elemental-brighter-bg-face))))
    (highlight-parentheses--color-update))

  (setup-after "cperl-mode"
    (set-face-attribute 'cperl-hash-key-face nil :inherit 'elemental-key))
  )

;;   + Misc: built-ins

;; frame.el (loaded before init.el)
(window-divider-mode 1)
(blink-cursor-mode -1)

;; font-lock.el (loaded before init.el)
(setq font-lock-support-mode 'jit-lock-mode
      jit-lock-stealth-time 16)

;; highlight matching parens
;; - show-paren-mode cannot be delayed with "!-" (why?)
(setup "paren"
  (setq show-paren-delay 0)
  (show-paren-mode 1))

(setup "hl-line"
  (global-hl-line-mode 1))

(setup-lazy '(whitespace-mode) "whitespace"
  :prepare (setup-hook 'find-file-hook 'whitespace-mode)
  (setq whitespace-space-regexp     "\\(\x3000+\\)"
        whitespace-style            '(face tabs spaces space-mark tab-mark)
        whitespace-display-mappings '((space-mark ?\x3000 [?□])
                                      (tab-mark ?\t [?\xBB ?\t]))))

(setup-after "iimage"
  (setup-keybinds iimage-mode-map "C-l" nil))

;;   + Misc: plug-ins

(!-
 (setup "highlight-parentheses"
   (define-globalized-minor-mode global-highlight-parentheses-mode
     highlight-parentheses-mode
     (lambda () (highlight-parentheses-mode 1)))
   (define-advice hl-paren-create-overlays (:after (&rest _))
     (dolist (ov hl-paren-overlays)
       (overlay-put ov 'priority 2)))
   (global-highlight-parentheses-mode 1)
   (setup-after "vi"
     (push 'highlight-parentheses-mode my-kindly-unsupported-minor-modes))))

(!-
 (setup "highlight-stages"
   (setq highlight-stages-highlight-real-quote t
         highlight-stages-highlight-priority   2)
   (highlight-stages-global-mode 1)))

(!- (setup "rainbow-delimiters"))

(!- (setup "rainbow-mode"))

(!-
 (setup-lazy '(show-eof-mode) "show-eof-mode"
   :prepare (progn
              (setup-hook 'prog-mode-hook 'show-eof-mode)
              (setup-hook 'text-mode-hook 'show-eof-mode))))

(setup-lazy '(my-stripe-buffer) "stripe-buffer"
  (defun my-stripe-buffer ()
    (stripe-buffer-mode 1)
    (setq-local face-remapping-alist (cons '(hl-line . stripe-hl-line) face-remapping-alist)))
  ;; workaround emacs 27.1 support
  (set-face-attribute 'stripe-highlight nil :extend t)
  (set-face-attribute 'stripe-hl-line nil :extend t))

;; make GUI modern
(setup "sublimity"
  (setup "sublimity-scroll"
    (setq sublimity-scroll-weight       4
          sublimity-scroll-drift-length 3))
  (setup "sublimity-attractive"
    (setq sublimity-attractive-centering-width fill-column))
  (sublimity-mode 1))

;; + | Keybinds
;;   + translations

;; by default ...
;; - C-m is RET
;; - C-i is TAB
;; - C-[ is ESC
(keyboard-translate ?\C-h ?\C-?)

;; Use command (super) key as meta on mac systems
(!when (eq system-type 'darwin)
  (setq ns-command-modifier   'meta
        ns-alternate-modifier 'super))

;;   + keyboard
;;   + | ignored keys

;; ignore (disable translation too)
(setup-keybinds nil
  "<escape>" 'ignore
  "C-M-S-n"  'ignore                    ; mute discord
  )

;; disable some confusing commands
(setup-keybinds nil
  "C-z" nil                             ; suspend-frame
  "C-/" nil                             ; undo (built-in)
  '("C-\\" "C-`") nil                   ; toggle-input-method
  )

;;   + | fundamental
;;     + | prefix arguments

(setup-keybinds nil
  '("C-1" "C-2" "C-3" "C-4" "C-5"
    "C-6" "C-7" "C-8" "C-9" "C-0"
    "C-M-1" "C-M-2" "C-M-3" "C-M-4" "C-M-5"
    "C-M-6" "C-M-7" "C-M-8" "C-M-9" "C-M-0"
    "M-!" "M-@" "M-#" "M-$" "M-%"
    "M-^" "M-&" "M-*" "M-(" "M-)")
  'digit-argument)

;;     + | emacs

(setup-keybinds nil
  "C-g"     'keyboard-quit
  "M-G"     'keyboard-quit
  "C-M-g"   'abort-recursive-edit
  "M-e"     'my-eval-sexp-dwim
  "M-E"     'my-eval-and-replace-sexp
  "M-p"     '("ipretty" ipretty-last-sexp eval-print-last-sexp)
  "M-x"     'execute-extended-command
  "M-m"     '("dmacro" dmacro-exec repeat)
  "C-M-x"   'eval-defun
  "C-x C-c" 'save-buffers-kill-emacs
  "C-x C-0" 'kmacro-end-macro
  "C-x C-9" 'kmacro-start-macro
  "C-x RET" 'kmacro-end-and-call-macro
  "M-<f4>"  'save-buffers-kill-emacs)

;;     + | buffer

(setup-keybinds nil
  "M-b"     'switch-to-buffer
  "C-x C-w" 'write-file
  "C-x C-s" 'save-buffer
  "C-x C-x" 'my-rename-current-buffer-file
  "C-x C-b" 'list-buffers
  "C-x C-k" 'my-kill-this-buffer
  "C-x C-e" 'set-buffer-file-coding-system
  "C-x C-r" 'revert-buffer-with-coding-system)

;;     + | frame, window

(setup-keybinds nil
  "M-0" 'next-window-any-frame
  "M-1" 'delete-other-windows
  "M-2" 'my-split-window
  "M-3" 'my-resize-window
  "M-8" 'my-transpose-window-buffers
  "M-9" 'previous-window-any-frame
  "M-o" 'my-toggle-transparency
  "M-k" 'delete-window)

;;   + | motion
;;     + cursor

(setup-keybinds nil
  "C-b"   'backward-char
  "C-p"   'my-previous-line
  "C-n"   'my-next-line
  "C-f"   'forward-char
  "M--"   'my-jump-back!
  "C-M-b" 'backward-word
  "C-M-p" 'my-previous-blank-line
  "C-M-n" 'my-next-blank-line
  "C-M-f" 'forward-word
  "M-B"   'backward-sexp
  "M-P"   'my-up-list
  "M-N"   'my-down-list
  "M-F"   'forward-sexp)

;;     + jump

(setup-keybinds nil
  "C-j"   'my-smart-bol
  "C-e"   'end-of-line
  "C-M-j" 'beginning-of-defun
  "C-M-e" 'end-of-defun
  "M-l"   'goto-line
  "M-j"   '("consult-imenu" consult-imenu imenu))

;;     + scroll

(setup-keybinds nil
  "C-u"     'scroll-down-command
  "C-v"     'scroll-up-command
  "C-l"     'my-recenter
  "C-M-u"   'beginning-of-buffer
  "C-M-v"   'end-of-buffer
  "C-M-l"   'my-retop
  "M-L"     'my-recenter
  "C-x C-u" 'untabify)

;;   + | edit
;;     + undo, redo

(setup-keybinds nil
  "C--"   '("undo-tree" undo-tree-undo undo)
  "C-M--" '("undo-tree" undo-tree-redo repeat-complex-command)
  "M-_"   '("undo-tree" undo-tree-undo undo))

;;     + mark, region

(setup-keybinds nil
  "C-,"        '("expand-region" er/expand-region mark-word)
  "C-a"        '("multiple-cursors" my-mc/mark-next-dwim)
  "C-M-a"      '("multiple-cursors" my-mc/mark-all-dwim-or-skip-this)
  "C-M-,"      'mark-whole-buffer
  "M-<"        'my-mark-sexp
  "M-V"        'set-mark-command
  "<left>"     'my-move-region-left
  "<right>"    'my-move-region-right
  "<up>"       'my-move-region-up
  "<down>"     'my-move-region-down
  "C-SPC"      'set-mark-command
  "C-<return>" '("phi-rectangle" phi-rectangle-set-mark-command))

;;     + kill, yank

;; when "DEL" is defined, backward-delete-char on minibuffer sometimes
;; doesn't work
(setup-keybinds nil
  "C-w"   '("phi-rectangle" phi-rectangle-kill-region kill-region)
  "C-k"   'kill-line
  "C-d"   'delete-char
  "C-y"   '("phi-rectangle" phi-rectangle-yank yank)
  "C-M-w" '("phi-rectangle" phi-rectangle-kill-ring-save kill-ring-save)
  "C-M-k" 'my-kill-line-backward
  "C-M-d" 'kill-word
  "C-M-h" 'backward-kill-word
  "C-M-y" '("yasnippet" mark-hacks-expand-oneshot-snippet)
  "M-W"   'my-copy-sexp
  "M-K"   '("paredit" my-paredit-kill kill-line)
  "M-D"   'kill-sexp
  "M-H"   'backward-kill-sexp
  "M-Y"   'my-overwrite-sexp
  "M-y"   '("consult" consult-yank-pop yank-pop))

;;     + newline, indent, format

(setup-keybinds nil
  "TAB"   'my-indent-or-expand-dwim ; C-i
  "C-o"   'my-open-line-and-indent
  "RET"   'newline-and-indent ; C-m
  "C-M-i" 'fill-paragraph
  "C-M-o" 'my-new-line-between
  "C-M-m" 'my-next-opened-line
  "M-u"   '("undo-tree" undo-tree-visualize)
  "M-I"   'my-indent-defun
  "M-O"   'my-open-line-and-indent
  "M-M"   '("paredit" paredit-newline newline-and-indent))

;;     + search, replace

(setup-keybinds nil
  "C-r"   '("phi-replace" phi-replace-query query-replace-regexp)
  "C-s"   '("phi-search" phi-search isearch-forward-regexp)
  "C-M-r" '("phi-replace" phi-replace replace-regexp)
  "C-M-s" '("phi-search" phi-search-backward isearch-backward-regexp)
  "M-s"   '("phi-grep" phi-grep-in-file))

;;     + other edit commands

(setup-keybinds nil
  "C-t"   'my-transpose-words
  "C-;"   'comment-dwim
  "C-M-t" 'my-transpose-lines
  "C-."   '("include-anywhere" include-anywhere)
  "M-h"   'my-shrink-whitespaces
  "M-*"   '("paredit" paredit-forward-barf-sexp)
  "M-("   '("paredit" my-paredit-wrap-round)
  "M-)"   '("paredit" paredit-forward-slurp-sexp)
  "M-{"   '("paredit" my-paredit-wrap-square)
  "M-R"   '("paredit" paredit-raise-sexp)
  "M-U"   '("paredit" paredit-splice-sexp-killing-backward)
  "M-S"   '("paredit" paredit-split-sexp)
  "M-J"   '("paredit" paredit-join-sexps)
  "M-C"   '("paredit" paredit-convolute-sexp)
  "M-\""  '("paredit" paredit-meta-doublequote)
  "M-T"   'my-transpose-sexps
  "M-:"   'my-comment-sexp)

;;   + | file, directory, shell
;;     + browsing

(setup-keybinds nil
  "M-d"     'my-dired-default-directory
  "M-f"     'find-file
  "M-g"     '("phi-grep" phi-grep-in-directory rgrep)
  "M-r"     '("consult" consult-recent-file recentf-open-files)
  "C-x C-f" '("phi-grep" phi-grep-find-file-flat)
  "C-x C-=" '("ediff" ediff)
  "C-x C-d" 'dired
  "C-x DEL" '("dumb-jump" xref-find-definitions ff-find-other-file) ; C-x C-h
  )

;;   + | help

(define-prefix-command 'help-map)

(setup-keybinds nil
  "<f1>"      'help-map
  "<f1> <f1>" 'info
  "<f1> b"    'describe-keymap
  "<f1> c"    'describe-char
  "<f1> k"    'describe-key
  "<f1> m"    'describe-mode
  "<f1> f"    'describe-function
  "<f1> v"    'describe-variable
  "<f1> a"    'describe-face
  "<f1> x"    'describe-syntax
  "<f1> s"    'info-lookup-symbol)

;;   + | others

(setup-keybinds nil
  "M-`"       'toggle-input-method
  "M-<kanji>" 'ignore
  "C-q"       'quoted-insert
  ","         'my-smart-comma
  "M-w"       '("scratch-palette" scratch-palette-popup)
  "M-q"       '("scratch-pop" scratch-pop)
  "C-="       'text-scale-increase
  "C-M-="     'text-scale-decrease
  "C-M-c"     '("rpn-calc" rpn-calc calc)
  "M-a"       'artist-mode
  "M-n"       'my-toggle-narrowing
  "M-c"       '("smart-compile" smart-compile compile)
  "C-x C-t"   'toggle-truncate-lines
  "C-x C-p"   'my-restore-from-backup
  "C-x C-,"   '("download-region" download-region-as-url))

;;   + keychord

(setup-after "key-chord"
  (key-chord-define-global "fj" 'my-transpose-chars)
  (key-chord-define-global "hh" 'my-capitalize-word-dwim)
  (key-chord-define-global "jj" 'my-upcase-previous-word)
  (key-chord-define-global "kk" 'my-downcase-previous-word))
