;; https://github.com/Fuco1/smartparens
(smartparens-global-mode t)

(setq sp-ignore-modes-list
      '(ein:notebooklist-mode))

(sp-local-tag 'emacs-lisp-mode "`" "`" "'" :actions '(wrap))
(require 'smartparens-config)
(require 'smartparens-latex)

(provide 'smartparens-conf)
