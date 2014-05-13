;; This is to make things work in Windows
(cond
 ((equal system-type 'windows-nt)
  (setq eclim-executable "C:\\eclipse-kepler-4.3.1\\eclim.bat")
  (setq eclimd-executable "C:\\eclipse-kepler-4.3.1\\eclimd.bat")
  (setq eclimd-default-workspace "~/workspace/" )
  ;; wait for eclim to start
  (setq eclimd-wait-for-process nil))
 ((equal system-type 'gnu/linux)

  (setq eclim-executable "/opt/eclipse/eclim")
  ;; (setq eclim-default-workspace "~/workspace/" )
  (setq eclimd-executable "/opt/eclipse/eclimd")
  (setq eclimd-default-workspace "~/workspace/" )
  ;; wait for eclim to start
  (setq eclimd-wait-for-process nil)))

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
