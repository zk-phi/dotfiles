(eval-when-compile
  (require 'subr-x))

;; reference | http://github.com/milkypostman/dotemacs/init.el
(defun my-rename-current-buffer-file ()
  "Rename current buffer file."
  (interactive)
  (if-let ((oldname (buffer-file-name))
           (newname (read-file-name "New name: " nil oldname)))
          (if (get-file-buffer newname)
              (error "A buffer named %s already exists." newname)
            (rename-file oldname newname 0)
            (rename-buffer newname)
            (set-visited-file-name newname)
            (set-buffer-modified-p nil)
            (message "Successfully renamed to %s." (file-name-nondirectory newname)))
          (error "Not a file buffer.")))

;; reference | http://d.hatena.ne.jp/IMAKADO/20090215/1234699972
(defun my-toggle-transparency ()
  "Toggle transparency."
  (interactive)
  (let* ((current-alpha (or (cdr (assoc 'alpha (frame-parameters))) 100))
         (new-alpha (cl-case current-alpha ((100) 93) ((93) 91) ((91) 78) ((78) 66) ((66) 50) (t 100))))
    (set-frame-parameter nil 'alpha new-alpha)))

;; URL encode / decode region
(defun my-url-decode-region (beg end)
  "Decode region as hexified string."
  (interactive "r")
  (let ((str (buffer-substring beg end)))
    (delete-region beg end)
    (insert (decode-coding-string (url-unhex-string str) 'utf-8))))
(defun my-url-encode-region (beg end)
  "Hexify region."
  (interactive "r")
  (let ((str (buffer-substring beg end)))
    (delete-region beg end)
    (insert (url-hexify-string (encode-coding-string str 'utf-8)))))

;; byte-compile directory recursively
(defun my-byte-compile-dir (dir)
  (interactive (list (read-directory-name "DIR: ")))
  (let ((errors nil))
    (dolist (file (directory-files-recursively dir "\\.el$"))
      (unless (ignore-errors (byte-compile-file file))
        (push file errors)))
    (message "Following files have failed to compile: %s"
             (mapcar (lambda (x) (file-name-nondirectory x)) errors))))

(defun my-async-shell-command (command)
  (interactive (list (read-string "Async shell command : ")))
  (let ((buf (generate-new-buffer (format "*%s*" command))))
    (save-window-excursion
      (async-shell-command command buf))
    (with-selected-window (split-window-vertically -15 (frame-root-window))
      (switch-to-buffer buf))))
