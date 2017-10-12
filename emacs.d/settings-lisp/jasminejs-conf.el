;; Se activan snippets de jasminejs
(add-hook 'jasminejs-mode-hook '(lambda () (jasminejs-add-snippets-to-yas-snippet-dirs)))

(provide 'jasminejs-conf)
