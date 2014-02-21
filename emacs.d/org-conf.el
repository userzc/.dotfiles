;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-log-done t)
;; para utilizar google-chrome en los enlaces
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; make org-table ready for action!
(require 'org-table)

;; active babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)
   (octave . t)
   ;; (maxima . t)
   (python . t)
   ;; (cpp . t)
   ))

(provide 'org-conf)
