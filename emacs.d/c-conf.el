
;; Para cargar google c style:

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
;; If you want the RETURN key to go to the next line and space over
;; to the right place, add this to your .emacs right after the load-file:
;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; Al parecer es en c++-mode-map que se deben de añadir las cosas, en
;; caso de que empiece a hacer considerablemente grande la lista de
;; configuraciones para los modos relacionados con C, es preferible
;; definir una función con un nombre particular en lugar de usar la
;; función "lambda"
(add-hook 'c-initialization-hook
          '(lambda ()
             (define-key c++-mode-map (kbd "C-c C-c") 'compile)
             (define-key c++-mode-map (kbd "C-c C-r") 'recompile)))

;; c-eldoc
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
(add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)

(provide 'c-conf)
