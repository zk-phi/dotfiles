(eval-when-compile
  (require 'subr-x))

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
  (when-let (replacement
             (or (cl-some (lambda (pair) (and (looking-back (car pair) (point-at-bol)) (cdr pair)))
                          my-transpose-chars-list)
                 (and (looking-back "\\(.\\)\\(.\\)" (max 0 (- (point) 2))) "\\2\\1")))
            (replace-match replacement)))

(defun my-smart-comma ()
  "Insert comma maybe followed by a space."
  (interactive)
  (cond ((not (eq last-command 'my-smart-comma))
         (insert ", "))
        ((= (char-before) ?\s)
         (delete-char -1))
        (t
         (insert " "))))

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
                                    (and (not (memq (char-after) '(?\] ?\) ?\} nil)))
                                         (not (memq (char-before) '(?\[ ?\( ?\{ nil)))
                                         (insert " "))))
      (cond ((= bol eol)              ; blank-line(s) : shrink => join
             (if (< (- (line-number-at-pos eos) (line-number-at-pos bos)) 3)
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

;; expand dwim
(defvar my-expand-dwim-fallback nil)
(defun my-expand-dwim (&optional lines)
  "Expands either

- flyspell correction if exists

- most recent, preceding word which shares the prefix

  When LINES is specified, matches must be at most LINES lines
  far from the cursor.

- elisp package name if the cursor is after \"(\", \"@\" etc

If no candidates above are available, call
`my-expand-dwim-fallback' function (if set),"
  (interactive)
  (cond ((and (catch 'flyspell-error-found
                (dolist (ov (overlays-in (1- (point)) (point)))
                  (when (eq (overlay-get ov 'face) 'flyspell-incorrect)
                    (throw 'flyspell-error-found ov))))
              (fboundp 'flyspell-correct-word-before-point))
         (flyspell-correct-word-before-point))
        ((and (looking-back "\\_<\\(?:\\sw\\|\\s_\\)+" (point-at-bol))
              (save-excursion
                (search-backward-regexp
                 (concat (regexp-quote (match-string 0)) "\\(\\(?:\\sw\\|\\s_\\)+\\)\\_>")
                 (and lines (point-at-bol (- lines))) t)))
         (insert (match-string 1) " "))
        ((and (not (eq this-command last-command))
              (eq major-mode 'emacs-lisp-mode)
              (memq (char-before) '(?\[ ?\( ?\s ?, ?' ?` ?@))
              buffer-file-name)
         (insert (file-name-base buffer-file-name) "-"))
        (my-expand-dwim-fallback
         (funcall my-expand-dwim-fallback))
        (t
         (message "No completions found."))))

(defun my-indent-or-expand-dwim (arg)
  (interactive "P")
  (cond
   ((use-region-p)
    (indent-for-tab-command)
    (setq this-command 'indent-for-tab-command))
   ((let ((old-point (point))
          (old-tick (buffer-chars-modified-tick))
          (tab-always-indent t))
      (indent-for-tab-command arg)
      (if (and (eq last-command 'indent-for-tab-command)
               (eq old-point (point))
               (eq old-tick (buffer-chars-modified-tick)))
          (my-expand-dwim)
        (setq this-command 'indent-for-tab-command))))))

(defun my-map-lines-from-here (fn)
  (interactive (list (eval `(lambda (s) ,(read (read-from-minibuffer "(s) => "))))))
  (save-excursion
    (while (progn (let ((res (funcall fn (buffer-substring (point-at-bol) (point-at-eol)))))
                    (kill-whole-line)
                    (and res (insert res "\n")))
                  (not (eobp))))))
