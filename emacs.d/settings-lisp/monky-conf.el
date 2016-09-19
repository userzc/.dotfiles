;; full screen monky-status, based on
;; http://whattheemacsd.com/setup-magit.el-01.html
(defadvice monky-status (around monky-fullscreen activate)
  (window-configuration-to-register :monky-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun monky-quit-session ()
  "Restores the previous window configuration and kills the monky buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :monky-fullscreen))

;; Using a single cmdserver and communicate through pipes (speed up)
(setq monky-process-type 'cmdserver)

(provide 'monky-conf)
