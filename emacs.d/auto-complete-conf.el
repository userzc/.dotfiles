;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; auto-complete-mode
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-complete-config)
(ac-config-default)

;; (setq auto-complete-mode t )
;; (setq global-auto-complete-mode t)
(add-to-list 'ac-modes 'python-mode)
(setq ac-auto-start nil)
(ac-set-trigger-key "C-.")
(setq ac-use-menu-map t)
;; (setq ac-modes '(python-mode))
(add-hook 'python-mode-hook
          (lambda ()
            (add-to-list 'ac-sources
                         'ac-source-yasnippet)
            (add-to-list 'ac-sources
                         'ac-source-words-in-all-buffer t)))
;; Valores obtenidos por default, quizá convenga cambiarlos
;; ac-auto-start: 2
;; auto-complete: t
;;

;; Semantic sources
;; http://www.emacswiki.org/emacs/AutoCompleteSources#toc6
(defun ac-semantic-construct-candidates (tags)
  "Construct candidates from the list inside of tags."
  (apply 'append
	 (mapcar (lambda (tag)
		   (if (listp tag)
		       (let ((type (semantic-tag-type tag))
			     (class (semantic-tag-class tag))
			     (name (semantic-tag-name tag)))
			 (if (or (and (stringp type)
				      (string= type "class"))
				 (eq class 'function)
				 (eq class 'variable))
			     (list (list name type class))))))
		 tags)))


(defvar ac-source-semantic-analysis nil)
(setq ac-source-semantic
  `((sigil . "b")
    (init . (lambda () (setq ac-source-semantic-analysis
                             (condition-case nil
                                             (ac-semantic-construct-candidates (semantic-fetch-tags))))))
    (candidates . (lambda ()
                    (if ac-source-semantic-analysis
                        (all-completions ac-target (mapcar 'car ac-source-semantic-analysis)))))))

(provide 'auto-complete-conf)
