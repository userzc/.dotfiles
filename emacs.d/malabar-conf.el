;; this file is provided with the intention to setup malabar mode or
;; any other java-configuration so java development is as smooth as
;; possible

;; (eval-after-load "malabar-mode"
;;   '(progn
;;      (setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
;;                                        global-semanticdb-minor-mode
;;                                        global-semantic-idle-summary-mode
;;                                        global-semantic-mru-bookmark-mode))
;;      (semantic-mode 1)))

(defun load-malabar ()
  "load semantic and malabar mode as needed"
  (interactive)
  (setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                    global-semanticdb-minor-mode
                                    global-semantic-idle-summary-mode
                                    global-semantic-mru-bookmark-mode))
  (semantic-mode 1)
  (malabar-mode 1))

(provide 'malabar-conf)
