;; Para zshrc respaldado
(add-to-list 'auto-mode-alist '("zshrc" . sh-mode))

;; Para archivos .zsh
(add-to-list 'auto-mode-alist '("\\.zsh" . sh-mode))

;; Para cargar programas Prolog
(add-to-list 'auto-mode-alist '("\\.pl" . prolog-mode))

;; Para cargar programas Octave
(add-to-list 'auto-mode-alist '("\\.m"  . octave-mode))

;; Para cargar programas en Maxima
(add-to-list 'auto-mode-alist '("\\.mac" . maxima-mode))

;; markdown-mode
(if (fboundp 'markdown-mode)
    (progn
      (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
      (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))))

;; textile-mode
(if (fboundp 'textile-mode)
    (progn
      (add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))))

;; shell-script-mode for zsh-theme
(add-to-list 'auto-mode-alist '("\\.zsh-theme\\'" . shell-script-mode))

;; El archivo "autostart.el" modifica algunos modos por default que no
;; me son útiles ni respetan las configuraciones propuestas en
;; emacsrocks propuestas por Magnar Svens. Se puede intentar con
;; html-mumamo-mode en lugar de html-mode.

(eval-after-load "autostart.el"
  '(progn
     ;; (setcdr (assoc "\\.html\\'" auto-mode-alist) 'html-mode)
     ;; (setcdr (assoc "\\.htm\\'" auto-mode-alist) 'html-mode)
     (add-to-list 'auto-mode-alist '("\\.html?\\'" . html-mode))
     ))

;; Lista de funciones de multiple mode
(add-to-list 'auto-mode-alist '(".mc-lists.el" . emacs-lisp-mode))

(provide 'automodes-conf)
