;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Se inicia de nuevo con emacs 24	       ;;
;; tested on emacs-version "24.3.1"	       ;;
;; semi-fuctional on emacs-version "24.3.50.1" ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path user-emacs-directory) ;Cargar archivos en `~/.emacs.d'

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Considerar instalar: ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; - `cedit': https://github.com/zk-phi/cedit, al
;; parecer funciona de manera adecuada con paredit
;; - `emmet': https://github.com/smihica/emmet-mode, al parecer debe de
;; sustiruir `zencoding-mode' pues zencoding cambió de nombre a emmet,
;; se añaden nuevas funcionalidades
;; - `readline-complete':
;; https://github.com/emacsmirror/readline-complete/blob/master/readline-complete.el
;; parece que es una alternativa para generar opciones para
;; complementar con `zsh' y `multi-term'

(defvar lista-paquetes-instalados
  '(ac-math ace-jump-mode ack-and-a-half ag auctex auto-complete
	 bookmark+ c-eldoc cl-lib clues-theme color-theme
	 color-theme-gruber-darker color-theme-sanityinc-tomorrow
	 color-theme-solarized color-theme-wombat+ cyberpunk-theme dash
	 deferred dired+ dired-details dired-details+ ein enclose
	 expand-region git-commit-mode gitconfig-mode github-theme
	 gitignore-mode google-c-style google-contacts gruvbox-theme
	 icicles icomplete+ ido-better-flex magit mark-more-like-this
	 markdown-mode melpa monokai-theme multi-term multiple-cursors
	 nose oauth2 popup powerline projectile purty-mode python-django
	 qsimpleq-theme rainbow-delimiters rainbow-mode request
	 smart-mode-line smart-tab smartparens sublime-themes
	 tango-2-theme tangotango-theme textile-mode websocket wgrep
	 windsize wrap-region yasnippet zenburn-theme zencoding-mode
	 zone-matrix)
  "Lista de paquetes instalados actualmente en mi configuración.")

;; Default custom file
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

(require 'default-conf) ;Configuraciones personales por default
(require 'package-conf) ;Configuración para paquetes
(require 'automodes-conf) ;Configuración para diferentes tipos de archivos
(require 'defuns) ;Funciones para edición

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
(require 'server)
(unless (server-running-p) (server-start))

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
(require 'python-django)
(require 'powerline)
(require 'projectile)
(require 'smart-mode-line)
(require 'zone-matrix)

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
(require 'zone-matrix-conf)
(require 'load-theme-conf)
(require 'projectile-conf)
;; (require 'powerline-conf)
(require 'smart-mode-line-conf)

(require 'keybinds-conf)
