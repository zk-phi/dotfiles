;; init.el (for Emacs 24.3) | 2012- zk_phi

(require 'setup)
(setup-initialize)

(setup-include "cl-lib")

;; + Cheat Sheet :
;; + | global
;;   + Ctrl-

;; C-_
;; |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  | Undo|Zoom+|     |     |
;;    | Quot| Cut | End |Rplce|TrsWd| Yank| PgUp| Tab | Open| U p |(ESC)|     |
;;       |MCNxt|Serch|Delte|Right| Quit| B S | Home|KilLn|Centr|Comnt|     |
;;          |     |  *  |  *  | PgDn| Left| Down|Retrn|ExpRg|     |     |

;; C-M-_
;; |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  | Redo|Zoom-|     |     |
;;    |     | Copy|EdDef|RplAl|TrsLn|YankS|BgBuf| Fill|NLBet|BPgph|(ESC)|     |
;;       |MCAll|SrchB|KilWd|FWord|Abort|BKlWd|BgDef|BKlLn| Top |     |     |
;;          |     |     | Calc|EdBuf|BWord|NPgph|FwRet|MrkAl|     |     |

;;   + Meta-

;; M-_
;; |KlWnd|MkWnd|Blnce|Follw|     |     |     |SwWnd|PvWnd|NxWnd|LstCg|     |     |     |
;;    |Scrat|Palet| Eval|Recnt|Table|YankP|UndoT|Shell|Opcty|EvalP|     |     |
;;       |Artst| All |Dired| File| Grep|Shrnk|Anthg|KlWnd| Goto|     |     |
;;          |     |Comnd|Cmpil| Vim |Buffr|Narrw|DMcro| Howm|     |     |

;; M-Shift-
;; |     |     |     |     |     |     |     | Barf|Wrap(|Slurp| Undo|     |     |     |
;;    |     |CpSex|EvlRp|Raise|TrsSx|YnkRp|Splce|IndtX| Open|UpLst|Wrap[|     |
;;       |     |SpltS|KlSex|FwrdX|     |KillX|JoinX|KillX|Centr|CmntX|Wrap"|
;;          |     |     |Convo| Mark|BackX|DnLst|Retrn|MkSex|     |     |

;;   + C-x -

;; C-x C-_
;; |     |     |     |     |     |     |     |     |BgMcr|EdMcr|WUndo| Diff|     |     |
;;    |     |Write|Encod|Revrt|Trnct|     |Untab|SpChk|     |RdOly|(ESC)|     |
;;       |MFile| Save|     |FFlat|     |OthrF|     |KilBf|CgLog|     |     |
;;          |     |Rname|Close|     |Bffrs|     |ExMcr|  DL |     |     |

;;   + specials

;; key-chord
;;
;; - fj : transpose-chars
;; - hh : capitalize word
;; - kk : upcase word
;; - jj : downcase word
;;
;; - sf : iy-go-to-char-backward
;; - jl : iy-go-to-char
;; - df : yas-expand
;; - jk : yas-expand

;; specials
;;
;; -    <f1> : help prefix
;; -  M-<f4> : kill-emacs
;;
;; -     TAB : indent / ac-expand
;; -     ESC : vi-mode
;; -   NConv : dabbrev-expand / yas-expand
;; -   C-RET : phi-rectangle-set-mark-command
;; -   C-SPC : set-mark-command / visible-register / exchange-point-and-mark

;; + | orgtbl-mode

;; C-_
;; |     | Edit|     |     |     |     |     |     |     |     |     |ColFm|     |     |
;;    |     |RcCut|     |     |TrRow|RcPst|     |FwCel|InRow|     |     |     |
;;       |     |     |     |     |     |     |     |     |     |     |     |
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

;; + Code :
;; + | Constants
;;   + system

;; Inherit some constant definitions from site-start.el, so that we
;; can write system-specific settings not in this file but in it.
;; Note that we need some of these values also during compilation.
(eval-and-compile
  (defconst my-home-system-p
    (when (boundp 'my-home-system-p) my-home-system-p)
    "Whether Emacs is running on my home system.")
  (defconst my-additional-include-directories
    (when (boundp 'my-additional-include-directories) my-additional-include-directories)
    "List of directories counted as additional info directory.")
  (defconst my-additional-info-directories
    (when (boundp 'my-additional-info-directories) my-additional-info-directories)
    "List of directories counted as additional include directory.")
  (defconst my-howm-import-directory
    (when (boundp 'my-howm-import-directory) my-howm-import-directory)
    "Directory which Howm should import notes from.")
  (defconst my-howm-export-file
    (when (boundp 'my-howm-export-file) my-howm-export-file)
    "File which Howm should export schedules to.")
  (defconst my-howm-export-ics
    (when (boundp 'my-howm-export-ics) my-howm-export-ics)
    "iCal which Howm should export schedules to.")
  (defconst my-clojure-jar-file
    (when (boundp 'my-clojure-jar-file) my-clojure-jar-file)
    "Path to clojure.jar executable.")
  (defconst my-migemo-dictionary
    (when (boundp 'my-migemo-dictionary) my-migemo-dictionary)
    "Dictionary file for migemo.")
  (defconst my-lingr-account
    (when (boundp 'my-lingr-account) my-lingr-account)
    "My Lingr account.")
  (defconst my-tramp-proxies
    (when (boundp 'my-tramp-proxies) my-tramp-proxies)
    "My tramp proxies.")
  (defconst my-lmntal-home-directory
    (when (boundp 'my-lmntal-home-directory) my-lmntal-home-directory)
    "The LMNTAL_HOME Path.")
  (defconst my-tramp-abbrevs
    (when (boundp 'my-tramp-abbrevs) my-tramp-abbrevs)
    "Abbreviation table for remote hosts.")
  (defconst my-secret-words
    (when (boundp 'my-secret-words) my-secret-words)
    "List of secret words to be hidden."))

;;   + path to library files

(defconst my-snippets-directory
  (!when (file-exists-p "~/.emacs.d/snippets/")
    "~/.emacs.d/snippets/")
  "Dictionary directory for yasnippet.")

(defconst my-dictionary-directory
  (!when (file-exists-p "~/.emacs.d/ac-dict/")
    "~/.emacs.d/ac-dict/")
  "Dictionary directory for auto-complete.")

(defconst my-latex-dictionary-directory
  (!when (file-exists-p "~/.emacs.d/ac-l-dict/")
    "~/.emacs.d/ac-l-dict/")
  "Dictionary directory for auto-complete-latex.")

(defconst my-sdic-eiwa-dictionary
  (!when (file-exists-p "~/.emacs.d/sdic/gene.sdic")
    "~/.emacs.d/sdic/gene.sdic")
  "Eiwa dictionary for sdic.")

(defconst my-sdic-waei-dictionary
  (!when (file-exists-p "~/.emacs.d/sdic/jedict.sdic")
    "~/.emacs.d/sdic/jedict.sdic")
  "Waei dictionary for sdic.")

(defconst my-ditaa-jar-file
  (!when (file-exists-p "~/.emacs.d/lib/ditaa.jar")
    "~/.emacs.d/lib/ditaa.jar")
  "/path/to/ditaa.jar")

(defconst my-ftp-executable
  (!when (file-exists-p "~/.emacs.d/lib/ftp.exe")
    "~/.emacs.d/lib/ftp.exe")
  "/path/to/ftp")

;;   + path to data files

;; Directory

(eval-and-compile
  (defconst my-dat-directory "~/.emacs.d/dat/"
    "Directory to save datas in."))

;; make sure that my-dat-directory exists
(eval-when-compile
  (unless (file-exists-p my-dat-directory)
    (make-directory my-dat-directory)))

(defconst my-eww-download-directory
  "~/.emacs.d/dat/eww_download/"
  "Directory to download files in.")

;; Common History Datas

(defconst my-ac-history-file
  (! (concat my-dat-directory "ac-comphist"))
  "File to save auto-complete history.")

(defconst my-smex-save-file
  (! (concat my-dat-directory "smex"))
  "File to save smex history.")

(defconst my-mc-list-file
  (! (concat my-dat-directory "mc-list"))
  "File to save the list of multiple-cursors compatible commands.")

(defconst my-ispell-dictionary
  (! (concat my-dat-directory "ispell-dict"))
  "File name of personal ispell dictionary.")

(defconst my-ispell-repl
  (! (concat my-dat-directory "ispell-repl"))
  "File name of personal ispell replacement dictionary.")

(defconst my-lingr-log-file
  (! (concat my-dat-directory "lingr"))
  "File to save `symon-lingr' log in.")

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

;; System-specific History Datas

(defconst my-auto-save-list-directory
  (! (concat my-dat-directory "auto-save-list_" system-name "/"))
  "Directory to save auto-save-list(s) in.")

(defconst my-palette-directory
  (! (concat my-dat-directory "palette_" system-name "/"))
  "Directory to save scratch-palette(s).")

(defconst my-eshell-directory
  (! (concat my-dat-directory "eshell_" system-name "/"))
  "Directory to save eshell histories.")

(defconst my-undohist-directory
  (! (concat my-dat-directory "undohist_" system-name "/"))
  "Directory to save undo histories.")

(defconst my-backup-directory
  (! (concat my-dat-directory "backups_" system-name "/"))
  "Directory to save backup files.")

(defconst my-scratch-pop-directory
  (! (concat my-dat-directory "scratch_pop_" system-name "/"))
  "File to save scratch.")

(defconst my-ido-save-file
  (! (concat my-dat-directory "ido_" system-name))
  "File to save ido history.")

(defconst my-recentf-file
  (! (concat my-dat-directory "recentf_" system-name))
  "File to save recentf history.")

(defconst my-save-place-file
  (! (concat my-dat-directory "save-place_" system-name))
  "File to save save-place datas.")

(defconst my-tramp-file
  (! (concat my-dat-directory "tramp_" system-name))
  "File to save tramp settings.")

;; + | Utilities

(defvar my-lispy-modes
  '(lisp-mode emacs-lisp-mode scheme-mode
              lisp-interaction-mode gauche-mode
              clojure-mode racket-mode egison-mode))
(setup-hook 'change-major-mode-after-body-hook
  (when (apply 'derived-mode-p my-lispy-modes)
    (run-hooks 'my-lispy-mode-common-hook)))

(defvar my-listy-modes
  '(tabulated-list-mode dired-mode proced-mode))
(setup-hook 'change-major-mode-after-body-hook
  (when (apply 'derived-mode-p my-listy-modes)
    (run-hooks 'my-listy-mode-common-hook)))

(defvar my-css-modes
  '(css-mode scss-mode))
(setup-hook 'change-major-mode-after-body-hook
  (when (apply 'derived-mode-p my-css-modes)
    (run-hooks 'my-css-mode-common-hook)))

(defvar my-web-modes
  '(js-mode css-mode html-mode web-mode))

(defun my-shorten-directory (dir len)
  (if (null dir) ""
    (let ((lst (mapcar (lambda (s)
                         (if (> (length s) 5)
                             (cons 5 (concat (substring s 0 4) "-"))
                           (cons (length s) s)))
                       (reverse (split-string (abbreviate-file-name dir) "/"))))
          (reslen 0)
          (res ""))
      (when (zerop (caar lst)) (setq lst (cdr lst))) ; ?
      (while (and lst (< (+ reslen (caar lst) 1 (if (cdr lst) 4 0)) len))
        (setq res    (concat (cdar lst) "/" res)
              reslen (+ reslen (caar lst) 1)
              lst    (cdr lst)))
      (when lst (setq res (concat "…/" res)))
      res)))

(defun my-read-font-family ()
  (completing-read "Font Family: " (cl-remove-duplicates (font-family-list)) nil t))

(defun my-set-fontset-font (family targets &optional rescale-rate add)
  "TARGETS can be a, or a list of, either charset-scripts (listed
in charset-script-alist), charsets (listed in charset-list), or a
cons of two integers."
  (let ((font-spec (font-spec :family family)))
    (when rescale-rate
      (push (cons font-spec rescale-rate) face-font-rescale-alist))
    (unless (and (consp targets) (listp (cdr targets)))
      (setq targets (list targets)))
    (dolist (target targets)
      (set-fontset-font t target font-spec nil add))))

;; + | System
;;   + *scratch* utilities [scratch-pop]
;;   + | backup/popup scratches

(setup "scratch-pop"
  (setq scratch-pop-backup-directory my-scratch-pop-directory)
  (setup-hook 'after-init-hook
    (scratch-pop-restore-scratches 1))
  (setup-hook 'kill-emacs-hook 'scratch-pop-backup-scratches))

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
(setup-hook 'after-save-hook
  (unless (get-buffer "*scratch*")
    (generate-new-buffer "*scratch*")
    (my-clean-scratch)))

;;   + hooks for save/open

;; make a parent directory on save if it does not exist
(!-
 (setup-hook 'before-save-hook
   (when buffer-file-name
     (let ((dir (file-name-directory buffer-file-name)))
       (when (and (not (file-exists-p dir))
                  (y-or-n-p (format "Directory does not exist. Create it? ")))
         (make-directory dir t))))))

;; query delete empty files instead of saving it
;; reference | http://www.bookshelf.jp/soft/meadow_24.html#SEC265
(!-
 (setup-hook 'after-save-hook
   (when (and (buffer-file-name (current-buffer))
              (= 0 (buffer-size)))
     (when (y-or-n-p "Delete file and kill buffer ? ")
       (delete-file (buffer-file-name (current-buffer)))
       (kill-buffer (current-buffer))))))

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

;;   + Misc: core
;;   + | system

(defalias 'yes-or-no-p 'y-or-n-p)

(setq frame-title-format                    "%b - Emacs"
      completion-ignore-case                t
      read-file-name-completion-ignore-case t
      ;; gc-cons-threshold                     (! (* 128 1024 1024))
      ;; gc-cons-percentage                    0.5
      message-log-max                       1000
      enable-local-variables                :safe
      echo-keystrokes                       0.1
      delete-by-moving-to-trash             t
      ;; common-win.el
      x-select-enable-clipboard             t
      ;; mule-cmds.el
      default-input-method                  "japanese"
      ;; startup.el
      inhibit-startup-screen                t
      inhibit-startup-message               t
      initial-scratch-message               ""
      initial-major-mode                    'emacs-lisp-mode
      ;; simple.el
      eval-expression-print-length          nil
      eval-expression-print-level           10
      shift-select-mode                     nil
      save-interprogram-paste-before-kill   t
      yank-excluded-properties              t
      delete-trailing-lines                 t
      ;; files.el
      magic-mode-alist                      nil
      interpreter-mode-alist                nil)

(setq-default indent-tabs-mode      nil
              tab-width             4
              truncate-lines        t
              line-move-visual      t
              cursor-type           'bar
              indicate-empty-lines  t
              ;; files.el
              require-final-newline t)

;; use UTF-8 as the default coding system
(prefer-coding-system 'utf-8)

;; on Windows, use Shift-JIS for file names
;; reference | http://sakito.jp/emacs/emacsshell.html
(!when (string= window-system "w32")
  (setq locale-coding-system    'sjis
        file-name-coding-system 'sjis))

;; un-disable some disabled commands
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
;; reference | http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
(setq minibuffer-prompt-properties
      '(read-only t point-entered minibuffer-avoid-prompt
                  face minibuffer-prompt))

;; truncate minibuffer
(setup-hook 'minibuffer-setup-hook
  (setq truncate-lines t))

;; make keyboard-quit quiet
;; reference | https://github.com/maginemu/dotfiles/blob/master/emacs.d/init.el
(setq ring-bell-function
      (lambda ()
        (unless (memq this-command '(minibuffer-keyboard-quit keyboard-quit))
          (ding))))

;; font settings
;; reference | http://macemacsjp.sourceforge.jp/matsuan/FontSettingJp.html
(!when (cl-every (lambda (f) (member f (font-family-list)))
                 '("Source Code Pro" "Unifont" ;; "Arial Unicode MS"
                   "Symbola" "VLゴシック phi" "さわらびゴシック phi"))
  (set-face-attribute 'default nil :family "Source Code Pro" :height 90) ; base
  ;; (set-face-attribute 'default nil :family "Source Code Pro" :height 75) ; base
  (my-set-fontset-font "Unifont" 'unicode) ; unicode fallback 2
  (my-set-fontset-font "Arial Unicode MS" 'unicode nil 'prepend) ; unicode fallback
  (my-set-fontset-font "Symbola" 'unicode nil 'prepend) ; unicode symbols
  (my-set-fontset-font "VLゴシック phi" 'unicode nil 'prepend) ; unicode
  (my-set-fontset-font "さわらびゴシック phi" '(han kana) nil 'prepend) ; japanese
  )

;; settings for the byte-compiler
(eval-when-compile
  (setq byte-compile-warnings '(not make-local)
        byte-compile-dynamic  t))

;;   + | backup, autosave

;; backup directory
(setq backup-directory-alist
      `(("\\.*$" . ,(expand-file-name my-backup-directory))))

;; version control
;; reference | http://aikotobaha.blogspot.jp/2010/07/emacs.html
(setq version-control        t
      kept-new-versions      200
      kept-old-versions      10
      delete-old-versions    t
      vc-make-backup-files   t)

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

;; uniquify buffer name
(!-
 (setup "uniquify"
   (setq uniquify-buffer-name-style 'post-forward-angle-brackets
         uniquify-ignore-buffers-re "*[^*]+*")))

(setup-include "saveplace"
  (setq save-place-file my-save-place-file)
  (setq-default save-place t)
  ;; open invisible automatically
  (defadvice save-place-find-file-hook (after save-place-open-invisible activate)
    (mapc (lambda (ov)
            (let ((ioit (overlay-get ov 'isearch-open-invisible-temporary)))
              (cond (ioit (funcall ioit ov nil))
                    ((overlay-get ov 'isearch-open-invisible)
                     (overlay-put ov 'invisible nil)))))
          (overlays-at (point)))))

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
    (setq ls-lisp-use-insert-directory-program  nil
          ls-lisp-dirs-first                    t)))

;; add include directories
(setup-after "find-file"
  (setq cc-search-directories
        (append my-additional-include-directories cc-search-directories)))

;;   + | edit

;; delete selection on insert like modern applications
(setup-include "delsel"
  (delete-selection-mode 1))

;; track undo history across sessions
(setup-include "undohist"
  (setq undohist-directory my-undohist-directory)
  (undohist-initialize)
  ;; fix for Windows
  (defun make-undohist-file-name (file)
    (when (string-match "\\(.\\):/?\\(.*\\)$" file)
      (setq file (concat "/drive_" (match-string 1 file) "/" (match-string 2 file))))
    (expand-file-name
     (subst-char-in-string ?/ ?! (replace-regexp-in-string "!" "!!" file))
     undohist-directory))
  ;; delete old histories
  (defun my-delete-old-undohists ()
    (let ((threshold (* (/ 365 2) 24 60 60))
          (current (float-time (current-time))))
      (dolist (file (directory-files undohist-directory t))
        (when (and (file-regular-p file)
                   (> (- current (float-time (nth 5 (file-attributes file))))
                      threshold))
          (message "deleting old undohist: %s" (file-name-base file))
          (delete-file file))))
    (message "Old undohists deleted."))
  (run-with-idle-timer 30 nil 'my-delete-old-undohists))

(setup-after "newcomment"
  (setq comment-empty-lines t))

;;   + | assistants

(setup-lazy '(turn-on-eldoc-mode) "eldoc"
  (setq eldoc-idle-delay                0.1
        eldoc-echo-area-use-multiline-p nil))

(setup-lazy '(my-turn-on-flyspell) "flyspell-lazy"
  ;; :prepare (add-hook 'find-file-hook 'my-turn-on-flyspell t)

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

;;   + | network

;; tramp settings
(setup-after "tramp"
  (setq tramp-persistency-file-name my-tramp-file
        tramp-default-proxies-alist (nconc my-tramp-proxies tramp-default-proxies-alist)))
(setup-expecting "tramp"
  (define-abbrev-table 'my-tramp-abbrev-table my-tramp-abbrevs)
  (setup-hook 'minibuffer-setup-hook
    (abbrev-mode 1)
    (setq local-abbrev-table my-tramp-abbrev-table)))

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

;;   + Misc: plug-ins
;;   + | buffers / windows

(!-
 (setup "smooth-scrolling"
   (setq smooth-scroll-margin 3)))

;; maximize frame on setup
(setup-include "maxframe"
  (!when (string= window-system "x")
    ;; send X messages
    (defadvice maximize-frame (after my-x-maximize-frame activate)
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                             '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                             '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))))
  (setup-hook 'window-setup-hook 'maximize-frame))

(setup "popwin"
  (setq popwin:reuse-window nil
        popwin:special-display-config
        '(("*Warnings*")
          ("*Shell Command Output*")
          ("*Compile-Log*" :noselect t) ; when selected compilation may fail ?
          ("*Backtrace*")
          ("*Completions*" :noselect t)))
  (popwin-mode 1))

;;   + | mark / region

;; load phi-rectangle
(setup-include "rect")                ; dependency
(setup-include "phi-rectangle"
  (setq phi-rectangle-collect-fake-cursors-kill-rings t))

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
  '(phi-grep-in-directory
    phi-grep-in-file
    phi-grep-find-file-flat) "phi-grep"
    (setup-after "indent-guide"
      (add-to-list 'indent-guide-inhibit-modes 'phi-grep-mode)))

;;   + | edit

(setup-include "phi-autopair"
  (nconc phi-autopair-lispy-modes my-lispy-modes)
  (phi-autopair-global-mode 1))

(setup-lazy '(electric-align-mode) "electric-align"
  :prepare (setup-hook 'prog-mode-hook 'electric-align-mode)
  (setq electric-align-shortcut-commands '(my-smart-comma)))

(setup-lazy '(electric-spacing-mode) "electric-spacing"
  (setq electric-spacing-regexp-pairs
        '(("\\cA\\|\\cC\\|\\ck\\|\\cK\\|\\cH" . "[\\\\{[($0-9A-Za-z]")
          ("[]\\\\})$0-9A-Za-z]" . "\\cA\\|\\cC\\|\\ck\\|\\cK\\|\\cH"))))

(setup-lazy '(jaword-mode) "jaword")

(!-
 (setup "popup")
 (setup "auto-complete"
   (setq ac-comphist-file  my-ac-history-file
         ac-auto-start     t
         ac-dwim           t
         ac-delay          0
         ac-ignore-case    nil
         ac-auto-show-menu 0.8
         ac-disable-faces  nil)
   (setq-default ac-sources '(ac-source-dictionary
                              ac-source-words-in-same-mode-buffers))
   (push my-dictionary-directory ac-dictionary-directories)
   (global-auto-complete-mode)
   (setup-keybinds ac-completing-map "S-<tab>" 'ac-previous)
   ;; complete words in web mode buffers
   (ac-define-source my-words-in-web-mode-buffers
     '((init . ac-update-word-index)
       (candidates . (ac-word-candidates
                      (lambda (buf)
                        (cl-some (lambda (mode)
                                   (with-current-buffer buf (derived-mode-p mode)))
                                 my-web-modes))))))
   ;; complete property names in CSS-like languages
   (setup-after "auto-complete-config"
     (ac-define-source my-css-propname
       '((candidates . (mapcar 'car ac-css-property-alist))
         (cache . 1)
         (prefix . "\\(?:^\\|;\\)[\s\t]*\\([^\s\t]*\\)")))
     (defadvice ac-css-prefix (around my-disable-ac-after-semicolon activate)
       (unless (= (char-before) ?\;) ad-do-it)))
   ;; do not complete remote file names
   (defadvice ac-filename-candidate (around my-disable-ac-for-remote-files activate)
     (unless (file-remote-p ac-prefix)
       ad-do-it))))

(setup-lazy '(guess-style-guess-all) "guess-style"
  :prepare (setup-hook 'find-file-hook
             (when (derived-mode-p 'prog-mode)
               (run-with-idle-timer 0 nil 'guess-style-guess-all))))

;;   + | keyboards

(!-
 (setup "key-chord"
   (key-chord-mode 1)))

(setup-lazy '(key-combo-mode key-combo-define-local) "key-combo"
  ;; input-method (and multiple-cursors) is incompatible with key-combo
  (defadvice key-combo-post-command-function (around mc-combo activate)
    (unless (or current-input-method
                (and (boundp 'multiple-cursors-mode) multiple-cursors-mode))
      ad-do-it)))
(defun my-unary (str)
  "a utility macro that generates smart insertion commands for
unary operators which can also be binary."
  `(lambda ()
     (interactive)
     (if (and (looking-back "[])\"a-zA-Z0-9_] *")
              (not (looking-back "\\(return\\|my\\|our\\) *")))
         (let ((back (unless (looking-back " ") " "))
               (forward (unless (looking-at " ") " ")))
           (insert (concat back ,str forward)))
       (insert ,str))))

;;   + | assistants

(setup-lazy '(flycheck-mode) "flycheck"
  ;; :prepare (add-hook 'prog-mode-hook 'flycheck-mode)
  (setq flycheck-display-errors-delay 0.1
        flycheck-highlighting-mode    'lines))

;; org-like folding via outline-mode
(setup "outline"
  (defvar-local my-outline-minimum-heading-len 10000)
  (setup-hook 'prog-mode-hook
    (when comment-start
      (outline-minor-mode 1)
      (setq-local outline-regexp (concat "^\\(\s*" (regexp-quote comment-start)
                                         "[" (regexp-quote comment-start) "]*\\)"
                                         "\s?\\(\s*\\++\\)\s"))
      (setq-local outline-level (lambda ()
                                  (setq my-outline-minimum-heading-len
                                        (min my-outline-minimum-heading-len
                                             (- (match-end 0) (match-beginning 0))))
                                  (- (match-end 0) (match-beginning 0)
                                     my-outline-minimum-heading-len)))))
  (setup-lazy '(my-outline-cycle-dwim) "outline-magic"
    :prepare (setup-keybinds outline-minor-mode-map "TAB" 'my-outline-cycle-dwim)
    (defun my-outline-cycle-dwim ()
      (interactive)
      (if (or (outline-on-heading-p) (= (point) 1))
          (outline-cycle)
        (call-interactively (global-key-binding "\t"))))
    (defadvice outline-cycle (after outline-cycle-do-not-show-subtree activate)
      ;; change "folded -> children -> subtree"
      ;; to "folded -> children -> folded -> ..."
      (when (eq this-command 'outline-cycle-children)
        (setq this-command 'outline-cycle))
      ;; change "overview -> contents -> show all"
      ;; to "overview -> show all -> overview -> ..."
      (when (eq this-command 'outline-cycle-overview)
        (setq this-command 'outline-cycle-toc)))))

;;   + | others

(!-
 (setup "symon"
   (setq symon-sparkline-ascent (!if my-home-system-p 97 100))
   (symon-mode 1)
   ;; (when my-lingr-account
   ;;   (setup-in-idle "symon-lingr")
   ;;   (setup-after "symon-lingr"
   ;;     (setup-after "popwin"
   ;;       (push '("*symon-lingr*") popwin:special-display-config))
   ;;     (setq symon-lingr-user-name (car my-lingr-account)
   ;;           symon-lingr-password  (cdr my-lingr-account)
   ;;           symon-lingr-log-file  my-lingr-log-file
   ;;           symon-lingr-app-key   "pvCm1t")
   ;;     (add-to-list 'symon-monitors 'symon-lingr-monitor t)
   ;;     ;; restart symon
   ;;     (symon-mode -1)
   ;;     (symon-mode 1)))
   ))

;; + | Commands
;;   + web browser [eww]

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

;;   + english <-> japanese dictionary [sdic]

(setup-after "sdic"

  ;; implement mode-hook
  (defvar sdic-mode-hook nil)
  (defadvice sdic-mode (after my-sdic-run-hooks activate)
    (run-hooks 'sdic-mode-hook))

  ;; advice "word-at-point" to use "word-at-point"
  (setup "thingatpt"
    (defadvice sdic-word-at-point (around my-fix-sdic-word-at-point activate)
      (let* ((str (or (word-at-point) ""))
             (len (length str)))
        (set-text-properties 0 len nil str)
        (setq ad-return-value str))))

  ;; popwin workaround
  (setup-after "popwin"
    (push '("*sdic*") popwin:special-display-config)
    ;; redefine some functions so that popwin can work with
    ;; reference | http://aikotobaha.blogspot.jp/2013/04/popwinel.html
    (defadvice sdic-display-buffer (around my-sdic-display-popwin activate)
      (let ((p (or (ad-get-arg 0) (point))))
        (and sdic-warning-hidden-entry
             (> p (point-min))
             (message "この前にもエントリがあります。"))
        (goto-char p)
        (display-buffer (get-buffer sdic-buffer-name))
        (set-window-start (get-buffer-window sdic-buffer-name) p)))
    (defadvice sdic-other-window (around my-sdic-fix-other-window activate)
      (other-window 1))
    (defadvice sdic-close-window (around my-sdic-fix-close-window activate)
      (bury-buffer sdic-buffer-name)))

  ;; settings
  (setq sdic-eiwa-dictionary-list (when my-sdic-eiwa-dictionary
                                    `((sdicf-client ,my-sdic-eiwa-dictionary)))
        sdic-waei-dictionary-list (when my-sdic-waei-dictionary
                                    `((sdicf-client ,my-sdic-waei-dictionary))))
  )

;;   + ido and recentf [flx-ido]
;;     + use ido almost everywhere

(setup-expecting "ido"
  ;; taken from "ido-everywhere"
  (setq read-file-name-function 'ido-read-file-name
        read-buffer-function 'ido-read-buffer)
  ;; taken from "ido-hacks"
  (put 'elp-instrument-package 'ido 'ignore)
  (setq completing-read-function 'my-completing-read-with-ido))

;; advice some functions to use the normal `completing-read'
(dolist (fn '(read-buffer-file-coding-system insert-char))
  (eval
   `(defadvice ,fn (around my-fix-completing-read activate)
      (let ((completing-read-function 'completing-read-default))
        ad-do-it))))

;;     + ido interface for recentf

(setup-expecting "recentf"
  (defvar recentf-save-file my-recentf-file))

(setup-after "recentf"
  (recentf-mode 1)
  (setq recentf-max-saved-items 500
        recentf-auto-cleanup    10
        recentf-exclude         '("/[^/]*\\<tmp\\>[^/]*/" "/[^/]*\\<backup\\>[^/]*/"
                                  "~$" "^#[^#]*#$" "^/[^/]*:" "/GitHub/" "\\.emacs\\.d/dat/"
                                  "/undohist/" "\\.elc$" "\\.howm$" "\\.dat$"))
  ;; auto-save recentf-list / delayed cleanup
  ;; reference | http://d.hatena.ne.jp/tomoya/20110217/1297928222
  (run-with-idle-timer 30 t 'recentf-save-list))

(setup-expecting "ido"
  (setup-lazy '(my-ido-recentf-open) "recentf"
    (defun my-ido-recentf-open ()
      "Use `ido-completing-read' to \\[find-file] a recent file"
      (interactive)
      (if (find-file
           (ido-completing-read "Find recent file: " recentf-list))
          (message "Opening file...")
        (message "Aborting")))))

;;     + settings for ido itself
;;     + | (prelude)

(setup-lazy
  '(ido-switch-buffer
    ido-write-file ido-find-file ido-dired
    ido-read-file-name ido-read-buffer
    my-completing-read-with-ido) "ido"

    (ido-mode t)

    ;; + | settings

    (setq ido-enable-regexp                      t
          ido-auto-merge-work-directories-length nil
          ido-save-directory-list-file           my-ido-save-file)

    (put 'dired-do-rename 'ido nil)       ; "'ignore" by default

    ;; + | ido interface for "completing-read"

    (defvar ido-hacks-completing-read-recursive nil)
    (defun my-completing-read-with-ido (prompt collection &optional
                                               predicate require-match initial-input
                                               hist def inherit-input-method)
      ;; workaround for info-lookup
      (when (consp collection)
        (setq collection
              (apply 'vector
                     (mapcar (lambda (x) (let ((obj (if (consp x) (car x) x)))
                                           (if (stringp obj) (make-symbol obj) obj)))
                             collection))))
      ;; --------------------------
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

    ;; + | better flex matching [flx-ido]

    (setup "flx-ido"

      (defun my-make-super-flex-keywords (str)
        (cl-labels ((shuffle-list (lst)
                                  ;; '(a b c) -> '((a b c) (b a c) (a c b))
                                  (when (>= (length lst) 2)
                                    (cons `(,(cadr lst) ,(car lst) . ,(cddr lst))
                                          (mapcar (lambda (l) (cons (car lst) l))
                                                  (shuffle-list (cdr lst)))))))
          (mapcar (lambda (lst) (mapconcat 'char-to-string lst ""))
                  (shuffle-list (string-to-list str)))))

      (defun my-super-flx-ido-match (query items)
        (cl-labels ((mix-lists (lists)
                               ;; '((a b) (c d) (e f)) -> '(a c e b d f)
                               (when (setq lists (delq nil lists))
                                 (nconc (mapcar 'car lists)
                                        (mix-lists (mapcar 'cdr lists))))))
          (mix-lists
           (mapcar (lambda (str) (flx-ido-match str items))
                   (my-make-super-flex-keywords query)))))

      (defun my-ido-disable-prefix ()
        (when (and (ido-active) ido-enable-prefix)
          (ido-tidy)
          (setq ido-enable-prefix nil)
          (ido-tidy)
          (ido-exhibit)))

      (defun my-valid-regex-p (regexp)
        (ignore-errors
          (string-match regexp "")
          t))

      (defadvice ido-set-matches-1 (after flx-ido-set-matches-1 activate)
        (when (my-valid-regex-p ido-text)
          (unless ad-return-value
            (when ido-enable-prefix (my-ido-disable-prefix))
            (unless ad-return-value
              ;; if not found, try flex matching
              (catch :too-big
                (setq ad-return-value (flx-ido-match ido-text (ad-get-arg 0)))
                ;; if not found, try super-flex matching
                (unless ad-return-value
                  (setq ad-return-value
                        (my-super-flx-ido-match ido-text (ad-get-arg 0)))))))
          (let ((rx (concat "^" ido-text))
                prefixed prefixed-sans-dir not-prefixed)
            (dolist (str ad-return-value)
              (cond ((string-match rx str)
                     (push str prefixed))
                    ((and (string-match "\\(?:.+/\\)?\\([^/]*\\)" str)
                          (string-match rx (match-string 1 str)))
                     (push str prefixed-sans-dir))
                    (t
                     (push str not-prefixed))))
            (setq ad-return-value (nconc (nreverse prefixed)
                                         (nreverse prefixed-sans-dir)
                                         (nreverse not-prefixed))))))

      ;; enable prefix initially, and disable after 1sec of idle-time
      (add-hook 'ido-setup-hook (setq ido-enable-prefix t))
      (run-with-idle-timer 1 t 'my-ido-disable-prefix)
      )

    ;; + | DWIM commands

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

    ;; + | keymap

    ;; reference | http://github.com/milkypostman/dotemacs/init.el
    (setup-hook 'ido-minibuffer-setup-hook
      (setup-keybinds ido-completion-map
        "C-n" 'ido-prev-work-directory
        "C-p" 'ido-next-work-directory
        "TAB" 'my-ido-spc-or-next
        "<S-tab>" 'ido-prev-match
        "<backtab>" 'ido-prev-match
        "SPC" 'my-ido-spc-or-next
        "RET" 'my-ido-exit-or-select
        "C-SPC" 'ido-select-text
        "C-<return>" 'ido-select-text))

    ;; + | (sentinel)
    )

;;   + jumping with anything [anything]
;;     + prepare highlight-changes-mode

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

;;     + anything-jump
;;     + | (prelude)

(setup-lazy '(my-anything-jump) "anything"

  ;;   + | force anything split window

  ;; reference | http://emacs.g.hatena.ne.jp/k1LoW/20090713/1247496970
  (setq anything-display-function
        (lambda (buf)
          (select-window (split-window (selected-window)
                                       (/ (* (window-height) 3) 5)))
          (switch-to-buffer buf)))

  ;;   + | execute parsistent-action on move

  ;; reference | http://shakenbu.org/yanagi/d/?date=20120213
  (setup-hook 'anything-move-selection-after-hook
    (if (member (cdr (assq 'name (anything-get-current-source)))
                '("Imenu" "Visible Bookmarks" "Changes" "Flycheck"))
        (anything-execute-persistent-action)))

  ;;   + | anything source for hilit-chg

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

  ;;   + | anything source for flycheck

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

  ;;   + | anything source for imenu

  ;; reference | http://www.emacswiki.org/emacs/AnythingSources
  (setup "imenu"
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
                   (cl-mapcan
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
                    (fst (car pair))
                    (snd (cadr pair)))
               (imenu
                (if snd
                    (assoc snd (cdr (assoc fst anything-c-imenu-alist)))
                  entry))))))))

  ;;   + | anything-jump command

  (defun my-anything-jump ()
    "My 'anything'."
    (interactive)
    (anything
     :sources (list (and (boundp 'anything-source-highlight-changes-mode)
                         anything-source-highlight-changes-mode)
                    (and (boundp 'my-anything-source-flycheck)
                         my-anything-source-flycheck)
                    anything-c-source-imenu)
     :input nil ;; (thing-at-point 'symbol)
     :prompt "symbol : "))

  ;;   + | (sentinel)
  )

;;   + isearch (isearch)

(setup-after "isearch"
  ;; isearch in japanese (for windows)
  ;; reference | http://d.hatena.ne.jp/myhobby20xx/20110228/1298865536
  (when (string= window-system "w32")
    (defun my-isearch-update ()
      (interactive)
      (isearch-update))
    (setup-keybinds isearch-mode-map
      [compend] 'my-isearch-update
      [kanji]   'isearch-toggle-input-method))
  ;; do not use lax-whitespace (for Emacs>=24)
  (setq isearch-lax-whitespace nil))

;;   + yasnippet settings [yasnippet]

(setup-lazy '(yas-expand) "yasnippet"
  :prepare (setup-in-idle "yasnippet")

  (setq yas-triggers-in-field t
        yas-fallback-behavior '(apply my-dabbrev-expand . nil)
        yas-snippet-dirs      (list my-snippets-directory)
        yas-verbosity         3)

  ;; let fallback-behavior return-nil while expanding snippets
  (setup-hook 'yas-before-expand-snippet-hook
    (setq yas-fallback-behavior 'return-nil))
  (setup-hook 'yas-after-exit-snippet-hook
    (setq yas-fallback-behavior '(apply my-dabbrev-expand . nil)))

  (yas-reload-all)
  (yas-global-mode 1)

  ;; use ido interface to select alternatives
  (setup-expecting "ido"
    (custom-set-variables '(yas-prompt-functions '(yas-ido-prompt))))

  (setup-keybinds yas-minor-mode-map '("TAB" "<tab>") nil)

  ;; keybinds in snippets
  ;; reference | https://github.com/magnars/.emacs.d/
  (defun my-yas/goto-end-of-active-field ()
    (interactive)
    (let* ((snippet (car (yas--snippets-at-point)))
           (pos (yas--field-end (yas--snippet-active-field snippet))))
      (if (= (point) pos)
          (move-end-of-line 1)
        (goto-char pos))))
  (defun my-yas/goto-start-of-active-field ()
    (interactive)
    (let* ((snippet (car (yas--snippets-at-point)))
           (pos (yas--field-start (yas--snippet-active-field snippet))))
      (if (= (point) pos)
          (move-beginning-of-line 1)
        (goto-char pos))))
  (setup-keybinds yas-keymap
    '("TAB" "<tab>")                           nil
    '("<oem-pa1>" "<muhenkan>" "<nonconvert>") 'yas-next-field-or-maybe-expand
    "C-j"                                      'my-yas/goto-start-of-active-field
    "C-e"                                      'my-yas/goto-end-of-active-field)
  )

;;   + multiple-cursors [multiple-cursors]

(setup-lazy
  '(my-mc/mark-next-dwim
    my-mc/mark-all-dwim-or-skip-this) "multiple-cursors"

    ;; force loading mc/list-file
    (setq mc/list-file my-mc-list-file)
    (ignore-errors (load mc/list-file))

    ;; keep mark active on "require" and "load"
    ;; reference | https://github.com/milkypostman/dotemacs/init.el
    (defadvice require (around my-require-advice activate)
      (save-excursion (let (deactivate-mark) ad-do-it)))
    (defadvice load (around my-require-advice activate)
      (save-excursion (let (deactivate-mark) ad-do-it)))

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
                   ((and (save-excursion  ; whole word is selected
                           (goto-char (region-beginning)) (looking-at "\\<"))
                         (save-excursion
                           (goto-char (region-end)) (looking-back "\\>")))
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
         (back-list (and back-list (- back-list (point))))
         (back-str (save-excursion
                     (and (search-backward-regexp "\\s\"" nil t)
                          (point))))
         (back-str (and back-str (- back-str (point))))
         (for-list (save-excursion
                     (and (search-forward-regexp "\\s(" nil t)
                          (point))))
         (for-list (and for-list (- for-list (point))))
         (for-str (save-excursion
                    (and (search-forward-regexp "\\s\"" nil t)
                         (point))))
         (for-str (and for-str (- for-str (point))))
         (diff (car (sort (list back-list back-str for-list for-str)
                          (lambda (a b)
                            (or (not (numberp b))
                                (and (numberp a) (< (abs a) (abs b)))))))))
    (if (numberp diff) (forward-char diff) (error "Cannot go down."))))

(defun my-copy-sexp ()
  (interactive)
  (save-excursion
    (my-mark-sexp)
    (kill-ring-save (region-beginning) (region-end))))

(defun my-transpose-sexps ()
  (interactive)
  (transpose-sexps -1))

(defun my-comment-sexp ()
  (interactive)
  (my-mark-sexp)
  (comment-or-uncomment-region (region-beginning) (region-end)))

(defun my-up-list ()
  "handy version of up-list for interactive use"
  (interactive)
  (let* ((in-string (nth 3 (syntax-ppss (point))))
         (back-pos (save-excursion
                     (if in-string
                         (search-backward-regexp "\\s\"" nil t)
                       (ignore-errors (backward-up-list) (point)))))
         (for-pos (save-excursion
                    (if in-string
                        (search-forward-regexp "\\s\"" nil t)
                      (ignore-errors (up-list) (point))))))
    (when (not (or back-pos for-pos))
      (signal 'scan-error "cannot go up"))
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

(defun my-eval-sexp-dwim ()
  "eval-last-sexp or eval-region"
  (interactive)
  (if (not (use-region-p))
      (call-interactively 'eval-last-sexp) ; must be interactive
    (eval-region (region-beginning) (region-end))
    (deactivate-mark)))

(defun my-eval-and-replace-sexp ()
  "Evaluate the sexp at point and replace it with its value"
  (interactive)
  (let ((value (eval-last-sexp nil)))
    (kill-sexp -1)
    (insert (format "%S" value))))

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
               (backward-down-list)
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
    :prepare (progn
               (setup-after "cc-mode"
                 (dolist (keymap (list c-mode-map c++-mode-map
                                       objc-mode-map java-mode-map))
                   (setup-keybinds keymap
                     "M-)" 'cedit-or-paredit-slurp
                     "M-{" 'cedit-wrap-brace
                     "M-*" 'cedit-or-paredit-barf
                     "M-U" 'cedit-or-paredit-splice-killing-backward
                     "M-R" 'cedit-or-paredit-raise)))
               (setup-after "promela-mode"
                 (setup-keybinds promela-mode-map
                   "M-)" 'cedit-or-paredit-slurp
                   "M-{" 'cedit-wrap-brace
                   "M-*" 'cedit-or-paredit-barf
                   "M-U" 'cedit-or-paredit-splice-killing-backward
                   "M-R" 'cedit-or-paredit-raise))))

;;   + | line-wise operations

;; reference | http://emacsredux.com/blog/2013/04/08/kill-line-backward/
(defun my-kill-line-backward ()
  "Kill line backward."
  (interactive)
  (kill-line 0)
  (indent-according-to-mode))

(defun my-next-opened-line ()
  "open line below, and put the cursor there"
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun my-open-line-and-indent ()
  "open line with indentation"
  (interactive)
  (open-line 1)
  (save-excursion
    (forward-line)
    (indent-according-to-mode)))

;; reference | https://github.com/milkypostman/dotemacs/init.el
(defun my-new-line-between ()
  (interactive)
  (newline)
  (save-excursion
    (newline)
    (indent-for-tab-command))
  (indent-for-tab-command))

(defun my-transpose-lines ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (end-of-line))

;;   + | word-wise operations

(defun my-capitalize-word-dwim ()
  (interactive)
  (if (looking-at "[a-z]")
      (capitalize-word 1)
    (capitalize-word -1)))

(defvar my-upcase-previous-word-count nil)
(defun my-upcase-previous-word ()
  (interactive)
  (if (not (eq last-command this-command))
      (upcase-word (setq my-upcase-previous-word-count -1))
    (cl-decf my-upcase-previous-word-count)
    (upcase-word my-upcase-previous-word-count)))

(defvar my-downcase-previous-word-count nil)
(defun my-downcase-previous-word ()
  (interactive)
  (if (not (eq last-command this-command))
      (downcase-word (setq my-downcase-previous-word-count -1))
    (cl-decf my-downcase-previous-word-count)
    (downcase-word my-downcase-previous-word-count)))

(defun my-transpose-words ()
  (interactive)
  (transpose-words -1))

;;   + Misc: core
;;   + | buffers / windows

;; move buffers among windows smartly
(defun my-transpose-window-buffers ()
  "Rotate buffers among windows."
  (interactive)
  (let ((m (make-sparse-keymap)))
    (dolist (cmd '(other-window previous-multiframe-window next-multiframe-window))
      (let ((keys (where-is-internal cmd))
            (def `(lambda ()
                    (interactive)
                    (let* ((w1 (selected-window))
                           (w2 (progn (call-interactively ',cmd) (selected-window)))
                           (tmp (window-buffer w1)))
                      (set-window-buffer w1 (window-buffer w2))
                      (set-window-buffer w2 tmp)))))
        (dolist (key keys) (define-key m key def))))
    (set-temporary-overlay-map m t)))

(defun my-kill-this-buffer (&optional force)
  (interactive "P")
  (if (not force)
      (kill-this-buffer)
    (let ((kill-buffer-query-functions nil)
          (kill-buffer-hook nil))
      (kill-this-buffer))))

;; resize windows
;; reference | http://d.hatena.ne.jp/mooz/touch/20100119/p1
(defun my-resize-window ()
  (interactive)
  (cl-case (read-char "Press npbf or hjkl to resize.")
    ((?f ? ?l)
     (enlarge-window-horizontally
      (if (zerop (car (window-edges))) 1 -1))
     (my-resize-window))
    ((?b ? ?h)
     (shrink-window-horizontally
      (if (zerop (car (window-edges))) 1 -1))
     (my-resize-window))
    ((?n ? ?j)
     (enlarge-window
      (if (zerop (cadr (window-edges))) 1 -1))
     (my-resize-window))
    ((?p ? ?k)
     (shrink-window
      (if (zerop (cadr (window-edges))) 1 -1))
     (my-resize-window))))

(defun my-retop ()
  "Make cursor displayed on top of the window."
  (interactive)
  (recenter 0))

(defun my-recenter ()
  "Make cursor displayed on 3/8 of the window"
  (interactive)
  (recenter (* (/ (window-height) 8) 3)))

(defun my-toggle-narrowing ()
  "narrow-to-region or widen."
  (interactive)
  (cond ((use-region-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((buffer-narrowed-p)
         (widen))
        (t
         (error "there is no active region"))))

;; split window smartly
;; reference | http://d.hatena.ne.jp/yascentur/20110621/1308585547
;;           | http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part16
(defvar my-split-window-saved-configuration nil)
(defun my-split-window ()
  "split windows smartly"
  (interactive)
  (cl-labels ((split
               (n &optional vertically)
               (cond
                ((< n 2) nil)
                ((= (mod n 2) 0)        ; (n/2) | (n/2)
                 (let ((wnd (if vertically
                                (split-window-vertically)
                              (split-window-horizontally))))
                   (with-selected-window wnd
                     (split (/ n 2) vertically))
                   (split (/ n 2) vertically)))
                (t                      ; (n-1) | 1
                 (if vertically
                     (split-window-vertically
                      (- (window-height) (/ (window-height) n)))
                   (split-window-horizontally
                    (- (window-total-width) (/ (window-total-width) n))))
                 (split (1- n) vertically)))))
    (cl-case last-command
      ;; |---------------| -> |-------|-------|
      ((my-split-window-horizontally-0)
       (split 2)
       (setq this-command 'my-split-window-horizontally-1))
      ;; |-------|-------| -> |----|-----|----|
      ((my-split-window-horizontally-1)
       (set-window-configuration my-split-window-saved-configuration)
       (split 3)
       (setq this-command 'my-split-window-horizontally-2))
      ;; |----|-----|----| -> |---|---|-------|
      ((my-split-window-horizontally-2)
       (set-window-configuration my-split-window-saved-configuration)
       (split 2)
       (split 2)
       (setq this-command 'my-split-window-horizontally-3))
      ;; |---|---|-------| -> |---|---|---|---|
      ((my-split-window-horizontally-3)
       (set-window-configuration my-split-window-saved-configuration)
       (split 4)
       (setq this-command 'my-split-window-horizontally-4))
      ;; |---|---|---|---| -> |---------------|
      ((my-split-window-horizontally-4)
       (set-window-configuration my-split-window-saved-configuration)
       (setq this-command 'my-split-window-horizontally-0))
      ;; vertically
      ((my-split-window-vertically-0)
       (split 2 t)
       (setq this-command 'my-split-window-vertically-1))
      ((my-split-window-vertically-1)
       (set-window-configuration my-split-window-saved-configuration)
       (split 3 t)
       (setq this-command 'my-split-window-vertically-2))
      ((my-split-window-vertically-2)
       (set-window-configuration my-split-window-saved-configuration)
       (setq this-command 'my-split-window-vertically-0))
      (t
       (setq my-split-window-saved-configuration
             (current-window-configuration))
       (cond ((> (window-total-width)
                 (* 2.65 (window-height)))
              (split 2)
              (setq this-command 'my-split-window-horizontally-1))
             (t
              (split 2 t)
              (setq this-command 'my-split-window-vertically-1)))))))

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

;;   + | jump around

;; linewise motion

(defun my-next-line (n)
  (interactive "p")
  (call-interactively 'next-line)
  (when (looking-back "^[\s\t]*")
    (let (goal-column) (back-to-indentation))))

(defun my-previous-line (n)
  (interactive "p")
  (call-interactively 'previous-line)
  (when (looking-back "^[\s\t]*")
    (let (goal-column) (back-to-indentation))))

(defun my-smart-bol ()
  "beginning-of-line or back-to-indentation"
  (interactive)
  (let ((command (if (eq last-command 'back-to-indentation)
                     'beginning-of-line
                   'back-to-indentation)))
    (setq this-command command)
    (funcall command)))

;; blank-line-delimited navigation

(defvar my-next-blank-line-skip-faces
  '(font-lock-string-face font-lock-comment-face font-lock-comment-delimiter-face))

(defun my-next-blank-line ()
  "Jump to the next empty line."
  (interactive)
  (when (eobp) (signal 'end-of-buffer "end of buffer"))
  (let ((type (get-text-property (point) 'face)))
    (skip-chars-forward "\s\t\n")
    (condition-case nil
        (while (and (search-forward-regexp "\n[\s\t]*$")
                    (let ((face (get-text-property (point) 'face)))
                      (and (memq face my-next-blank-line-skip-faces)
                           (not (eq face type))))))
      (error (goto-char (point-max))))))

(defun my-previous-blank-line ()
  "Jump to the previous empty line."
  (interactive)
  (when (bobp) (signal 'beginning-of-buffer "beginning of buffer"))
  (let ((type (get-text-property (point) 'face)))
    (skip-chars-backward "\s\t\n")
    (condition-case nil
        (while (and (search-backward-regexp "^[\s\t]*\n")
                    (let ((face (get-text-property (point) 'face)))
                      (and (memq face my-next-blank-line-skip-faces)
                           (not (eq face type))))))
      (error (goto-char (point-min))))))

;; jump-back!

(setup-include "ring")

(defvar-local my-jump-back!--marker-ring nil)

(defun my-jump-back!--ring-update ()
  (let ((marker (point-marker)))
    (unless my-jump-back!--marker-ring
      (setq my-jump-back!--marker-ring (make-ring 30)))
    (ring-insert my-jump-back!--marker-ring marker)))

(run-with-idle-timer 1 t 'my-jump-back!--ring-update)

(setup-lazy '(my-jump-back!) "edmacro"
  (defun my-jump-back! ()
    (interactive)
    (let (marker)
      (cond ((or (null my-jump-back!--marker-ring)
                 (ring-empty-p my-jump-back!--marker-ring))
             (error "No further undo information"))
            ((= (point-marker)
                (prog1 (setq marker (ring-ref my-jump-back!--marker-ring 0))
                  (ring-remove my-jump-back!--marker-ring 0)))
             (my-jump-back!))
            (t
             (goto-char marker)
             (let ((repeat-key (vector last-input-event)))
               (message "(Type %s to repeat)" (edmacro-format-keys repeat-key))
               (set-temporary-overlay-map
                (let ((km (make-sparse-keymap)))
                  (define-key km repeat-key 'my-jump-back!)
                  km) t)))))))

;;   + | edit

;; drag region with cursor keys
;; reference | http://www.pitecan.com/tmp/move-region.el
(defun my-move-region (function)
  "Drag region with FUNCTION."
  (if (use-region-p)
      (let (m)
        (kill-region (mark) (point))
        (call-interactively function)
        (setq m (point))
        (yank)
        (set-mark m)
        (setq deactivate-mark nil))
    (call-interactively function)))
(defun my-move-region-up ()
  "Drag region upward."
  (interactive)
  (my-move-region 'my-previous-line))
(defun my-move-region-down ()
  "Drag region downward."
  (interactive)
  (my-move-region 'my-next-line))
(defun my-move-region-left ()
  "Drag region backward."
  (interactive)
  (my-move-region 'backward-char))
(defun my-move-region-right ()
  "Drag region forward."
  (interactive)
  (my-move-region 'forward-char))

(defvar my-transpose-chars-list
  '(("->" ."<-") ("<-" ."->") ("<=" .">")
    (">=" ."<") ( "<" .">=") ( ">" ."<=")))
(defun my-transpose-chars ()
  (interactive)
  (let ((lst my-transpose-chars-list))
    (while (and lst (not (looking-back (caar lst))))
      (setq lst (cdr lst)))
    (if lst
        (replace-match (cdar lst))
      (save-excursion (transpose-chars -1)))))

(defun my-smart-comma ()
  "Insert comma maybe followed by a space."
  (interactive)
  (cond ((not (eq last-command 'my-smart-comma))
         (insert ", "))
        ((= (char-before) ?\s)
         (delete-char -1))
        (t
         (insert " "))))

;; shrink indentation on "kill-line"
;; reference | http://www.emacswiki.org/emacs/AutoIndentation
(defadvice kill-line (around shrink-indent activate)
  (if (or (not (eolp)) (bolp))
      ad-do-it
    ad-do-it
    (save-excursion (just-one-space))))

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
    (cl-labels ((maybe-insert-space ()
                                    ;; (foo
                                    ;;  ^ we do not need space here
                                    (and (looking-at "[^])}]")
                                         (looking-back "[^[({]")
                                         (insert " "))))
      (cond ((= bol eol)              ; blank-line(s) : shrink => join
             (if (< (- (line-number-at-pos eos)
                       (line-number-at-pos bos)) 3)
                 ;; just one blank line
                 (progn (delete-region bos eos)
                        (maybe-insert-space))
               ;; two or more blank lines
               (delete-region bos (save-excursion
                                    (goto-char eos)
                                    (1- (point-at-bol))))
               (newline-and-indent)))
            ((<= (point) bol)         ; bol: fix indentation => join
             (when (= (save-excursion
                        (back-to-indentation)
                        (point))
                      (progn
                        (call-interactively indent-line-function)
                        (back-to-indentation)
                        (point)))
               (delete-region bos (point))
               (maybe-insert-space)))
            ((= (point) eol)         ; eol: delete trailing ws => join
             (if (not (= (point) bos))
                 (delete-region (point) bos)
               (delete-region (point) eos)
               (maybe-insert-space)))
            (t                          ; otherwise: just-one-space
             (just-one-space))))))

;;   + | jokes

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

;;   + | others

;; reference | http://github.com/milkypostman/dotemacs/init.el
(defun my-rename-current-buffer-file ()
  "Rename current buffer file."
  (interactive)
  (let ((oldname (buffer-file-name)))
    (if (null oldname)
        (error "Not a file buffer.")
      (let ((newname (read-file-name "New name: " nil oldname)))
        (if (get-file-buffer newname)
            (error "A buffer named %s already exists." newname)
          (rename-file oldname newname 0)
          (rename-buffer newname)
          (set-visited-file-name newname)
          (set-buffer-modified-p nil)
          (message "Successfully renamed to %s." (file-name-nondirectory newname)))))))

;; reference | http://d.hatena.ne.jp/IMAKADO/20090215/1234699972
(defun my-toggle-transparency ()
  "Toggle transparency."
  (interactive)
  (let* ((current-alpha (or (cdr (assoc 'alpha (frame-parameters))) 100))
         (new-alpha (cl-case current-alpha ((100) 91) ((91) 78) ((78) 66) (t 100))))
    (set-frame-parameter nil 'alpha new-alpha)))

;; URL encode / decode region
(defun my-url-decode-region (beg end)
  "Decode region as hexified string."
  (interactive "r")
  (let ((str (buffer-substring beg end)))
    (delete-region beg end)
    (insert (url-unhex-string str))))
(defun my-url-encode-region (beg end)
  "Hexify region."
  (interactive "r")
  (let ((str (buffer-substring beg end)))
    (delete-region beg end)
    (insert (url-hexify-string str))))

;;   + Misc: built-ins
;;   + | buffers / windows

;; turn-off follow-mode on delete-other-windows
(setup-lazy '(follow-delete-other-windows-and-split) "follow"
  (defadvice delete-other-windows (after auto-disable-follow activate)
    (when (and (boundp 'follow-mode) follow-mode)
      (follow-mode -1))))

;;   + | edit

;; expand abbrev smartly
(setup-lazy '(my-dabbrev-expand) "dabbrev"
  (defun my-dabbrev-expand ()
    "Expand dabbrev and insert SPC. when no preceding letters are
provided and we are in emacs-lisp-mode, insert prefix for the
file. If the point is in a incorrect word marked by flyspell, correct the word."
    (interactive)
    (cond ((cl-some (lambda (ov)
                      (eq (overlay-get ov 'face) 'flyspell-incorrect))
                    (overlays-in (1- (point)) (point)))
           (flyspell-correct-word-before-point))
          ((and (not (eq this-command last-command))
                (eq major-mode 'emacs-lisp-mode)
                (looking-back "[[(\s,'`@]")
                buffer-file-name)
           (insert (file-name-base buffer-file-name) "-")
           (dabbrev--reset-global-variables))
          (t
           (when (= (char-before) ?\s)
             (delete-char -1))
           (dabbrev-expand nil)
           (insert " ")))))

;;   + | trace changes

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
        (append my-additional-info-directories Info-directory-list)))

;; Calendar
(setup-after "calendar"
  ;; mark today
  (add-hook 'calendar-today-visible-hook 'calendar-mark-today)
  ;; mark japanese holidays
  (setup "japanese-holidays"
    (setq mark-holidays-in-calendar t
          calendar-holidays (append japanese-holidays local-holidays other-holidays))))

;;   + Misc: plug-ins
;;   + | jump around

;; "f"-like jump command
(setup-lazy '(iy-go-to-char iy-go-to-char-backward) "iy-go-to-char")

(setup-lazy
  '(pager-page-up
    pager-page-down
    pager-row-up
    pager-row-down) "pager")

;; use "phi-search/replace" and "phi-search-mc" instead of "isearch"
(setup-lazy '(phi-replace phi-replace-query) "phi-replace")
(setup-lazy '(phi-search phi-search-backward) "phi-search"
  (setq phi-search-case-sensitive 'guess)
  (setup-expecting "multiple-cursors"
    (setup-lazy
      '(phi-search-mc/mark-next phi-search-mc/mark-all) "phi-search-mc"
      :prepare (setq phi-search-additional-keybinds
                     (append '(((kbd "C-a") . 'phi-search-mc/mark-next)
                               ((kbd "C-M-a") . 'phi-search-mc/mark-all))
                             phi-search-additional-keybinds)))))
(setup-lazy '(phi-search-migemo phi-search-migemo-backward) "phi-search-migemo"
  (setq migemo-command          "cmigemo"
        migemo-options          '("-q" "--emacs")
        migemo-dictionary       my-migemo-dictionary
        migemo-user-dictionary  nil
        migemo-regex-dictionary nil
        migemo-coding-system    'utf-8-unix
        migemo-isearch-enable-p nil))

;;   + | edit

;; autoload expand-region
(setup-lazy '(er/expand-region) "expand-region")

;; autoload anything-show-kill-ring
(setup-lazy '(anything-show-kill-ring) "anything-config"
  :prepare (setup-in-idle "anything-config")
  (setup-after "popwin"
    (push '("*Kill Ring*") popwin:special-display-config)))

;;   + | pop-up windows

;; make and popup scratch-notes for each files
(setup "scratch-palette"
  (setq scratch-palette-directory my-palette-directory)
  (setup-keybinds scratch-palette-minor-mode-map
    "M-w" 'scratch-palette-kill))

;; popup eshell
(setup-lazy '(shell-pop) "shell-pop"
  (setq shell-pop-internal-mode        "eshell"
        shell-pop-internal-mode-buffer "*eshell*"
        shell-pop-internal-mode-func   '(lambda () (eshell))
        shell-pop-window-height        19))

;;   + | trace changes

;; tree-like undo history browser
(!-
 (setup "diff")                ; dependency
 (setup "undo-tree"
   (global-undo-tree-mode 1)
   (setup-keybinds undo-tree-visualizer-mode-map
     "j" 'undo-tree-visualize-redo
     "k" 'undo-tree-visualize-undo
     "l" 'undo-tree-visualize-switch-branch-right
     "h" 'undo-tree-visualize-switch-branch-left
     "RET" 'undo-tree-visualizer-quit
     "C-g" 'undo-tree-visualizer-abort
     "q" 'undo-tree-visualizer-abort)
   (setup-keybinds undo-tree-map '("M-_") nil)))

;;   + | assistants

;; autoload pcre2el
(setup-lazy '(rxt-explain) "pcre2el"
  :prepare (defun describe-regexp () (interactive) (rxt-explain))
  (setup-after "rainbow-delimiters"
    (setup-hook 'rxt-help-mode-hook
      (rainbow-delimiters-mode -1))))

;; autoload RPN calc
(setup-lazy '(rpn-calc) "rpn-calc")

;;   + | jokes / games

;; ＿人人人人人人人人＿
;; ＞  sudden-death  ＜
;; ￣ＹＹＹＹＹＹＹＹ￣
(setup-lazy '(sudden-death) "sudden-death")

(setup-lazy '(2048-game) "2048-game")

;;   + | others

;; autoload smart-compile
(setup-lazy '(smart-compile) "smart-compile")

;; autoload ipretty
(setup-lazy '(ipretty-last-sexp) "ipretty")

;; use "smex" instead of M-x
(setup-lazy '(smex) "smex"
  (setq smex-save-file my-smex-save-file)
  (smex-initialize))

;; dynamic keyboard-macro
(setup-expecting "dmacro"
  ;; define a temporary function that loads "dmacro"
  (defun dmacro-exec ()
    (interactive)
    (let ((*dmacro-key* (this-single-command-keys)))
      (load "dmacro")
      ;; dmacro-exec is overriden here
      (call-interactively 'dmacro-exec))))

;; download region as an url
(setup-lazy '(download-region-as-url) "download-region"
  (setq download-region-max-downloads 5))

;; autoload some anything commands
(setup-lazy
  '(anything-colors
    anything-register
    anything-manage-advice) "anything-config")

;; start a HTTPd for this directory
(setup-lazy '(my-start-httpd) "simple-httpd"
  (defun my-start-httpd ()
    (interactive)
    (httpd-stop)
    (let* ((root (read-directory-name "Root Directory: " nil nil t))
           (port (read-number "Port: " 8080)))
      (setq httpd-root root
            httpd-port port)
      (httpd-start))))

;; Spritz-like speed reading mode
(setup-lazy '(spray-mode) "spray"
  (setq spray-wpm 400))

(setup-lazy '(ace-link-help ace-link-info ace-link-eww) "ace-link")

(setup-lazy '(mf/mirror-region-in-multifile) "multifiles")

(setup-lazy '(simple-demo-set-up) "simple-demo")

(setup-lazy '(htmlize-buffer htmlize-file) "htmlize")

(setup-lazy '(togetherly-client-start togetherly-server-start) "togetherly")

;; + | Modes
;;   + text modes
;;     + (common)

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

(setup-after "text-mode"
  (setup-hook 'text-mode-hook 'my-auto-kutoten-mode)
  (setup-expecting "electric-spacing"
    (setup-hook 'text-mode-hook 'electric-spacing-mode))
  (setup-expecting "jaword"
    (setup-hook 'text-mode-hook 'jaword-mode))
  (setup-after "mark-hacks"
    (push 'text-mode mark-hacks-auto-indent-inhibit-modes))
  (setup-expecting "phi-search-migemo"
    (setup-keybinds text-mode-map
      [remap phi-search]          'phi-search-migemo
      [remap phi-search-backward] 'phi-search-migemo-backward))
  (setup-keybinds text-mode-map "C-M-i" nil))

;;     + org-mode [htmlize]

(setup-after "org"

  (setup-hook 'org-mode-hook 'iimage-mode)
  (setup-hook 'org-mode-hook 'turn-on-auto-fill)

  (setq org-startup-folded             t
        org-startup-indented           t
        org-startup-with-inline-images t
        org-src-fontify-natively       t
        org-src-tab-acts-natively      t
        org-ditaa-jar-path (when my-ditaa-jar-file
                             (expand-file-name my-ditaa-jar-file)))

  (setup-after "smart-compile"
    (push '(org-mode . (org-export-as-html-and-open nil))
          smart-compile-alist))

  (setup-after "org-exp"

    (setq org-export-with-section-numbers     nil
          org-export-with-toc                 nil
          org-export-mark-todo-in-toc         t
          org-export-email-info               nil
          org-export-author-info              nil
          org-export-creator-info             nil
          org-export-time-stamp-file          nil
          org-export-table-remove-empty-lines nil)

    ;; Remove newlines between Japanese letters before exporting.
    ;; reference | http://qiita.com/kawabata@github/items/1b56ec8284942ff2646b
    (setup-hook 'org-export-preprocess-hook
      (goto-char (point-min))
      (while (search-forward-regexp "^\\([^|#*\n].+\\)\\(.\\)\n *\\(.\\)" nil t)
        (and (> (string-to-char (match-string 2)) #x2000)
             (> (string-to-char (match-string 3)) #x2000)
             (replace-match "\\1\\2\\3"))
        (goto-char (point-at-bol))))

    ;; babel
    (setup-after "ob-exp"
      (setq org-export-babel-evaluate nil))

    (setup-after "org-html"

      (setq org-export-html-link-org-files-as-html nil
            org-export-html-validation-link        nil
            org-export-html-style-include-scripts  nil
            org-export-html-style-include-default  nil
            org-export-html-inline-image-extensions
            '("png" "jpeg" "jpg" "gif" "svg" "bmp")
            org-export-html-mathjax-options
            '((path  "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML")
              (scale "100")
              (align "center")
              (indent "2em")
              (mathml nil)))

      ;; use htmlize in "org-export-as-html"
      (setup-lazy '(htmlize-buffer) "htmlize"
        :prepare (setup-after "org" (setup "htmlize"))
        (setq org-export-html-style-extra
              (format "<style>pre.src { background-color: %s; color: %s; }</style>"
                      (face-background 'default)
                      (face-foreground 'default))))

      ;; electric-spacing workaround
      (setup-after "electric-spacing"
        (defadvice org-export-as-html (around my-electric-spacing-workaround activate)
          (let ((electric-spacing-regexp-pairs nil))
            ad-do-it)))
      )
    )

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

;;     + latex-mode [phi-pretty-latex] [ac-latex]

(setup-expecting "tex-mode"
  (push '("\\.tex$" . latex-mode) auto-mode-alist))

(setup-after "tex-mode"
  (push "Verbatim" tex-verbatim-environments)
  (push "BVerbatim" tex-verbatim-environments)
  (push "lstlisting" tex-verbatim-environments)
  (setup-hook 'latex-mode-hook
    (outline-minor-mode 1)
    (setq-local outline-regexp "\\\\\\(sub\\)*section\\>")
    (setq-local outline-level (lambda () (- (outline-level) 7))))
  (setup-keybinds latex-mode-map
    "C-c C-'" 'latex-close-block
    '("C-j" "C-M-i" "<C-return>") nil)
  (setup-lazy '(magic-latex-buffer) "magic-latex-buffer"
    :prepare (setup-hook 'latex-mode-hook 'magic-latex-buffer)
    (setq magic-latex-enable-inline-image nil))
  (setup-after "auto-complete"
    (setup "auto-complete-latex"
      (setq ac-l-dict-directory my-latex-dictionary-directory)
      (push 'latex-mode ac-modes)
      (setup-hook 'latex-mode-hook 'ac-l-setup))))

;;     + web-mode

(setup-lazy '(web-mode) "web-mode"
  :prepare (progn
             (push '("\\.html?[^/]*$" . web-mode) auto-mode-alist)
             (push '("\\.jsx$" . web-mode) auto-mode-alist))

  (setup-keybinds web-mode-map
    "C-c '" 'web-mode-element-close
    "C-;"   'web-mode-comment-or-uncomment
    "M-;" nil)

  (setq web-mode-script-padding                   nil
        web-mode-style-padding                    nil
        web-mode-markup-indent-offset             2
        web-mode-css-indent-offset                4
        web-mode-code-indent-offset               4
        web-mode-enable-control-block-indentation nil
        web-mode-enable-auto-quoting              nil)

  ;; JSX syntax highlight
  (copy-face 'web-mode-html-attr-name-face 'web-mode-hash-key-face)
  (setq web-mode-javascript-font-lock-keywords
        (nconc
         '(;; labels
           ("case[\s\t]+\\([^:]+[^:\s\t]\\)[\s\t]*:" 1 'web-mode-constant-face)
           ;; hash-keys
           ("\\([A-z0-9_]+\\)[\s\t]*:" 1 'web-mode-hash-key-face)
           ;; method decls / lambda expressions
           ("\\(?:\\(function\\)\\|\\([A-z0-9_]+\\)\\)[\s\t]*\\((\\)[A-z0-9_\s\t,=]*)[\s\t\n]*{"
            (1 'web-mode-keyword-face nil t)
            (2 'web-mode-function-name-face nil t)
            ("\\([A-z0-9_]+\\)\\(?:[\s\t]*=[^,)]*\\)?[,)]"
             (goto-char (match-end 3)) nil (1 'web-mode-variable-name-face)))
           ;; import stmt
           ("\\(import\\)[\s\t]*\\([{A-z0-9_*]\\(?:[A-z0-9_,*\s\t]*[A-z0-9_}]\\)?\\)[\s\t]*\\(from\\)"
            (1 'web-mode-keyword-face)
            (2 'web-mode-variable-name-face)
            (3 'web-mode-keyword-face)))
         web-mode-javascript-font-lock-keywords))

  (setup "sgml-mode"
    (setup-keybinds web-mode-map
      "<f1> s"  'sgml-tag-help))

  (setup-expecting "rainbow-mode"
    (setup-hook 'web-mode-hook 'rainbow-mode))

  (setup-after "auto-complete"
    (setup "auto-complete-config"
      (setq web-mode-ac-sources-alist
            '(("javascript" . (ac-source-my-words-in-web-mode-buffers))
              ("jsx"        . (ac-source-my-words-in-web-mode-buffers))
              ("html"       . (ac-source-my-words-in-web-mode-buffers))
              ("css"        . (;; ac-source-my-css-propname
                               ac-source-css-property
                               ac-source-my-words-in-web-mode-buffers))))
      (push 'web-mode ac-modes)))

  (setup-after "smart-compile"
    (push '(web-mode . (browse-url-of-buffer)) smart-compile-alist))

  (setup-expecting "key-combo"
    ;; does not work ?
    (defun my-sgml-sp-or-smart-lt ()
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
    (setup-hook 'web-mode-hook
      (key-combo-mode 1)
      (key-combo-define-local (kbd "<") '(my-sgml-sp-or-smart-lt "&lt;" "<"))
      (key-combo-define-local (kbd "<!") "<!DOCTYPE `!!'>")
      (key-combo-define-local (kbd ">") '("&gt;" ">"))
      (key-combo-define-local (kbd "&") '("&amp;" "&"))))
  )

;;     + css-like languages

;; common settings
(setup-after "auto-complete"
  (setup "auto-complete-config"
    (setup-hook 'my-css-mode-common-hook
      (setq ac-sources '(;; ac-source-my-css-propname
                         ac-source-css-property
                         ac-source-my-words-in-web-mode-buffers)))
    (setq ac-modes (append my-css-modes ac-modes))))
(setup-expecting "key-combo"
  (setup-hook 'my-css-mode-common-hook
    (key-combo-mode 1)
    (key-combo-define-local (kbd "+") " + ")
    (key-combo-define-local (kbd ">") " > ")
    (key-combo-define-local (kbd "~") " ~ ")
    ;; doesn't work ... (why?)
    ;; (key-combo-define-local (kbd "^=") " ^= ")
    (key-combo-define-local (kbd "$=") " $= ")
    (key-combo-define-local (kbd "*=") " *= ")
    (key-combo-define-local (kbd "=") " = ")))

;; css
(setup-lazy '(css-mode) "css-mode"
  :prepare (push '("\\.css$" . css-mode) auto-mode-alist))

;; scss
(setup-lazy '(scss-mode) "scss-mode"
  :prepare (push '("\\.scss$" . scss-mode) auto-mode-alist))

;;     + gfm-mode [markdown-mode]

(setup-lazy '(gfm-mode) "markdown-mode"
  :prepare (progn
             (push '("\\.md$" . gfm-mode) auto-mode-alist)
             (push '("\\.markdown$" . gfm-mode) auto-mode-alist))
  (setup-keybinds gfm-mode-map
    '("M-n" "M-p" "M-{" "M-}" "C-M-i") nil
    "TAB" 'markdown-cycle))

;;   + prog modes
;;     + generic

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

;;     + lispy
;;       + (common)

;; toggle commands

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

(setup-hook 'my-lispy-mode-common-hook
  (local-set-key (kbd "C-c C-'") 'my-lisp-toggle-quote)
  (local-set-key (kbd "C-c C-8") 'my-lisp-toggle-let)
  (local-set-key (kbd "C-c C-9") 'my-lisp-toggle-bracket))

;; plugins

(setup-expecting "key-combo"
  (defun my-lisp-smart-dot ()
    (interactive)
    (insert (if (looking-back "[0-9]") "." " . ")))
  (setup-hook 'my-lispy-mode-common-hook
    (key-combo-mode 1)
    (key-combo-define-local (kbd ".") '(my-lisp-smart-dot "."))
    (key-combo-define-local (kbd ";") ";; ")))

(setup-expecting "rainbow-delimiters"
  (setup-hook 'my-lispy-mode-common-hook 'rainbow-delimiters-mode))

;;       + lisp-mode

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

;;       + emacs-lisp-mode [outlined-elisp] [cl-lib-hl]

(setup-after "lisp-mode"
  (font-lock-add-keywords
   'emacs-lisp-mode '(("(\\(defvar-local\\)" 1 font-lock-keyword-face)))
  (setup-keybinds emacs-lisp-mode-map '("M-TAB" "C-j") nil)
  (setup-expecting "eldoc"
    (setup-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode))
  (setup-after "smart-compile"
    ;; we may assume that setup.el is already loaded
    (setq smart-compile-alist
          (nconc '(("init\\.el" . (setup-byte-compile-file))
                   (emacs-lisp-mode . (emacs-lisp-byte-compile)))
                 smart-compile-alist)))
  (setup-after "auto-complete"
    (push 'emacs-lisp-mode ac-modes)
    (setup-hook 'emacs-lisp-mode-hook
      ;; ac-source-symbols is very nice but seems buggy
      (setq ac-sources '(ac-source-filename
                         ac-source-words-in-same-mode-buffers
                         ac-source-dictionary
                         ac-source-functions
                         ac-source-variables
                         ac-source-features))))
  (setup-expecting "key-combo"
    (setup-hook 'emacs-lisp-mode-hook
      (key-combo-define-local (kbd "#") '("#" ";;;###autoload"))))
  (setup-expecting "rainbow-mode"
    (setup-hook 'emacs-lisp-mode-hook 'rainbow-mode))
  (setup-include "cl-lib-highlight"
    (setup-hook 'emacs-lisp-mode-hook 'cl-lib-highlight-initialize)
    (setup-hook 'emacs-lisp-mode-hook 'cl-lib-highlight-warn-cl-initialize)))

;;       + gauche-mode [scheme-complete]

(setup-lazy '(gauche-mode) "gauche-mode"
  :prepare (push '("\\.scm$" . gauche-mode) auto-mode-alist)

  ;; hooks seems not working ...
  (defadvice gauche-mode (after gauche-run-hooks activate)
    (run-hooks 'gauche-mode-hook))

  ;; why "|" is whitespace in gauche-mode ?
  (modify-syntax-entry ?\| "_ 23b" gauche-mode-syntax-table)

  ;; use "-i" option to launch gosh process
  (setup-hook 'gauche-mode-hook
    (setq scheme-program-name "gosh -i"))

  ;; use auto-complete and eldoc in gauche-mode buffers
  (setup "scheme-complete"
    (setq scheme-default-implementation              'gauche
          scheme-always-use-default-implementation-p t)
    (setup-hook 'gauche-mode-hook
      (setq-local lisp-indent-function 'scheme-smart-indent-function))
    (setup-after "auto-complete"
      (push 'gauche-mode ac-modes)
      (defvar my-ac-source-scheme-complete
        '((candidates . (all-completions ac-target (apply 'append (scheme-current-env))))))
      (setup-hook 'gauche-mode-hook
        (make-local-variable 'ac-sources)
        (add-to-list 'ac-sources 'my-ac-source-scheme-complete t)))
    (setup-expecting "eldoc"
      (setup-hook 'gauche-mode-hook
        (turn-on-eldoc-mode)
        (setq-local eldoc-documentation-function 'scheme-get-current-symbol-info))))

  (setup-after "rainbow-delimiters"
    (push '(gauche-mode . rainbow-delimiters-escaped-char-predicate-lisp)
          rainbow-delimiters-escaped-char-predicate-list))

  ;; run scheme REPL in another window
  (defun my-run-scheme-other-window ()
    (interactive)
    (with-selected-window (split-window-vertically -10)
      (switch-to-buffer (get-buffer-create "*scheme*"))
      (run-scheme scheme-program-name))
    (when buffer-file-name
      (scheme-load-file buffer-file-name)))

  ;; send an expression DWIM to the REPL
  (defun my-scheme-send-dwim ()
    (interactive)
    (if (use-region-p)
        (scheme-send-region (region-beginning) (region-end))
      (scheme-send-last-sexp)))

  (setup-keybinds gauche-mode-map
    "C-c C-e" 'my-scheme-send-dwim
    "C-c C-m" 'gauche-mode-macroexpand
    "C-c C-s" 'my-run-scheme-other-window
    "C-c C-l" 'scheme-load-file)
  )

;;       + clojure-mode

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

;;       + egison-mode

(setup-lazy '(egison-mode) "egison-mode"
  :prepare (push '("\\.egi$" . egison-mode) auto-mode-alist)
  (setup-after "auto-complete"
    (push 'egison-mode ac-modes))
  (setup-keybinds egison-mode-map "C-j" nil))

;;       + racket-mode

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

;;     + c-like
;;       + (common)
;;         + (prelude)

(setup-after "cc-mode"

  ;;       + settings

  (setup-keybinds c-mode-base-map "/" nil)

  ;;       + coding style

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

  ;;       + key-combo

  (setup-expecting "key-combo"
    (defun my-c-smart-braces ()
      "smart insertion of braces for C-like laguages"
      (interactive)
      (cond ((use-region-p)              ; wrap with {}
             (let* ((beg (region-beginning))
                    (end (region-end))
                    (one-liner (= (line-number-at-pos beg)
                                  (line-number-at-pos end))))
               (deactivate-mark)
               (goto-char beg)
               (insert (if one-liner "{ " "\n{"))
               (goto-char (+ 2 end))
               (insert (if one-liner " }" "\n}"))
               (indent-region beg (point))))
            ((looking-back "\s")         ; insert {`!!'}
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
      (key-combo-mode 1)
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
      ;; (key-combo-define-local (kbd "^=") " ^= ")
      ;; => cannot invoke C-= when enabled (why?)
      ;; others
      (key-combo-define-local (kbd "/*") "/* `!!' */")
      (key-combo-define-local (kbd "{") '(my-c-smart-braces "{ `!!' }"))))

  ;;       + auto-complete

  (setup-after "auto-complete"
    (setup "ac-c-headers"
      (defun my-ac-install-c-sources ()
        (setq ac-sources '(ac-source-c-headers
                           ac-source-words-in-same-mode-buffers
                           ac-source-dictionary
                           ac-source-c-header-symbols)))))

  ;;       + (sentinel)
  )

;;       + C, C++, Objetive-C

(setup-after "cc-mode"

  (dolist (keymap (list c-mode-map c++-mode-map objc-mode-map))
    (setup-keybinds keymap
      "C-c C-g"                            'c-guess
      '("," "C-d" "C-M-a" "C-M-e"
        "M-e" "M-j" "C-M-h" "C-M-j" "DEL") nil))

  (setup-hook 'c-mode-hook
    (c-set-style "phi"))

  (setup-after "auto-complete"
    (push 'c-mode ac-modes)
    (push 'c++-mode ac-modes)
    (push 'objc-mode ac-modes)
    (setup-after "ac-c-headers"
      (setup-hook 'c-mode-hook 'my-ac-install-c-sources)
      (setup-hook 'c++-mode-hook 'my-ac-install-c-sources)))

  (setup-expecting "eldoc"
    (setup "c-eldoc"
      (setq c-eldoc-buffer-regenerate-time 15)
      (setup "find-file"
        (setq c-eldoc-cpp-command "cpp"
              c-eldoc-includes (mapconcat (lambda (s) (format "-I\"%s\"" s))
                                          cc-search-directories " ")))
      (setup-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)
      (setup-hook 'c-mode-hook 'c-turn-on-eldoc-mode)))

  (setup-after "smart-compile"
    (push `(c-mode . ,(concat "gcc -ansi -pedantic -Wall -W"
                              " -Wextra -Wunreachable-code %f"))
          smart-compile-alist))

  (setup-expecting "key-combo"
    (defun my-c-smart-angles ()
      (interactive)
      (if (looking-back "#include *")
          (progn
            (insert "<>")
            (backward-char 1))
        (let ((back (unless (looking-back " ") " "))
              (forward (unless (looking-at " ") " ")))
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
                 (let ((back (unless (looking-back " ") " "))
                       (forward (unless (looking-at " ") " ")))
                   (insert (concat back ,str forward)))))))
    (setup-hook 'c-mode-hook
      (my-install-c-common-smartchr)
      ;; pointers
      (key-combo-define-local (kbd "&") `(,(my-c-smart-pointer "&") " && "))
      (key-combo-define-local (kbd "*") `(,(my-c-smart-pointer "*")))
      (key-combo-define-local (kbd "->") "->")
      ;; include
      (key-combo-define-local (kbd "<") '(my-c-smart-angles " << "))
      ;; triary operation
      (key-combo-define-local (kbd "?") '( " ? `!!' : " "?"))))

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

;;       + Java

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

  (setup-after "auto-complete"
    (push 'java-mode ac-modes))

  (setup-after "smart-compile"
    (push '(java-mode . "javac -Xlint:all -encoding UTF-8 %f")
          smart-compile-alist))

  (setup-expecting "key-combo"
    (setup-hook 'java-mode-hook
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

;;       + PHP

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

;;       + SCAD

;; *NOTE* "scad-mode.el" provides "scad" feature (!!!)
;; So it's not good idea to specify "scad-mode" here.
(setup-lazy '(scad-mode) "scad-preview"
  (setup-keybinds scad-mode-map
    "C-c C-p" 'scad-preview-mode
    "C-c C-r" 'scad-preview-rotate
    "C-c C-c" 'scad-preview-export
    "<f5>"    'scad-preview-refresh))

;;       + Arduino

(setup-lazy '(arduino-mode) "arduino-mode"
  :prepare (progn (push '("\\.ino$" . arduino-mode) auto-mode-alist)
                  (push '("\\.pde$" . arduino-mode) auto-mode-alist))
  ;; if arduino-mk is installed, use it to upload programs
  (when (file-exists-p "/usr/share/arduino/Arduino.mk")
    (defvar my-arduino-port "/dev/ttyACM0")
    (defvar my-arduino-board-type "uno")
    (defun my-arduino-compile-and-upload ()
      (interactive)
      (setenv "BOARD_TAG" my-arduino-board-type)
      (setenv "MONITOR_PORT" my-arduino-port)
      (compile "make --makefile=/usr/share/arduino/Arduino.mk upload"))
    (setup-after "smart-compile"
      (push '(arduino-mode . (my-arduino-compile-and-upload))
            smart-compile-alist))))

;;       + flex/bison

(setup-lazy '(bison-mode) "bison-mode"
  :prepare (progn (push '("\\.ll?$" . bison-mode) auto-mode-alist)
                  (push '("\\.yy?$" . bison-mode) auto-mode-alist)))

;;     + other procedual
;;       + Javascript / Typescript

(setup-after "js"
  (setup-after "auto-complete"
    (push 'js-mode ac-modes)
    (setup-hook 'js-mode-hook
      (setq ac-sources '(ac-source-my-words-in-web-mode-buffers))))
  (setup "jquery-doc"
    (setup-hook 'js-mode-hook 'jquery-doc-setup)
    (setup-after "popwin"
      (push '("^\\*jQuery doc" :regexp t) popwin:special-display-config))
    (setup-keybinds js-mode-map
      "<f1> s" 'jquery-doc)))

(setup-lazy '(typescript-mode) "typescript"
  :prepare (push '("\\.tsx$" . typescript-mode) auto-mode-alist))

;;       + Perl-like

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
  (copy-face 'font-lock-type-face 'cperl-scope-face)
  (copy-face 'default 'cperl-hash-key-face)
  (font-lock-add-keywords
   'cperl-mode '(("\\_<\\(?:local\\|our\\|my\\)\\_>" . 'cperl-scope-face)))
  (font-lock-add-keywords
   'cperl-mode
   '(("[\[ \t{,(]\\(-?[a-zA-Z0-9_:]+\\)[ \t]*=>" 1 'cperl-hash-key-face t)
     ("\\([]}\\\\%@>*&]\\|\\$[a-zA-Z0-9_:]*\\)[ \t]*{[ \t]*\\(-?[a-zA-Z0-9_:]+\\)[ \t]*}"
      (2 'cperl-hash-key-face t)
      ("\\=[ \t]*{[ \t]*\\(-?[a-zA-Z0-9_:]+\\)[ \t]*}" nil nil (1 'cperl-hash-key-face t))))
   t)

  (setup-keybinds cperl-mode-map
    "C-c C-l" 'cperl-lineup
    '("{" "[" "(" "<" "}" "]" ")" "C-j" "DEL" "C-M-q" "C-M-\\" "C-M-|") nil)

  (setup-expecting "key-combo"
    (setup-hook 'cperl-mode-hook
      (key-combo-mode 1)
      ;; arithmetic
      (key-combo-define-local (kbd "+") `(,(my-unary "+") "++"))
      (key-combo-define-local (kbd "-") `(,(my-unary "-") "--"))
      (key-combo-define-local (kbd "*") `(,(my-unary "*") " ** "))
      (key-combo-define-local (kbd "^") " ^ ")
      (key-combo-define-local (kbd "%") `(,(my-unary "%") " % "))
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
      (key-combo-define-local (kbd "^=") " ^= ")
      (key-combo-define-local (kbd "<<=") " <<= ")
      (key-combo-define-local (kbd ">>=") " >>= ")
      (key-combo-define-local (kbd "&&=") " &&= ")
      (key-combo-define-local (kbd "||=") " ||= ")
      (key-combo-define-local (kbd "+=") " += ")
      (key-combo-define-local (kbd "-=") " -= ")
      (key-combo-define-local (kbd "*=") " *= ")
      ;; other
      (key-combo-define-local (kbd "->") "->")
      (key-combo-define-local (kbd "=>") " => ")
      (key-combo-define-local (kbd "qw") "qw/`!!'/")
      (key-combo-define-local (kbd "?") " ? `!!' : ")))
  )

(setup-lazy '(ruby-mode) "ruby-mode"
  :prepare (push '("\\(?:\\.r[bu]\\|Rakefile\\|Gemfile\\)$" . ruby-mode) auto-mode-alist)

  (setq ruby-insert-encoding-magic-comment nil
        ruby-deep-indent-paren-style       nil)

  ;; fix that the poor close-paren indentation
  ;; reference | http://blog.willnet.in/entry/2012/06/16/212313
  (defadvice ruby-indent-line (after my-unindent-closing-paren activate)
    (let ((column (current-column)) indent offset)
      (save-excursion
        (back-to-indentation)
        (let ((state (syntax-ppss)))
          (setq offset (- column (current-column)))
          (when (and (eq (char-after) ?\)) (not (zerop (car state))))
            (goto-char (cadr state))
            (setq indent (current-indentation)))))
      (when indent
        (indent-line-to indent)
        (when (> offset 0) (forward-char offset)))))

  (setup-keybinds ruby-mode-map
    [remap backward-sexp] 'ruby-backward-sexp
    [remap forward-sexp]  'ruby-forward-sexp
    "C-c ["               'ruby-toggle-block
    "C-m"                 'reindent-then-newline-and-indent
    '("M-C-b" "M-C-f" "M-C-p" "M-C-n" "M-C-q" "C-c {") nil)

  (setup "ruby-end"
    (setq ruby-end-insert-newline nil))
  )

;;       + Promela

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

;;     + functional
;;       + Haskell

(setup-lazy '(haskell-mode literate-haskell-mode) "haskell-mode"
  :prepare (progn (push '("\\.hs$" . haskell-mode) auto-mode-alist)
                  (push '("\\.lhs$" . literate-haskell-mode) auto-mode-alist))

  ;; FOR INSTALLATION :
  ;; (let ((generated-autoload-file
  ;;        "../site-lisp/plugins/haskell-mode/haskell-mode-autoloads.el"))
  ;;   (update-directory-autoloads "../site-lisp/plugins/haskell-mode/"))
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

;;       + Scala

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

;;       + Coq (proof-general)

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

;;       + OCaml (tuareg)

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

;;     + declarative
;;       + (common)

(setup-expecting "key-combo"
  (defun my-prolog-smart-pipes ()
    "insert pipe surrounded by spaces"
    (interactive)
    (if (looking-back "\\[")
        (insert "| ")
      (insert (concat (unless (looking-back " ") " ")
                      "|"
                      (unless (looking-at " ") " ")))))
  (defun my-install-prolog-common-smartchr ()
    (key-combo-mode 1)
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

;;       + Prolog


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
      "C-M-c" "C-M-n" "C-M-n") nil)

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

  (setup-after "auto-complete"
    (push 'prolog-mode ac-modes))

  (setup-expecting "key-combo"
    (setup-hook 'prolog-mode-hook
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

;;       + LMNtal

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

;;     + esolangs
;;       + Brainfuck

(setup-lazy '(bfbuilder-mode) "bfbuilder"
  :prepare (push '("\\.bf" . bfbuilder-mode) auto-mode-alist))

;;       + ZOMBIE

(setup-lazy '(zombie-mode) "zombie"
  :prepare (push '("\\.zombie$" . zombie-mode) auto-mode-alist))

;;     + other PLs
;;       + AHK

(setup-lazy '(ahk-mode) "ahk-mode"
  :prepare (progn
             (push '("\\.ahk$" . ahk-mode) auto-mode-alist)
             ;; the default value of ahk-path-exe-installed is invalid
             ;; on non-w32 systems.
             (unless (eq (window-system) 'w32)
               (defvar ahk-path-exe-installed nil)))
  (setup-after "mark-hacks"
    (push 'fundamental-mode mark-hacks-auto-indent-inhibit-modes))
  (setup-after "auto-complete"
    (push 'ahk-mode ac-modes))
  ;; ahk-mode-map must be set by hooks (why?)
  (setup-hook 'ahk-mode-hook
    (setup-keybinds ahk-mode-map '("C-j" "C-h") nil)))

;;       + DOS

(setup-lazy '(dos-mode) "dos"
  :prepare (setq auto-mode-alist
                 (nconc
                  '(("\\.\\(?:[bB][aA][tT]\\|[cC][mM][dD]\\)\\'" . dos-mode)
                    ("\\`[cC][oO][nN][fF][iI][gG]\\." . dos-mode)
                    ("\\`[aA][uU][tT][oO][eE][xX][eE][cC]\\." . dos-mode))
                  auto-mode-alist))
  (setup-after "auto-complete"
    (push 'dos-mode ac-modes)))

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

;;   + orgtbl-mode

(setup-lazy '(orgtbl-mode) "org-table"

  ;; kill whole row with "org-table-cut-region"
  ;; reference | http://dev.ariel-networks.com/Members/matsuyama/tokyo-emacs-02/
  (defadvice org-table-cut-region (around cut-region-or-kill-row activate)
    (if (use-region-p)
        (org-table-kill-row)
      ad-do-it))

  ;; enable overlay while editing formulas
  (defadvice org-table-eval-formula (around my-table-formula-helper activate)
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

  ;; my commands
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

  ;; keybinds
  (setup-hook 'orgtbl-mode-hook
    (setup-keybinds orgtbl-mode-map
      ;; motion
      "C-f"   'forward-char
      "C-M-f" 'org-table-next-field
      "C-b"   'backward-char
      "C-M-b" 'org-table-previous-field
      "C-n"   'next-line
      "C-M-n" 'next-line
      "C-p"   'previous-line
      "C-M-p" 'previous-line
      ;; region
      "C-w"   'org-table-cut-region
      "C-M-w" 'org-table-copy-region
      "C-y"   'org-table-paste-rectangle
      "C-M-y" 'org-table-copy-down
      ;; newline and indent
      "C-i"   'org-table-next-field
      "C-M-i" 'my-orgtbl-hard-next-field
      "C-o"   'my-orgtbl-open-row
      "C-M-o" 'org-table-insert-hline
      "C-m"   'org-table-next-row
      "C-M-m" 'org-table-hline-and-move
      ;; transpose
      "C-t"   'org-table-move-row-up
      "C-M-t" 'org-table-move-column-left
      ;; others
      "C-="   'my-orgtbl-eval-column-formula
      "C-M-=" 'my-orgtbl-eval-field-formula
      "C-/"   'org-table-sort-lines
      "C-2"   'org-table-edit-field
      "M-e"   'my-orgtbl-recalculate))
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

(setup-lazy '(sdic-describe-word) "sdic"
  (setup-expecting "vi"
    (setup-hook 'sdic-mode-hook 'my-kindly-view-mode)))

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
    (setq-local key-chord-mode nil)
    (setq-local input-method-function nil)))

(setup-expecting "stripe-buffer"
  (setup-hook 'my-listy-mode-common-hook 'my-stripe-buffer))

(setup-hook 'my-listy-mode-common-hook
  (local-set-key (kbd "j") 'next-line)
  (local-set-key (kbd "k") 'previous-line))

(setup-after "tabulated-list"
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
    "z"       'dired-do-compress                     ; 'Z'ip
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
                               (looking-at " "))
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
    (let ((file (dired-get-filename)))
      (cond ((eq system-type 'windows-nt)
             (w32-shell-execute "open" file))
            ((eq system-type 'darwin)
             (shell-command (concat "open '" file "'")))
            (t
             (error "unsupported system")))))

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
        (let ((files 0) (lines 0) (comments 0)
              (count-fn
               (lambda (file)
                 (unless (string-match "\\(?:^\\|/\\)\\.\\.?$" file)
                   (if (file-directory-p file)
                       (mapc count-fn (directory-files file t))
                     (with-temp-buffer
                       (insert-file-contents file)
                       (goto-char (point-min))
                       (let ((buffer-file-name file))
                         (ignore-errors (set-auto-mode)))
                       (setq lines (+ (count-lines (point-min) (point-max)) lines)
                             files (1+ files))
                       (while (ignore-errors
                                (let* ((beg (goto-char (comment-search-forward (point-max))))
                                       (beg-okay (looking-back "^[\s\t]*")))
                                  (forward-comment 1)
                                  (when (and beg-okay (looking-at "^[\s\t]*\\|[\s\t]*$"))
                                    (setq comments (+ (count-lines beg (point)) comments))))
                                t))))))))
          (dired-map-over-marks-check
           (lambda ()
             (let ((file (dired-get-filename)))
               (funcall count-fn file)
               nil))
           nil 'count-lines t)
          (message "%d lines (including %d comment lines) in %s files."
                   lines comments files)))
      )
  )

;;     + Buffer-menu

(setup-after "buff-menu"
  (setup-after "popwin"
    (push '("*Buffer List*") popwin:special-display-config))
  (setup-keybinds Buffer-menu-mode-map
    "RET" 'Buffer-menu-select
    "SPC" 'Buffer-menu-delete
    "l"   'Buffer-menu-select
    "o"   'Buffer-menu-other-window
    "v"   'Buffer-menu-view
    "d"   'Buffer-menu-execute
    "f"   'Buffer-menu-toggle-files-only))

;;     + proced

(setup-after "proced"

  (setq proced-tree-flag t)

  (setup-after "popwin"
    (push '("*Proced*") popwin:special-display-config))

  (setup-keybinds proced-mode-map
    "SPC" 'proced-mark
    "DEL" 'proced-unmark-backward
    "u"   'proced-unmark-all
    "t"   'proced-toggle-marks
    "C"   'proced-mark-children
    "P"   'proced-mark-parents
    "/"   'proced-filter-interactive
    ","   'proced-sort-interactive
    "d"   'proced-send-signal
    "r"   'proced-renice
    "j"   'next-line
    "k"   'previous-line))

;;     + list-environment [list-environment]

(setup-lazy '(list-environment) "list-environment"
  (setup-after "popwin"
    (push '("*Process-Environment*") popwin:special-display-config))
  (setup-keybinds list-environment-mode
    "s" 'list-environment-setenv
    "n" 'list-environment-addenv
    "d" 'list-environment-clear))

;;   + others
;;     + fundamental-mode

(setup-after "fundamental-mode"
  (setup-after "mark-hacks"
    (push 'fundamental-mode mark-hacks-auto-indent-inhibit-modes)))

;;     + vi-mode

(setup-after "vi"

  ;; undo-tree integration
  (setup-expecting "undo-tree"
    (setup-keybinds vi-com-map
      "C-r" 'undo-tree-redo
      "u"   'undo-tree-undo))

  ;; vi-like paren-matching
  (setup-after "paren"
    (defadvice show-paren-function (around vi-show-paren activate)
      (if (and (eq major-mode 'vi-mode)
               (looking-back "\\s)"))
          (save-excursion (forward-char) ad-do-it)
        ad-do-it)))

  ;; make cursor "box" while in vi-mode
  (defadvice vi-mode (after make-cursor-box-while-vi activate)
    (setq cursor-type 'box))
  (defadvice vi-goto-insert-state (after make-cursor-box-while-vi activate)
    (setq cursor-type 'bar))

  ;; disable key-chord
  (setup-after "key-chord"
    (defadvice vi-mode (after disable-key-chord activate)
      (setq-local key-chord-mode nil)
      (setq-local input-method-function nil))
    (defadvice vi-goto-insert-state (after disable-key-chord activate)
      (kill-local-variable 'key-chord-mode)
      (kill-local-variable 'input-method-function)))

  ;; keybinds
  (setup-keybinds vi-com-map "v" 'set-mark-command)
  )

;;     + eshell

(setup-after "eshell"

  (setq eshell-directory-name  my-eshell-directory
        eshell-prompt-regexp   (concat "^" (regexp-opt
                                            '("（*>w<）? " "（*'-'）? " "（`;w;）! ")))
        eshell-prompt-function (lambda ()
                                 (concat "\n" (my-shorten-directory (eshell/pwd) 30) "\n"
                                         (cond ((= (user-uid) 0) "（*>w<）? ")
                                               ((= eshell-last-command-status 0) "（*'-'）? ")
                                               (t "（`;w;）! ")))))
  (setup-hook 'eshell-mode-hook
    (setq eshell-last-command-status 0))

  (setup-after "mark-hacks"
    (push 'eshell-mode mark-hacks-auto-indent-inhibit-modes))

  (setup-after "auto-complete"
    (setup-hook 'eshell-mode-hook
      (setq ac-sources '(ac-source-files-in-current-dir
                         ac-source-words-in-same-mode-buffers))))

  ;; aliases
  ;; reference | http://www.emacswiki.org/cgi-bin/wiki?EshellFunctions
  ;;           | http://www.bookshelf.jp/soft/meadow_25.html
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
  (when (string= window-system "w32")
    (defun eshell/open (&optional file)
      "win-start the current line's file."
      (interactive)
      (unless (null file)
        (w32-shell-execute "open" (expand-file-name file)))))

  ;; "eshell-mode-map" does not work (why?)
  (setup-hook 'eshell-mode-hook
    (local-set-key (kbd "C-j") 'eshell-bol))
  )

;;     + howm
;;     + | (prelude)

(setup-lazy '(my-howm-menu-or-remember) "howm"
  :prepare (progn (setup-in-idle "howm")
                  (push '("\\.howm$" . org-mode) auto-mode-alist))

  ;;   + | settings

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

  ;;   + | utilities

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

  ;;   + | dropbox -> howm

  (setup-hook 'howm-menu-hook
    (when my-howm-import-directory
      (let ((imported-flag nil))
        (dolist (file (directory-files my-howm-import-directory))
          (unless (string-match "^[#-]\\|~$" file)
            (let ((abs-path (concat my-howm-import-directory file)))
              (when (file-regular-p abs-path)
                (howm-remember)
                (insert-file-contents abs-path)
                (beginning-of-buffer)
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

  ;;   + | howm -> dropbox

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
        (insert-string (my-howm-menu-reminder))
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

  ;;   + | howm-calendar

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
             '("[" year "-" (format "%02d" (string-to-int month))
               "-" (format "%02d" (string-to-int day)) "]")))
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

  ;;   + | commands

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
  (defun howm-action-lock-interpret-input (str)
    (cond ((string-match "^[-+][0-9]+$" str) ; relative
           (howm-datestr-shift date 0 0 (string-to-number str)))
          ((string-match "^[0-9]+$" str)  ; absolute
           (howm-datestr-expand str date future-p))
          ((string-match "^\\.$" str)     ; today
           (howm-time-to-datestr))
          (t
           (error (format "Invalid input %s." str)))))
  (defun howm-action-lock-date (date &optional new future-p)
    (let* ((prompt (concat "[" (howm-datestr-day-of-week date) "] "
                           "RET(list), [+-]num(shift), yymmdd(set)"
                           ", x~y(from/to), .(today): "))
           (str (howm-read-string prompt nil "+-~0123456789" nil nil)))
      (if (not (string-match
                "^\\([-+]?[0-9]+\\|\\.\\)\\(?:~\\([-+]?[0-9]+\\|\\.\\)\\)?$" str))
          (error (format "Invalid input %s." str))
        (save-excursion
          (let ((d1 (save-match-data
                      (howm-action-lock-interpret-input (match-string 1 str))))
                (d2 (when (match-beginning 2)
                      (howm-action-lock-interpret-input (match-string 2 str)))))
            (while (not (looking-at howm-date-regexp))
              (backward-char))
            (replace-match d1)
            (when d2
              (goto-char (1+ (match-end 0)))
              (insert
               (format "@%d" (- (1+ (time-to-days (howm-datestr-to-time d2)))
                                (time-to-days (howm-datestr-to-time d1)))))))))))

  ;;   + | keybinds

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

  ;;   + | (sentinel)
  )

;; + | Appearance
;;   + mode-line settings
;;   + | faces, colors

(!foreach '(mode-line-bright-face
            mode-line-dark-face
            mode-line-highlight-face
            mode-line-special-mode-face
            mode-line-git-branch-face
            mode-line-warning-face
            mode-line-modified-face
            mode-line-read-only-face
            mode-line-narrowed-face
            mode-line-mc-face
            mode-line-palette-face
            header-line)
  (make-face ,it)
  (set-face-attribute ,it nil :inherit 'mode-line-face))

(defvar my-mode-line-background '("#194854" . "#594854"))

(defvar my-mode-line-battery-indicator-colors
  ;; (mapcar (lambda (c) (apply 'color-rgb-to-hex c))
  ;;         (color-gradient '(1.0 0.2 0.1) '(0.4 0.9 0.2) 11))
  '("#f2411b" "#e5501d" "#d85f1f" "#cb6e22" "#bf7d24" "#b28c26"
    "#a59b28" "#98aa2a" "#8cb82c" "#7fc72e" "#72d630"))

;;   + | change color while recording macros

(defadvice kmacro-start-macro (after my-recording-mode-line activate)
  (set-face-background 'mode-line (cdr my-mode-line-background))
  (add-hook 'post-command-hook 'my-recording-mode-line-end))

(defun my-recording-mode-line-end ()
  (unless defining-kbd-macro
    (set-face-background 'mode-line (car my-mode-line-background))
    (remove-hook 'post-command-hook 'my-recording-mode-line-end)))

;;   + | the mode-line-format

;; battery status
(require 'battery)
(defvar my-battery-status nil "cons of (PERCENTILE . CHARGING)")
(defun my-update-battery-status ()
  (let* ((stat (funcall battery-status-function))
         (percentile (read (cdr (assoc ?p stat))))
         (charging (member (cdr (assoc ?L stat)) '("AC" "on-line")))
         (last-stat my-battery-status))
    (when (numberp percentile)
      (setq my-battery-status (cons percentile charging))
      (unless (equal last-stat my-battery-status)
        (force-mode-line-update)))))
(run-with-timer 0 60 'my-update-battery-status)

;; scratch-palette status
(defvar-local my-palette-available-p nil)
(setup-after "scratch-palette"
  (defun my-update-palette-status ()
    (when (and buffer-file-name
               (file-exists-p (scratch-palette--file-name buffer-file-name)))
      (setq my-palette-available-p t)))
  (defadvice scratch-palette-kill (after my-update-palette-status activate)
    (my-update-palette-status))
  (setup-hook 'find-file-hook 'my-update-palette-status)
  (my-update-palette-status))

;; ramen timer
(defvar my-ramen-start-time nil)
(defvar my-ramen-timer-object nil)
(defun my-ramen ()
  (interactive)
  (cond (my-ramen-start-time
         (setq my-ramen-start-time nil)
         (cancel-timer my-ramen-timer-object))
        (t
         (setq my-ramen-start-time   (and (not my-ramen-start-time) (current-time))
               my-ramen-timer-object (run-with-timer 0 1 'force-mode-line-update)))))

;; coding system
(defun my-eol-type-mnemonic (coding-system)
  (let ((eol-type (coding-system-eol-type coding-system)))
    (if (vectorp eol-type) ?-
      (cl-case eol-type
        ((0) ?u) ((1) ?d) ((2) ?m) (else ?-)))))

(defvar-local my-current-branch-name nil)
(setup-hook 'find-file-hook
  (let* ((project-root
          (and buffer-file-name
               (locate-dominating-file buffer-file-name ".git")))
         (head-path
          (and project-root
               (concat project-root "/.git/HEAD")))
         str)
    (when (and head-path (file-exists-p head-path))
      (setq str
            (with-temp-buffer
              (insert-file-contents head-path)
              (goto-char (point-min))
              (search-forward-regexp "\\(?:[^/]+/\\)?\\([^/\n]+\\)$" nil t)
              (match-string 1)))
      (setq my-current-branch-name (if (> (length str) 3) (substring str 0 3) str)))))

(defun my-generate-mode-line-format ()
  (let ((VBAR
         (! (propertize " : " 'face 'mode-line-dark-face)))
        (linum
         (! (propertize "%5l" 'face 'mode-line-bright-face)))
        (colnum-or-region
         (if (not mark-active)
             (propertize "%3c" 'face 'mode-line-bright-face)
           (let ((rows (count-lines (region-beginning) (region-end))))
             (if (= rows 1)
                 (propertize (format "%3d" (- (region-end) (region-beginning)))
                             'face 'mode-line-warning-face)
               (propertize (format "%3d" rows) 'face 'mode-line-warning-face)))))
        (i-narrowed
         (propertize "n" 'face (if (buffer-narrowed-p)
                                   'mode-line-narrowed-face 'mode-line-bright-face)))
        (i-readonly
         (propertize "%%" 'face (if buffer-read-only
                                    'mode-line-narrowed-face 'mode-line-bright-face)))
        (i-modified
         (propertize "*" 'face (if (buffer-modified-p)
                                   'mode-line-modified-face 'mode-line-bright-face)))
        (i-mc
         (if (and (boundp 'multiple-cursors-mode) multiple-cursors-mode)
             (propertize (format "%02d" (mc/num-cursors)) 'face 'mode-line-mc-face)
           (! (propertize "00" 'face 'mode-line-bright-face))))
        (dirname
         (propertize (let ((dir (if (not buffer-file-name) ""
                                  (file-name-directory buffer-file-name))))
                       (my-shorten-directory dir 20)) 'face 'mode-line-dark-face))
        (filename
         (! (propertize "%b" 'face 'mode-line-highlight-face)))
        (branch
         (and my-current-branch-name
              (propertize (concat "/" my-current-branch-name)
                          'face 'mode-line-git-branch-face)))
        (palette
         (when my-palette-available-p
           (! (propertize " :p" 'face 'mode-line-palette-face))))
        (recur
         (! (propertize " %]" 'face 'mode-line-dark-face)))
        ;; right half must not contain "%" notation otherwise we
        ;; cannot determine the size of right margin
        (mode
         (cond ((and (boundp 'artist-mode) artist-mode)
                (! (propertize "*Artist*" 'face 'mode-line-special-mode-face)))
               ((and (boundp 'orgtbl-mode) orgtbl-mode)
                (! (propertize "*OrgTbl*" 'face 'mode-line-special-mode-face)))
               (t
                (propertize
                 ;; mode-name may be a list in sgml modes
                 (if (listp mode-name) (cadr mode-name) mode-name)
                 'face 'mode-line-bright-face))))
        (process
         (propertize (format-mode-line mode-line-process) 'face 'mode-line-highlight-face))
        (encoding
         (propertize (format "(%c%c)"
                             (coding-system-mnemonic buffer-file-coding-system)
                             (my-eol-type-mnemonic buffer-file-coding-system))
                     'face 'mode-line-dark-face))
        (time
         (if (null my-ramen-start-time)
             (propertize (format-time-string "%d %H:%M") 'face 'mode-line-bright-face)
           (propertize (format-time-string
                        "%M:%S" (time-subtract (current-time) my-ramen-start-time))
                       'face 'mode-line-warning-face)))
        (battery
         (let* ((index (/ (floor (car my-battery-status)) 10))
                (str (nth index '("₀_" "₁▁" "₂▂" "₃▃" "₄▄" "₅▅" "⁶▅" "⁷▆" "⁸▇" "⁹█" "⁰█")))
                (color (nth index my-mode-line-battery-indicator-colors)))
           (if (cdr my-battery-status)
               (propertize str 'face 'mode-line-dark-face)
             (propertize str 'face `(:foreground ,color))))))
    (let* ((lstr
            (concat linum VBAR colnum-or-region VBAR
                    i-narrowed i-readonly i-modified i-mc VBAR
                    dirname filename branch palette recur))
           (rstr
            (concat VBAR mode process " " encoding VBAR time " " battery))
           (lmargin
            (propertize " " 'display '((space :align-to (+ 1 left-fringe)))))
           (rmargin
            (propertize " " 'display `((space :align-to (- right-fringe ,(length rstr)))))))
      (concat lmargin lstr rmargin rstr))))

(setq-default mode-line-format '((:eval (my-generate-mode-line-format))))

;;   + | others

;; force update mode-line every minutes
(run-with-timer 60 60 'force-mode-line-update)

;;   + "kindly-view" minor-mode

;; reference | http://d.hatena.ne.jp/nitro_idiot/20130215/1360931962
(setup-lazy '(my-kindly-view-mode) "vi"
  (defvar my-kindly-view-mode-map
    (let ((kmap (copy-keymap vi-com-map)))
      (setup-keybinds kmap
        '("j" "C-n")   '("pager" pager-row-down vi-next-line)
        '("k" "C-p")   '("pager" pager-row-up previous-line)
        "h"            'backward-char
        "l"            'forward-char)))
  (defvar my-kindly-unsupported-minor-modes
    '(indent-guide-mode phi-autopair-mode)
    "list of minor-modes that must be turned-off temporarily.")
  (defvar my-kindly-unsupported-global-variables
    '(global-hl-line-mode show-paren-mode
                          key-chord-mode input-method-function)
    "list of variables that must be set nil locally.")
  (defvar-local my-kindly-view-mode nil)
  (defun my-kindly-view-mode ()
    (interactive)
    (setq my-kindly-view-mode t
          line-spacing        0.3
          cursor-type         'bar)
    (dolist (mode my-kindly-unsupported-minor-modes)
      (when (and (boundp mode) mode) (funcall mode -1)))
    (dolist (var my-kindly-unsupported-global-variables)
      (set (make-local-variable var) nil))
    (setq-local buffer-face-mode-face '(:family "Times New Roman" :width semi-condensed))
    (buffer-face-mode 1)
    (text-scale-set +2)
    ;; use current major-mode's bindings as the minor-mode bindings
    (setq-local minor-mode-map-alist
                (cons (cons 'my-kindly-view-mode (current-local-map)) minor-mode-map-alist))
    ;; and kindly-view-mode-map as the major-mode bindings
    (use-local-map my-kindly-view-mode-map)))

;;   + "secret-words" minor-mode

(defvar my-secret-words nil)

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

(define-minor-mode my-secret-words-mode
  "Minor mode to hide secret words in the buffer."
  :init-value nil
  :global nil
  :lighter "Secr"
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

(my-global-secret-words-mode 1)

;;   + colorscheme
;;   + | util

(eval-and-compile
  (require 'color)
  (defun my-make-color (basecolor &optional bright sat mixcolor percent)
    "generate a color by brightening BASECOLOR by BRIGHT,
saturating by SAT, and mixing with MIXCOLOR by PERCENT."
    (let ((hsl
           (if mixcolor
               (cl-destructuring-bind (r g b) (color-name-to-rgb basecolor)
                 (cl-destructuring-bind (rr gg bb) (color-name-to-rgb mixcolor)
                   (let* ((x (if percent (/ percent 100.0) 0.5))
                          (y (- 1 x)))
                     (color-rgb-to-hsl (+ (* r y) (* rr x))
                                       (+ (* g y) (* gg x))
                                       (+ (* b y) (* bb x))))))
             (apply 'color-rgb-to-hsl (color-name-to-rgb basecolor)))))
      (when bright
        (when (eq (frame-parameter nil 'background-mode) 'light)
          (setq bright (- bright)))
        (setq hsl (apply 'color-lighten-hsl `(,@hsl ,bright))))
      (when sat
        (setq hsl (apply 'color-saturate-hsl `(,@hsl ,sat))))
      (apply 'color-rgb-to-hex (apply 'color-hsl-to-rgb hsl)))))

;; load "term" and "hl-line" during compile so that we can use
;; "(face-foreground 'term-color-red)"
(eval-when-compile
  (require 'term))

;;   + | colorscheme [solarized-definitions]

(eval-and-compile          ; we want the theme applied also during compile
  (setup-include "solarized-definitions"

    (defmacro create-solarized-based-theme
        (name mode description darkest-base brightest-base
              type-yellow warning-orange error-red visited-magenta
              link-violet identifier-blue string-cyan keyword-green)
      (declare (indent 2))
      `(let ((solarized-colors
              '((base03  ,darkest-base)
                (base02  ,(my-make-color darkest-base nil nil brightest-base 3))
                (base01  ,(my-make-color darkest-base nil nil brightest-base 35))
                (base00  ,(my-make-color darkest-base nil nil brightest-base 40))
                (base0   ,(my-make-color darkest-base nil nil brightest-base 52))
                (base1   ,(my-make-color darkest-base nil nil brightest-base 58))
                (base2   ,(my-make-color darkest-base nil nil brightest-base 97 ;; 94
                                         ))
                (base3   ,brightest-base)
                (yellow  ,type-yellow)
                (orange  ,warning-orange)
                (red     ,error-red)
                (magenta ,visited-magenta)
                (violet  ,link-violet)
                (blue    ,identifier-blue)
                (cyan    ,string-cyan)
                (green   ,keyword-green))))
         (set-frame-parameter nil 'background-mode ',mode)
         (create-solarized-theme ,name ,description (solarized-color-definitions))))

    ;; ;; the solarized-dark theme
    ;; (set-frame-parameter nil 'background-mode 'dark)
    ;; (create-solarized-theme
    ;;  solarized solarized-description (solarized-color-definitions))

    ;; ;; the solarized-light theme
    ;; (set-frame-parameter nil 'background-mode 'light)
    ;; (create-solarized-theme
    ;;  solarized solarized-description (solarized-color-definitions))

    ;; ;; "jellybeans" based theme
    ;; ;; reference | https://github.com/nanotech/jellybeans.vim
    ;; (create-solarized-based-theme solarized-jellybeans dark
    ;;   "solarized-based theme with `jellybeans' inspired color-palette."
    ;;   "#202020" "#ffffff" "#ffb964" "#8fbfdc" "#a04040"
    ;;   "#b05080" "#805090" "#fad08a" "#99ad6a" "#8fbfdc")

    ;; ;; "mesa" based theme
    ;; ;; reference | http://emacsfodder.github.io/blog/mesa-theme/
    ;; (create-solarized-based-theme solarized-mesa light
    ;;   "solarized-based theme with `mesa' inspired color-palette."
    ;;   "#000000" "#faf5ee" "#3388dd" "#ac3d1a" "#dd2222"
    ;;   "#8b008b" "#00b7f0" "#1388a2" "#104e8b" "#00688b")

    ;; ;; "tron" based theme
    ;; ;; reference | https://github.com/ivanmarcin/emacs-tron-theme/
    ;; (create-solarized-based-theme solarized-tron dark
    ;;   "solarized-based theme with `tron' inspired color-palette."
    ;;   "#000000" "#b0c7d4" "#74abbe" "orange" "red"
    ;;   "magenta" "violet" "#ec9346" "#e8b778" "#a4cee5")

    ;; ;; "majapahit" based theme
    ;; ;; reference | https://gitlab.com/franksn/majapahit-theme/
    ;; (create-solarized-based-theme solarized-majapahit dark
    ;;   "solarized-based theme with `majapahit' inspired color-palette."
    ;;   "#2A1F1B" "#e0d9c6" "#768d82" "#d99481" "#bb4e62"
    ;;   "#db6b7e" "#8e6a60" "#adb78d" "#849f98" "#d4576f")

    ;; ;; "planet" based theme
    ;; ;; reference | https://github.com/cmack/emacs-planet-theme/
    ;; (create-solarized-based-theme solarized-planet dark
    ;;   "solarized-based theme with `planet' inspired color-palette."
    ;;   "#192129" "#d2dde8" "#e9b96e" "#ff8683" "#fe5450"
    ;;   "#a6a1ea" "SlateBlue" "#729fcf" "#649d8a" "#c4dde8")

    ;; ;; "kagamine len" inspired theme
    ;; ;; reference | http://vocaloidcolorpalette.tumblr.com/
    ;; ;;           | http://smallwebmemo.blog113.fc2.com/blog-entry-156.html
    ;; (create-solarized-based-theme lenlen light
    ;;   "solarized-based theme with kagamine len inspired color-palette."
    ;;   "#291e03" "#fffdf9" "#db8d2e" "#f77e96" "#f47166"
    ;;   "#b04d99" "#51981b" "#fda700" "#34bd7d" "#59a9d2")

    ;; ;; "reykjavik" based theme
    ;; ;; reference | https://github.com/mswift42/reykjavik-theme/
    ;; (create-solarized-based-theme reykjavik dark
    ;;   "solarized-based theme with `reykjavik' inspired color-palette."
    ;;   "#112328" "#dadada" "#c1d2b1" "#e86310" "#e81050"
    ;;   "#c4cbee" "#a3d6cc" "#f1c1bd" "#e6c2db" "#a3d4e8")

    ;; "monochrome" based theme
    ;; reference | https://github.com/fxn/monochrome-theme.el/
    (create-solarized-based-theme chillized dark
      "solarized-based theme with `monochrome' inspired color-palette."
      "#101010" "#cacaca" "#989898" "#a08560" "#a07070"
      "#c0c0c0" "#c0c0c0" "#c0c0c0" "#708090" "#989898")

    (set-face-attribute 'italic nil :slant 'italic :underline nil)
    ))

;;   + | modeline

(setq my-mode-line-background
      (! (cons (my-make-color (face-background 'mode-line) 8 -15)
               (my-make-color (face-background 'mode-line) 8 -15 "red" 20))))

(set-face-attribute
 'mode-line nil
 :foreground    (! (my-make-color (face-foreground 'default) 6 -1))
 :background    (car my-mode-line-background)
 :inverse-video nil
 :box `(:line-width 1 :color ,(car my-mode-line-background)))
(set-face-attribute
 'mode-line-inactive nil
 :foreground    (! (my-make-color (face-foreground 'default) -16 2))
 :background    (my-make-color (car my-mode-line-background) -6)
 :inverse-video nil
 :box `(:line-width 1 :color ,(my-make-color (car my-mode-line-background) -6)))

(set-face-attribute
 'mode-line-dark-face nil
 :foreground (face-foreground 'mode-line-inactive))
(set-face-attribute
 'mode-line-highlight-face nil
 :foreground (! (face-foreground 'term-color-yellow))
 :weight     'bold)
(set-face-attribute
 'mode-line-warning-face nil
 :foreground (! (face-background 'default))
 :background (! (face-foreground 'term-color-yellow)))
(set-face-attribute
 'mode-line-special-mode-face nil
 :foreground (! (face-foreground 'term-color-cyan))
 :weight     'bold)
(set-face-attribute
 'mode-line-git-branch-face nil
 :foreground (! (face-foreground 'default))
 :weight     'bold)

(set-face-attribute
 'mode-line-modified-face nil
 :foreground (! (face-foreground 'term-color-red))
 :box        (! `(:line-width 1 :color ,(face-foreground 'term-color-red))))
(set-face-attribute
 'mode-line-read-only-face nil
 :foreground (! (face-foreground 'term-color-blue))
 :box        (! `(:line-width 1 :color ,(face-foreground 'term-color-blue))))
(set-face-attribute
 'mode-line-narrowed-face nil
 :foreground (! (face-foreground 'term-color-cyan))
 :box        (! `(:line-width 1 :color ,(face-foreground 'term-color-cyan))))
(set-face-attribute
 'mode-line-mc-face nil
 :foreground (! (my-make-color (face-foreground 'default) 6 -1))
 :box        `(:line-width 1 :color ,(face-foreground 'mode-line)))

(set-face-attribute
 'mode-line-palette-face nil
 :foreground (! (face-foreground 'term-color-cyan))
 :bold       t)

;;   + | font-lock

;; highlight regexp symbols
;; reference | http://pastelwill.jp/wiki/doku.php?id=emacs:init.el
(setup-after "font-lock"
  (set-face-foreground 'font-lock-regexp-grouping-backslash
                       (! (face-foreground 'term-color-red)))
  (set-face-foreground 'font-lock-regexp-grouping-construct
                       (! (face-foreground 'term-color-red))))

;;   + | highlight-parentheses

(setup-after "highlight-parentheses"
  (hl-paren-set 'hl-paren-colors nil)
  (hl-paren-set 'hl-paren-background-colors
                (! (list (my-make-color (face-background 'default) 12 -20)))))

;;   + | highlight-stages

(setup-after "highlight-stages"
  (set-face-background 'highlight-stages-negative-level-face
                       (! (my-make-color (face-background 'default) -4)))
  (set-face-background 'highlight-stages-level-1-face
                       (! (my-make-color (face-background 'default) 4)))
  (set-face-background 'highlight-stages-level-2-face
                       (! (my-make-color (face-background 'default) 8)))
  (set-face-background 'highlight-stages-level-3-face
                       (! (my-make-color (face-background 'default) 12)))
  (set-face-background 'highlight-stages-higher-level-face
                       (! (my-make-color (face-background 'default) 16))))

;;   + | paren

(setup-after "paren"
  (set-face-attribute 'show-paren-match-face nil :underline t :bold t)
  (set-face-attribute 'show-paren-mismatch-face nil :underline t :bold t))

;;   + | whitespace

(setup-after "whitespace"
  (set-face-attribute 'whitespace-space nil
                      :foreground (car my-mode-line-background)
                      :background 'unspecified)
  (set-face-attribute 'whitespace-tab nil
                      :foreground (car my-mode-line-background)
                      :background 'unspecified))

;;   + | stripe-buffer

(setup-after "stripe-buffer"
  (set-face-background 'stripe-highlight
                       (! (my-make-color (face-background 'default) 5 -10)))
  (set-face-attribute 'stripe-hl-line nil
                      :foreground 'unspecified
                      :background 'unspecified
                      :inherit 'region))

;;   + | web-mode

(setup-after "web-mode"
  (set-face-attribute
   'web-mode-function-call-face nil
   :inherit 'unspecified))

;;   + | cperl-mode

(setup-after "cperl-mode"
  (set-face-attribute
   'cperl-hash-face nil
   :weight 'unspecified :slant 'italic :underline t
   :background 'unspecified :foreground (face-foreground 'font-lock-variable-name-face))
  (set-face-attribute
   'cperl-array-face nil
   :background 'unspecified :weight 'unspecified :slant 'italic :underline t
   :foreground (face-foreground 'font-lock-variable-name-face))
  (set-face-attribute
   'cperl-nonoverridable-face nil
   :weight 'unspecified :slant 'unspecified :underline nil
   :foreground (face-foreground 'font-lock-keyword-face))
  (set-face-attribute
   'cperl-hash-key-face nil
   :foreground (! (my-make-color (face-foreground 'default) 30))))

;;   + | lmntal-mode

(setup-after "lmntal-mode"
  (set-face-background 'lmntal-link-name-face
                       (! (my-make-color (face-background 'default) 3.5 -10))))

;;   + | phi-search

(setup-after "phi-search-core"
  (set-face-background 'phi-search-match-face
                       (! (my-make-color (face-background 'mode-line) 15 -15)))
  (set-face-background 'phi-search-selection-face
                       (! (my-make-color (face-background 'mode-line) 8 -15 "red" 40))))

;;   + | indent-guide

(setup-after "indent-guide"
  (set-face-background 'indent-guide-face (! (my-make-color (face-foreground 'default) -30)))
  (setq indent-guide-char " "))

;;   + | flyspell

(setup-after "flyspell"
  (set-face-attribute
   'flyspell-incorrect nil
   :foreground 'unspecified
   :background 'unspecified
   :underline  (! `(:style wave :color ,(face-foreground 'term-color-red)))))

;;   + Misc: built-ins

(setup-after "frame"
  (blink-cursor-mode -1))

(setup-after "font-lock"
  (setq font-lock-support-mode 'jit-lock-mode
        jit-lock-stealth-time 16))

;; highlight matching parens
;; - show-paren-mode cannot be delayed with "!-" (why?)
(setup-include "paren"
  (setq show-paren-delay 0)
  (show-paren-mode 1))

(setup-include "hl-line"
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
 (setup "indent-guide"
   (indent-guide-global-mode)))
;; (!-
;;  (setup "indent-guide2"
;;    (setq indent-guide2-line-char ?|
;;          indent-guide2-line-enable-xpm nil)
;;    (indent-guide2-global-mode)))

(!-
 (setup "highlight-parentheses"
   (define-globalized-minor-mode global-highlight-parentheses-mode
     highlight-parentheses-mode
     (lambda () (highlight-parentheses-mode 1)))
   (defadvice hl-paren-create-overlays (after my-prior-hl-paren-overlays activate)
     (dolist (ov hl-paren-overlays)
       (overlay-put ov 'priority 2)))
   (global-highlight-parentheses-mode 1)))

(!-
 (setup "highlight-stages"
   (setq highlight-stages-highlight-real-quote t
         highlight-stages-highlight-priority   2)
   (highlight-stages-global-mode 1)))

(setup-lazy '(rainbow-delimiters-mode) "rainbow-delimiters")

(setup-lazy '(rainbow-mode) "rainbow-mode")

(setup-lazy '(my-stripe-buffer) "stripe-buffer"
  (defun my-stripe-buffer ()
    (stripe-buffer-mode 1)
    (setq-local face-remapping-alist (cons '(hl-line . stripe-hl-line) face-remapping-alist))))

;; make GUI modern
(setup-include "sublimity"
  (sublimity-mode 1)
  (setup-include "sublimity-scroll"
    (setq sublimity-scroll-weight       4
          sublimity-scroll-drift-length 3))
  (setup-include "sublimity-attractive"
    (setup-hook 'after-init-hook
      (setq sublimity-attractive-centering-width 100)
      (sublimity-attractive-hide-bars)
      (sublimity-attractive-hide-fringes))))

;; + | Keybinds
;;   + translations

;; by default ...
;; - C-m is RET
;; - C-i is TAB
;; - C-[ is ESC
(keyboard-translate ?\C-h ?\C-?)

;;   + mouse buttons

;; <mouse-1>, <wheel-up>, <wheel-down> are not disabled
(setup-keybinds nil
  '("<down-mouse-1>" "<drag-mouse-1>"
    "<double-mouse-1>" "<triple-mouse-1>"
    "<mouse-2>" "<down-mouse-2>" "<drag-mouse-2>"
    "<double-mouse-2>" "<triple-mouse-2>"
    "C-<mouse-1>" "C-<down-mouse-1>" "C-<drag-mouse-1>"
    "C-<double-drag-mouse-1>" "C-<triple-drag-mouse-1>"
    "C-<mouse-2>" "C-<down-mouse-2>" "C-<drag-mouse-2>"
    "C-<double-drag-mouse-2>" "C-<triple-drag-mouse-2>"
    "M-<mouse-1>" "M-<down-mouse-1>" "M-<drag-mouse-1>"
    "M-<double-drag-mouse-1>" "M-<triple-drag-mouse-1>"
    "M-<mouse-2>" "M-<down-mouse-2>" "M-<drag-mouse-2>"
    "M-<double-drag-mouse-2>" "M-<triple-drag-mouse-2>") 'ignore)

;;   + keyboard
;;   + | fundamental
;;     + |prefix arguments

(setup-keybinds nil
  '("C-1" "C-2" "C-3" "C-4" "C-5"
    "C-6" "C-7" "C-8" "C-9" "C-0"
    "C-M-1" "C-M-2" "C-M-3" "C-M-4" "C-M-5"
    "C-M-6" "C-M-7" "C-M-8" "C-M-9" "C-M-0"
    "M-!" "M-@" "M-#" "M-$" "M-%"
    "M-^" "M-&" "M-*" "M-(" "M-)") 'digit-argument)

;;     + |emacs

(setup-keybinds nil
  "C-g"     'keyboard-quit
  "C-M-g"   'abort-recursive-edit
  "M-e"     'my-eval-sexp-dwim
  "M-E"     'my-eval-and-replace-sexp
  "M-p"     '("ipretty" ipretty-last-sexp eval-print-last-sexp)
  "M-x"     '("smex" smex execute-extended-command)
  "M-m"     '("dmacro" dmacro-exec repeat)
  "C-x C-c" 'save-buffers-kill-emacs
  "C-x C-0" 'kmacro-end-macro
  "C-x C-9" 'kmacro-start-macro
  "C-x RET" 'kmacro-end-and-call-macro
  "M-<f4>"  'save-buffers-kill-emacs)

;;     + |buffer

(setup-keybinds nil
  "M-b"     '("ido" ido-switch-buffer switch-to-buffer)
  "C-x C-w" '("ido" ido-write-file write-file)
  "C-x C-s" 'save-buffer
  "C-x C-x" 'my-rename-current-buffer-file
  "C-x C-b" 'list-buffers
  "C-x C-k" 'my-kill-this-buffer
  "C-x C-e" 'set-buffer-file-coding-system
  "C-x C-r" 'revert-buffer-with-coding-system)

;;     + |frame, window

(setup-keybinds nil
  "M-0" 'next-multiframe-window
  "M-1" 'delete-other-windows
  "M-2" 'my-split-window
  "M-3" 'my-resize-window
  "M-8" 'my-transpose-window-buffers
  "M-9" 'previous-multiframe-window
  "M-o" 'my-toggle-transparency
  "M-k" 'delete-window
  "C-x C--" 'my-window-undo)

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
  "C-e"   'move-end-of-line
  "C-M-j" 'beginning-of-defun
  "C-M-e" 'end-of-defun
  "M-l"   'goto-line
  "M-j"   '("anything" my-anything-jump))

;;     + scroll

(setup-keybinds nil
  "C-u"     '("pager" pager-page-up scroll-down)
  "C-v"     '("pager" pager-page-down scroll-up)
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
  "M-_"   '("undo-tree" undo-tree-undo undo) ; not working ?
  )

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
  "M-y"   '("anything-config" anything-show-kill-ring yank-pop))

;;     + newline, indent, format

(setup-keybinds nil
  "TAB"   'indent-for-tab-command ; C-i
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
  "C-t"          'my-transpose-words
  "C-;"          'comment-dwim
  "C-M-t"        'my-transpose-lines
  "M-h"          'my-shrink-whitespaces
  "M-*"          '("paredit" paredit-forward-barf-sexp)
  "M-("          '("paredit" my-paredit-wrap-round)
  "M-)"          '("paredit" paredit-forward-slurp-sexp)
  "M-{"          '("paredit" my-paredit-wrap-square)
  "M-R"          '("paredit" paredit-raise-sexp)
  "M-U"          '("paredit" paredit-splice-sexp-killing-backward)
  "M-S"          '("paredit" paredit-split-sexp)
  "M-J"          '("paredit" paredit-join-sexps)
  "M-C"          '("paredit" paredit-convolute-sexp)
  "M-\""         '("paredit" paredit-meta-doublequote)
  "M-T"          'my-transpose-sexps
  "M-:"          'my-comment-sexp
  "<oem-pa1>"    '("yasnippet" yas-expand my-dabbrev-expand)
  "<muhenkan>"   '("yasnippet" yas-expand my-dabbrev-expand)
  "<nonconvert>" '("yasnippet" yas-expand my-dabbrev-expand))

;;   + | file, directory, shell
;;     + browsing

(setup-keybinds nil
  "M-d"     'my-dired-default-directory
  "M-f"     '("ido" ido-find-file find-file)
  "M-g"     '("phi-grep" phi-grep-in-directory rgrep)
  "M-r"     'my-ido-recentf-open
  "C-x C-f" '("phi-grep" phi-grep-find-file-flat)
  "C-x C-=" '("ediff" ediff)
  "C-x C-d" '("ido" ido-dired dired)
  "C-x DEL" 'ff-find-other-file ; C-x C-h
  )

;;     + shell command

(setup-keybinds nil
  "M-i" '("shell-pop" shell-pop eshell))

;;   + | help

(define-prefix-command 'help-map)

(setup-keybinds nil
  "<f1>"      'help-map
  "<f1> <f1>" 'info
  "<f1> b"    'describe-bindings
  "<f1> c"    'describe-char
  "<f1> k"    'describe-key
  "<f1> m"    'describe-mode
  "<f1> f"    'describe-function
  "<f1> v"    'describe-variable
  "<f1> a"    'describe-face
  "<f1> x"    'describe-syntax
  "<f1> s"    'info-lookup-symbol
  "<f1> r"    '("pcre2el" describe-regexp)
  "<f1> w"    '("sdic" sdic-describe-word))

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
  "<escape>"  'vi-mode
  "M-v"       'vi-mode
  "M-t"       'orgtbl-mode
  "M-a"       'artist-mode
  "M-n"       'my-toggle-narrowing
  "M-,"       '("howm" my-howm-menu-or-remember)
  "M-c"       '("smart-compile" smart-compile compile)
  "C-x C-i"   '("ispell" ispell-region)
  "C-x C-a"   '("multifiles" mf/mirror-region-in-multifile)
  "C-x C-l"   'my-add-change-log-entry
  "C-x C-t"   'toggle-truncate-lines
  "C-x C-p"   'proced
  "C-x C-v"   'list-environment
  "C-x C-,"   '("download-region" download-region-as-url))

;;   + keychord

(setup-after "key-chord"
  (key-chord-define-global "fj" 'my-transpose-chars)
  (key-chord-define-global "hh" 'my-capitalize-word-dwim)
  (key-chord-define-global "jj" 'my-upcase-previous-word)
  (key-chord-define-global "kk" 'my-downcase-previous-word)
  (setup-expecting "yasnippet"
    (key-chord-define-global "fd" 'yas-expand)
    (key-chord-define-global "jk" 'yas-expand))
  (setup-after "yasnippet"
    (key-chord-define yas-keymap "fd" 'yas-next-field-or-maybe-expand)
    (key-chord-define yas-keymap "jk" 'yas-next-field-or-maybe-expand))
  (setup-expecting "iy-go-to-char"
    (key-chord-define-global "sf" 'iy-go-to-char-backward)
    (key-chord-define-global "jl" 'iy-go-to-char)))
