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

;;         foo  |                    |
;; foo          |              foo { |            foo
;; |    -> |    | foo { | } ->     | | foo|bar -> |
;; bar          |              }     |            bar
;;         bar  |                    |
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
