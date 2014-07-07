;; ibuffer > list-buffer
(global-set-key (kbd "C-x C-b") 'ibuffer-list-buffers)

;; zap-up-to-char
(eval-after-load "misc"
  '(progn    (global-set-key (kbd "M-Z") 'zap-up-to-char)
             ;; easier navigation, assumes `misc.el'
             (global-set-key (kbd "M-F") 'forward-to-word)
             (global-set-key (kbd "M-B") 'backward-to-word)))

;; change help-map to C-c h, tomado de:
;; https://github.com/magnars/.emacs.d/blob/master/key-bindings.el
(global-set-key (kbd "C-c h") (lookup-key global-map (kbd "C-h")))
(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "C-h") 'backward-delete-char)

;; change the spelling dictionary
(global-set-key (kbd "C-c s") 'ispell-change-dictionary)

;; delete-pairs
(global-set-key (kbd "C-c d") 'delete-pair)

;; open lines faster from anywhere in the current line
(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)

;; Para ayudar a copiar una línea completa
(global-set-key (kbd "C-c k") 'kill-whole-line)

;; more information on `goto-line'
(global-set-key [remap goto-line] 'goto-line-with-feedback)

;; Para recuperar 'shell-command-on-region' en  `unity'
(global-set-key (kbd "M-¬") 'shell-command-on-region)

;; sr-speedbar
(global-set-key (kbd "C-c M-s") 'sr-speedbar-toggle)

;;;;;;;;;;;;;;
;; org-mode ;;
;;;;;;;;;;;;;;
(eval-after-load "org"
  '(progn
     ;; Change word separators
     (global-set-key (kbd "C-c C") 'org-capture)
     (global-set-key (kbd "C-c L") 'org-store-link)
     (global-set-key (kbd "C-c a") 'org-agenda)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; magnars' keybinding rip-off ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; shorthand for interactive lambdas
(defmacro λ (&rest body)
  `(lambda ()
     (interactive)
     ,@body))

(eval-after-load "s"
  '(progn
     ;; Change word separators
     (global-unset-key (kbd "C-x +")) ;; used to be balance-windows
     (global-set-key (kbd "C-x + -") (λ (replace-region-by 's-dashed-words)))
     (global-set-key (kbd "C-x + _") (λ (replace-region-by 's-snake-case)))
     (global-set-key (kbd "C-x + c") (λ (replace-region-by 's-lower-camel-case)))
     (global-set-key (kbd "C-x + C") (λ (replace-region-by 's-upper-camel-case)))))


;; Las siguientes lineas son para probar el paquete `bookmark+'
(eval-after-load "bookmark+"
  '(progn (global-set-key "\C-cb" bookmark-map)
          (global-set-key "\C-cbc" bmkp-set-map)
          (global-unset-key "\C-xp")))

;; para utilizar `expand-region' similar a como viene en emacsrocks.com/e09.html
;; con un key-bind que no viene recomendado en la página de github
(eval-after-load "expand-region"
  '(progn (global-set-key (kbd "M-_") 'er/expand-region)
          (global-set-key (kbd "C-M-_") 'er/contract-region)
          (global-set-key (kbd "C->") 'er/expand-region)
          (global-set-key (kbd "C-<") 'er/contract-region)))

;; ;; para moverse atravez de los "windows":, e.g.: c-left  =  windmove-left
;; (windmove-default-keybindings 'control)

;; Siguiendo la configuración de i3-wm
(eval-after-load "windmove"
  '(progn
     ;; Movement for en_US keyboard layout
     (global-set-key (kbd "M-H") 'windmove-left)
     (global-set-key (kbd "M-L") 'windmove-right)
     (global-set-key (kbd "M-K") 'windmove-up)
     (global-set-key (kbd "M-J") 'windmove-down)

     ;; ;; Movement for es_MX keyboard layout
     ;; (global-set-key (kbd "M-J") 'windmove-left)
     ;; (global-set-key (kbd "M-Ñ") 'windmove-right)
     ;; (global-set-key (kbd "M-L") 'windmove-up)
     ;; (global-set-key (kbd "M-K") 'windmove-down)
     ))

;; Trabajar rápido en un problema de ACM
(global-set-key (kbd "C-c C-n") 'acm-problem)

;; emmet-mode
(eval-after-load "emmet-mode"
  ;; Auto-start on any markup modes
  '(progn (add-hook 'nxml-mode-hook 'emmet-mode)
          (add-hook 'sgml-mode-hook 'emmet-mode)
          (define-key emmet-mode-keymap (kbd "C-c C-j")
            'emmet-expand-line)
          (define-key emmet-mode-keymap (kbd "C-j") 'nil)
          (define-key emmet-mode-keymap (kbd "<C-return>") 'nil)))

;; Webjump let's you quickly search google, wikipedia, emacs wiki
(global-set-key (kbd "C-x g") 'webjump)
(global-set-key (kbd "C-x M-g") 'browse-url-at-point)

;; magit-mode
(eval-after-load "magit"
  '(progn
     (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)
     (global-set-key (kbd "C-c M-m") 'magit-status)))

;; monky-mode
(eval-after-load "monky"
  '(progn
     ;; (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)
     (global-set-key (kbd "C-c M-M") 'monky-status)))

;; nose-mode
;; The previous keybinds are included in the new nose-mode, so they were removed
;; TODO: modificar keybinds en python-debugger para hacer espacio para
;; projectile
(eval-after-load "nose"
  '(add-hook 'python-mode-hook '(lambda () (nose-mode t))))


;; Window rotations and toggle, from:
;; https://github.com/magnars/.emacs.d/blob/master/key-bindings.el
(global-set-key (kbd "C-x -") 'rotate-windows)
(global-set-key (kbd "C-x C--") 'toggle-window-split)
(global-unset-key (kbd "C-x C-+")) ;; don't zoom like this

;; cedit mode
;; https://github.com/zk-phi/cedit

;; cedit-forward-char
;; cedit-backward-char
;; cedit-beginning-of-statement
;; cedit-end-of-statement

(global-set-key (kbd "C-M-S-d") 'cedit-down-block)
(global-set-key (kbd "C-M-S-e") 'cedit-up-block-forward)
(global-set-key (kbd "C-M-S-u") 'cedit-up-block-backward)

;; Probando las funciones que se utilizan
(global-set-key  (kbd "C-M-S-<right>") 'cedit-slurp)
(global-set-key  (kbd "C-M-{") 'cedit-wrap-brace)
(global-set-key  (kbd "C-M-S-<left>") 'cedit-barf)
(global-set-key  (kbd "C-M-ĸ") 'cedit-splice-killing-backward) ; AltGr-k = ĸ
(global-set-key  (kbd "C-M-¶") 'cedit-raise)                   ; AltGr-r = ¶


;; projectile-mode
;; https://github.com/bbatsov/projectile
;; Es útil acceder de manera global a project-file sin tener que
;; activar el minor-mdoe
(global-set-key (kbd "C-c p s") 'projectile-switch-project)

(global-set-key (kbd "C-c n") 'cleanup-buffer)
;; Se necesita encontrar un nuevo key-bind para esta función y poder
;; intentar `abl-mode' con sus default key-binds.
(global-set-key (kbd "C-c w") 'cleanup-buffer-safe)


(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map
              (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))


;; Make it work in inferior processes: octave-inferior, imaxima, etc.

(add-hook 'comint-mode-hook
          (lambda ()
            (define-key comint-mode-map
              (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))


;; (global-set-key (kbd "C-c t") 'multi-term-next)
;; hay que buscar otro `key-bind' que sí funcione en `python-mode'
(if (fboundp 'multi-term)
    (progn (global-set-key (kbd "C-c c m") 'multi-term-dedicated-toggle)
           ;; create a new one
           (global-set-key (kbd "C-c c M") 'multi-term)))

;; Para evitar que "yasnippet" interfiera con la completación mediante
;; TAB en "zsh"
(add-hook 'term-mode-hook
          '(lambda ()
             ;; To change from `char-mode' to `line-mode'
             (define-key term-raw-map (kbd "C-c C-j") 'term-line-mode)
             (setq yas/minor-mode nil)))


;; ;; (setq auto-complete-mode t )
;; ;; (setq global-auto-complete-mode t)
;; (add-to-list 'ac-modes 'python-mode)
;; (setq ac-auto-start nil)
;; (ac-set-trigger-key "C-.")
;; (setq ac-use-menu-map t)
;; ;; (setq ac-modes '(python-mode))
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (add-to-list 'ac-sources
;;                          'ac-source-yasnippet)
;;             (add-to-list 'ac-sources
;;                          'ac-source-words-in-all-buffer t)))
;; ;; Valores obtenidos por default, quizá convenga cambiarlos
;; ;; ac-auto-start: 2
;; ;; auto-complete: t
;; ;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emaxima-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; para utilizar c-ret en emaxima-mode-map
(eval-after-load "emaxima"
  '(define-key emaxima-mode-map [C-return] 'emaxima-update-single-cell))


(add-hook 'maxima-mode-hook
          '(lambda ()
             (define-key maxima-mode-map
               (kbd "M-;") 'comment-dwim)
             (define-key maxima-mode-map
               (kbd "C-c ;") 'maxima-insert-short-comment)
             (define-key maxima-mode-map
               (kbd "C-c *") nil)
             (define-key maxima-mode-map
               (kbd "C-c M-;") 'maxima-insert-long-comment)))

;; para utilizar completación de historial como en terminal
(eval-after-load "python"
  '(progn
     (define-key inferior-python-mode-map [(meta p)]
       'comint-previous-matching-input-from-input)
     (define-key inferior-python-mode-map [(meta n)]
       'comint-next-matching-input-from-input)
     (define-key inferior-python-mode-map [(control meta n)]
       'comint-next-input)
     (define-key inferior-python-mode-map [(control meta p)]
       'comint-previous-input)
     (define-key inferior-python-mode-map
       (kbd "C-c C-z") 'quit-window)
     (define-key python-mode-map
       (kbd "C-x p l") 'load-ropemacs)
     (define-key python-mode-map (kbd "C-c j")
       'rope-jump-to-global)
     ))

;; las siguientes líneas impiden que el movimiento entre windows se
;; modifique por los keybinds de comint
(add-hook  'comint-mode-hook
           '(lambda ()
              (define-key comint-mode-map [C-down] nil)
              (define-key comint-mode-map [C-up] nil)
              (define-key comint-mode-map [C-right] nil)
              (define-key comint-mode-map [C-left] nil)
              ;; redefine the old funtion so as to not lose functionality
              (define-key comint-mode-map (kbd "C-c z") 'comint-stop-subjob)
              (define-key comint-mode-map (kbd "C-c C-z") 'quit-window)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multiple-cursors, emacs rocks: http://emacsrocks.com/e13.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; -------------------------------------------------------------------
;; Quizás sea conveniente revisar los demás keybinds de magnars, están
;; en la página: https://github.com/magnars/.emacs.d/blob/master/key-bindings.el

(eval-after-load "multiple-cursors"
  '(progn
     ;; Experimentando con region-bindings-mode, parece tener sus peculiaridades
     (global-set-key (kbd "M-P") 'mc/mark-previous-like-this)
     (global-set-key (kbd "M-N") 'mc/mark-next-like-this)
     (global-set-key (kbd "M-s M-p") 'mc/mark-previous-symbol-like-this)
     (global-set-key (kbd "M-s M-n") 'mc/mark-next-symbol-like-this)

     ;; like the other two, but takes an argument (negative is previous)
     ;; (global-set-key ;; (kbd "C-M-m") 'mc/mark-more-like-this)
     (global-set-key (kbd "C-c *") 'mc/mark-all-like-this)
     (global-set-key (kbd "C-c M-*") 'mc/mark-all-symbols-like-this)
     (global-set-key (kbd "C-c e") 'mc/edit-lines)
     (global-set-key (kbd "C-c M-e") 'mc/edit-ends-of-lines)
     (global-set-key (kbd "C-c M-a") 'mc/edit-beginnings-of-lines)

     ;;Hay que optimizar:
     (global-set-key (kbd "M-æ") 'mc/mark-all-like-this-dwim)   ;; AltGr-a = æ
     (global-set-key (kbd "M-á") 'mc/mark-all-like-this-dwim)   ;; AltGr-a = á
     (global-set-key (kbd "M-→") 'mc/insert-numbers)            ;; AltGr-i = →
     (global-set-key (kbd "M-í") 'mc/insert-numbers)            ;; AltGr-i = í
     ;; keybind alternativo, el anterior no parece seguir funcionando
     (global-set-key (kbd "M-€") 'mc/insert-numbers)            ;; AltGr-e = €
     (global-set-key (kbd "M-é") 'mc/insert-numbers)            ;; AltGr-e = é
     (global-set-key (kbd "M-¶") 'mc/reverse-regions)           ;; AltGr-r = ¶
     (global-set-key (kbd "M-®") 'mc/reverse-regions)           ;; AltGr-r = ®
     (global-set-key (kbd "M-ß") 'mc/sort-regions)              ;; AltGr-s = ß
     (global-set-key (kbd "M-S-SPC") 'set-rectangular-region-anchor)
     (global-set-key (kbd "M-þ") 'mc/mark-pop)                  ;; AltGr-p = þ
     (global-set-key (kbd "M-ö") 'mc/mark-pop)                  ;; AltGr-p = ö
     ;; Este acorde no tiene equivalente apropiado en distribución en_US
     (global-set-key (kbd "M-ŧ") 'mc/mark-sgml-tag-pair)        ;; AltGr-t = ŧ
     ;; (global-set-key (kbd "C-c C-r") 'rename-sgml-tag)
     ;; Probando keybind alterno, evitar conflicto con: AUCTeX
     (global-set-key (kbd "C-c M-x") 'mc/mark-more-like-this-extended)
     ;; Parece ser útil tener multiple-cursors en regiones
     ;; (global-set-key (kbd "M-®") 'mc/mark-all-in-region)
     ;; ;; Se podria cambiar por:
     (global-set-key (kbd "M-Æ") 'mc/mark-all-in-region)
     (global-set-key (kbd "M-Á") 'mc/mark-all-in-region) ;AltGr-Shift-A = Á
     ;; No he podido identificar la tecla Hyper, así que estoy probando
     ;; diferentes opciones, investigar más respecto a ns-function-modifier
     ;; (setq ns-function-modifier 'hyper )
     ;; (global-set-key (kbd "H-SPC") 'set-rectangular-region-anchor)
     ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; acejump, http://emacsrocks.com/e10.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; los keybinds son los sugeridos por emacs rocks

(eval-after-load "ace-jump-mode"
  ;; (define-key global-map (kbd "C-ø") 'ace-jump-mode)
  ;; (define-key global-map (kbd "M-ø") 'ace-jump-mode) ; to access in terminal
  '(progn
     (define-key global-map (kbd "M-ñ") 'ace-jump-mode) ; to access in terminal
     (define-key global-map (kbd "C-;") 'ace-jump-mode) ; to access in terminal
     (autoload
       'ace-jump-mode-pop-mark
       "ace-jump-mode"
       "Ace jump back:-)"
       t)
     (eval-after-load "ace-jump-mode"
       '(ace-jump-mode-enable-mark-sync))
     (define-key global-map (kbd "C-c SPC") 'ace-jump-mode-pop-mark)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; "smart tab" y "hippie expand"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tal como se ve en:
;; https://github.com/rmm5t/dotfiles/blob/master/emacs.d/rmm5t/tabs.el
;; y funciona como en http://www.youtube.com/watch?v=a-jrn_ba41w

(eval-after-load "smart-tab"
  '(global-set-key (kbd "TAB") 'smart-tab))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         window resize
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load "windsize"
  '(progn (setq windsize-cols 2)
          (setq windsize-rows 1)
          (windsize-default-keybindings)
          ;; Resemblance to windmove and i3-wm on left hand
          (global-set-key (kbd "M-Q") 'windsize-left)
          (global-set-key (kbd "M-R") 'windsize-right)
          (global-set-key (kbd "M-W") 'windsize-up)
          (global-set-key (kbd "M-E") 'windsize-down)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         smartparens
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load "smartparens"
  '(progn
     (setq sp-smartparens-bindings
           '(("C-M-f" . sp-forward-sexp)
             ("C-M-b" . sp-backward-sexp)
             ("C-M-d" . sp-down-sexp)
             ("C-M-a" . sp-backward-down-sexp)
             ("C-S-d" . sp-beginning-of-sexp)
             ("C-S-a" . sp-end-of-sexp)
             ("C-M-e" . sp-up-sexp)
             ("C-M-u" . sp-backward-up-sexp)
             ("C-M-n" . sp-next-sexp)
             ("C-M-p" . sp-previous-sexp)
             ("C-M-k" . kill-sexp)
             ("C-M-S-K" . sp-kill-sexp)
             ("C-M-w" . sp-copy-sexp)
             ("C-c C-d" . sp-unwrap-sexp)
             ("M-<backspace>" . sp-backward-unwrap-sexp)
             ("C-<right>" . sp-forward-slurp-sexp)
             ("C-<left>" . sp-forward-barf-sexp)
             ("C-M-<left>" . sp-backward-slurp-sexp)
             ("C-M-<right>" . sp-backward-barf-sexp)
             ("M-D" . sp-splice-sexp)
             ("M-S" . sp-split-sexp)
             ("C-c J" . sp-join-sexp)
             ("C-M-<delete>" . sp-splice-sexp-killing-forward)
             ("C-M-<backspace>" . sp-splice-sexp-killing-backward)
             ("C-S-<backspace>" . sp-splice-sexp-killing-around)
             ("C-]" . sp-select-next-thing-exchange)
             ("C-M-]" . sp-select-next-thing)
             ("C-M-S-f" . sp-forward-symbol)
             ("C-M-S-b" . sp-backward-symbol)
             ))

     (global-set-key (kbd "C-c C-M-a")
                     'beginning-of-defun)
     (global-set-key (kbd "C-c C-M-e")
                     'end-of-defun)
     (sp-use-smartparens-bindings)))

;; Evitar tapado de opciones de icicles debido a smartparens en el
;; minibuffer, se añadiran más conforme se descubran
(add-hook 'minibuffer-setup-hook
          '(lambda ()
             (define-key smartparens-mode-map
               (kbd "C-S-a") nil)))

(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (define-key smartparens-mode-map
               (kbd "C-S-a") 'sp-end-of-sexp)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         python-django
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load "python-django"
  '(progn
     (global-set-key (kbd "C-c M-d") 'python-django-open-project)))

;; ;; Enable completion-at-point in terminal, for some reason the first
;; ;; attempt doesn't work. There can be problems with icicles.
;; (global-set-key (kbd "<M-S-iso-lefttab>") 'completion-at-point)
(global-set-key (kbd "<backtab>") 'completion-at-point)

;; Existe la opción de intentar hacer un remap de las funciones
;; asociadas a este keybind, pero aún no me queda claro la forma de
;; hacerlo. No parece funcionar, hay que considerar además alguna otra
;; forma para hacerlo. Hasta el momento se han intentado las
;; siguientes opciones con algunas otras variantes sin resultado
;; favorable.

;; (eval-after-load "gnus-group"
;;   '(progn
;;      (define-key gnus-agent-group-mode-map [remap
;;      gnus-group-edit-global-kill] 'windmove-down)
;;      ;; (define-key gnus-agent-group-mode-map "\eK" nil)
;; ))

;; (add-hook 'gnus-group-mode-hook
;;        (lambda ()
;;          ;; Disable this is a little more complicated
;;          (define-key gnus-group-group-map (kbd "M-K") nil)))

;; (add-hook 'gnus-group-mode-hook
;;        (lambda ()
;;          ;; Disable this is a little more complicated
;;          (define-key gnus-group-group-map
;;            [remap gnus-group-edit-global-kill] 'windmove-down)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         malabar-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load "malabar-mode"
  '(progn
     (define-key malabar-mode-map (kbd "C-c C-v m") 'malabar-run-maven-command)
     ;; imitando el comportamiento de python
     (define-key malabar-mode-map (kbd "C-c C-z") 'malabar-groovy-start)
     (define-key malabar-mode-map (kbd "C-c C-v g") 'malabar-groovy-start)
     (define-key malabar-mode-map (kbd "C-c C-v s") 'malabar-groovy-stop)
     (define-key malabar-mode-map (kbd "C-c C-v C-s") 'malabar-groovy-stop)
     (define-key malabar-mode-map (kbd "C-c C-v r") 'malabar-groovy-restart)))

(provide 'keybinds-conf)
