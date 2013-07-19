;; loaded with options:
;; -nw -q -l default.el

;; Se inicia de nuevo con emacs 24
;; tested on emacs-version "24.3.1"
;; not working on emacs-version "24.3.50.1"
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

;; Considerar revisar la forma de personalizar la variable
;; package-load-list para no cargar demasiados paquetes

(setq package-load-list '((ac-math nil)
			  (ace-jump-mode t)
			  (ack-and-a-half t)
			  (auctex nil)
			  (auto-complete nil)
			  (bookmark+ t)
			  (c-eldoc nil)
			  (cl-lib t)
			  (clues-theme t)
			  (color-theme t)
			  (color-theme-gruber-darker t)
			  (color-theme-sanityinc-tomorrow t)
			  (color-theme-solarized t)
			  (color-theme-wombat+ t)
			  (cyberpunk-theme t)
			  (dash t)
			  (deferred t)
			  (dired+ t)
			  (dired-details t)
			  (dired-details+ t)
			  (ein nil)
			  (enclose t)
			  (expand-region t)
			  (git-commit-mode t)
			  (gitconfig-mode t)
			  (github-theme t)
			  (gitignore-mode t)
			  (google-c-style t)
			  (google-contacts nil)
			  (icicles nil)
			  (icomplete+ t)
			  (ido-better-flex t)
			  (magit t)
			  (mark-more-like-this nil)
			  (markdown-mode t)
			  (melpa t)
			  (monokai-theme t)
			  (multi-term t)
			  (multiple-cursors t)
			  (nose t)
			  (oauth2 t)
			  (popup t)
			  (purty-mode t)
			  (python t)
			  (qsimpleq-theme t)
			  (rainbow-delimiters t)
			  (rainbow-mode t)
			  (request t)
			  (smart-mode-line nil)
			  (smart-tab t)
			  (tango-2-theme t)
			  (tangotango-theme t)
			  (textile-mode t)
			  (websocket nil)
			  (wgrep t)
			  (windsize t)
			  (wrap-region t)
			  (yasnippet t)
			  (zenburn-theme t)
			  (zencoding-mode t)
			  (powerline nil)
			  ))

(package-initialize)

(require 'cl)
(require 'ace-jump-mode)
;; (define-key global-map (kbd "C-ø") 'ace-jump-mode)
;; (define-key global-map (kbd "M-ø") 'ace-jump-mode) ; to access in terminal
(define-key global-map (kbd "M-ñ") 'ace-jump-mode) ; to access in terminal
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode-pop-mark)


;; Ido backup settings
(setq ido-enable-flex-mathching t)
(setq ido-everywhere t)
(ido-better-flex/enable)
(ido-mode 1)
