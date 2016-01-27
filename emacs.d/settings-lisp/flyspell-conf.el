(add-hook 'flyspell-mode-hook
          '(lambda ()
	     (message "[flyspell-conf] file loading")
	     (define-key flyspell-mode-map (kbd "C-.") nil)))

(provide 'flyspell-conf)
