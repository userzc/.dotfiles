;; https://github.com/bbatsov/projectile

;; para que esto funcione, no se debe hacer `require' de projectile
;; antes de que se ejecute la siguiente instrucción, de lo contrario
;; habría que hacer un remap con todas las funciones de `projectile'
;; en un `eval-after-load'.
;; (setq-default projectile-keymap-prefix (kbd "C-c f"))

;; El sistema default permite la interacción con `iciciles', aún hay
;; que probar más detalladamente este comportamiento
(setq projectile-completion-system 'default)

(add-hook 'python-mode-hook 'projectile-mode)
(add-hook 'LaTeX-mode-hook 'projectile-mode)
(add-hook 'rst-mode-hook 'projectile-mode)
(add-hook 'c++-mode-hook 'projectile-mode)
(add-hook 'java-mode-hook 'projectile-mode)
(add-hook 'nxml-mode-hook 'projectile-mode)
(add-hook 'html-mode-hook 'projectile-mode)
(add-hook 'drools-mode-hook 'projectile-mode)
(add-hook 'malabar-groovy-mode-hook 'projectile-mode)
(add-hook 'js2-mode-hook 'projectile-mode)
(add-hook 'org-mode-hook 'projectile-mode)

;; Ya se tiene bien configurado git en Windows, se puede confiar en
;; este método de indexado
(setq projectile-indexing-method 'alien)

(provide 'projectile-conf)
