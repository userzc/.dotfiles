;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; auto-complete-mode
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-complete-config)
(ac-config-default)

;; (setq auto-complete-mode t )
;; (setq global-auto-complete-mode t)
(add-to-list 'ac-modes 'python-mode)
(setq ac-auto-start nil)
(ac-set-trigger-key "C-.")
(setq ac-use-menu-map t)
;; (setq ac-modes '(python-mode))
(add-hook 'python-mode-hook
          (lambda ()
            (add-to-list 'ac-sources
                         'ac-source-yasnippet)
            (add-to-list 'ac-sources
                         'ac-source-words-in-all-buffer t)))
;; Valores obtenidos por default, quizá convenga cambiarlos
;; ac-auto-start: 2
;; auto-complete: t
;;

(provide 'auto-complete-conf)
