;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Se inicia de nuevo con emacs 24             ;;
;; tested on emacs-version "24.3.1"            ;;
;; semi-fuctional on emacs-version "24.3.50.1" ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path user-emacs-directory) ;Cargar archivos en `~/.emacs.d'

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Considerar instalar: ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; - `readline-complete':
;; https://github.com/emacsmirror/readline-complete/blob/master/readline-complete.el
;; parece que es una alternativa para generar opciones para
;; complementar con `zsh' y `multi-term'
;; - `hgignore-mode'
;; - `showkey'

(defvar lista-paquetes-instalados
  '(ac-js2 ac-math ace-jump-mode ack-and-a-half ag ample-zen-theme
	auctex auto-complete base16-theme bookmark+ c-eldoc cedit
	cl-lib clues-theme color-theme color-theme-gruber-darker
	color-theme-sanityinc-tomorrow command-log-mode
	cyberpunk-theme dash deferred dired+ dired-details
	dired-details+ ein emacs-eclim emmet-mode enclose
	expand-region feature-mode git-commit-mode gitconfig-mode
	github-theme gitignore-mode google-c-style
	google-contacts gruvbox-theme icicles icomplete+
	ido-better-flex java-snippets js2-mode js2-refactor
	litable lorem-ipsum magit mark-more-like-this
	markdown-mode material-theme moe-theme monky
	monokai-theme multi-term multiple-cursors niflheim-theme
	nose oauth2 ox-ioslide popup powerline projectile
	purty-mode python-django qsimpleq-theme
	rainbow-delimiters rainbow-mode request scss-mode
	smart-mode-line smart-tab smartparens solarized-theme
	spacegray-theme sr-speedbar sublime-themes tango-2-theme
	tangotango-theme textile-mode ubuntu-theme websocket
	wgrep wgrep-ag windsize wrap-region yaml-mode yasnippet
	zenburn-theme zone-matrix)
  "Lista de paquetes instalados actualmente en mi configuración.")

;; Default custom file
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

;; varialbes:
;; `HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\AutoRun'
;; `HKEY_CURRENT_USER\Software\Microsoft\Command Processor\AutoRun'
;; Maybe that is the place to add some paths to `git' and other
;; programs that don't seem to be working properly


;; Al parecer las siguientes lineas hacen que cualquier subdirectorio
;; de la carpeta "~/.emacs.d/lisp/" sea cargada al load-path, lo cual
;; es necesario para los paquetes:
;; - nxhtml     : se obtiene mumamo-mode y más.
;; - linkd      : Drew Adams lo utiliza p/documentaciones de sus paquetes
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/defuns/")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))


(require 'default-conf) ;Configuraciones personales por default
(require 'package-conf) ;Configuración para paquetes
(require 'automodes-conf) ;Configuración para diferentes tipos de archivos
(require 'defuns) ;Funciones para edición

;; La siguiente opción se añade para poder utilizar emacs como servidor
;; en particular en ipython y en octave
(require 'server)
(unless (server-running-p) (server-start))

;; Required libraries
(require 'misc)
(require 'wgrep)
(require 'bookmark+)
(require 'expand-region)
(require 'emmet-mode)
(require 'moe-theme)
(require 'magit)
(require 'monky)
(require 'ace-jump-mode)
(require 'multiple-cursors)
(require 'python)
(require 'nose)
(require 'smart-tab)
(require 'windsize)
(require 'markdown-mode)
(require 'textile-mode)
(require 'dired+)
(require 'yasnippet)
(require 'python-django)
(require 'powerline)
(require 'projectile)
(require 'smart-mode-line)
;; (require 'zone-matrix)
(require 'speedbar)
(require 'js2-refactor)
;; (require 'org)
;; (require 'eclim)
(require 'taskjuggler-mode)

(condition-case nil (require 'malabar-mode)
  (error
   (message "Malabar mode not found")))

(condition-case nil
    (require 'drools-mode)
  (error
   "Something wrong"
   (message "-- Cannot load Drools Mode")))

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
(require 'monky-conf)
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
;; (require 'zone-matrix-conf)
(require 'load-theme-conf)
(require 'projectile-conf)
(require 'groovy-conf)
;; (require 'eclim-conf)
;; (require 'malabar-conf )
;; (require 'powerline-conf)
(require 'smart-mode-line-conf)
(require 'drools-conf)
(require 'sr-speedbar-conf)
(require 'js2-conf)

(require 'keybinds-conf)
