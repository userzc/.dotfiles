;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUCTeX, RefTeX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; to use with auctex 11.87 compiled from cvs or submodule:
;; ./autogen.sh
;; ./configure
;; make
;; makeinstall
(condition-case nil (load "auctex.el" nil t t)
  (error (message "auctex.el not found")))
(condition-case nil (load "preview-latex.el" nil t t)
  (error (message "preview-latex.el not found")))

;; Para utilizar AUCTeX con documentos multi-arichivos, archivos de estilo
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; Para auto cargar RefTex con modos tipo LaTex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

;; Para utilizar RefTex con AUCTeX
(setq reftex-plug-into-AUCTeX t)

;; ;; Para utilizar Evince con archivos pdf
;; (setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
;; (setq TeX-view-program-selection '((output-pdf "Evince")))

;; Para habilitar correlación de manera automática
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;; (setq TeX-source-correlate-start-server t)

;; ;; (add-to-list 'LaTeX-verbatim-environments-local "comment")
;; (add-hook 'LaTeX-mode-hook
;; 	  (lambda ()
;; 	    (TeX-add-style-hook
;; 	     "listings"
;; 	     (lambda ()
;; 	       (add-to-list 'LaTeX-verbatim-environments-local "comment")))
;; 	    ))

;; ;; Para añadir ambiente comment a la lista verbatim
;; (TeX-add-style-hook
;;  "listings"
;;  (lambda ()
;;    (add-to-list 'LaTeX-verbatim-environments-local "comment")))


;; Para utilizar cleveref con RefTex
;; (add-to-list 'reftex-ref-style-alist
;;           '("Cleveref" "cleveref"
;;             (("\\cref" ?c) ("\\Cref" ?b)))) ; TODO crefrange
;; (setq reftex-ref-style-default-list '("Default" "Cleveref"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		  ;;
;; ;; ;; Configuraciones originales para Synctex y Evince ;;		  ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		  ;;
;; ;; En caso de necesitar utilizar versiones previas de AUCTeX, es	  ;;
;; ;; sufifiente con tener el archivo de la versión 11.86.1 (previo más	  ;;
;; ;; reciente comprobado en funcionar) y añadir lo siguiente antes de	  ;;
;; ;; hacer un `(package-initialize)':					  ;;
;; 									  ;;
;; ;; ;; hasta que se arregle la versión 11.87				  ;;
;; ;; (add-to-list 'package-load-list '(auctex "11.86.1"))		  ;;
;; 									  ;;
;; ;; después de lo cual se activa el código siguiente para que la	  ;;
;; ;; correlación funcione de manera apropiada.				  ;;
;; 									  ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;						  ;;
;; ;; sobre AUCTeX-11.86.1 ;;						  ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;						  ;;
;; ;; Se copió el paquete instalado a la carpeta			  ;;
;; ;; emacs.d/lisp/auctex-11.86.1/ para que se pueda recuperar en caso de ;;
;; ;; que la versión más actual de problemas				  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; Para intentar evitar que se cuelgue con synctex
;; (require 'tex)
;; (defun TeX-synctex-output-page ()
;;   "Return the page corresponding to the current source position.
;; This method assumes that the document was compiled with SyncTeX
;; enabled and the `synctex' binary is available."
;;   (let ((synctex-output
;;          (with-output-to-string
;;            (call-process "synctex" nil (list standard-output nil) nil "view"
;;                          "-i" (format "%s:%s:%s" (line-number-at-pos)
;;                                       (current-column)
;;                                       ;; The real file name (not symbolic) fixed
;;                                       ;; for the synctex path bug
;;                                       (concat (file-name-directory (file-truename (buffer-file-name)))
;;                                               "./"
;;                                               (file-name-nondirectory (buffer-file-name))))
;;                          "-o" (TeX-active-master (TeX-output-extension))))))
;;     (if (string-match "Page:\\([0-9]+\\)" synctex-output)
;;         (match-string 1 synctex-output)
;;       "1")))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Configuraciones tomadas de internet ; SyncTeX basics
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; un-urlify and urlify-escape-only should be improved to handle all special characters, not only spaces.
;; ;; The fix for spaces is based on the first comment on http://emacswiki.org/emacs/AUCTeX#toc20
;; (defun un-urlify (fname-or-url)
;;   "Transform file:///absolute/path from Gnome into /absolute/path with very limited support for special characters"
;;   (if (string= (substring fname-or-url 0 8) "file:///")
;;       (url-unhex-string (substring fname-or-url 7))
;;     fname-or-url))

;; (defun urlify-escape-only (path)
;;   "Handle special characters for urlify"
;;   (replace-regexp-in-string " " "%20" path))

;; (defun urlify (absolute-path)
;;   "Transform /absolute/path to file:///absolute/path for Gnome with very limited support for special characters"
;;   (if (string= (substring absolute-path 0 1) "/")
;;       (concat "file://" (urlify-escape-only absolute-path))
;;     absolute-path))

;; ;; SyncTeX backward search - based on http://emacswiki.org/emacs/AUCTeX#toc20, reproduced on http://tex.stackexchange.com/a/49840/21017
;; (defun th-evince-sync (file linecol &rest ignored)
;;   (let* ((fname (un-urlify file))
;;          (buf (find-file fname))
;;          (line (car linecol))
;;          (col (cadr linecol)))
;;     (if (null buf)
;;         (message "[Synctex]: Could not open %s" fname)
;;       (switch-to-buffer buf)
;;       (goto-line (car linecol))
;;       (unless (= col -1)
;;         (move-to-column col)))))

;; (defvar *dbus-evince-signal* nil)

;; (defun enable-evince-sync ()
;;   (require 'dbus)
;;   ;; cl is required for setf, taken from:
;;   ;; http://lists.gnu.org/archive/html/emacs-orgmode/2009-11/msg01049.html
;;   (require 'cl)
;;   (when (and
;;          (eq window-system 'x)
;;          (fboundp 'dbus-register-signal))
;;     (unless *dbus-evince-signal*
;;       (setf *dbus-evince-signal*
;;             (dbus-register-signal
;;              :session nil "/org/gnome/evince/Window/0"
;;              "org.gnome.evince.Window" "SyncSource"
;;              'th-evince-sync)))))

;; (add-hook 'LaTeX-mode-hook 'enable-evince-sync)

;; ;; SyncTeX forward search - based on
;; ;; http://tex.stackexchange.com/a/46157 universal time, need by evince
;; (defun utime ()
;;   (let ((high (nth 0 (current-time)))
;;         (low (nth 1 (current-time))))
;;     (+ (* high (lsh 1 16) ) low)))

;; ;; Forward search.  Adapted from
;; ;; http://dud.inf.tu-dresden.de/~ben/evince_synctex.tar.gz
;; (defun auctex-evince-forward-sync (pdffile texfile line)
;;   (let ((dbus-name
;;          (dbus-call-method :session
;;                            "org.gnome.evince.Daemon"  ; service
;;                            "/org/gnome/evince/Daemon" ; path
;;                            "org.gnome.evince.Daemon"  ; interface
;;                            "FindDocument"
;;                            (urlify pdffile)
;;                            t     ; Open a new window if the file is
;;                                         ; not opened.
;;                            )))
;;     (dbus-call-method :session
;;                       dbus-name
;;                       "/org/gnome/evince/Window/0"
;;                       "org.gnome.evince.Window"
;;                       "SyncView"
;;                       (urlify-escape-only texfile)
;;                       (list :struct :int32 line :int32 1)
;;                       (utime))))

;; (defun auctex-evince-view ()
;;   (let ((pdf (file-truename (concat default-directory
;;                                     (TeX-master-file (TeX-output-extension)))))
;;         (tex (buffer-file-name))
;;         (line (line-number-at-pos)))
;;     (auctex-evince-forward-sync pdf tex line)))

;; ;; New view entry: Evince via D-bus.
;; (setq TeX-view-program-list '())
;; (add-to-list 'TeX-view-program-list
;;              '("EvinceDbus" auctex-evince-view))

;; ;; Prepend Evince via D-bus to program selection list
;; ;; overriding other settings for PDF viewing.
;; (setq TeX-view-program-selection '())
;; (add-to-list 'TeX-view-program-selection
;;              '(output-pdf "EvinceDbus"))

(provide 'auctex-conf)
