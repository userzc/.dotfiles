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

;; Settings for MobileOrg (I couldn't find the original site, the
;; following is a repalcement):
;; http://blog.everythingtastesbetterwithchilli.com/2013/02/10/org-mode-as-exocortex-introduction-to-mobile-org/
(setq org-directory "~/Dropbox/org/")
(setq org-default-notes-file "~/Dropbox/org/notes.org")
(setq org-mobile-directory "~/Dropbox/MobileOrg/")
(setq org-mobile-inbox-for-pull "~/Dropbox/org/flagged.org")

;; (require 'org-mobile)
;; (org-mobile-sync-mode 1)

;; hilight current line in org-agenda-mode
(add-hook 'org-agenda-mode-hook
          '(lambda ()
             (hl-line-mode 1)))

;; org-capture-templates
;; http://orgmode.org/manual/Capture-templates.html#Capture-templates
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Dropbox/org/notes.org" "Tasks")
         "* TODO %?\n  %i\n  %a" :kill-buffer :empty-lines 1)
        ("i" "Computer information" entry (file+headline "~/Dropbox/org/notes.org" "Information")
         "* [#A] %? :computer:" :kill-buffer :empty-lines 1)))

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
         ((org-agenda-sorting-strategy '(priority-down effort-down))))
        ("A" "Archive search" search ""
	 ((org-agenda-files (file-expand-wildcards "~/Dropbox/org/*.org_archive"))))
        ("D" "Archive search" search "DONE"
         ((org-agenda-files (file-expand-wildcards "~/Dropbox/org/*.org_archive"))))))

;; https://github.com/coldnew/org-ioslide
(require 'ox-ioslide)

(provide 'org-conf)
