
;; Para utilizar enclose-mode en todos los buffers
;; https://github.com/rejeep/enclose
(enclose-global-mode t)
(enclose-add-encloser "`" "`")
;; (enclose-add-encloser "$" "$")
(add-to-list 'enclose-except-modes 'dired-mode)

;; Se reindenta la línea después de insertar un caracter.
;; SE PUEDE ESPERAR QUE NECESITA CORRECCIÓN POSTERIOR, EN CASO DE QUE
;; SEA NECESARIO.
(defadvice enclose-trigger (after enclose-reindent-line activate)
  "Indenta la línea actual, sólo en los 'major-mode' apropiados"
  (if (member (buffer-local-value 'major-mode (current-buffer)) '(c++-mode))
      (indent-for-tab-command)))

(provide 'enclose-conf)
