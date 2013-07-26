
;; para utilizar desktop y se guarden los ultimos buffers que se editaban
(desktop-save-mode 1)
(add-to-list 'desktop-minor-mode-table '(icicle-mode nil))
(add-to-list 'desktop-minor-mode-handlers  '(icicle-mode . nil))
;; (add-to-list 'desktop-minor-mode-table (icy-mode nil))

(provide 'desktop-conf)
