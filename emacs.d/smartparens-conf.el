;; https://github.com/Fuco1/smartparens
(smartparens-global-mode t)

(setq sp-ignore-modes-list
      '(ein:notebooklist-mode))

(require 'smartparens-config)
(require 'smartparens-latex)

(provide 'smartparens-conf)
