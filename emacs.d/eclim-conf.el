(setq eclim-executable "/opt/eclipse/eclim")
;; (setq eclim-default-workspace "~/workspace/" )
(setq eclimd-executable "/opt/eclipse/eclimd")
(setq eclimd-default-workspace "~/workspace/" )
;; (setq eclimd-wait-for-process nil)	; wait for eclim to start

;; (global-eclim-mode)
(require 'eclimd)

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

(eval-after-load "auto-complete-conf.el"
  '(progn
    (require 'ac-emacs-eclim-source)
    (ac-emacs-eclim-config)))

(provide 'eclim-conf)
