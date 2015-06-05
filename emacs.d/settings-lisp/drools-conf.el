;; This is a first config version to test drools-mode and possibly
;; improve IT

(add-to-list 'auto-mode-alist '("\\.drl$" . drools-mode))
(add-to-list 'auto-mode-alist '("\\.dslr$" . drools-mode))

(provide 'drools-conf)
