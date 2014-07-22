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

;; (color-theme-wombat+)
;; (load-theme 'organic-green t)
;; (load-theme 'tangotango t)
;; (load-theme 'moe-light t)
;; (load-theme 'moe-dark t)
;; (load-theme 'wombat t)
;; (load-theme 'tango-2 t)
;; (load-theme 'cyberpunk t)
;; (load-theme 'tron t)
;; (load-theme 'github t)
;; (load-theme 'monokai t)
;; (load-theme 'niflheim t)
;; (load-theme 'granger t)
;; (load-theme 'clues t)
;; (load-theme 'assemblage t)
;; (load-theme 'default-black t)
;; (custom-set-faces '(default ((t (:background "nil")))))
;; (load-theme 'zenburn t)
;; (load-theme 'base16-mocha t)
;; (load-theme 'base16-monokai t)
;; (load-theme 'ample-zen t)
(load-theme 'spacegray t)
;; (load-theme 'sanityinc-tomorrow-day t)
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

;; font
(if (equal system-type 'gnu/linux)
    (condition-case nil
        ;; (set-default-font "Meslo LG S for Powerline-11")
        (set-default-font "Inconsolata-dz for Powerline-10")
	;; (set-default-font "Ubuntu Mono-11")
      (error
       (set-default-font "Inconsolata-11")))
  (condition-case nil
      (set-default-font "Inconsolata-11")
    (error
     (set-default-font "DejaVu Sans Mono-10"))))

(provide 'load-theme-conf)
