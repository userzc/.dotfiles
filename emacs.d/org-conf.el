;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-log-done t)
;; para utilizar google-chrome en los enlaces
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; para poder escalar imagenes en org mode
(setq org-image-actual-width nil )

;; make org-table ready for action!
(require 'org-table)

(setq org-directory "~/Dropbox/org/")
(setq org-default-notes-file "~/Dropbox/org/notes.org")
(setq org-mobile-directory "~/Dropbox/MobileOrg/")
(setq org-mobile-inbox-for-pull "~/Dropbox/org/flagged.org")

;; hilight current line in org-agenda-mode
(add-hook 'org-agenda-mode-hook
          '(lambda ()
             (hl-line-mode 1)))

;; active babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)
   (octave . t)
   (latex . t)
   (maxima . t)
   (python . t)
   (C . t)
   (java . t)))

;; org-agenda custom commands
;; http://orgmode.org/worg/org-tutorials/org-custom-agenda-commands.html
(setq org-agenda-custom-commands
      '(("i" "Computer information" tags "computer"
         ((org-agenda-sorting-strategy '(priority-down effort-down))))))

;; https://github.com/coldnew/org-ioslide
(require 'ox-ioslide)

(provide 'org-conf)
