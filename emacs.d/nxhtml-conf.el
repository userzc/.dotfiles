;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nXhtml, ver: http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Se puede cambiar la versión compilada de este archivo por la
;; extención sin compilar [.elc <=> .el]

;; (load "~/.emacs.d/lisp/nxhtml/autostart.elc")
(load "~/.emacs.d/lisp/nxhtml/autostart.el")

(setq debug-on-error nil)
(setq mumamo-background-colors nil)

;; Esta parte en particular no la he podido hechar a andar para
;; probarla con ein-mode para IPython Notebook, hace falta checar que
;; se puede hacer con la siguiente línea de código.
;; ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;; Para activar nXhtml, en particular para utilizar MuMaMo,
;; (require 'nxhtml-autostart)

;; Como alternativa se puede utilizar un archivo `.dir-locals.el' para
;; definir variables locales con el siguiente código:
;; ((html-mode . ((eval . (django-html-mumamo-mode)))))

;; ;; `C-d' to terminate process and kill buffer in shell buffers,
;; ;; ver: http://whattheemacsd.com/setup-shell.el-01.html
;; (defun comint-delchar-or-eof-or-kill-buffer (arg)
;;   (interactive "p")
;;   (if (null (get-buffer-process (current-buffer)))
;;       (kill-buffer)
;;     (comint-delchar-or-maybe-eof arg)))

(provide 'nxhtml-conf)
