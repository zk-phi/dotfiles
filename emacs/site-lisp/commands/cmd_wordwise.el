;;                          |                          |
;; |hoge hoge -> Hoge| hoge | hoge| hoge -> Hoge| hoge | [hoge hoge| hoge -> Hoge Hoge| hoge
;;                          |                          |
(defun my-capitalize-word-dwim ()
  (interactive)
  (cond ((use-region-p)
         (let* ((orig-str (buffer-substring (region-beginning) (region-end)))
                (str (replace-regexp-in-string "[-_]" "" (capitalize orig-str))))
           (delete-region (region-beginning) (region-end))
           (insert str)))
        ((memql (char-after) '(?- ?_))
         (delete-char 1)
         (capitalize-word 1))
        ((<= ?a (char-after) ?z)
         (capitalize-word 1))
        (t
         (capitalize-word -1))))

;; hoge hoge| hoge -> hoge HOGE| hoge -> HOGE HOGE| hoge
(defvar my-upcase-previous-word-count nil)
(defun my-upcase-previous-word ()
  (interactive)
  (cond ((use-region-p)
         (upcase-region (region-beginning) (region-end))
         (setq my-upcase-previous-word-count 0)
         (setq my-upcase-previous-word-count 0))
        ((not (eq last-command this-command))
         (upcase-word (setq my-upcase-previous-word-count -1)))
        (t
         (cl-decf my-upcase-previous-word-count)
         (upcase-word my-upcase-previous-word-count))))

;; Hoge HOGE| HOGE -> Hoge hoge| HOGE -> hoge hoge| HOGE
(defvar my-downcase-previous-word-count nil)
(defun my-downcase-previous-word ()
  (interactive)
  (cond ((use-region-p)
         (downcase-region (region-beginning) (region-end))
         (setq my-downcase-previous-word-count 0))
        ((not (eq last-command this-command))
         (downcase-word (setq my-downcase-previous-word-count -1)))
        (t
         (cl-decf my-downcase-previous-word-count)
         (downcase-word my-downcase-previous-word-count))))

(defun my-transpose-words ()
  (interactive)
  (if (bound-and-true-p jaword-mode)
      (jaword-transpose -1)
    (transpose-words -1)))
