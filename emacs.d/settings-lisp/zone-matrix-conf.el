;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs screen-saver ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(setq zone-programs [zone-matrix])
;; (setq zone-programs [zmx-buffer-impl])
;; (setq zone-programs [zmx-text-impl])
(zone-when-idle 1800)
(provide 'zone-matrix-conf)
