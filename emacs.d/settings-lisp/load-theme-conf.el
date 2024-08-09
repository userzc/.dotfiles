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

(defvar selected-font nil "The font to set on all frames")

;;;;;;;;;;;;;;;;;
;; Dark themes ;;
;;;;;;;;;;;;;;;;;
;; (color-theme-wombat+)
;; (load-theme 'tangotango t)
(load-theme 'badwolf t)
;; (load-theme 'spacemacs-dark t)
;; (load-theme 'green-phosphor t)
;; (load-theme 'idea-darkula t)
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
;; (load-theme 'base16-google-light)

;;;;;;;;;;;;;;;;;;;
;; font and size ;;
;;;;;;;;;;;;;;;;;;;

;; (setq selected-font "anonymous-pro")
;; (setq selected-font "arimo")
;; (setq selected-font "cousine")
;; (setq selected-font "deja-vu-sans-mono")
;; (setq selected-font "droid-sans-mono")
;; (setq selected-font "droid-sans-mono-dotted")
;; (setq selected-font "droid-sans-mono-slashed")
;; (setq selected-font "fira-mono-10")
;; (setq selected-font "Hack-10")
(setq selected-font "Monoisome-8")
;; (setq selected-font "Coder Nerd Font Medium-12")
;; (setq selected-font "inconsolata")
;; (setq selected-font "inconsolata-dz")
;; (setq selected-font "inconsolata-g")
;; (setq selected-font "input-mono")
;; (setq selected-font "liberation-mono")
;; (setq selected-font "Meslo LG S for Powerline")
;; (setq selected-font "monofur")
;; (setq selected-font "roboto-mono")
;; (setq selected-font "samples")
;; (setq selected-font "source-code-pro")
;; (setq selected-font "symbol-neu")
;; (setq selected-font "terminus")
;; (setq selected-font "tinos")
;; (setq selected-font "ubuntu-mono")

(if (equal system-type 'gnu/linux)
    (condition-case nil
        (set-frame-font selected-font nil t)
      (error
       (set-frame-font "Inconsolata-8" nil t)))
  (condition-case nil
      (set-frame-font "Inconsolata-8" nil t)
    (error
     (set-frame-font "DejaVu Sans Mono-10" nil t))))

(provide 'load-theme-conf)
