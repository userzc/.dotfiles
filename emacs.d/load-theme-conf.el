;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load-theme & color-theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Se define la siguiente variable para compatibilidad de los temas
;; solarized en terminal, sin embargo no son tan buenos como uno
;; esperaría
(setq solarized-termcolors 256)

;; Añadiendo caminos a `custom-theme-load-path'
(add-to-list 'custom-theme-load-path
             "~/.emacs.d/lisp/emacs-tron-theme/")
(add-to-list 'custom-theme-load-path
             "~/.emacs.d/elpa/tangotango-theme-20121014.1916/")

(add-to-list 'custom-theme-load-path
             "~/.emacs.d/elpa/github-theme-0.0.3/")
(add-to-list 'custom-theme-load-path
             "~/.emacs.d/lisp/default-black-theme/")
(add-to-list 'custom-theme-load-path
             "~/.emacs.d/elpa/moe-theme-20130625.1427/")

;; (require 'color-theme )
;; (setq color-theme-load-all-themes nil)
;; (load-file
;;  "~/.emacs.d/elpa/color-theme-wombat+-0.0.2/color-theme-wombat+.el")
;; (color-theme-wombat+)
;; (load-theme 'wombat+ t)
;; (load-theme 'tangotango t)
;; (load-theme 'wombat t)
;; (load-theme 'tango-2 t)
;; (load-theme 'cyberpunk t)
;; (load-theme 'tron t)
;; (load-theme 'github t)
;; (load-theme 'monokai t)
;; (load-theme 'clues t)
;; (load-theme 'assemblage t)
;; (load-theme 'default-black t)
;; (custom-set-faces '(default ((t (:background "nil")))))
(load-theme 'zenburn t)
;; (load-theme 'sanityinc-tomorrow-day t)
;; (load-theme 'solarized-light t)
;; (load-theme 'qsimpleq t)
;; (load-theme 'dorsey t)
;; (load-theme 'fogus t)
;; (load-theme 'graham t);bad powerline compatibility
;; (load-theme 'hickey t)
;; (load-theme 'mccarthy t);bad powerline compatibility
;; (load-theme 'odersky t)
;; (load-theme 'wilson t)

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

(provide 'load-theme-conf)
