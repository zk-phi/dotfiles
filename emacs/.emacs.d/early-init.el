;; disable some expensive features before GUI starts up
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(setq frame-inhibit-implied-resize t)

;; disable package
(setq package-enable-at-startup nil)

;; ignore x session resources for slight speed-up
(advice-add 'x-apply-session-resources :override 'ignore)
