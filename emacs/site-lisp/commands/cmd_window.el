;; move buffers among windows smartly
(defun my-transpose-window-buffers ()
  "Rotate buffers among windows."
  (interactive)
  (let ((m (make-sparse-keymap)))
    (dolist (cmd '(other-window previous-window-any-frame next-window-any-frame))
      (let ((keys (where-is-internal cmd))
            (def `(lambda ()
                    (interactive)
                    (let* ((w1 (selected-window))
                           (w2 (progn (call-interactively ',cmd) (selected-window)))
                           (tmp (window-buffer w1)))
                      (set-window-buffer w1 (window-buffer w2))
                      (set-window-buffer w2 tmp)))))
        (dolist (key keys) (define-key m key def))))
    (set-transient-map m t)))

(defun my-kill-this-buffer (&optional force)
  "Like kill-this-buffer but accepts FORCE argument to skip
kill-buffer-query-functions."
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
  (cl-case (read-char-choice "Press npbf or hjkl to resize." '(?n ?p ?b ?f ?h ?j ?k ?l))
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

(defun my-scroll-down-by-row ()
  "Scroll down by 1 row."
  (interactive)
  (scroll-down 1))
(defun my-scroll-up-by-row ()
  "Scroll up by 1 row."
  (interactive)
  (scroll-up 1))

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
      ;; horizontally
      ;; |---------------| -> |-------|-------|
      ((my-split-window-horizontally-0)
       (split 2)
       (setq this-command 'my-split-window-horizontally-1))
      ;; (try vertical split)
      ((my-split-window-horizontally-1)
       (set-window-configuration my-split-window-saved-configuration)
       (split 2 t)
       (setq this-command 'my-split-window-horizontally-2))
      ;; |-------|-------| -> |----|-----|----|
      ((my-split-window-horizontally-2)
       (set-window-configuration my-split-window-saved-configuration)
       (split 3)
       (setq this-command 'my-split-window-horizontally-3))
      ;; |----|-----|----| -> |---|---|-------|
      ((my-split-window-horizontally-3)
       (set-window-configuration my-split-window-saved-configuration)
       (split 2)
       (split 2)
       (setq this-command 'my-split-window-horizontally-4))
      ;; |---|---|-------| -> |---|---|---|---|
      ((my-split-window-horizontally-4)
       (set-window-configuration my-split-window-saved-configuration)
       (split 4)
       (setq this-command 'my-split-window-horizontally-5))
      ;; |---|---|---|---| -> |---------------|
      ((my-split-window-horizontally-5)
       (set-window-configuration my-split-window-saved-configuration)
       (setq this-command 'my-split-window-horizontally-0))
      ;; vertically
      ((my-split-window-vertically-0)
       (split 2 t)
       (setq this-command 'my-split-window-vertically-1))
      ((my-split-window-vertically-1)
       (set-window-configuration my-split-window-saved-configuration)
       (split 2)
       (setq this-command 'my-split-window-vertically-2))
      ((my-split-window-vertically-2)
       (set-window-configuration my-split-window-saved-configuration)
       (split 3 t)
       (setq this-command 'my-split-window-vertically-3))
      ((my-split-window-vertically-3)
       (set-window-configuration my-split-window-saved-configuration)
       (setq this-command 'my-split-window-vertically-0))
      (t
       (setq my-split-window-saved-configuration
             (current-window-configuration))
       (cond ((or (<= (* 0.9 fill-column) (/ (window-total-width) 2))
                  (<= (window-height) 20))
              (split 2)
              (setq this-command 'my-split-window-horizontally-1))
             (t
              (split 2 t)
              (setq this-command 'my-split-window-vertically-1)))))
    (other-window 1)))
