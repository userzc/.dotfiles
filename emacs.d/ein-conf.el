;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ein, emacs ipython notebook
;; http://tkf.github.com/emacs-ipython-notebook/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; para intentar corregir el problema con mumamo
;; (defadvice ein:url-no-cache
;;   (around ein:url-no-cache-no (url) activate)
;;   "do not use jquery-like caching workaround."
;;   (setq ad-return-value url))

;; use `multilang-mode' based notebook mode (mode defined in `ein')
;; when mumamo is not installed
(setq ein:notebook-modes
      '(ein:notebook-mumamo-mode ein:notebook-multilang-mode))

;; (eval-after-load "ein:notebooklist"
;;   '(progn
;;      (hl-line-mode 1)))

;; hilight current line in ein:notebooklist-mode
(add-hook 'ein:notebooklist-mode-hook
	  '(lambda ()
	     (hl-line-mode 1)))

;; Se aumenta a un valor conveniente para utilizar el kernel
(setq ein:query-timeout 60000)
(setq ein:use-auto-complete-superpack t)
(setq ein:complete-on-dot nil)

;; Workaround the annoying warnings:
;;    Warning (mumamo-per-buffer-local-vars):
;;    Already 'permanent-local t: buffer-file-name
(when (and (>= emacs-major-version 24)
           (>= emacs-minor-version 2))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

;; Se intenta con esta nueva opción
(add-hook 'ein:shared-output-mode-hook
          '(lambda ()
             (define-key ein:shared-output-mode-map (kbd "q") 'quit-window)))

;; Se intenta agregar sources para auto-complete para el modo ein en
;; la variable ein:ac-sources, su valor usual es:
;; (ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers)
;; (setq ein:ac-sources '(ac-source-yasnippet ac-source-abbrev
;;       ac-source-dictionary ac-source-words-in-same-mode-buffers))


(eval-after-load "ein-notebook"
  '(progn
     ;; se desaactivan movimientos entre celdas para que no interfiera con
     ;; el movimiento entre `windows' de emacs, hay que modificar el key-map
     ;; ein:notebook-mode-map
     (define-key ein:notebook-mode-map [C-down] nil)
     (define-key ein:notebook-mode-map [C-up] nil)

     ;; estos movimientos son remapeados a la tecla shift para no perder
     ;; esta funcionalidad
     (define-key ein:notebook-mode-map [S-down] 'ein:worksheet-goto-next-input)
     (define-key ein:notebook-mode-map [S-up] 'ein:worksheet-goto-prev-input)
     (define-key ein:notebook-mode-map (kbd "C-;")
       'ein:shared-output-pop-to-buffer)

     ;; Para evitar que 'desktop' destruya buffers relacionados con 'ein'.
     (eval-after-load 'desktop
       '(push "\\*ein:.*\\*" desktop-clear-preserve-buffers))
     ))

(provide 'ein-conf)
