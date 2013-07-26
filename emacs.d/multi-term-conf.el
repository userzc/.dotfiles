;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multi-term
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Es necesario deshabilitar "yas/minor-mode" en este "major-mode" para
;; poder tener acceso a autocompletion mediante TAB
(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)
(eval-after-load 'desktop
  '(push "\\*MULTI-TERM-DEDICATED\\*" desktop-clear-preserve-buffers))

;; (setq multi-term-program "/bin/bash")   ;; use bash
(setq multi-term-program "/bin/zsh") ;; or use zsh...

;; Para evitar que el buffer dedicato sea considerado al cambiar a
;; otra ventana
(setq multi-term-dedicated-skip-other-window-p t)

(defadvice multi-term-dedicated-open
  (after do-select-dedicated-window )
  "Seleciona buffer `*MULTI-TERM-DEDICATED*' al utilizar el
  `multi-term-dedicated-open', útil al usar
  `multi-term-dedicated-toggle'."
  (multi-term-dedicated-select))

(provide 'multi-term-conf)
