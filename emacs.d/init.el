;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Se inicia de nuevo con emacs 24	       ;;
;; tested on emacs-version "24.3.1"	       ;;
;; semi-fuctional on emacs-version "24.3.50.1" ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Para deshabilitar tool-bar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; Emacs gurus don't need no stinking scroll bars
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)


(defvar lista-paquetes-instalados
  '(ac-math ace-jump-mode ack-and-a-half auctex auto-complete bookmark+
	    c-eldoc cl-lib clues-theme color-theme color-theme-gruber-darker
	    color-theme-sanityinc-tomorrow color-theme-solarized
	    color-theme-wombat+ cyberpunk-theme dash deferred dired+
	    dired-details dired-details+ ein enclose expand-region
	    git-commit-mode gitconfig-mode github-theme gitignore-mode
	    google-c-style google-contacts icicles icomplete+ ido-better-flex
	    magit mark-more-like-this markdown-mode melpa monokai-theme
	    multi-term multiple-cursors nose oauth2 popup powerline purty-mode
	    python qsimpleq-theme rainbow-delimiters rainbow-mode request
	    smart-mode-line smart-tab smartparens sublime-themes tango-2-theme
	    tangotango-theme textile-mode websocket wgrep windsize wrap-region
	    yasnippet zenburn-theme zencoding-mode)
  "Lista de paquetes instalados actualmente en mi configuración.")

;; ;; esta parte es para comprobar que paquetes están installados
;; (loop for p in lista-paquetes-instalados
;;       when (package-installed-p p) do
;;       (print p))

;; Default custom file
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

(require 'cl)

;; Intentando nueva forma para descargar paquetes, basado en
;; https://github.com/purcell/emacs.d y
;; https://github.com/magnars/.emacs.d/blob/master/setup-package.el
(unless (file-exists-p "~/.emacs.d/elpa/archives/melpa")
  (package-refresh-contents))


;; workaround to get package archive's update in emacs-snapshot taken
;; from:
;; https://github.com/LiaoPengyu/emacs.d/blob/fc7a6fedb5c496c613d6d19a4fcdab18b36a8d87/init-elpa.el
(defvar package-filter-function nil
  "Optional predicate function used to internally filter packages
  used by package.el.

The function is called with the arguments PACKAGE VERSION ARCHIVE
where PACKAGE is a symbol, VERSION is a vector as produced by
`version-to-list', and ARCHIVE is the string name of the package
archive.")

(defadvice package--add-to-archive-contents
  (around filter-packages (package archive) activate)
  "Add filtering of available packages using
`package-filter-function', if non-nil."
  (when (or (null package-filter-function)
	    (funcall package-filter-function
		     (car package)
		     (funcall (if (fboundp 'package-desc-version)
				  'package--ac-desc-version
				'package-desc-vers)
			      (cdr package))
		     archive))
    ad-do-it))

(setq package-filter-function
      (lambda (package version archive)
	(and
	 (not (memq package '(eieio)))
	 (or (not (string-equal archive "melpa"))
	     (not (memq package '(slime)))))))

(defun packages-install (packages)
  "Función para determinar si todos los paquetes de la lista de
paquetes están instalados en la máquina actual."
  (loop for p in packages
        when (not (package-installed-p p)) do (package-install p)
        finally (return t)))

;; On-demand installation of packages
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(defun init--install-packages ()
  (packages-install
   lista-paquetes-instalados))

(package-initialize)

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))


;; Para cargar archivos en `~/.emacs.d'
(add-to-list 'load-path user-emacs-directory)

;; Configuración para diferentes tipos de archivos
(require 'automodes-conf)

;; Configuraciones personales por default
(require 'default-conf)

;; Funciones para edición
(require 'defuns)

;; julia-mode
(add-to-list 'load-path "~/julia_test/julia/contrib/")
(condition-case nil
    (require 'julia-mode)
  (error
   (message "Didn't find Julia Mode")))

;; Al parecer las siguientes lineas hacen que cualquier subdirectorio
;; de la carpeta "~/.emacs.d/lisp/" sea cargada al load-path, lo cual
;; es necesario para los paquetes:
;; - nxhtml     : se obtiene mumamo-mode y más.
;; - linkd      : Drew Adams lo utiliza p/documentaciones de sus paquetes
(add-to-list 'load-path "~/.emacs.d/lisp/")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; La siguiente opción se añade para poder utilizar emacs como servidor
;; en particular en ipython y en octave
(server-start)

;; Required libraries
(require 'misc)
(require 'bookmark+)
(require 'expand-region)
(require 'zencoding-mode)
(require 'magit)
(require 'ace-jump-mode)
(require 'multiple-cursors)
(require 'python)
(require 'smart-tab)
(require 'windsize)
(require 'markdown-mode)
(require 'textile-mode)
(require 'dired+)
(require 'nose)
(require 'yasnippet)

;; Configuraciones de las librerías anteriores

(require 'smartparens-conf)
;; (require 'enclose-conf)
;; (require 'wrap-region-conf)
(require 'c-conf)
(require 'dired-conf)
(require 'icicles-conf)
(require 'yasnippet-conf)
(require 'desktop-conf)
(require 'icomplete-conf)
(require 'ack-conf)
(require 'magit-conf)
(require 'multi-term-conf)
(require 'mail-conf)
(require 'auto-complete-conf)
(require 'nxhtml-conf)
(require 'emaxima-conf)
(require 'python-conf)
(require 'ein-conf)
(require 'org-conf)
(require 'auctex-conf)
(require 'smart-hippie-conf)
(require 'load-theme-conf)
(require 'powerline-conf)

;; font
(if (equal system-type 'gnu/linux)
    (condition-case nil
	(set-default-font "Ubuntu Mono-11")
      (error
       (set-default-font "Inconsolata-11")))
  (condition-case nil
      (set-default-font "Inconsolata-11")
    (error
     (set-default-font "DejaVu Sans Mono-10"))))

(require 'keybinds-conf)
