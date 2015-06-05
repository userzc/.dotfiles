;; https://github.com/Fuco1/smartparens
(smartparens-global-mode t)

(setq sp-ignore-modes-list
      '(ein:notebooklist-mode speedbar-mode))

(sp-local-pair 'emacs-lisp-mode  "`" "'" :wrap "`")
(sp-local-pair 'org-mode  "*" "*" :wrap "*")
(sp-local-pair 'org-mode  "=""=" :wrap "=")
(sp-local-pair 'org-mode  "~""~" :wrap "~")

(require 'smartparens-config)
(require 'smartparens-latex)

(provide 'smartparens-conf)
