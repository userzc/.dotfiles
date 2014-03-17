;; this file is provided with the intention to setup malabar mode or
;; any other java-configuration so java development is as smooth as
;; possible
;; see:
;; https://github.com/m0smith/malabar-mode

;; ;; Estas configuraciones parecen no ser necesarias para la
;; ;; inicialización de malabar-mode, se dejan como referencias en case
;; ;; de que se necesite añadir alguna otra cosa
;; (eval-after-load "malabar-mode"
;;   '(progn
;;      ;; (setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
;;      ;;                                   global-semanticdb-minor-mode
;;      ;;                                   global-semantic-idle-summary-mode
;;      ;;                                   global-semantic-mru-bookmark-mode))
;;      (semantic-mode 1)))

;; Debido a que aún no me decido por algún modo en particular para
;; java, la configuración para los modos se pone aquí sólo en caso de
;; que se use esta configuración
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))

;; (setq malabar-groovy-lib-dir
;;       "~/.emacs.d/lisp/malabar-mode-jar/")

;; (setq malabar-groovy-lib-dir
;;       "~/.gvm/groovy/current/lib")

(provide 'malabar-conf)
