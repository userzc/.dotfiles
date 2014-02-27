;; Para deshabilitar tool-bar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; Emacs gurus don't need no stinking scroll bars
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Do something about ringin bell on windows and snapshot
(setq visible-bell t)
(setq ring-bell-function
      (lambda ()
	"Using Scroll Lock led as alarm"
	(progn
	  (call-process-shell-command "xset led named 'Scroll Lock'")
	  (call-process-shell-command "xset -led named 'Scroll Lock'"))))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backend-files t)

;; No cargar el default
(setq inhibit-default-init t)

;; Para quitar el cursor del mouse cuando estorba
(mouse-avoidance-mode 'banish)

;; Para los números de columna
(column-number-mode 1)

;; Uniquify
(require 'uniquify )
(setq uniquify-buffer-name-style 'post-forward)

;; Para contestar "y-or-n" en lugar de  "yes-or-no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Para indicar lineas vacias
(set-default 'indicate-empty-lines t)

;; Fringes pequeñas
(set-fringe-mode '(1 . 1))

;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)

;; Para utilizar el modo "Delete Selection Mode"
;; que borra la region seleccionada cuando se presiona una tecla
(delete-selection-mode t)

;; para ver paréntesis en pares
(show-paren-mode t)

;; para que el diccionario por default de aspell sea castellano8
(setq ispell-dictionary "castellano8")

;; para utilizar sólo espacios
(setq indent-tabs-mode nil)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; UTF-8 please
;; ver https://github.com/magnars/.emacs.d/blob/master/sane-defaults.el

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


(provide 'default-conf)
