;; para utilizar yasnippet
;; hay que chacar como se utiliza el directorio ~/.emacs.d/snippets
;; (setq yas/snippet-dirs '("~/.emacs.d/snippets" "~/.emacs.d/extras/imported"))
;; (setq yas/snippet-dirs
;;       '("/home/rene/.emacs.d/elpa/yasnippet-20130829.1020/snippets"))
(yas/global-mode 1)

;; Para utilizar `yasnippet' con `popup', tomado de:
;; http://iany.me/2012/03/use-popup-isearch-for-yasnippet-prompt/

;; ;; This may be required in some cases, but so far it isn't
;; (require 'popup)
(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))

(setq yas-prompt-functions
      '(yas-popup-isearch-prompt
	yas-x-prompt yas-dropdown-prompt yas-completing-prompt
	yas-ido-prompt yas-no-prompt))

(provide 'yasnippet-conf)
