;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Se inicia de nuevo con emacs 25             ;;
;; tested on emacs-version "25.2.2"            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; (add-to-list 'load-path user-emacs-directory) ;Cargar archivos en `~/.emacs.d'
(add-to-list 'load-path "~/.emacs.d/settings-lisp/")

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Considerar instalar: ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; - `readline-complete':
;; https://github.com/emacsmirror/readline-complete/blob/master/readline-complete.el
;; parece que es una alternativa para generar opciones para
;; complementar con `zsh' y `multi-term'
;; - `showkey'

(defvar lista-paquetes-instalados
  '(ac-js2 ac-math ag all-the-icons auctex auto-complete avy
           badwolf-theme c-eldoc cedit cl-lib command-log-mode company dash
           deferred dockerfile-mode editorconfig ein elpy emmet-mode enclose
           exec-path-from-shell expand-region f feature-mode flx-ido
           flycheck-yamllint git-modes google-c-style google-contacts gradle-mode
           gradle-mode groovy-mode hgignore-mode jasminejs-mode java-snippets
           javadoc-lookup js-doc js2-mode js2-refactor litable lorem-ipsum magit
           magit-gitflow makey markdown-mode mermaid-mode monky monokai-theme
           multi-term multiple-cursors neotree nvm oauth2 org-bullets
           poly-markdown popup powerline powershell projectile purty-mode
           python-django rainbow-delimiters rainbow-mode request restclient
           scss-mode smart-mode-line smart-tab smartparens spacegray-theme
           sql-indent sr-speedbar sublime-themes tango-2-theme tangotango-theme
           textile-mode tide virtualenvwrapper web-mode websocket wgrep wgrep-ag
           windsize wrap-region yaml-mode yasnippet yasnippet-snippets
           zenburn-theme)
  "Lista de paquetes instalados actualmente en mi configuración.")

(setq el-get-paquetes-instalados
      '(bookmark+ dired-details+ icicles icomplete+ ox-ioslide ox-twbs))

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
;; - linkd      : Drew Adams lo utiliza p/documentaciones de sus paquetes
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/defuns/")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'default-conf) ;Configuraciones personales por default

(require 'package-conf) ;Configuración para paquetes

;; Configuración para exec-path-from-shell
;; ver: https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'automodes-conf) ;Configuración para diferentes tipos de archivos
(require 'defuns) ;Funciones para edición

;; La siguiente opción se añade para poder utilizar emacs como servidor
;; en particular en ipython y en octave
(require 'server)
(unless (server-running-p) (server-start))

;; Configuraciones para instalar paquetes que sólo están en emacswiki
;; (mediante emacsmirror)
;; TODO: mover dependencias ox-ioslide a el-get (f makey)
(require 'el-get-conf)

;; required libraries
(require 'misc)
(require 'wgrep)
(require 'bookmark+)
(require 'expand-region)
(require 'emmet-mode)
(require 'magit)
(require 'monky)
(require 'avy)
(require 'multiple-cursors)
(require 'python)
;; (require 'nose)
(require 'smart-tab)
(require 'windsize)
(require 'markdown-mode)
(require 'textile-mode)
;; (require 'dired+)
(require 'yasnippet)
(require 'python-django)
(require 'powerline)
(require 'projectile)
(require 'smart-mode-line)
;; (require 'zone-matrix)
(require 'speedbar)
(require 'js2-refactor)
(require 'taskjuggler-mode)
(require 'recentf)
(require 'web-mode)
(require 'poly-markdown)
;; (require 'jdee)

(condition-case nil
    (require 'drools-mode)
  (error
   "Something wrong"
   (message "-- Cannot load Drools Mode")))

;; Configuraciones de las librerías anteriores
(require 'smartparens-conf)
(require 'c-conf)
(require 'dired-conf)
(require 'icicles-conf)
(require 'yasnippet-conf)
;; (require 'desktop-conf)
(require 'icomplete-conf)
;; (require 'ack-conf)
(require 'magit-conf)
(require 'monky-conf)
(require 'multi-term-conf)
(require 'mail-conf)
(require 'auto-complete-conf)
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
;; (require 'malabar-conf )
;; (require 'powerline-conf)
(require 'jdee-conf)
(require 'smart-mode-line-conf)
(require 'drools-conf)
;; (require 'emms-conf)
(require 'sr-speedbar-conf)
(require 'js2-conf)
(require 'js2r-conf)
(require 'recentf-conf)
(require 'neotree-conf)
(require 'css-conf)
(require 'flyspell-conf)
(require 'tide-conf)
(require 'jasminejs-conf)
(require 'sql-conf)
(require 'nvm-conf)

(require 'keybinds-conf)
