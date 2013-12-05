;; https://github.com/Fuco1/smartparens
(smartparens-global-mode t)
;; La configuración por default de dicho paquete se puede intentar
;; ignorar el minibuffer, `minibuffer-inactive-mode'
(setq sp-ignore-modes-list
      '(ein:notebooklist-mode minibuffer-inactive-mode))

(require 'smartparens-config)
(require 'smartparens-latex)

(provide 'smartparens-conf)
