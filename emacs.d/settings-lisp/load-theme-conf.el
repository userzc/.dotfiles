;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load-theme & color-theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; se define la siguiente variable para compatibilidad de los temas
;; solarized en terminal, sin embargo no son tan buenos como uno
;; esperaría
(setq solarized-termcolors 256)

;; (setq solarized-distinct-fringe-background t)
;; (setq solarized-high-contrast-mode-line t)

(add-to-list 'custom-theme-load-path
             "~/.emacs.d/lisp/default-black-theme/")

;;;;;;;;;;;;;;;;;
;; Dark themes ;;
;;;;;;;;;;;;;;;;;
;; (color-theme-wombat+)
;; (load-theme 'tangotango t)
(load-theme 'badwolf t)
;; (load-theme 'material t)
;; (load-theme 'moe-dark t)
;; (load-theme 'wombat t)
;; (load-theme 'tango-2 t)
;; (load-theme 'cyberpunk t)
;; (load-theme 'tron t)
;; (load-theme 'github t)
;; (load-theme 'monokai t)
;; (load-theme 'ubuntu t)
;; (load-theme 'waher t)
;; (load-theme 'niflheim t)
;; (load-theme 'oldlace t)
;; (load-theme 'professional t)
;; (load-theme 'granger t)
;; (load-theme 'clues t)
;; (load-theme 'assemblage t)
;; (load-theme 'default-black t)
;; (custom-set-faces '(default ((t (:background "nil")))))
;; (load-theme 'zenburn t)
;; (load-theme 'gotham t)
;; (load-theme 'base16-mocha-dark t)
;; (load-theme 'base16-monokai t)
;; (load-theme 'base16-greenscreen-light t)
;; (load-theme 'base16-ocean-dark t)
;; (load-theme 'base16-flat-dark t)
;; (load-theme 'ample-zen t)
;; (load-theme 'spacegray t)
;; (load-theme 'sanityinc-tomorrow-night t)
;; (load-theme 'solarized-dark t)
;; (load-theme 'qsimpleq t)
;; (load-theme 'dorsey t)
;; (load-theme 'fogus t)
;; (load-theme 'graham t);bad powerline compatibility
;; (load-theme 'hickey t)
;; (load-theme 'mccarthy t);bad powerline compatibility
;; (load-theme 'odersky t)
;; (load-theme 'wilson t)
;; (load-theme 'gruvbox t)

;;;;;;;;;;;;;;;;;;
;; Light themes ;;
;;;;;;;;;;;;;;;;;;
;; (load-theme 'moe-light t)
;; (load-theme 'solarized-light t)
;; (load-theme 'organic-green t)
;; (load-theme 'base16-mocha-light t)

;; font
(if (equal system-type 'gnu/linux)
    (condition-case nil
        ;; (set-default-font "Meslo LG S DZ Regular for Powerline-11")
        (set-default-font "Inconsolata-dz for Powerline-10")
	;; (set-default-font "Ubuntu Mono-11")
      (error
       (set-default-font "Inconsolata-11")))
  (condition-case nil
      (set-default-font "Inconsolata-11")
    (error
     (set-default-font "DejaVu Sans Mono-10"))))

;; Opciones:
;; -adobe-Source Code Pro for Powerline-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -adobe-Source Code Pro for Powerline-extra-light-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -adobe-Source Code Pro for Powerline-light-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -adobe-Source Code Pro for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -adobe-Source Code Pro for Powerline-semi-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -adobe-Source Code Pro for Powerline-ultra-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -bitstream-Meslo LG L DZ for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -bitstream-Meslo LG L for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -bitstream-Meslo LG M DZ for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -bitstream-Meslo LG M for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -bitstream-Meslo LG S DZ for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -bitstream-Meslo LG S for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Anonymous Pro for Powerline-bold-italic-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Anonymous Pro for Powerline-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Anonymous Pro for Powerline-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Anonymous Pro for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-DejaVu Sans Mono for Powerline-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-DejaVu Sans Mono for Powerline-bold-oblique-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-DejaVu Sans Mono for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-DejaVu Sans Mono for Powerline-normal-oblique-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Droid Sans Mono for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Fira Mono for Powerline-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Fira Mono for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Fira Mono Medium for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Inconsolata for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Inconsolata-dz for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Inconsolata-g for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Liberation Mono for Powerline-bold-italic-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Liberation Mono for Powerline-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Liberation Mono for Powerline-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Liberation Mono for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-monofur for Powerline-bold-normal-normal-*-*-*-*-*-*-0-iso10646-1
;; -unknown-monofur for Powerline-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-monofur for Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Ubuntu Mono derivative Powerline-bold-italic-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Ubuntu Mono derivative Powerline-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Ubuntu Mono derivative Powerline-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Ubuntu Mono derivative Powerline-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1

;; Ejemplos de nombres:
;; -unknown-Inconsolata-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;; -unknown-Inconsolata-normal-normal-normal-*-15-*-*-*-m-0-fontset-auto1
;; -unknown-Inconsolata-normal-normal-normal-*-16-*-*-*-m-0-fontset-auto27
;; -unknown-Inconsolata-normal-normal-normal-*-16-*-*-*-m-0-fontset-auto28

(provide 'load-theme-conf)
