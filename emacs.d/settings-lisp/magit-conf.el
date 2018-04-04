;; full screen magit-status, http://whattheemacsd.com/setup-magit.el-01.html
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

;; Avoid warning message for magit-1.4.0
(setq magit-last-seen-setup-instructions "1.4.0")

;; Muestra sólo commits no subidos
;; https://github.com/magit/magit/issues/3230#issuecomment-339900039
(magit-add-section-hook 'magit-status-sections-hook
                        'magit-insert-unpushed-to-upstream
                        'magit-insert-unpushed-to-upstream-or-recent
                        'replace)

(magit-add-section-hook 'magit-status-sections-hook
                        'magit-insert-unpulled-from-upstream)
(provide 'magit-conf)
