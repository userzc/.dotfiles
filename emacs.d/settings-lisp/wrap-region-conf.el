
;; Para utilizar wrap-region-mode en todos los buffers
;; https://github.com/rejeep/wrap-region
;; Al parecer tengo que utilizar el paquete "cl" para que funcione
;; de manera correcta
;; (require 'cl)
(wrap-region-global-mode t)
(wrap-region-add-wrapper "*" "*" nil 'org-mode)
(wrap-region-add-wrapper "/" "/" nil 'org-mode)
(wrap-region-add-wrapper "_" "_" nil 'org-mode)
(wrap-region-add-wrapper "`" "`" nil '(gfm-mode markdown-mode emacs-lisp-mode))
(wrap-region-add-wrapper "$" "$" nil '(python-mode markdown-mode latex-mode))

;; TODO: hay un problema con smartparens-mode en latex-mode, algo parece
;; interferir con la generación del par "\[\]"

(add-to-list 'wrap-region-except-modes 'ibuffer-mode)
(add-to-list 'wrap-region-except-modes 'term-mode)

(provide 'wrap-region-conf)
