;; Por alguna razón emacs no está haciendo caso de la configuración de
;; auto-mode-alist, así que se añade un hook para cambiar el major-mode
(add-hook 'js2-mode-hook 'ac-js2-mode)

(setq js2-highlight-level 3)

;; Activar jasmine en js2-mode
(add-hook 'js2-mode-hook '(lambda () (jasminejs-mode)))

;; Activar jasmine en js2-mode
(add-hook 'js2-mode-hook '(lambda () (subword-mode 1)))

(provide 'js2-conf)
