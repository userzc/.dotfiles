;; https://github.com/Fuco1/smartparens
(smartparens-global-mode t)
;; La configuración por default de dicho paquete
(setq sp-ignore-modes-list
      '(ein:notebooklist-mode))

(require 'smartparens-config)
(require 'smartparens-latex)
(provide 'smartparens-conf)
