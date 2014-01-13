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

;; setting up `ein:console-security-dir' and `ein:console-args',
;; doesn't seem to work with `virtualenv' properly, maybe in future
;; releases.
(setq ein:console-security-dir '((8888 . "~/notebooks_dir/")))
(setq ein:console-args '("--existing"))

;; Investigation to set this variable is needes, perhaps multiple
;; directories can be used, one per virtualenv, trying to use
;; `$WORKON_HOME'
;; (shell-command-to-string ". ~/.zshrc; echo -n $WORKON_HOME")
;; (setq ein:console-executable '((8888 . "~")) )

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
     (define-key ein:notebook-mode-map (kbd "C-;")
       'ein:shared-output-pop-to-buffer)

     ;; Para evitar que 'desktop' destruya buffers relacionados con 'ein'.
     (eval-after-load 'desktop
       '(push "\\*ein:.*\\*" desktop-clear-preserve-buffers))
     ))

(provide 'ein-conf)
