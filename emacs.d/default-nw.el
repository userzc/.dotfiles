;; loaded with options:
;; -nw -q -l default.el

;; Para cargar archivos en `~/.emacs.d'
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path "~/.emacs.d/defuns/")

;; Configuraciones personales por default
(require 'default-conf)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Considerar revisar la forma de personalizar la variable
;; package-load-list para no cargar demasiados paquetes

(setq package-load-list '((ac-math nil)
			  (ace-jump-mode t)
			  (ack-and-a-half t)
			  (auctex nil)
			  (auto-complete nil)
			  (bookmark+ t)
			  (c-eldoc t)
			  (cl-lib t)
			  (clues-theme nil)
			  (color-theme nil)
			  (color-theme-gruber-darker nil)
			  (color-theme-sanityinc-tomorrow nil)
			  (color-theme-solarized nil)
			  (color-theme-wombat+ nil)
			  (cyberpunk-theme nil)
			  (dash t)
			  (deferred t)
			  (dired+ t)
			  (dired-details t)
			  (dired-details+ t)
			  (dired-x t)
			  (ein nil)
			  (enclose t)
			  (expand-region t)
			  (git-commit-mode t)
			  (git-rebase-mode t)
			  (gitconfig-mode t)
			  (github-theme nil)
			  (gitignore-mode t)
			  (google-c-style t)
			  (google-contacts t)
			  (icicles nil)
			  (icomplete+ t)
			  (ido-better-flex t)
			  (magit t)
			  (mark-more-like-this nil)
			  (markdown-mode t)
			  (monokai-theme nil)
			  (multi-term t)
			  (multiple-cursors t)
			  (nose t)
			  (oauth2 t)
			  (popup t)
			  (purty-mode t)
			  (python t)
			  (qsimpleq-theme nil)
			  (rainbow-delimiters t)
			  (rainbow-mode t)
			  (request t)
			  (s t)
			  (smart-mode-line nil)
			  (smart-tab t)
			  (smartparens t)
			  (tango-2-theme nil)
			  (tangotango-theme nil)
			  (textile-mode t)
			  (websocket nil)
			  (wgrep t)
			  (windsize t)
			  (wrap-region t)
			  (yasnippet t)
			  (zenburn-theme nil)
			  (emmet-mode t)
			  (powerline nil)
			  (js2-mode t)
			  (js2-refactor t)))

(package-initialize)

;; Default custom file
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

;; Configuración para diferentes archivos
(require 'automodes-conf)

;; Funciones para edición
(require 'defuns)

;; Librerias requeridas
(require 'cl)
(require 'misc)
(require 'ace-jump-mode)
(require 'smart-tab)
(require 'expand-region)
(require 'markdown-mode)
(require 'textile-mode)
(require 'windsize)
(require 'multiple-cursors)
;; (require 'yasnippet)


;; configuraicones de librerias
;; (require 'enclose-conf)
;; (require 'wrap-region-conf)
(require 'smartparens-conf)
(require 'ido-conf)
(require 'mail-conf)
(require 'dired-conf)
;; (require 'yasnippet-conf)
(require 'js2-mode)

(load-theme 'tango-dark)

(require 'keybinds-conf)
