;; Ack-and-a-half
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
;; always ask for directory in which to run ack
(setq ack-and-a-half-prompt-for-directory t)

(provide 'ack-conf)
