;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; "smart tab" y "hippie expand"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tal como se ve en:
;; https://github.com/rmm5t/dotfiles/blob/master/emacs.d/rmm5t/tabs.el
;; y funciona como en http://www.youtube.com/watch?v=a-jrn_ba41w
(setq smart-tab-completion-functions-alist
      '((text-mode       . dabbrev-completion)))

(setq smart-tab-using-hippie-expand t)
(setq smart-tab-using-auto-complete nil)
;; hippie expand.  groovy vans with tie-dyes.
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name
        try-complete-lisp-symbol))

;; Se deshabilitar `auto-complete` de `smart-tab`
(defun smart-tab-call-completion-function ()
  "Get a completion function according to current major mode."
  (if smart-tab-debug
      (message "complete"))
  (let ((completion-function
         (cdr (assq major-mode smart-tab-completion-functions-alist))))
    (if (null completion-function)
        (if (and (not (minibufferp))
                 (memq 'auto-complete-mode minor-mode-list)
                 (boundp' auto-complete-mode)
                 auto-complete-mode
                 smart-tab-using-auto-complete)
            (smart-tab-funcall 'ac-start :force-init t)
          (if smart-tab-using-hippie-expand
              (hippie-expand nil)
            (dabbrev-expand nil)))
      (funcall completion-function))))
;; de momento se ha optado por intentar deshabilitar el smart-tab en
;; los modos con comint, para que se utilice los métodos de
;; complemento que vienen en cada uno de esos modos, de forma que no
;; den mucha lata.

;; todo: se puede intentar añadir a esta lista los demás modos que
;; utilizan comint como el de python o maxima, etc. según se vayan
;; necesitando de irán añadiendo

(setq  smart-tab-disabled-major-modes
       '(inferior-octave-mode
         term-mode
         org-mode
         ein:notebooklist-mode
         inferior-python-mode))

(global-smart-tab-mode 1)

(provide 'smart-hippie-conf)
