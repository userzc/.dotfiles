;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; smart-mode-line, ver: http://github.com/Bruce-Connor/smart-mode-line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(add-to-list 'sml/replacer-regexp-list
	     '("^:DF:emacs\.d/" ":ED:"))

(add-to-list 'sml/replacer-regexp-list
	     '("^~/\.dotfiles/" ":DF:"))

(if after-init-time (sml/setup)
  (add-hook 'after-init-hook 'sml/setup))

(provide 'smart-mode-line-conf)
