;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuración de js2 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Por alguna razón emacs no está haciendo caso de la configuración de
;; auto-mode-alist, así que se añade un hook para cambiar el major-mode
(add-hook 'js2-mode-hook 'ac-js2-mode)

;; Indentación de javascript
;; https://github.com/standard/standard
(setq js-indent-level 2)

(setq js2-highlight-level 3)

;; Activar jasmine en js2-mode
(add-hook 'js2-mode-hook '(lambda () (jasminejs-mode)))

;; Activar subword-mode en js2-mode
(add-hook 'js2-mode-hook '(lambda () (subword-mode 1)))

(add-hook 'js2-mode-hook
          #'(lambda ()
              (define-key js2-mode-map (kbd "C-M-S-i") 'js-doc-insert-function-doc)
              ;; (define-key js2-mode-map "@" 'js-doc-insert-tag)
              ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuración de tide (TypeScript) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq typescript-indent-level 2)

(add-hook 'tide-mode-hook '(lambda () (subword-mode 1)))

(setq
 tide-format-options
 '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions
   t
   :placeOpenBraceOnNewLineForFunctions
   nil
   :indentsize
   2
   :tabSize
   2))


(provide 'js2-conf)
