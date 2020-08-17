(require 'color)

(defun my-read-font-family ()
  (interactive)
  (let ((res (completing-read "Font Family: " (cl-remove-duplicates (font-family-list)) nil t))
        (outputfn (if (called-interactively-p 'any) (lambda (s) (insert "\"" s "\"")) 'identity)))
    (funcall outputfn res)))

(defun my-generate-random-str (len)
  (interactive (list (read-number "length : ")))
  (let* ((chars (string-to-vector "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKMNLOPQRSTUVWXYZ_"))
         (max (length chars))
         (lst (make-list len nil))
         (str (mapconcat (lambda (x) (char-to-string (aref chars (random max)))) lst ""))
         (outputfn (if (called-interactively-p 'any) 'insert 'identity)))
    (funcall outputfn str)))

;; hexify 0-255 colorname
(defun my-make-color-name (r g b)
  (interactive (list (read-number "R: ") (read-number "G: ") (read-number "B: ")))
  (funcall (if (called-interactively-p 'any) 'insert 'identity)
           (color-rgb-to-hex (/ r 255.0) (/ g 255.0) (/ b 255.0) 2)))
