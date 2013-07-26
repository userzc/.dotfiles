;; Se añade la librería "dired-x", extensiones necesarias por ejemplo
;; para abrir varios archivos marcados en dired mode, etc.
;; Se puede investigar cómo hacer algo similar con icicles
(add-hook 'dired-load-hook
          (function (lambda () (load "dired-x"))))

;; dired-details+
(require 'dired-details+)
(setq-default dired-details-hidden-string "--- " )

(provide 'dired-conf)
