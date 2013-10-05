;; https://github.com/bbatsov/projectile

;; para que esto funcione, no se debe hacer `require' de projectile
;; antes de que se ejecute la siguiente instrucción, de lo contrario
;; habría que hacer un remap con todas las funciones de `projectile'
;; en un `eval-after-load'.
(setq-default projectile-keymap-prefix (kbd "C-c f"))

(add-hook 'python-mode-hook 'projectile-on)

(provide 'projectile-conf)
