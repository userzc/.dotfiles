;; Se añade la librería "dired-x", extensiones necesarias por ejemplo
;; para abrir varios archivos marcados en dired mode, etc.
;; Se puede investigar cómo hacer algo similar con icicles
(add-hook 'dired-load-hook
          (function (lambda () (load "dired-x"))))

;; Dired listing options
(setq dired-listing-switches "-alh --group-directories-first")

;; dired-details+ conf if dired-details is available
(if (equal emacs-version "25.2.2")
    (progn
      (require 'dired-details+)
      (setq-default dired-details-hidden-string "--- " )))


(provide 'dired-conf)
