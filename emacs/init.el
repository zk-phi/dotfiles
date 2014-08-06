;; init.el (for Emacs 24.3) | 2014 zk_phi

(require 'setup)
(setup-initialize)

;; + Cheat Sheet :
;; + | global
;;   + (format)

;; Format
;; |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
;;    |     |     |     |     |     |     |     |     |     |     |     |     |
;;       |     |     |     |     |     |     |     |     |     |     |     |
;;          |     |     |     |     |     |     |     |     |     |     |

;;   + Ctrl-

;; C-_
;; |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  | Undo|Zoom+|     |     |
;;    | Quot| Cut | End |Rplce|TrsWd| Yank| PgUp| Tab | Open| U p |  *  |     |
;;       |MCNxt|Serch|Delte|Right| Quit| B S | Home|CutLn|Centr|Comnt|     |
;;          |     |  *  |  *  | PgDn| Left| Down|Retrn|MrkPg|     |     |

;; C-M-_
;; |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  | Redo|Zoom-|     |     |
;;    |     | Copy|EdDef|RplAl|TrsLn|YankS|BgBuf| Fill|NlBet|BPgph|  *  |     |
;;       |MCAll|SrchB|KilWd|FWord|Abort|BKlWd|BgDef|KlPgh|Cntr0|  -  |     |
;;          |     |  -  |  -  |EdBuf|BWord|NPgph|NNLin|MrkAl|     |     |

;;   + Meta-

;; M-_
;; |AlWnd|SpWnd|Blnce|Follw|     |     |     |SwWnd|PvWnd|NxWnd|LstCg|     |     |     |
;;    |Scrtc|Palet| Eval|Recnt|Table|YankP|UndoT|Shell|Opcty|EvalP|     |     |
;;       |Artst| All |Dired| File| Grep|Shrnk| Jump|KlWnd| Goto|     |     |
;;          |     |Comnd|Cmpil| Vim |Buffr|Narrw|DMcro| Howm|     |     |

;; M-Shift-
;; |     |     |     |     |     |     |     | Barf|Wrap(|Slurp| Undo|     |     |     |
;;    |     |CpSex|EvalR|Raise|TrsSx| Yank|RaisB|IdntX| Open|UpSex|     |     |
;;       |     |SpltS|KlSex|FwSex| Quit|KlSex|JoinS|KillX|Centr|CmntX|Wrap"|
;;          |     |     |     | Mark|BwSex|DnSex|Retrn|MkSex|     |     |

;;   + C-x -

;; C-x C-_
;; |     |     |     |     |     |     |     |     |BgMcr|EdMcr|     | Diff|     |     |
;;    |     |Write|Encod|Revrt|Trnct|     |Untab|Spell|     |RdOly|     |     |
;;       |     | Save|     |     |     |FHead|     |KilBf|CgLog|     |     |
;;          |     |     |Close|     |Bffrs|     |ExMcr|  DL |     |     |

;;   + specials

;; key-chord
;;
;; - fj : transpose-chars
;; - hh : capitalize word
;; - kk : upcase word
;; - jj : downcase word
;;
;; - df : iy-go-to-char-backward
;; - jk : iy-go-to-char
;; - jl : ace-jump-mode

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

;; + Code :
;; + | Constants
;;   + system

;; Inherit some constant definitions from site-start.el, so that we
;; can write system-specific settings not in this file but in it.
;; Note that we need some of these values also in compilation.
(eval-and-compile
  (dolist (var '((my-home-system-p
                  . "Whether Emacs is running on my home system.")
                 (my-additional-include-directories
                  . "List of directories counted as additional include dir.")
                 (my-additional-info-directories
                  . "List of directories coutned as additional info dir.")
                 (my-howm-import-directory
                  . "Directory wich Howm should import notes from.")
                 (my-howm-export-file
                  . "File which Howm should export schedules to.")
                 (my-howm-export-ics
                  . "iCal which Howm should export schedules to.")
                 (my-clojure-jar-file
                  . "Path to clojure.jar executable.")
                 (my-sdic-eiwa-dictionary
                  . "Path to English->Japanese sdic dictionary.")
                 (my-sdic-waei-dictionary
                  . "Path to Japanese->English sdic dictionary.")))
    (eval `(defconst ,(car var) (when (boundp ',(car var)) ,(car var)) ,(cdr var)))))

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

;;   + path to data files

;; Directory

(defconst my-dat-directory "~/.emacs.d/dat/"
  "Directory to save datas in.")

;; make sure that my-dat-directory exists
(eval-when-compile
  (unless (file-exists-p my-dat-directory)
    (make-directory my-dat-directory)))

;; Common History Datas

(defconst my-ac-history-file (! (concat my-dat-directory "ac-comphist"))
  "File to save auto-complete history.")

(defconst my-smex-save-file (! (concat my-dat-directory "smex"))
  "File to save smex history.")

(defconst my-mc-list-file (! (concat my-dat-directory "mc-list"))
  "File to save the list of multiple-cursors compatible commands.")

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

(defconst my-eshell-directory
  (! (concat my-dat-directory "eshell_" system-name "/"))
  "Directory to save eshell histories.")

(defconst my-undohist-directory
  (! (concat my-dat-directory "undohist_" system-name "/"))
  "Directory to save undo histories.")

(defconst my-kill-ring-file
  (! (concat my-dat-directory "killring_" system-name))
  "File to save kill-ring.")

(defconst my-ido-save-file
  (! (concat my-dat-directory "ido_" system-name))
  "File to save ido history.")

(defconst my-recentf-file
  (! (concat my-dat-directory "recentf_" system-name))
  "File to save recentf history.")

(defconst my-save-place-file
  (! (concat my-dat-directory "save-place_" system-name))
  "File to save save-place datas.")

(defconst my-scratch-file
  (! (concat my-dat-directory "scratch_" system-name))
  "File to save scratch.")

(defconst my-backup-directory
  (! (concat my-dat-directory "backups_" system-name "/"))
  "Directory to save backup files.")

;; + | Utilities

(defvar my-lispy-modes
  '(lisp-mode emacs-lisp-mode scheme-mode
              lisp-interaction-mode gauche-mode
              clojure-mode racket-mode))

(defun my-shorten-directory (dir len)
  (if (null dir) ""
    (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
          (output ""))
      (when (and path (equal "" (car path)))
        (setq path (cdr path)))
      (while (and path (< (length output) (- len 4)))
        (setq output (concat (car path) "/" output)
              path (cdr path)))
      (when path
        (setq output (concat ".../" output)))
      output)))

;; + | System
;;   + *scratch* utilities
;;   + | make *scratch* persistent

;; reference | http://www.bookshelf.jp/soft/meadow_29.html#SEC392

(defun my-clean-scratch ()
  (with-current-buffer "*scratch*"
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (message "*scratch* is cleaned up.")))

;; clean scratch instead of killing it
(setup-hook 'kill-buffer-query-functions
  (or (not (string= "*scratch*" (buffer-name)))
      (progn (my-clean-scratch) nil)))

;; make a new scratch buffer on save
(setup-hook 'after-save-hook
  (unless (get-buffer "*scratch*")
    (generate-new-buffer "*scratch*")
    (message "new *scratch* is created.")
    (my-clean-scratch)))

;;   + | save *scratch* across sessions

(setup-hook 'kill-emacs-hook
  (with-current-buffer "*scratch*"
    (write-region 1 (1+ (buffer-size)) my-scratch-file)))

(setup-hook 'after-init-hook
  (with-current-buffer "*scratch*"
    (when (file-exists-p my-scratch-file)
      (insert-file-contents my-scratch-file))))

;;   + hooks for save/open

;; make a parent directory on save if it does not exist
(setup-hook 'before-save-hook
  (when buffer-file-name
    (let ((dir (file-name-directory buffer-file-name)))
      (when (and (not (file-exists-p dir))
                 (y-or-n-p (format "Directory does not exist. Create it? ")))
        (make-directory dir t)))))

;; query delete empty files instead of saving it
;; reference | http://www.bookshelf.jp/soft/meadow_24.html#SEC265
(setup-hook 'after-save-hook
  (when (and (buffer-file-name (current-buffer))
             (= 0 (buffer-size)))
    (when (y-or-n-p "Delete file and kill buffer ? ")
      (delete-file (buffer-file-name (current-buffer)))
      (kill-buffer (current-buffer)))))

;; delete-trailing-whitespace on save
(setup-hook 'before-save-hook
  (when (not (string= (buffer-string)
                      (progn (delete-trailing-whitespace)
                             (buffer-string))))
    (message "trailing whitespace deleted")
    (sit-for 0.4)))

;; query switch to root
(setup-hook 'find-file-hook
  (when (and (eq 0 (nth 2 (file-attributes buffer-file-name)))
             (not (file-writable-p buffer-file-name))
             (y-or-n-p "Switch to root ? "))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;;   + save kill-ring

(setup-hook 'kill-emacs-hook
  (with-temp-buffer
    (insert
     (concat "(setq kill-ring '" (prin1-to-string kill-ring) ")"))
    (write-region 1 (1+ (buffer-size)) my-kill-ring-file)))

(setup-hook 'after-init-hook
  (when (file-exists-p my-kill-ring-file)
    (load my-kill-ring-file)))

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

;;   + Misc: core
;;   + | system

(defalias 'yes-or-no-p 'y-or-n-p)

(setq frame-title-format                    "%b - Emacs++"
      completion-ignore-case                t
      read-file-name-completion-ignore-case t
      gc-cons-threshold                     20000000
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
      ;; simple.el
      eval-expression-print-length          nil
      eval-expression-print-level           10
      shift-select-mode                     nil
      save-interprogram-paste-before-kill   t
      yank-excluded-properties              t
      ;; files.el
      magic-mode-alist                      nil)

(setq-default indent-tabs-mode      nil
              tab-width             4
              truncate-lines        t
              line-move-visual      t
              cursor-type           'bar
              indicate-empty-lines  t
              ;; files.el
              require-final-newline t)

;; use utf-8 as the default coding system
(prefer-coding-system 'utf-8)

;; on Windows, use Shift-JIS for file names
;; reference | http://sakito.jp/emacs/emacsshell.html
(!when (string= window-system "w32")
  (setq locale-coding-system    'sjis
        file-name-coding-system 'sjis))

;; un-disable some disabled commands
(dolist (command '(narrow-to-region
                   dired-find-alternate-file
                   upcase-region downcase-region))
  (put command 'disabled nil))

;; handle non-ascii parens
(dolist (pair '((?\( . ?\)) (?\[ . ?\]) (?\{ . ?\})
                (?（ . ?）) (?｛ . ?｝) (?「 . ?」) (?［ . ?］)
                (?【 . ?】) (?〈 . ?〉) (?《 . ?》) (?『 . ?』)))
  (modify-syntax-entry (car pair)
                       (concat "(" (char-to-string (cdr pair))))
  (modify-syntax-entry (cdr pair)
                       (concat ")" (char-to-string (car pair)))))

;; dont let the cursor go into minibuffer prompt
;; reference | http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
(setq minibuffer-prompt-properties
      '(read-only t point-entered minibuffer-avoid-prompt
                  face minibuffer-prompt))

;; make keyboard-quit quiet
;; reference | https://github.com/maginemu/dotfiles/blob/master/emacs.d/init.el
(setq ring-bell-function
      (lambda ()
        (unless (memq this-command '(minibuffer-keyboard-quit keyboard-quit))
          (ding))))

;; font settings
;; reference | http://macemacsjp.sourceforge.jp/matsuan/FontSettingJp.html
(!when my-home-system-p
  (set-face-attribute 'default nil :family "Source Code Pro" :height 90)
  ;; (set-fontset-font t nil (font-spec :family "Source Code Pro"))
  (set-fontset-font t 'unicode (font-spec :family "VL ゴシック"))
  (push '("VL ゴシック.*" . 1.2) face-font-rescale-alist))

;; settings for the byte-compiler
(eval-when-compile
  (eval-after-load "bytecomp"
    '(setq byte-compile-warnings '(not make-local))))

;;   + | backup, autosave

;; backup directory
(setq backup-directory-alist
      `(("\\.*$" . ,(expand-file-name my-backup-directory))))

;; version control
;; reference | http://aikotobaha.blogspot.jp/2010/07/emacs.html
(setq version-control        t
      kept-new-versions      20
      kept-old-versions      2
      delete-old-versions    t
      vc-make-backup-files   t)

;; use autosave
(setq auto-save-default      t
      delete-auto-save-files t)

;; delete old back-ups
;; reference | https://github.com/Silex/emacs-config/
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
(run-with-idle-timer 30 nil 'my-delete-old-backups)

;;   + Misc: built-ins
;;   + | buffers / windows

;; uniquify buffer name
(setup-include "uniquify"
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets
        uniquify-ignore-buffers-re "*[^*]+*"))

(setup-include "saveplace"
  (setq save-place-file my-save-place-file)
  (setq-default save-place t)
  ;; open invisible automatically
  (defadvice save-place-find-file-hook (after save-place-open-invisible activate)
    (mapc (lambda (ov)
            (let ((ioit (overlay-get ov 'isearch-open-invisible-temporary)))
              (cond (ioit (funcall ioit ov hidep))
                    ((overlay-get ov 'isearch-open-invisible)
                     (overlay-put ov 'invisible nil)))))
          (overlays-at (point)))))

;;   + | compilation

;; setting for compilation result buffer
(setup-after "compile"
  (setq compilation-scroll-output t)
  (setup-keybinds compilation-shell-minor-mode-map
    '("C-M-p" "C-M-n" "C-M-p" "C-M-p") nil))

;;   + | files

;; use elisp implementation of "ls"
(setup-include "ls-lisp"
  (setq ls-lisp-use-insert-directory-program  nil
        ls-lisp-dirs-first                    t))

;; add include directories
(setup-after "find-file"
  (setq cc-search-directories
        (append my-additional-include-directories cc-search-directories)))

;;   + | edit

;; delete selection on insert like modern applications
(setup-include "delsel"
  (delete-selection-mode 1))

;; count camelCase word as two or more words
(setup-include "subword")
(setup-after "subword"
  (define-globalized-minor-mode subword-global-mode
    subword-mode
    (lambda () (subword-mode 1)))
  (subword-global-mode 1))

;; track undo history across sessions
(setup-include "undohist"
  ;; fix for Windows
  (defadvice make-undohist-file-name (around my-undohist-fix activate)
    (flet ((convert-standard-filename (file) file))
      ad-do-it))
  (setq undohist-directory my-undohist-directory)
  (undohist-initialize))

;;   + | assistants

(setup-lazy '(turn-on-eldoc-mode) "eldoc"
  (setq eldoc-idle-delay                0.1
        eldoc-echo-area-use-multiline-p nil))

;;   + Misc: plug-ins
;;   + | buffers / windows

;; maximize frame on setup
(setup-include "maxframe"
  (!when (string= window-system "x")
    ;; send X messages
    (defadvice maximize-frame (after x-maximize-frame activate)
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                             '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                             '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))))
  (add-hook 'window-setup-hook 'maximize-frame))

;; *FIXME* setup-include seems buggy for popwin ...
(setup "popwin"
  (setq popwin:special-display-config
        '(("ChangeLog")
          ("*howm-remember*")
          ("*Buffer List*")
          ("*Kill Ring*")
          ("*Help*")
          ("*info*")
          ("*Warnings*")
          ("*Shell Command Output*")
          ("*All*")
          ;; if *Compile-Log* is selected immediately, it fails!!
          ("*Compile-Log*" :noselect t) ; ???
          ("*compilation*" ;; :noselect t
           ) ; ???
          ("*Completions*" :noselect t)
          ("*Backtrace*" :noselect t)))
  (popwin-mode 1))

(setup-include "smooth-scrolling"
  (setq smooth-scroll-margin 3))

;;   + | mark / region

;; load phi-rectangle
(setup-include "rect")                  ; dependency
(setup-include "phi-rectangle")

;; load mark-hacks
(setup-include "mark-hacks"
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
    (mark-hacks-register-copy-command 'phi-rectangle-kill-ring-save)))

;;   + | files

;; an Elisp implementation of "rgrep"
(setup-lazy '(traverse-deep-rfind) "traverselisp"
  (setup-keybinds traverse-mode-map
    "C-p" 'traverse-go-backward
    "C-n" 'traverse-go-forward
    "C-g" 'traverse-quit))

;;   + | edit

(setup-include "phi-autopair"
  (nconc phi-autopair-lispy-modes my-lispy-modes)
  (phi-autopair-global-mode 1))

(setup-lazy '(electric-spacing-mode) "electric-spacing"
  (setq electric-spacing-regexp-pairs
        '(("\\cA\\|\\cC\\|\\ck\\|\\cK\\|\\cH" . "[\\\\{[(<$0-9A-Za-z]")
          ("[]\\\\})>$0-9A-Za-z]" . "\\cA\\|\\cC\\|\\ck\\|\\cK\\|\\cH"))))

;; *FIXME* setup-include seems buggy for auto-complete ...
(setup "popup")
(setup "auto-complete"
  (setq ac-comphist-file  my-ac-history-file
        ac-auto-start     t
        ac-dwim           t
        ac-delay          0
        ac-auto-show-menu 0.8
        ac-disable-faces  nil)
  (setq-default ac-sources '(ac-source-dictionary
                             ac-source-words-in-same-mode-buffers))
  (add-to-list 'ac-dictionary-directories my-dictionary-directory)
  (global-auto-complete-mode)
  (setup-keybinds ac-completing-map "S-<tab>" 'ac-previous))

;;   + | keyboards

(setup-include "key-chord"
  (key-chord-mode 1))

(setup-lazy '(key-combo-mode) "key-combo"
  ;; input-method (and multiple-cursors) is incompatible with key-combo
  (defadvice key-combo-post-command-function (around mc-combo activate)
    (unless (or current-input-method
                (and (boundp 'multiple-cursors-mode) multiple-cursors-mode))
      ad-do-it))
  (defun my-unary (str)
    "a utility function that generates smart inesrtion commands
for unary operators which can also be binary."
    (eval `(lambda ()
             (interactive)
             (if (looking-back "[])a-zA-Z0-9_] *")
                 (let ((back (unless (looking-back " ") " "))
                       (forward (unless (looking-at " ") " ")))
                   (insert (concat back ,str forward)))
               (insert ,str))))))

;;   + | assistants

(setup-lazy '(flycheck-mode) "flycheck"
  (setq flycheck-display-errors-delay 0.1
        flycheck-highlighting-mode    'lines)
  ;; display error messages by new lines
  (setq flycheck-display-errors-function
        (lambda (errors)
          (let ((messages (delq nil (mapcar 'flycheck-error-message errors))))
            (when (and messages (flycheck-may-use-echo-area-p))
              (message (mapconcat 'identity messages " / ")))))))

(setup-after "outline"
  (setup-lazy '(outline-cycle-dwim) "outline-magic"
    :prepare (setup-keybinds outline-minor-mode-map "TAB" 'outline-cycle-dwim)
    (defun outline-cycle-dwim ()
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

;; + | Commands
;;   + english <-> japanese dictionary [sdic]

(setup-after "sdic"

  ;; implement mode-hook
  (defvar sdic-mode-hook nil)
  (defadvice sdic-mode (after my-sdic-run-hooks activate)
    (run-hooks 'sdic-mode-hook))

  ;; use "word-at-point" instead of "sdic-word-at-point"
  (setup "thingatpt"
    (defun sdic-word-at-point ()
      (let* ((str (or (word-at-point) ""))
             (len (length str)))
        (set-text-properties 0 len nil str)
        str)))

  ;; popwin workaround
  (setup-after "popwin"
    (push '("*sdic*") popwin:special-display-config)
    ;; redefine some functions so that popwin can work with
    ;; reference | http://aikotobaha.blogspot.jp/2013/04/popwinel.html
    (defun sdic-display-buffer (arg)
      (let ((p (or arg (point))))
        (and sdic-warning-hidden-entry
             (> p (point-min))
             (message "この前にもエントリがあります。"))
        (goto-char p)
        (display-buffer (get-buffer sdic-buffer-name))
        (set-window-start (get-buffer-window sdic-buffer-name) p)))
    (defun sdic-other-window ()
      (other-window 1))
    (defun sdic-close-window ()
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

;;     + ido interface for recentf

(setup-expecting "recentf"
  (defvar recentf-save-file my-recentf-file))

(setup-after "recentf"
  (recentf-mode 1)
  (setq recentf-max-saved-items 500
        recentf-auto-cleanup    10
        recentf-exclude         '("/[^/]*\\<tmp\\>[^/]*/" "/[^/]*\\<backup\\>[^/]*/"
                                  "~$" "^#[^#]*#$" "/ssh:" "/sudo:" "/GitHub/" "/palette/"
                                  "/undohist/" "\\.elc$" "\\.howm$" "\\.dat$"))
  ;; auto-save recentf-list / delayed cleanup
  ;; reference | http://d.hatena.ne.jp/tomoya/20110217/1297928222
  (run-with-idle-timer 30 t 'recentf-save-list))

(setup-expecting "ido"
  (setup-lazy '(ido-recentf-open) "recentf"
    (defun ido-recentf-open ()
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

      (defun my-ido-disable-prefix ()
        (when (and (ido-active) ido-enable-prefix)
          (ido-tidy)
          (setq ido-enable-prefix nil)
          (ido-tidy)
          (ido-exhibit)))

      (defadvice ido-set-matches-1 (after flx-ido-set-matches-1 activate)
        (if ad-return-value
            nil
          (when ido-enable-prefix (my-ido-disable-prefix))
          (unless ad-return-value
            ;; if not found, try flex matching
            (catch :too-big
              (setq ad-return-value (flx-ido-match ido-text (ad-get-arg 0)))
              ;; if not found, try super-flex matching
              (unless ad-return-value
                (setq ad-return-value
                      (my-super-flx-ido-match ido-text (ad-get-arg 0))))))))

      ;; enable prefix initially, and disable after 1sec of idle-time
      (setup-hook 'ido-setup-hook
        (setq my-ido-enable-prefix t)
        (run-with-idle-timer 1 nil 'my-ido-disable-prefix))
      )

    ;; + | dwim commands

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

    ;; reference | http://github.com/milkypostman/dotemacs/blob/master/init.el
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
  :prepare (add-hook 'find-file-hook 'highlight-changes-mode)

  ;; start with invisible mode
  (setq highlight-changes-visibility-initial-state nil)

  ;; clear highlights after save
  (setup-hook 'after-save-hook
    (when highlight-changes-mode
      (highlight-changes-remove-highlight 1 (1+ (buffer-size)))))

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

  (defun anything-split-window (buf)
    (select-window
     (split-window (selected-window)
                   (/ (* (window-height) 3) 5)))
    (switch-to-buffer buf))

  (setq anything-display-function 'anything-split-window)

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
  ;;           | https://github.com/yasuyk/helm-flycheck
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
                        (flycheck-sort-errors flycheck-current-errors))))
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

;;   + slice programs [all]

(setup-lazy '(my-all-command) "all"

  (defvar my-all-previous-position nil)

  (defun my-all-command ()
    (interactive)
    (setq my-all-previous-position (point))
    (call-interactively 'all))

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

  (setup-keybinds all-mode-map
    "C-n" 'my-all-next-line
    "C-p" 'my-all-previous-line
    "C-g" 'my-all-exit)
  )

;;   + isearch (isearch)

;; do not use lax-whitespace (for Emacs>=24)
(setup-after "isearch"
  (setq isearch-lax-whitespace nil))

;; isearch in japanese (for windows)
;; reference | http://d.hatena.ne.jp/myhobby20xx/20110228/1298865536
(setup-after "isearch"
  (when (string= window-system "w32")
    (defun w32-isearch-update ()
      (interactive)
      (isearch-update))
    (setup-keybinds isearch-mode-map
      [compend] 'w32-isearch-update
      [kanji]   'isearch-toggle-input-method)))

;; isearch with the region
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

;;   + multiple-cursors [multiple-cursors]

(setup-lazy
  '(my-mc/mark-next-dwim
    my-mc/mark-all-dwim-or-skip-this) "multiple-cursors"

    ;; force loading mc/list-file
    (setq mc/list-file my-mc-list-file)
    (ignore-errors (load mc/list-file))

    ;; keep mark active on "require" and "load"
    ;; reference | https://github.com/milkypostman/dotemacs
    (defadvice require (around require-advice activate)
      (save-excursion (let (deactivate-mark) ad-do-it)))
    (defadvice load (around require-advice activate)
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
    (cl-case (cdar (sort `((,back-list . back-list)
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
  (let* ((str-p (and (member (get-text-property (point) 'face)
                             '(font-lock-string-face font-lock-doc-face))
                     (member (get-text-property (1- (point)) 'face)
                             '(font-lock-string-face font-lock-doc-face))))
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

(defun my-eval-sexp-dwim ()
  "eval-last-sexp or eval-region"
  (interactive)
  (if (use-region-p)
      (eval-region (region-beginning) (region-end))
    (call-interactively 'eval-last-sexp))) ; must be interactive

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
    paredit-comment-dwim
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
    :prepare
    (progn
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

;; reference | https://github.com/milkypostman/dotemacs
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

(defun my-upcase-previous-word ()
  (interactive)
  (save-excursion
    (skip-chars-backward "^a-z")
    (upcase-word -1)))

(defun my-downcase-previous-word ()
  (interactive)
  (save-excursion
    (skip-chars-backward "^A-Z")
    (downcase-word -1)))

(defun my-transpose-words ()
  (interactive)
  (transpose-words -1))

;;   + Misc: core
;;   + | buffers / windows

;; reference | https://github.com/milkypostman/dotemacs
(defun my-rotate-windows ()
  "Rotate buffers among windows."
  (interactive)
  (let ((windows (window-list))
        win1 win2 tmp)
    (dotimes (i (1- (length windows)))
      (setq win1 (nth i windows)
            win2 (nth (1+ i) windows))
      (setq tmp (window-buffer win1))
      (set-window-buffer win1 (window-buffer win2))
      (set-window-buffer win2 tmp))))

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
                 (* 2.1 (window-height)))
              (split 2)
              (setq this-command 'my-split-window-horizontally-1))
             (t
              (split 2 t)
              (setq this-command 'my-split-window-vertically-1)))))))

;; window-undo
(setup-lazy '(my-window-undo) "edmacro"
  (defvar my-window-undo-list `((1 . ,(current-window-configuration))))
  (defun my-window-undo-window-configuration-change-hook ()
    (let ((wins (length (window-list))))
      (unless (or (eq this-command 'my-window-undo)
                  (and (boundp 'phi-search--original-position)
                       phi-search--original-position)
                  (and (boundp 'phi-search--target)
                       phi-search--target)
                  (and my-window-undo-list
                       (= (caar my-window-undo-list) wins)))
        (push (cons wins (current-window-configuration)) my-window-undo-list))))
  (add-hook 'window-configuration-change-hook
            'my-window-undo-window-configuration-change-hook)
  (defun my-window-undo ()
    (interactive)
    (let ((repeat-key (vector last-input-event)))
      (set-temporary-overlay-map
       (let ((km (make-sparse-keymap)))
         (define-key km repeat-key 'my-window-undo)
         km))
      (message "(Type %s to repeat)" (edmacro-format-keys repeat-key))
      (pop my-window-undo-list)
      (if (null my-window-undo-list)
          (message "No further undo information")
        (set-window-configuration (cdar my-window-undo-list))))))

;;   + | jump around

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

(defun my-next-blank-line ()
  "Jump to the next empty line."
  (interactive)
  (when (eobp) (error "end of buffer"))
  (skip-chars-forward "\s\t\n")
  (let ((type (car (memq (get-text-property (point) 'face)
                         '(font-lock-doc-face
                           font-lock-string-face
                           font-lock-comment-face)))))
    (condition-case nil
        (while (and (search-forward-regexp "\n[\s\t]*$")
                    (let ((face (car (memq (get-text-property (point) 'face)
                                           '(font-lock-doc-face
                                             font-lock-string-face
                                             font-lock-comment-face)))))
                      (and face (not (eq face type))))))
      (error (goto-char (point-max))))))

(defun my-previous-blank-line ()
  "Jump to the previous empty line."
  (interactive)
  (when (bobp) (error "beginning of buffer"))
  (skip-chars-backward "\s\t\n")
  (let ((type (car (memq (get-text-property (point) 'face)
                         '(font-lock-doc-face
                           font-lock-string-face
                           font-lock-comment-face)))))
    (condition-case nil
        (while (and (search-backward-regexp "^[\s\t]*\n")
                    (let ((face (car (memq (get-text-property (point) 'face)
                                           '(font-lock-doc-face
                                             font-lock-string-face
                                             font-lock-comment-face)))))
                      (and face (not (eq face type))))))
      (error (goto-char (point-min))))))

;; point-undo
(defvar my-point-undo-list nil)
(make-variable-buffer-local 'my-point-undo-list)
(defun my-point-undo-post-command-hook ()
  (let ((lin (line-number-at-pos)))
    (unless (or (eq this-command 'my-point-undo)
                (and my-point-undo-list
                     (< (abs (- lin (caar my-point-undo-list))) 2)))
      (push (cons lin (point)) my-point-undo-list))))
(add-hook 'post-command-hook 'my-point-undo-post-command-hook)
(defun my-point-undo ()
  (interactive)
  (let ((repeat-key (vector last-input-event)))
    (set-temporary-overlay-map
     (let ((km (make-sparse-keymap)))
       (define-key km repeat-key 'my-point-undo)
       km))
    (pop my-point-undo-list)
    (message "(Type %s to repeat)" (edmacro-format-keys repeat-key))
    (if (null my-point-undo-list)
        (message "No further undo information")
      (goto-char (cdar my-point-undo-list)))))

;;   + | edit

;; drag region with cursor keys
;; reference | http://www.pitecan.com/tmp/move-region.el
(dolist (cmd '((my-move-region-up "upward" my-previous-line)
               (my-move-region-down "downward" my-next-line)
               (my-move-region-left "forward" backward-char)
               (my-move-region-right "backward" forward-char)))
  (eval `(defun ,(car cmd) ()
           ,(concat "Drag region " (cadr cmd) ".")
           (interactive)
           (if (and transient-mark-mode mark-active)
               (let (m)
                 (kill-region (mark) (point))
                 (call-interactively ',(cl-caddr cmd))
                 (setq m (point))
                 (yank)
                 (set-mark m)
                 (setq deactivate-mark nil))
             (call-interactively ',(cl-caddr cmd))))))

(defvar my-transpose-chars-list
  '(("->" ."<-") ("<-" ."->") ("<=" .">")
    (">=" ."<") ( "<" .">=") ( ">" ."<=")))
(defun my-transpose-chars ()
  (interactive)
  (let ((lst my-transpose-chars-list))
    (while (and lst
                (not (looking-back (caar lst))))
      (setq lst (cdr lst)))
    (if lst
        (replace-match (cdar lst))
      (transpose-chars -1)
      (forward-char))))

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

;; jokes sǝʞoɾ
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
    (insert-rectangle rect)))

;;   + | others

;; reference | http://d.hatena.ne.jp/IMAKADO/20090215/1234699972
(defun my-toggle-transparency ()
  "Toggle transparency."
  (interactive)
  (let ((current-alpha
         (or (cdr (assoc 'alpha (frame-parameters))) 100)))
    (set-frame-parameter nil 'alpha
                         (if (= current-alpha 100) 66 100))))

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
file."
    (interactive)
    (if (and (not (eq this-command last-command))
             (memq major-mode '(lisp-interaction-mode emacs-lisp-mode))
             (looking-back "[[(\s,'`@]")
             (buffer-file-name))
        (progn
          (insert (file-name-base (buffer-file-name)) "-")
          (dabbrev--reset-global-variables))
      (when (= (char-before) ?\s)
        (delete-char -1))
      (dabbrev-expand nil)
      (insert " "))))

;;   + | trace changes

;; add change-lod entry
(setup-lazy '(my-add-change-log-entry) "add-log"
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
(setup-lazy '(ediff) "ediff")

;;   + | assistants

;; automatically update imenu tags
(setup-after "imenu"
  (setq imenu-auto-rescan t))

;; spellchecker settings
(setup-after "ispell"
  (setq ispell-program-name "aspell"
        ispell-extra-args '("--sug-mode=ultra"))
  (ispell-change-dictionary "english")
  ;; do not spell-check non-ascii characters
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]")))

;; Elisp implementation of "info"
(setup-lazy '(info-lookup-symbol) "info-look"
  (setq info-lookup-other-window-flag nil
        Info-directory-list
        (append my-additional-info-directories Info-directory-list)))

;;   + Misc: plug-ins
;;   + | jump around

;; "hit-a-hint"-like jump command
(setup-lazy '(ace-jump-word-mode) "ace-jump-mode"
  (add-hook 'ace-jump-mode-end-hook 'my-recenter))

;; "f"-like jump command
(setup-lazy '(iy-go-to-char iy-go-to-char-backward) "iy-go-to-char")

;; use "phi-search/replace" and "phi-search-mc" instead of "isearch"
(setup-after "phi-search"
  (setq phi-search-case-sensitive 'guess)
  (setup-expecting "multiple-cursors"
    (setup-lazy
      '(phi-search-mc/mark-next phi-search-mc/mark-all) "phi-search-mc"
      :prepare (setq phi-search-additional-keybinds
                     (append '(((kbd "C-a") . 'phi-search-mc/mark-next)
                               ((kbd "C-M-a") . 'phi-search-mc/mark-all))
                             phi-search-additional-keybinds)))))

;;   + | edit

;; browse kill-ring graphically
(setup-after "browse-kill-ring"
  (setq browse-kill-ring-highlight-current-entry t)
  (setup-keybinds browse-kill-ring-mode-map
    "C-n" 'browse-kill-ring-forward
    "C-p" 'browse-kill-ring-previous
    "C-g" 'browse-kill-ring-quit
    "j" 'browse-kill-ring-forward
    "k" 'browse-kill-ring-previous
    "<escape>" 'browse-kill-ring-quit))

;;   + | pop-out windows

;; make and popup scratch-notes for each files
(setup-after "scratch-palette"
  (setup-keybinds scratch-palette-minor-mode-map
    "M-w" 'scratch-palette-kill))

;; popup eshell
(setup-after "shell-pop"
  (setq shell-pop-internal-mode        "eshell"
        shell-pop-internal-mode-buffer "*eshell*"
        shell-pop-internal-mode-func   '(lambda () (eshell))
        shell-pop-window-height        19))

;;   + | trace changes

;; tree-like undo history browser
(setup-include "diff")                  ; dependency
(setup-include "undo-tree"
  (global-undo-tree-mode 1)
  (setup-keybinds undo-tree-visualizer-mode-map
    "j" 'undo-tree-visualize-redo
    "k" 'undo-tree-visualize-undo
    "l" 'undo-tree-visualize-switch-branch-right
    "h" 'undo-tree-visualize-switch-branch-left
    "RET" 'undo-tree-visualizer-quit
    "C-g" 'undo-tree-visualizer-abort
    "q" 'undo-tree-visualizer-abort)
  (setup-keybinds undo-tree-map '("M-_") nil))

;;   + | assistants

(setup-lazy '(rxt-explain) "pcre2el"
  :prepare (defalias 'pcre2el-describe-regexp 'rxt-explain)
  (setup-hook 'rxt-help-mode-hook
    (add-hook 'post-command-hook 'end-of-line nil t)))

;;   + | jokes

;; ＿人人人人人人人人＿
;; ＞  sudden-death  ＜
;; ￣ＹＹＹＹＹＹＹＹ￣
(setup-lazy '(sudden-death) "sudden-death")

;;   + | others

;; use "smex" instead of M-x
(setup-after "smex"
  (setq smex-save-file my-smex-save-file)
  (smex-initialize))

;; dynamic keyboard-macro
(setup-expecting "dmacro"
  (defun dmacro-exec ()
    (interactive)
    (let ((*dmacro-key* (this-single-command-keys)))
      (load "dmacro")
      ;; dmacro-exec is overriden here
      (call-interactively 'dmacro-exec))))

;; download region as an url
(setup-after "download-region"
  (setq download-region-max-downloads 5))

;; autoload some anything commands
(setup-lazy
  '(anything-colors
    anything-register
    anything-manage-advice) "anything-config")

;; Spritz-like speed reading mode
(setup-lazy '(spray-mode) "spray"
  (setq spray-wpm 400))

;; + | Modes
;;   + basic
;;     + fundamental-mode

(setup-after "fundamental-mode"
  (setup-after "mark-hacks"
    (add-to-list 'mark-hacks-auto-indent-inhibit-modes 'fundamental-mode)))

;;     + text-mode

(setup-after "text-mode"
  (setup-expecting "electric-spacing"
    (add-hook 'text-mode-hook 'electric-spacing-mode))
  (setup-after "mark-hacks"
    (add-to-list 'mark-hacks-auto-indent-inhibit-modes 'text-mode)))

;;   + markup
;;     + org-mode [htmlize]

(setup-after "org"

  (add-hook 'org-mode-hook 'iimage-mode)
  (add-hook 'org-mode-hook 'turn-on-auto-fill)

  (setq org-startup-folded             t
        org-startup-indented           t
        org-startup-with-inline-images t
        org-ditaa-jar-path (when my-ditaa-jar-file
                             (expand-file-name my-ditaa-jar-file)))

  (setup-expecting "electric-spacing"
    (add-hook 'org-mode-hook 'electric-spacing-mode))

  (setup-after "mark-hacks"
    (add-to-list 'mark-hacks-auto-indent-inhibit-modes 'org-mode))

  (setup-after "org-exp"

    (setq org-export-time-stamp-file          nil
          org-export-email-info               nil
          org-export-creator-info             t
          org-export-author-info              nil
          org-export-mark-todo-in-toc         t
          org-export-table-remove-empty-lines nil
          org-export-babel-evaluate           nil)

    ;; Remove newlines between Japanese letters before exporting.
    ;; reference | http://qiita.com/kawabata@github/items/1b56ec8284942ff2646b
    (setup-hook 'org-export-preprocess-hook
      (let ((after-change-functions nil)) ; electric-spacing workaround
        (goto-char (point-min))
        (while (search-forward-regexp "^\\([^|#*\n].+\\)\\(.\\)\n *\\(.\\)" nil t)
          (and (> (string-to-char (match-string 2)) #x2000)
               (> (string-to-char (match-string 3)) #x2000)
               (replace-match "\\1\\2\\3"))
          (goto-char (point-at-bol)))))

    (setup-after "org-html"
      ;; use "worg-classic" stylesheet
      ;; *FIXME* write your own stylesheet
      (setq org-export-html-style-default "<link rel=\"stylesheet\" type=\"text/css\"
 href=\"http://orgmode.org/worg/style/worg-classic.css\">")
      ;; do not fix "*.org" to "*.html"
      (setq org-export-html-link-org-files-as-html nil)
      ;; use htmlize in "org-export-as-html"
      (setup-lazy '(htmlize-buffer) "htmlize"
        :prepare (setup-after "org" (setup "htmlize"))))
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
  (add-to-list 'tex-verbatim-environments "Verbatim")
  (add-to-list 'tex-verbatim-environments "BVerbatim")
  (add-to-list 'tex-verbatim-environments "lstlisting")
  (setup-hook 'latex-mode-hook
    (auto-fill-mode 1)
    (outline-minor-mode 1)
    (setq-local outline-regexp "\\\\\\(sub\\)*section\\>")
    (setq-local outline-level (lambda () (- (outline-level) 7))))
  (add-hook 'latex-mode-hook 'turn-on-auto-fill)
  (setup-keybinds latex-mode-map
    "、" "，"
    "。" "．"
    '("C-j" "C-M-i" "<C-return>") nil)
  (setup-lazy '(magic-latex-buffer) "magic-latex-buffer"
    :prepare (add-hook 'latex-mode-hook 'magic-latex-buffer))
  (setup-expecting "electric-spacing"
    (add-hook 'latex-mode-hook 'electric-spacing-mode))
  (setup-after "mark-hacks"
    (add-to-list 'mark-hacks-auto-indent-inhibit-modes 'latex-mode))
  (setup-after "auto-complete"
    (setup "auto-complete-latex"
      (setq ac-l-dict-directory my-latex-dictionary-directory)
      (add-to-list 'ac-modes 'latex-mode)
      (add-hook 'latex-mode-hook 'ac-l-setup))))

;;     + sgml-mode [zencoding]

(setup-after "sgml-mode"
  (setup-after "smart-compile"
    (add-to-list 'smart-compile-alist
                 '(html-mode . (browse-url-of-buffer))))
  (setup "zencoding"
    (add-hook 'sgml-mode-hook 'zencoding-mode)
    (setq zencoding-indent 2)
    (setup-keybinds zencoding-mode-keymap
      "C-j"          nil
      "<C-return>"   nil
      "<oem-pa1>"    'zencoding-expand-line
      "<muhenkan>"   'zencoding-expand-line
      "<nonconvert>" 'zencoding-expand-line))
  (setup-expecting "key-combo"
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
    (setup-hook 'sgml-mode-hook
      (key-combo-mode 1)
      (key-combo-define-local (kbd "<") '(my-sgml-sp-or-smart-lt "&lt;" "<"))
      (key-combo-define-local (kbd "<!") "<!-- `!!' -->")
      (key-combo-define-local (kbd ">") '("&gt;" ">"))
      (key-combo-define-local (kbd "&") '("&amp;" "&")))))

;;     + css-mode

(setup-after "css-mode"
  (setup-expecting "rainbow-mode"
    (add-hook 'css-mode-hook 'rainbow-mode)))

;;   + generic

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
    bat-generic-mode
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
           '(("\\(?:srm\\|httpd\\|access\\)\\.conf\\'" . apache-conf-generic-mode)
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
             ("/etc/\\(?:modules.conf\\|conf.modules\\)" . etc-modules-conf-generic-mode))
           auto-mode-alist))
    )

;;   + lispy
;;     + (common)

(setup-expecting "key-combo"
  (defun my-lisp-smart-dot ()
    (interactive)
    (insert (if (looking-back "[0-9]") "." " . ")))
  (defun my-install-lisp-common-smartchr ()
    (key-combo-mode 1)
    (key-combo-define-local (kbd ".") '(my-lisp-smart-dot "."))
    (key-combo-define-local (kbd ";") ";; ")))

;;     + lisp-mode

(setup-after "lisp-mode"
  (setup-expecting "rainbow-delimiters"
    (add-hook 'lisp-mode-hook 'rainbow-delimiters-mode))
  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'lisp-mode))
  (setup-expecting "key-combo"
    (add-hook 'lisp-mode-hook 'my-install-lisp-common-smartchr))
  (setup-keybinds lisp-mode-map '("M-TAB" "C-j") nil))

;;     + emacs-lisp-mode [outlined-elisp] [cl-lib-hl]

(setup-after "lisp-mode"
  (font-lock-add-keywords
   'emacs-lisp-mode '(("(\\(defvar-local\\)" 1 font-lock-keyword-face)))
  (setup-hook 'emacs-lisp-mode-hook
    (outline-minor-mode 1)
    (setq-local outline-regexp "^[\s\t]*;;[\s]+\\+[+-]*\s")
    (setq-local outline-level (lambda () (- (outline-level) 4))))
  (setup-keybinds emacs-lisp-mode-map '("M-TAB" "C-j") nil)
  (setup-keybinds lisp-interaction-mode-map '("M-TAB" "C-j") nil)
  (setup-expecting "eldoc"
    (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode))
  (setup-after "smart-compile"
    (add-to-list 'smart-compile-alist
                 '(emacs-lisp-mode . (emacs-lisp-byte-compile))))
  (setup-after "auto-complete"
    (defun my-ac-install-elisp-sources ()
      ;; ac-source-symbols is very nice but seems buggy
      (setq ac-sources '(ac-source-filename
                         ac-source-words-in-same-mode-buffers
                         ac-source-dictionary
                         ac-source-functions
                         ac-source-variables
                         ac-source-features)))
    (add-to-list 'ac-modes 'emacs-lisp-mode)
    (add-to-list 'ac-modes 'lisp-interaction-mode)
    (add-hook 'emacs-lisp-mode-hook 'my-ac-install-elisp-sources))
  (setup-expecting "key-combo"
    (setup-hook 'emacs-lisp-mode-hook
      (my-install-lisp-common-smartchr)
      (key-combo-define-local (kbd "#") '("#" ";;;###autoload"))))
  (setup-expecting "rainbow-delimiters"
    (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))
  (setup-expecting "rainbow-mode"
    (add-hook 'emacs-lisp-mode-hook 'rainbow-mode))
  (setup-include "cl-lib-highlight"
    (add-hook 'emacs-lisp-mode-hook 'cl-lib-highlight-initialize)
    (add-hook 'emacs-lisp-mode-hook 'cl-lib-highlight-warn-cl-initialize)))

;;     + gauche-mode [scheme-complete]

(setup-lazy '(gauche-mode) "gauche-mode"
  :prepare (push '("\\.scm$" . gauche-mode) auto-mode-alist)

  ;; hooks seems not working ...
  (defadvice gauche-mode (after gauche-run-hooks activate)
    (when (eq major-mode 'gauche-mode)
      (run-hooks 'gauche-mode-hook)))

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
      (add-to-list 'ac-modes 'gauche-mode)
      (defvar my-ac-source-scheme-complete
        '((candidates . (all-completions
                         ac-target (apply 'append (scheme-current-env))))))
      (setup-hook 'gauche-mode-hook
        (make-local-variable 'ac-sources)
        (add-to-list 'ac-sources 'my-ac-source-scheme-complete t)))
    (setup-expecting "eldoc"
      (setq-local eldoc-documentation-function
                  'scheme-get-current-symbol-info)
      (add-hook 'gauche-mode-hook 'turn-on-eldoc-mode)))

  (setup-expecting "rainbow-delimiters"
    (add-hook 'gauche-mode-hook 'rainbow-delimiters-mode)
    (add-to-list 'rainbow-delimiters-escaped-char-predicate-list
                 '(gauche-mode . rainbow-delimiters-escaped-char-predicate-lisp)))

  (setup-expecting "key-combo"
    (add-hook 'gauche-mode-hook 'my-install-lisp-common-smartchr))

  ;; run scheme REPL in another window
  (defun my-run-scheme-other-window ()
    (interactive)
    (with-selected-window (split-window-vertically -10)
      (switch-to-buffer (get-buffer-create "*scheme*"))
      (run-scheme scheme-program-name))
    (let ((file (buffer-file-name)))
      (when file (scheme-load-file file))))

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

;;     + clojure-mode

(setup-lazy '(clojure-mode) "clojure-mode"
  :prepare (progn (push '("\\.clj$" . clojure-mode) auto-mode-alist))

  (setq clojure-inf-lisp-command (when my-clojure-jar-file
                                   (concat "java -jar " my-clojure-jar-file)))

  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'clojure-mode))

  (setup-expecting "rainbow-delimiters"
    (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode))

  (defun my-run-clojure-other-window ()
    (interactive)
    (if (not clojure-inf-lisp-command)
        (error "Clojure executable is not specified.")
      (with-selected-window (split-window-vertically -10)
        (run-lisp clojure-inf-lisp-command))
      (let ((file (buffer-file-name)))
        (when file (clojure-load-file file)))))

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

;;     + racket-mode

(setup-lazy '(racket-mode) "racket-mode"
  :prepare (push '("\\.rkt$" . racket-mode) auto-mode-alist)

  ;; implement hooks
  (defvar racket-mode-hook nil)
  (defadvice racket-mode (after my-racket-run-hooks activate)
    (run-hooks 'racket-mode-hook))

  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'racket-mode))

  (setup-expecting "flycheck"
    (add-hook 'racket-mode-hook 'flycheck-mode))

  (setup-after "rainbow-delimiters-mode"
    (add-hook 'racket-mode-hook 'rainbow-delimiters-mode))

  (setup-expecting "key-combo"
    (add-hook 'racket-mode-hook 'my-install-lisp-common-smartchr))

  (defun my-run-racket-other-window ()
    (interactive)
    (with-selected-window (split-window-vertically -10)
      (racket-repl)
      (switch-to-buffer racket--repl-buffer-name))
    (let ((file (buffer-file-name)))
      (when file (my-racket-load file))))

  (defun my-racket-send-dwim ()
    (interactive)
    (if (use-region-p)
        (racket-send-region (region-beginning) (region-end))
      (racket-send-last-sexp)))

  (defun my-racket-load (&optional file)
    (interactive)
    (let ((file (or file
                    (expand-file-name (buffer-file-name))
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
  (dolist (hook '(racket-mode-hook racket-repl-mode-hook))
    (setup-hook hook
      (setq-local font-lock-builtin-face 'default)
      (setq-local racket-selfeval-face 'default)
      (setq-local racket-lambda-char
                  '(?l (cr cl 0 0) ?a (cr cl 0 0) ?m (cr cl 0 0)
                       ?b (cr cl 0 0) ?d (cr cl 0 0) ?a))))

  (setup-keybinds racket-mode-map
    "C-c C-e" 'my-racket-send-dwim
    "C-c C-m" 'my-racket-expand-dwim
    "C-c C-s" 'my-run-racket-other-window
    "C-c C-p" 'racket-cycle-paren-shapes
    "C-c C-d" 'racket-find-definition
    "C-c C-f" 'racket-fold-all-tests
    "C-c C-u" 'racket-unfold-all-tests
    "<f1> s" 'racket-help
    '("<f5>" "M-C-<f5>" "C-<f5>" "M-C-x" "C-x C-e" "C-c C-r"
      "C-c C-e x" "C-c C-e e" "C-c C-e r" "C-c C-e a"
      "RET" ")" "]" "}" "C-c C-p" "M-C-y" "<f1>"
      "C-c C-h" "C-c C-d" "C-c C-f" "C-c C-U") nil)
  )

;;   + c-like
;;     + (common)
;;       + (prelude)

(setup-after "cc-mode"

  ;;     + coding style

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
    (setq c-auto-newline t)
    (c-set-style "phi"))

  ;;     + key-combo

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
               (insert (if one-liner "{ " "{\n"))
               (goto-char (+ 2 end))
               (insert (if one-liner " }" "\n}"))
               (indent-region beg (point))))
            ((looking-back "\s")         ; insert {`!!'}
             (insert "{  }")
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
      (key-combo-define-local (kbd "^") " ^ ")
      (key-combo-define-local (kbd "^=") " ^= ")
      ;; others
      (key-combo-define-local (kbd "/*") "/* `!!' */")
      (key-combo-define-local (kbd "{") '(my-c-smart-braces "{ `!!' }"))))

  ;;     + auto-complete

  (setup-after "auto-complete"
    (setup "ac-c-headers"
      (defun my-ac-install-c-sources ()
        (setq ac-sources '(ac-source-c-headers
                           ac-source-words-in-same-mode-buffers
                           ac-source-dictionary
                           ac-source-c-header-symbols)))))

  ;;     + (sentinel)
  )

;;     + C, C++, Objetive-C

(setup-after "cc-mode"

  (dolist (keymap (list c-mode-map c++-mode-map objc-mode-map))
    (setup-keybinds keymap
      "C-c C-g"                            'c-guess
      '("," "C-d" "C-M-a" "C-M-e"
        "M-e" "M-j" "C-M-h" "C-M-j" "DEL") nil))

  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'c-mode)
    (add-to-list 'ac-modes 'c++-mode)
    (add-to-list 'ac-modes 'objc-mode)
    (setup-after "ac-c-headers"
      (add-hook 'c-mode-hook 'my-ac-install-c-sources)
      (add-hook 'c++-mode-hook 'my-ac-install-c-sources)))

  (setup-expecting "eldoc"
    (setup "c-eldoc"
      (setq c-eldoc-buffer-regenerate-time 15)
      ;; try MinGW include path on Windows
      (when (and (string= window-system "w32")
                 (file-exists-p "C:/MinGW/include"))
        (setq c-eldoc-includes    "-I./ -I../ -I\"C:/MinGW/include\""
              c-eldoc-cpp-command "C:/MinGW/bin/cpp"))
      (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)
      (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)))

  (setup-after "smart-compile"
    (add-to-list 'smart-compile-alist
                 `(c-mode . ,(concat "gcc -ansi -pedantic -Wall -W"
                                     " -Wextra -Wunreachable-code %f"))))

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
    (dolist (pair '((my-c-smart-and . "&") (my-c-smart-star . "*")))
      (eval `(defun ,(car pair) ()
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
                   (insert ,(cdr pair))
                 (let ((back (unless (looking-back " ") " "))
                       (forward (unless (looking-at " ") " ")))
                   (insert (concat back ,(cdr pair) forward)))))))
    (setup-hook 'c-mode-hook
      (my-install-c-common-smartchr)
      ;; pointers
      (key-combo-define-local (kbd "&") '(my-c-smart-and " && "))
      (key-combo-define-local (kbd "*") '(my-c-smart-star))
      (key-combo-define-local (kbd "->") "->")
      ;; include
      (key-combo-define-local (kbd "<") '(my-c-smart-angles " << "))
      ;; triary operation
      (key-combo-define-local (kbd "?") '( " ? `!!' : " "?"))))

  (setup-expecting "flycheck"
    (add-hook 'c-mode-hook 'flycheck-mode)
    (add-hook 'c++-mode-hook 'flycheck-mode))
  (setup-after "flycheck"
    ;; C/C++ checkers using gcc/g++
    ;; reference | https://github.com/jedrz/.emacs.d/blob/master/setup-flycheck.el
    (flycheck-define-checker c-gcc
      "A C checker using gcc"
      :command ("gcc" "-fsyntax-only" "-ansi" "-pedantic"
                "-Wall" "-Wextra" "-W" "-Wunreachable-code" source-inplace)
      :error-patterns ((warning line-start (file-name) ":" line ":" column ":"
                                " warning: " (message) line-end)
                       (error line-start (file-name) ":" line ":" column ":"
                              " error: " (message) line-end))
      :modes 'c-mode)
    (flycheck-define-checker c++-g++
      "A C checker using g++"
      :command ("g++" "-fsyntax-only" "-std=c++11" "-pedantic"
                "-Wall" "-Wextra" "-W" "-Wunreachable-code" source-inplace)
      :error-patterns ((warning line-start (file-name) ":" line ":" column ":"
                                " warning: " (message) line-end)
                       (error line-start (file-name) ":" line ":" column ":"
                              " error: " (message) line-end))
      :modes 'c++-mode)
    (add-to-list 'flycheck-checkers 'c-gcc)
    (add-to-list 'flycheck-checkers 'c++-g++))
  )

;;     + Java

(setup-after "cc-mode"

  ;; add some modifications for the coding style
  (setup-hook 'java-mode-hook
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
    (add-to-list 'ac-modes 'java-mode))

  (setup-after "smart-compile"
    (add-to-list 'smart-compile-alist
                 '(java-mode . "javac -Xlint:all -encoding UTF-8 %f")))

  (setup-expecting "key-combo"
    (setup-hook 'java-mode-hook
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

;;     + promela-mode

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
    (add-to-list 'ac-modes 'promela-mode))

  (defun my-promela-electric-semi ()
    (interactive)
    (insert ";")
    (unless (string-match "}" (buffer-substring (point) (point-at-eol)))
      (promela-indent-newline-indent)))

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

;;     + flex/bison-mode

(setup-lazy '(bison-mode) "bison-mode"
  :prepare (progn (push '("\\.ll?$" . bison-mode) auto-mode-alist)
                  (push '("\\.yy?$" . bison-mode) auto-mode-alist)))

;;   + functional
;;     + haskell-mode

(setup-lazy '(haskell-mode literate-haskell-mode) "haskell-mode"
  :prepare (progn (push '("\\.hs$" . haskell-mode) auto-mode-alist)
                  (push '("\\.lhs$" . literate-haskell-mode) auto-mode-alist))

  ;; FOR INSTALLATION :
  ;; (let ((generated-autoload-file
  ;;        "../site-lisp/plugins/haskell-mode/haskell-mode-autoloads.el"))
  ;;   (update-directory-autoloads "../site-lisp/plugins/haskell-mode/"))
  (require 'haskell-mode-autoloads)

  (setup-hook 'haskell-mode-hook
    (turn-on-haskell-indent)
    (turn-on-haskell-doc-mode))

  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'haskell-mode)
    (add-to-list 'ac-modes 'literate-haskell-mode))

  (setup-after "smart-compile"
    (add-to-list 'smart-compile-alist
                 '(haskell-mode . "ghc -Wall -fwarn-missing-import-lists %f")))

  (setup-expecting "flycheck"
    (add-hook 'haskell-mode-hook 'flycheck-mode))

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
      (key-combo-define-local (kbd "-") `(,(my-unary "-")))
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
    (add-hook 'haskell-mode-hook 'my-install-haskell-smartchr)
    (add-hook 'literate-haskell-mode-hook 'my-install-haskell-smartchr))
  )

;;     + scala-mode

(setup-lazy '(scala-mode) "scala-mode"
  :prepare (push '("\\.scala$" . scala-mode) auto-mode-alist)
  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'scala-mode))
  (setup-expecting "flycheck"
    (add-hook 'scala-mode-hook 'flycheck-mode)))

;;     + coq-mode (proof-general)

(setup-lazy '(coq-mode) "proof-site"
  :prepare (push '("\\.v$" . coq-mode) auto-mode-alist)

  (setq proof-shrink-windows-tofit       t
        proof-splash-enable              nil
        proof-electric-terminator-enable t
        proof-keep-response-history      t)

  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'coq-mode))

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
      (key-combo-define-local (kbd "+") `(,(my-unary "+")))
      (key-combo-define-local (kbd "-") `(,(my-unary "-")))
      (key-combo-define-local (kbd "*") " * ")
      (key-combo-define-local (kbd "/") " / ")))

  (defadvice proof-electric-terminator (before reindent-terminator activate)
    (open-line 1)
    (indent-for-tab-command))

  (defun my-proof-process-buffer ()
    (interactive)
    (goto-char (point-max))
    (proof-goto-point))

  (setup-keybinds coq-mode-map
    "C-m"                      'reindent-then-newline-and-indent
    "C-c C-c"                  'proof-interrupt-process
    "C-c C-n"                  'proof-assert-next-command-interactive
    "C-c C-p"                  'proof-undo-last-successful-command
    "C-c C-u"                  'proof-retract-buffer
    "C-c C-v"                  'my-proof-process-buffer
    "C-c C-e"                  'proof-goto-end-of-locked
    "C-c C-<return>"           'proof-goto-point
    '("M-a" "M-e" "M-n" "M-p") nil)
  )

;;   + declarative
;;     + (common)

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
    ;; arithmetic
    (key-combo-define-local (kbd "+") `(,(my-unary "+")))
    (key-combo-define-local (kbd "-") `(,(my-unary "-")))
    (key-combo-define-local (kbd "*") " * ")
    ;; not for lmntal
    ;; (key-combo-define-local (kbd "/") " / ")
    ))

;;     + prolog-mode

(setup-expecting "prolog"
  (push '("\\.swi$" . prolog-mode) auto-mode-alist))

(setup-after "prolog"
  (setup-keybinds prolog-mode-map "C-c C-c" 'inferior-prolog-load-file)
  (setup-after "popwin"
    (add-to-list 'popwin:special-display-config '("*prolog*")))
  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'prolog-mode))
  (setup-expecting "key-combo"
    (setup-hook 'prolog-mode-hook
      (my-install-prolog-common-smartchr)
      (key-combo-define-local (kbd "/") " / "))
    (add-hook 'prolog-mode-hook 'my-install-prolog-common-smartchr)))

;;     + (cs)lmntal-mode

(setup-lazy '(lmntal-mode) "lmntal-mode"
  :prepare (push '("\\.lmn$" . lmntal-mode) auto-mode-alist)

  (setq lmntal-home-directory "~/Work/LMNtal/LaViT2_6_2/lmntal/"
        lmntal-unyo-directory "~/Work/LMNtal/LaViT2_6_2/lmntal/unyo1_1_1/"
        lmntal-mc-use-dot     t)

  (add-hook 'lmntal-trace-mode-hook 'my-kindly-view-mode)
  (add-hook 'lmntal-mc-mode-hook 'my-kindly-view-mode)

  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'lmntal-mode))

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
      (key-combo-define-local (kbd ">=.") " >=. ")))

  (setup-after "mark-hacks"
    (add-to-list 'mark-hacks-auto-indent-inhibit-modes 'lmntal-slimcode-mode))
  )

(setup-lazy '(cslmntal-mode) "cslmntal-mode"
  :prepare (push '("\\.cslmn$" . cslmntal-mode) auto-mode-alist)
  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'cslmntal-mode)))

;;     + hydla-mode

(setup-lazy '(hydla-mode) "hydla-mode"
  :prepare (push '("\\.hydla$" . hydla-mode) auto-mode-alist)
  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'hydla-mode)))

;;   + other PLs
;;     + ahk-mode

(setup-lazy '(ahk-mode) "ahk-mode"
  :prepare (push '("\\.ahk$" . ahk-mode) auto-mode-alist)
  (setup-after "mark-hacks"
    (add-to-list 'mark-hacks-auto-indent-inhibit-modes 'fundamental-mode))
  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'ahk-mode))
  ;; ahk-mode-map must be set by hooks (why?)
  (setup-hook 'ahk-mode-hook
    (setup-keybinds ahk-mode-map '("C-j" "C-h") nil)))

;;     + dos-mode

(setup-lazy '(dos-mode) "dos-mode"
  :prepare (setq auto-mode-alist
                 (nconc
                  '(("\\.\\(?:[bB][aA][tT]\\|[cC][mM][dD]\\)\\'" . dos-mode)
                    ("\\`[cC][oO][nN][fF][iI][gG]\\." . bat-generic-mode)
                    ("\\`[aA][uU][tT][oO][eE][xX][eE][cC]\\." . bat-generic-mode))
                  auto-mode-alist))
  (setup-after "auto-complete"
    (add-to-list 'ac-modes 'dos-mode)))

;;     + makefile-mode

(setup-after "makefile-mode"
  (setup-expecting "flycheck"
    (add-hook 'makefile-mode-hook 'flycheck-mode)))

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

  ;;   + line-delete commands

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

  ;;   + region-move commands

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

  ;;   + rectangle copy command

  (defun my-picture-copy-rectangle (start end)
    (interactive "r")
    (setq picture-killed-rectangle (extract-rectangle start end)))

  ;;   + keymap

  (setup-keybinds artist-mode-map
    "<right>"   'picture-line-draw-right
    "<left>"    'picture-line-draw-left
    "<up>"      'picture-line-draw-up
    "<down>"    'picture-line-draw-down
    "C-<right>" 'picture-line-delete-right
    "C-<left>"  'picture-line-delete-left
    "C-<up>"    'picture-line-delete-up
    "C-<down>"  'picture-line-delete-down
    "M-<right>" 'picture-region-move-right
    "M-<left>"  'picture-region-move-left
    "M-<up>"    'picture-region-move-up
    "M-<down>"  'picture-region-move-down
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
      "M-e"   'my-orgtbl-recalculate
      "C-g"   'orgtbl-mode))
  )

;;   + reading modes

(setup-after "debug"
  (setup-expecting "vi"
    (add-hook 'debugger-mode-hook 'my-kindly-view-mode)))

(setup-after "help-mode"
  (setup-expecting "vi"
    (add-hook 'help-mode-hook 'my-kindly-view-mode)))

(setup-after "sdic"
  (setup-expecting "vi"
    (add-hook 'sdic-mode-hook 'my-kindly-view-mode)))

(setup-after "info"
  (setup-expecting "vi"
    ;; "Info-mode-map" does not work ?
    (setup-hook 'Info-mode-hook
      (my-kindly-view-mode)
      (local-set-key (kbd "RET") 'Info-follow-nearest-node)
      (local-set-key (kbd "n") 'Info-next-reference)
      (local-set-key (kbd "p") 'Info-prev-reference)
      (local-set-key (kbd "q") 'Info-backward-node)
      (local-set-key (kbd "]") 'Info-forward-node)
      (local-set-key (kbd "u") 'Info-up))))

;;   + others
;;     + vi-mode

(setup-after "vi"

  ;; undo-tree integration
  (setup-expecting "undo-tree"
    (setup-keybinds vi-com-map
      "C-r" 'undo-tree-redo
      "u"   'undo-tree-undo))

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

;;     + dired [idired] [dired-k] [find-dired-lisp]

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
    (rename-buffer (concat "[Dired]" (buffer-name)) t))

  ;; disable key-chord
  (setup-after "key-chord"
    (setup-hook 'dired-mode-hook
      (setq-local key-chord-mode nil)
      (setq-local input-method-function nil)))

  ;; disbable indent-guide in dired-mode
  (setup-after "indent-guide"
    (defadvice indent-guide-show (around disable-in-dired activate)
      (unless (eq major-mode 'dired-mode)
        ad-do-it)))

  (setup "find-dired-lisp"
    (require 'find-dired)               ; dependency (find-ls-option)
    (setup-keybinds dired-mode-map "f" 'find-dired-lisp))

  (setup "idired"
    (add-hook 'dired-mode-hook 'idired-mode))

  (setup "dired-k"
    (defun dired-k--inside-git-repository-p () nil)
    (setup-hook 'dired-mode-hook
      (run-with-idle-timer 0 nil 'dired-k--highlight)))

  ;; command
  (defun my-dired-default-directory ()
    (interactive)
    (dired default-directory))
  )

;;     + Buffer-menu

(setup-after "buff-menu"
  (setup-hook 'Buffer-menu-mode-hook
    ;; disable key-chord
    (setq-local key-chord-mode nil)
    (setq-local input-method-function nil))
  (setup-keybinds Buffer-menu-mode-map
    "RET" 'Buffer-menu-select
    "j" 'next-line
    "k" 'previous-line
    "l" 'Buffer-menu-select
    "o" 'Buffer-menu-other-window
    "v" 'Buffer-menu-view
    "s" 'Buffer-menu-save
    "m" 'Buffer-menu-delete
    "d" 'Buffer-menu-execute
    "u" 'Buffer-menu-unmark
    "5" 'Buffer-menu-toggle-read-only
    "b" 'Buffer-menu-bury
    "f" 'Buffer-menu-toggle-files-only))

;;     + eshell

(setup-after "eshell"
  (setq eshell-directory-name  my-eshell-directory
        eshell-prompt-regexp   "^λ>?> "
        eshell-prompt-function (lambda ()
                                 (concat "\n"
                                         (my-shorten-directory (eshell/pwd) 20)
                                         "\n"
                                         (if (= (user-uid) 0) "λ>> " "λ> "))))

  (setup-after "mark-hacks"
    (add-to-list 'mark-hacks-auto-indent-inhibit-modes 'eshell-mode))

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

(setup-lazy '(howm-menu-or-remember) "howm"
  :prepare (progn (setup-in-idle "howm")
                  (push '("\\.howm$" . org-mode) auto-mode-alist))

  ;;   + | calendar settings

  (require 'calendar)

  (setup "japanese-holidays"
    (setq mark-holidays-in-calendar t
          calendar-holidays
          (append japanese-holidays local-holidays other-holidays))
    (add-hook 'calendar-today-visible-hook 'calendar-mark-today))

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
        howm-menu-lang                       'en
        howm-menu-schedule-days-before       0
        howm-menu-schedule-days              185
        howm-menu-todo-num                   50
        howm-menu-reminder-separators
        '((-1000 . "\n// dead") (-1 . "\n// today")
          (0 . "\n// upcoming") (nil . "\n// someday")))

  (set-face-background 'howm-reminder-today-face nil)
  (set-face-background 'howm-reminder-tomorrow-face nil)

  ;;   + | dropbox -> howm

  (setup-hook 'howm-menu-hook
    (when my-howm-import-directory
      (dolist (file (directory-files my-howm-import-directory))
        (unless (string-match "^-" file)
          (let ((abs-path (concat my-howm-import-directory file)))
            (when (file-regular-p abs-path)
              (howm-remember)
              (insert-file-contents abs-path)
              (beginning-of-buffer)
              (cond ((not (y-or-n-p (format "import %s ?" file)))
                     (howm-remember-discard)
                     (rename-file abs-path (concat my-howm-import-directory "-" file)))
                    (t
                     (let ((howm-template (concat "* " (howm-reminder-today)
                                                  "-100 " file "\n\n%cursor")))
                       (howm-remember-submit)
                       (delete-file abs-path))))))))))

  ;;   + | howm -> dropbox

  (defun my-howm-export-file (target)
    (with-temp-file target
      ;; dropbox App compatibility
      (set-buffer-file-coding-system 'utf-8)
      (insert (format "* Howm Schedule %s ~ %s *\n\n"
                      (howm-reminder-today)
                      (howm-reminder-today howm-menu-schedule-days))
              ;; calender of the next two months
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
              (howm-menu-reminder))
      (message "successfully exported")))

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
        (insert-string (howm-menu-reminder))
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

  ;;   + | commands

  (defun my-howm-kill-buffer ()
    "save and kill this howm buffer"
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
          (buffer-list)))

  (defun howm-menu-or-remember ()
    (interactive)
    (if (use-region-p)
        (let ((str (buffer-substring (region-beginning) (region-end))))
          (howm-remember)
          (insert str))
      (howm-menu)))

  ;; reference | http://www.bookshelf.jp/soft/meadow_38.html#SEC563
  (defun howm-insert-date-from-calendar ()
    (interactive)
    (let ((day nil)
          (calendar-date-display-form
           '("[" year "-" (format "%02d" (string-to-int month))
             "-" (format "%02d" (string-to-int day)) "]")))
      (setq day (calendar-date-string
                 (calendar-cursor-to-date t)))
      (calendar-exit)
      (insert day)))
  (defun howm-insert-date-with-calendar ()
    (interactive)
    (calendar))
  (setup-keybinds calendar-mode-map
    "RET" 'howm-insert-date-from-calendar
    "C-g" 'calendar-exit)

  ;;   + | keybinds

  (setup-keybinds howm-mode-map
    "C-x C-s" 'my-howm-kill-buffer
    "M-d"     'howm-insert-date
    "M-c"     'howm-insert-date-with-calendar)
  (setup-keybinds howm-menu-mode-map
    "q"       'my-howm-exit)
  (setup-keybinds howm-remember-mode-map
    "C-g"     'howm-remember-discard
    "C-x C-s" 'howm-remember-submit)

  ;;   + | (sentinel)
  )

;; + | Appearance
;;   + mode-line settings
;;     + faces

(dolist (face '(mode-line-bright-face
                mode-line-dark-face
                mode-line-highlight-face
                mode-line-special-mode-face
                mode-line-warning-face
                mode-line-modified-face
                mode-line-read-only-face
                mode-line-narrowed-face
                mode-line-mc-face
                header-line))
  (make-face face)
  (set-face-attribute face nil :inherit 'mode-line-face))

;;     + change color while recording macros

(defvar my-mode-line-background '("#194854" . "#594854"))

(defadvice kmacro-start-macro (after my-recording-mode-line activate)
  (set-face-background 'mode-line (cdr my-mode-line-background))
  (add-hook 'post-command-hook 'my-recording-mode-line-end))

(defun my-recording-mode-line-end ()
  (unless defining-kbd-macro
    (set-face-background 'mode-line (car my-mode-line-background))
    (remove-hook 'post-command-hook 'my-recording-mode-line-end)))

;;     + mode-line-format

(defun my-generate-mode-line-format ()
  (let ((vbar
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
         (propertize (let* ((file (buffer-file-name))
                            (dir (if file (file-name-directory file) "")))
                       (my-shorten-directory dir 10)) 'face 'mode-line-dark-face))
        (filename
         (! (propertize "%b" 'face 'mode-line-highlight-face)))
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
        (encoding
         (propertize (format " (%s)" (symbol-name buffer-file-coding-system))
                     'face 'mode-line-dark-face))
        (time
         (let ((time (decode-time (current-time))))
           (propertize (format "%02d:%02d" (cl-caddr time) (cadr time))
                       'face 'mode-line-bright-face))))
    (let* ((lstr (concat linum vbar
                         colnum-or-region vbar
                         i-narrowed i-readonly i-modified i-mc vbar
                         dirname filename recur))
           (rstr (concat vbar mode encoding vbar time))
           (lmargin (propertize " " 'display
                                '((space :align-to (+ 1 left-fringe)))))
           (rmargin (propertize " " 'display
                                `((space :align-to (- right-fringe ,(length rstr)))))))
      (concat lmargin lstr rmargin rstr))))

(setq-default mode-line-format '(:eval (my-generate-mode-line-format)))

;;     + others

;; force update mode-line every minutes
(run-with-timer 60 60 'force-mode-line-update)

;;   + "kindly-view" minor-mode

;; reference | http://d.hatena.ne.jp/nitro_idiot/20130215/1360931962
(setup-lazy '(my-kindly-view-mode) "vi"
  (defvar my-kindly-view-mode-map (copy-keymap vi-com-map))
  (setup-keybinds my-kindly-view-mode-map
    '("j" "C-n")   '("pager" pager-row-down vi-next-line)
    '("k" "C-p")   '("pager" pager-row-up previous-line)
    '("C-g" "C-c") nil)
  (defvar my-kindly-unsupported-minor-modes
    '(indent-guide-mode phi-autopair-mode)
    "list of minor-modes that must be turned-off temporarily.")
  (defvar my-kindly-unsupported-global-variables
    '(global-hl-line-mode show-paren-mode
                          key-chord-mode input-method-function)
    "list of variables that must be set nil locally.")
  (defun my-kindly-view-mode ()
    (interactive)
    (read-only-mode 1)
    (setq line-spacing 0.3
          cursor-type 'bar)
    (dolist (mode my-kindly-unsupported-minor-modes)
      (when (and (boundp mode) mode) (funcall mode -1)))
    (dolist (var my-kindly-unsupported-global-variables)
      (set (make-local-variable var) nil))
    (setq-local buffer-face-mode-face
                '(:family "Times New Roman" :width semi-condensed))
    (buffer-face-mode 1)
    (text-scale-set +2)
    (use-local-map my-kindly-view-mode-map)))

;;   + colorscheme [solarized-definitions]
;;     + (prelude)

(setup-include "solarized-definitions"

  ;;   + palettes

  ;; copied from "solarized-color-definitions"
  (eval-and-compile
    (defun solarized-find-color (name)
      (let ((index (cl-case window-system
                     (nil (cl-case (display-color-cells)
                            (16 4)
                            (8  5)
                            (otherwise 3)))
                     (mac 2)
                     (otherwise 1))))
        (nth index (assoc name solarized-colors)))))

  (eval-and-compile
    (setq solarized-colors
          '((base03          "#002b36")  ; background
            (lmntal-name     "#003944")  ; for lmntal-mode (bg)
            (flymake-err     "#402b36")  ; flymake highlight
            (base02          "#073642")  ; hl-line, inactive modeline
            (modeline-active "#194854")  ; active modeline
            (modeline-record "#594854")  ; recording modeline
            (base01          "#586e75") ; region, comment, ace-jump base
            (base00          "#657b83") ;
            (base0           "#839496") ; foreground, cursor
            (base1           "#93a1a1") ; modeline active (fg)
            (base2           "#eee8d5") ;
            (base3           "#fdf6e3") ; ace-jump match
            (yellow          "#b58900") ; type, highlight
            (orange          "#cb4b16") ; preprocessor, regexp group
            (red             "#dc322f") ; warning, mismatch
            (magenta         "#d33682") ; visited link
            (violet          "#6c71c4") ; link
            (blue            "#268bd2") ; function, variable name
            (cyan            "#2aa198") ; string, showparen, minibuffer
            (green           "#859900") ; keyword, builtin, constant
            )))
  (create-solarized-theme dark)

  ;; (eval-and-compile
  ;;   (setq solarized-colors
  ;;         '((base03          "#202020")  ; background
  ;;           (lmntal-name     "#2c2c2c")  ; for lmntal-mode (bg)
  ;;           (flymake-err     "#3a2020")  ; flymake highlight
  ;;           (base02          "#292929")  ; hl-line, inactive modeline
  ;;           (modeline-active "#393939")  ; active modeline
  ;;           (modeline-record "#593939")  ; recording modeline
  ;;           (base01          "#666666") ; region, comment, ace-jump base
  ;;           (base00          "#ffffff") ;
  ;;           (base0           "#b8b8a3") ; foreground, cursor
  ;;           (base1           "#a8b8b3") ; modeline active (fg)
  ;;           (base2           "#ffffff") ;
  ;;           (base3           "#ffffff") ; ace-jump match
  ;;           (yellow          "#ffb964") ; type, highlight
  ;;           (orange          "#8fbfdc") ; preprocessor, regexp group
  ;;           (red             "#a04040") ; warning, mismatch
  ;;           (magenta         "#b05080") ; visited link
  ;;           (violet          "#805090") ; link
  ;;           (blue            "#fad08a") ; function, variable name
  ;;           (cyan            "#99ad6a") ; string, showparen, minibuffer
  ;;           (green           "#8fbfdc") ; keyword, builtin, constant
  ;;           )))
  ;; (create-solarized-theme dark)

  ;; (eval-and-compile
  ;;   (setq solarized-colors
  ;;         '((base03          "#ee0000")  ; ace-jump match
  ;;           (lmntal-name     "#efefef")  ; for lmntal-mode (bg)
  ;;           (flymake-err     "#ffefe8")  ; flymake highlight
  ;;           (base02          "#f2ede6")  ; inactive modeline
  ;;           (modeline-active "#dcd7f0")  ; active modeline
  ;;           (modeline-record "#fdd9d2")  ; recording modeline
  ;;           (base01          "#4d4d4d")  ; modeline active (fg)
  ;;           (base00          "#4d4d4d")  ; foreground, cursor
  ;;           (base0           "#ffffff")  ;
  ;;           (base1           "#697799") ; region, comment, ace-jump base
  ;;           (base2           "#f2ede6") ; hl-line
  ;;           (base3           "#faf5ee") ; background
  ;;           (yellow          "#3388dd") ; type, highlight
  ;;           (orange          "#ac3d1a") ; preprocessor, regexp group
  ;;           (red             "#dd2222") ; warning, mismatch
  ;;           (magenta         "#8b008b") ; visited link
  ;;           (violet          "#00b7f0") ; link
  ;;           (blue            "#1388a2") ; function, variable name
  ;;           (cyan            "#104e8b") ; string, showparen, minibuffer
  ;;           (green           "#00688b") ; keyword, builtin, constant
  ;;           )))
  ;; (create-solarized-theme light)

  ;;   + modeline

  (setq my-mode-line-background
        (cons (! (solarized-find-color 'modeline-active))
              (! (solarized-find-color 'modeline-record))))

  (set-face-attribute 'mode-line nil
                      :foreground (! (solarized-find-color 'base1))
                      :background (! (solarized-find-color 'modeline-active))
                      :inverse-video nil
                      :box (append '(:line-width 1)
                                   `(:color ,(! (solarized-find-color 'modeline-active)))))
  (set-face-attribute 'mode-line-inactive nil
                      :foreground (! (solarized-find-color 'base01))
                      :background (! (solarized-find-color 'base02))
                      :inverse-video nil
                      :box (append '(:line-width 1)
                                   `(:color ,(! (solarized-find-color 'base02)))))

  (set-face-attribute 'mode-line-dark-face nil
                      :foreground (! (solarized-find-color 'base01)))
  (set-face-attribute 'mode-line-highlight-face nil
                      :foreground (! (solarized-find-color 'yellow))
                      :weight 'bold)
  (set-face-attribute 'mode-line-warning-face nil
                      :foreground (! (solarized-find-color 'base03))
                      :background (! (solarized-find-color 'yellow)))
  (set-face-attribute 'mode-line-special-mode-face nil
                      :foreground (! (solarized-find-color 'cyan))
                      :weight 'bold)

  (set-face-attribute 'mode-line-modified-face nil
                      :foreground (! (solarized-find-color 'magenta))
                      :box (append '(:line-width 1)
                                   `(:color ,(! (solarized-find-color 'magenta)))))
  (set-face-attribute 'mode-line-read-only-face nil
                      :foreground (! (solarized-find-color 'blue))
                      :box (append '(:line-width 1)
                                   `(:color ,(! (solarized-find-color 'blue)))))
  (set-face-attribute 'mode-line-narrowed-face nil
                      :foreground (! (solarized-find-color 'cyan))
                      :box (append '(:line-width 1)
                                   `(:color ,(! (solarized-find-color 'cyan)))))
  (set-face-attribute 'mode-line-mc-face nil
                      :foreground (! (solarized-find-color 'base1))
                      :box (append '(:line-width 1)
                                   `(:color ,(! (solarized-find-color 'base1)))))

  ;;   + ace-jump-mode

  (setup-after "ace-jump-mode"
    (cl-case (frame-parameter nil 'background-mode)
      (dark (set-face-foreground 'ace-jump-face-foreground
                                 (! (solarized-find-color 'base3)))
            (set-face-foreground 'ace-jump-face-background
                                 (! (solarized-find-color 'base01))))
      (light (set-face-foreground 'ace-jump-face-foreground
                                  (! (solarized-find-color 'base03)))
             (set-face-foreground 'ace-jump-face-background
                                  (! (solarized-find-color 'base1))))))

  ;;   + font-lock

  ;; highlight regexp symbols
  ;; reference | http://pastelwill.jp/wiki/doku.php?id=emacs:init.el
  (setup-after "font-lock"
    (set-face-foreground 'font-lock-regexp-grouping-backslash
                         (! (solarized-find-color 'red)))
    (set-face-foreground 'font-lock-regexp-grouping-construct
                         (! (solarized-find-color 'red))))

  ;;   + highlight-parentheses

  (setup-after "highlight-parentheses"
    (hl-paren-set 'hl-paren-colors nil)
    (hl-paren-set 'hl-paren-background-colors
                  (list (! (solarized-find-color 'modeline-active)))))

  ;;   + paren

  (setup-after "paren"
    (set-face-attribute 'show-paren-match-face nil :underline t :bold t)
    (set-face-attribute 'show-paren-mismatch-face nil :underline t :bold t))

  ;;   + flymake

  (setup-after "flymake"
    (set-face-attribute 'flymake-errline nil
                        :foreground 'unspecified
                        :inverse-video 'unspecified
                        :background (! (solarized-find-color 'flymake-err)))
    (set-face-attribute 'flymake-warnline nil
                        :foreground 'unspecified
                        :inverse-video 'unspecified
                        :background (! (solarized-find-color 'flymake-err))))

  ;;   + whitespace

  (setup-after "whitespace"
    (set-face-attribute 'whitespace-space nil
                        :foreground (! (solarized-find-color 'modeline-active))
                        :background 'unspecified)
    (set-face-attribute 'whitespace-tab nil
                        :foreground (! (solarized-find-color 'modeline-active))
                        :background 'unspecified))

  ;;   + lmntal-mode

  (setup-after "lmntal-mode"
    (set-face-background 'lmntal-link-name-face
                         (! (solarized-find-color 'lmntal-name))))

  ;;   + phi-search

  (setup-after "phi-search-core"
    (set-face-background 'phi-search-match-face
                         (! (solarized-find-color 'modeline-active)))
    (set-face-background 'phi-search-selection-face
                         (! (solarized-find-color 'modeline-record))))

  ;;   + indent-guide

  (setup-after "indent-guide"
    (cl-case (frame-parameter nil 'background-mode)
      (dark (set-face-foreground 'indent-guide-face
                                 (! (solarized-find-color 'base01))))
      (light (set-face-foreground 'indent-guide-face
                                  (! (solarized-find-color 'base1))))))

  ;;   + traverselisp

  (setup-after "traverselisp"
    (set-face-background 'traverse-overlay-face
                         (! (solarized-find-color 'base02))))

  ;;   + (sentinel)
  )

;;   + Misc: built-ins

(setup-after "frame"
  (blink-cursor-mode -1))

(setup-after "font-lock"
  (setq font-lock-support-mode 'jit-lock-mode
        jit-lock-stealth-time 16))

;; highlight matching parens
(setup-include "paren"
  (show-paren-mode)
  (setq show-paren-delay 0))

(setup-include "hl-line"
  (global-hl-line-mode 1))

(setup-lazy '(whitespace-mode) "whitespace"
  :prepare (add-hook 'find-file-hook 'whitespace-mode)
  (setq whitespace-space-regexp     "\\(\x3000+\\)"
        whitespace-style            '(face tabs spaces space-mark tab-mark)
        whitespace-display-mappings '((space-mark ?\x3000 [?□])
                                      (tab-mark ?\t [?\xBB ?\t]))))

(setup-after "iimage"
  (setup-keybinds iimage-mode-map "C-l" nil))

;;   + Misc: plug-ins

(setup-include "indent-guide"
  (indent-guide-global-mode))

(setup-include "highlight-parentheses"
  (define-globalized-minor-mode global-highlight-parentheses-mode
    highlight-parentheses-mode
    (lambda () (highlight-parentheses-mode 1)))
  (global-highlight-parentheses-mode 1))

(setup-lazy '(rainbow-delimiters-mode) "rainbow-delimiters")

(setup-lazy '(rainbow-mode) "rainbow-mode")

;; make GUI modern
(setup-include "sublimity"
  (sublimity-mode 1)
  (setup-include "sublimity-scroll"
    (setq sublimity-scroll-weight       4
          sublimity-scroll-drift-length 3))
  (setup-include "sublimity-attractive"
    (setup-hook 'after-init-hook
      (setq sublimity-attractive-centering-width 110)
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
  "C-x C-b" 'list-buffers
  "C-x C-k" 'kill-this-buffer
  "C-x C-e" 'set-buffer-file-coding-system
  "C-x C-r" 'revert-buffer-with-coding-system)

;;     + |frame, window

(setup-keybinds nil
  "M-0" 'next-multiframe-window
  "M-1" 'delete-other-windows
  "M-2" 'my-split-window
  "M-3" 'balance-windows
  "M-4" 'follow-delete-other-windows-and-split
  "M-8" 'my-rotate-windows
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
  "M--"   'my-point-undo
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
  "C-d"   '("phi-autopair" phi-autopair-delete-forward delete-char)
  "C-y"   '("phi-rectangle" phi-rectangle-yank yank)
  "C-M-w" '("phi-rectangle" phi-rectangle-kill-ring-save kill-ring-save)
  "C-M-k" 'my-kill-line-backward
  "C-M-d" '("phi-autopair" phi-autopair-delete-forward-word kill-word)
  "C-M-h" '("phi-autopair" phi-autopair-delete-backward-word backward-kill-word)
  "C-M-y" '("yasnippet" my-yas-expand-oneshot)
  "M-W"   'my-yank-sexp
  "M-K"   '("paredit" my-paredit-kill kill-line)
  "M-D"   'kill-sexp
  "M-H"   'backward-kill-sexp
  "M-Y"   'my-overwrite-sexp
  "M-y"   '("browse-kill-ring" browse-kill-ring yank-pop))

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
  "M-s"   '("all" my-all-command))

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
  "M-:"          '("paredit" paredit-comment-dwim comment-dwim)
  "<oem-pa1>"    '("yasnippet" yas-expand my-dabbrev-expand)
  "<muhenkan>"   '("yasnippet" yas-expand my-dabbrev-expand)
  "<nonconvert>" '("yasnippet" yas-expand my-dabbrev-expand))

;;   + | file, directory, shell
;;     + browsing

(setup-keybinds nil
  "M-d"     'my-dired-default-directory
  "M-f"     '("ido" ido-find-file find-file)
  "M-g"     '("traverselisp" traverse-deep-rfind rgrep)
  "M-r"     'ido-recentf-open
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
  "<f1> r"    '("pcre2el" pcre2el-describe-regexp)
  "<f1> w"    '("sdic" sdic-describe-word)
  "<f1> ,"    '("sos" sos))

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
  "<escape>"  'vi-mode
  "M-v"       'vi-mode
  "M-t"       'orgtbl-mode
  "M-a"       'artist-mode
  "M-n"       'my-toggle-narrowing
  "M-,"       '("howm" howm-menu-or-remember)
  "M-c"       '("smart-compile" smart-compile compile)
  "C-x C-l"   'my-add-change-log-entry
  "C-x C-t"   'toggle-truncate-lines
  "C-x C-p"   'read-only-mode
  "C-x C-i"   'ispell-region
  "C-x C-,"   '("download-region" download-region-as-url))

;;   + keychord

(setup-after "key-chord"

  (key-chord-define-global "fj" 'my-transpose-chars)
  (key-chord-define-global "hh" 'my-capitalize-word-dwim)
  (key-chord-define-global "kk" 'my-upcase-previous-word)
  (key-chord-define-global "jj" 'my-downcase-previous-word)

  ;; reference | http://endlessparentheses.com/banishing-the-shift-key-with-key-chord-in-emacs.html
  (key-chord-define-global "0o" ")")
  (key-chord-define-global "1q" "!")
  (key-chord-define-global "2w" "@")
  (key-chord-define-global "3e" "#")
  (key-chord-define-global "4r" "$")
  (key-chord-define-global "5t" "%")
  (key-chord-define-global "6y" "^")
  (key-chord-define-global "6t" "^")
  (key-chord-define-global "7y" "&")
  (key-chord-define-global "8u" "*")
  (key-chord-define-global "9i" "(")
  (key-chord-define-global "-p" "_")

  (setup-expecting "iy-go-to-char"
    (key-chord-define-global "jk" 'iy-go-to-char)
    (key-chord-define-global "df" 'iy-go-to-char-backward))
  (setup-expecting "ace-jump-mode"
    (key-chord-define-global "jl" 'ace-jump-word-mode))
  )
