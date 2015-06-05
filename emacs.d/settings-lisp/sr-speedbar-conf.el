;; configure `sr-speedbar' on the right, this is the default but I
;; keep the file for future refences
(setq speedbar-use-images nil)
;; (setq sr-speedbar-right-side t)

;; Don't refresh unless I want to, there should also be a way to
;; refresh only if in a tree structure different than the one
;; currrently displayed
(setq sr-speedbar-auto-refresh nil)

(speedbar-add-supported-extension ".drl")
(speedbar-add-supported-extension ".xml")
(speedbar-add-supported-extension ".groovy")

(provide 'sr-speedbar-conf)
