;; ibuffer > list-buffer
(global-set-key (kbd "C-x C-b") 'ibuffer-list-buffers)

;; zap-up-to-char
(eval-after-load "misc"
    '(progn    (global-set-key (kbd "M-Z") 'zap-up-to-char)
	      ;; easier navigation, assumes `misc.el'
	      (global-set-key (kbd "M-F") 'forward-to-word)
	      (global-set-key (kbd "M-B") 'backward-to-word)))




;; delete-pairs
(global-set-key (kbd "C-c d") 'delete-pair)


(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)


;; Para ayudar a copiar una línea completa
(global-set-key (kbd "C-c k") 'kill-whole-line)


(global-set-key [remap goto-line] 'goto-line-with-feedback)


;; (eval-after-load "octave-inf"
;;   '(progn
;;      (define-key inferior-octave-mode-map [C-d] nil)
;;      (define-key inferior-octave-mode-map [C-up] nil)
;;      (define-key inferior-octave-mode-map [C-right] nil)
;;      (define-key inferior-octave-mode-map [C-left] nil)))


;; ;; Al parecer es en c++-mode-map que se deben de añadir las cosas, en
;; ;; caso de que empiece a hacer considerablemente grande la lista de
;; ;; configuraciones para los modos relacionados con C, es preferible
;; ;; definir una función con un nombre particular en lugar de usar la
;; ;; función "lambda"
;; (add-hook 'c-initialization-hook
;;           '(lambda ()
;;              (define-key c++-mode-map (kbd "C-c C-c") 'compile)
;;              (define-key c++-mode-map (kbd "C-c C-r") 'recompile)))


;; Para recuperar 'shell-command-on-region'
(global-set-key (kbd "M-¬") 'shell-command-on-region)


;; Las siguientes lineas son para probar el paquete Bookmark+
(eval-after-load "bookmark+"
    '(progn (global-set-key "\C-cb" bookmark-map)
	   (global-set-key "\C-cbc" bmkp-set-map)
	   (global-unset-key "\C-xp")))


;; ;; Para utilizar icicles, es recomendable cargarlo después de cargar
;; ;; delete-selection-mode
;; ;; Es IMPORTANTE NO BORRAR de manera contínua icicles, se están
;; ;; generando demasiados errores de manera frecuente con cada
;; ;; actualización
;; (add-hook 'icicle-mode-hook 'bind-my-icicles-keys)
;; (add-hook 'icicle-mode-hook 'bind-my-icicles-top-keys)
;; (defun bind-my-icicles-keys ()
;;   "Replace some default Icicles minibuffer bindings with others."
;;   (dolist (map (append (list minibuffer-local-completion-map
;;                              minibuffer-local-must-match-map)
;;                        (and (fboundp 'minibuffer-local-filename-completion-map)
;;                             (list minibuffer-local-filename-completion-map))))
;;     (when icicle-mode
;;       (define-key map (icicle-kbd "M-¬")
;;         'icicle-all-candidates-list-alt-action))))


;; (require 'icicles)
;; (defun bind-my-icicles-top-keys ()
;;   "Set some Icicles bindings for `icicle-mode'"
;;   (when icicle-mode
;;     (define-key icicle-mode-map (icicle-kbd "C-c l") 'icicle-locate)))


;; para utilizar "expand-region" similar a como viene en emacsrocks.com/e09.html
;; con un key-bind que no viene recomendado en la página de github
(eval-after-load "expand-region"
    '(progn (global-set-key (kbd "M-_") 'er/expand-region)
	   (global-set-key (kbd "C-M-_") 'er/contract-region)))


;; para moverse atravez de los "windows":, e.g.: c-left  =  windmove-left
(windmove-default-keybindings 'control)

;; Para seguir la configuración de i3-wm
(eval-after-load "windmove"
  '(progn  (global-set-key (kbd "M-J") 'windmove-left)
	   (global-set-key (kbd "M-Ñ") 'windmove-right)
	   (global-set-key (kbd "M-L") 'windmove-up)
	   (global-set-key (kbd "M-K") 'windmove-down)))

(global-set-key (kbd "C-c C-n") 'acm-problem)


;; zencoding-mode
(eval-after-load "zencoding-mode"
  ;; Auto-start on any markup modes
  '(progn (add-hook 'sgml-mode-hook 'zencoding-mode)
	  (define-key zencoding-mode-keymap (kbd "C-c C-j")
	    'zencoding-expand-line)
	  (define-key zencoding-mode-keymap (kbd "C-j") 'nil)
	  (define-key zencoding-mode-keymap (kbd "<C-return>") 'nil)))


;; Webjump let's you quickly search google, wikipedia, emacs wiki
(global-set-key (kbd "C-x g") 'webjump)
(global-set-key (kbd "C-x M-g") 'browse-url-at-point)


;; magit-mode



(eval-after-load "magit"
    '(progn
      (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)
      (global-set-key (kbd "C-c M-m") 'magit-status)))

;; ;; nose-mode
;; (require 'nose)
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (local-set-key "\C-ca" 'nosetests-all)
;;             (local-set-key "\C-cmo" 'nosetests-module)
;;             (local-set-key "\C-c." 'nosetests-one)
;;             (local-set-key "\C-cpa" 'nosetests-pdb-all)
;;             (local-set-key "\C-cpm" 'nosetests-pdb-module)
;;             (local-set-key "\C-cp." 'nosetests-pdb-one)))


;; Window rotations and toggle, from:
;; https://github.com/magnars/.emacs.d/blob/master/key-bindings.el
(global-set-key (kbd "C-x -") 'rotate-windows)
(global-set-key (kbd "C-x C--") 'toggle-window-split)
(global-unset-key (kbd "C-x C-+")) ;; don't zoom like this


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
               (kbd "C-c ;") 'maxima-insert-short-comment)))


;; (define-key maxima-mode-map (kbd "M-;") 'comment-dwim)
;; (define-key maxima-mode-map (kbd "C-c ;") 'maxima-insert-short-comment)


;; para utilizar completación de historial como en terminal

(eval-after-load "python"
    '(progn    (define-key inferior-python-mode-map [(meta p)]
		'comint-previous-matching-input-from-input)
	      (define-key inferior-python-mode-map [(meta n)]
		'comint-next-matching-input-from-input)
	      (define-key inferior-python-mode-map [(control meta n)]
		'comint-next-input)
	      (define-key inferior-python-mode-map [(control meta p)]
		'comint-previous-input)
	      (define-key inferior-python-mode-map
		(kbd "C-c C-z") 'quit-window)))

;; las siguientes líneas impiden que el movimiento entre windows se
;; modifique por los keybinds de comint
(add-hook  'comint-mode-hook
	   '(lambda ()
	      (define-key comint-mode-map [C-down] nil)
	      (define-key comint-mode-map [C-up] nil)
	      (define-key comint-mode-map [C-right] nil)
	      (define-key comint-mode-map [C-left] nil)))


;; (defun load-ropemacs ()
;;   "load pymacs and ropemacs, special configurations made by René Zurita Corro."
;;   ;; initialize pymacs
;;   (interactive)
;;   (autoload 'pymacs-apply "pymacs")
;;   (autoload 'pymacs-call "pymacs")
;;   (autoload 'pymacs-eval "pymacs" nil t)
;;   (autoload 'pymacs-exec "pymacs" nil t)
;;   (autoload 'pymacs-load "pymacs" nil t)
;;   (autoload 'pymacs-autoload "pymacs")
;;   ;; module "desktop" savagely kills `*pymacs*' in some circumstances.
;;   ;; let's avoid such damage.
;;   (eval-after-load 'desktop
;;     '(push "\\*pymacs\\*" desktop-clear-preserve-buffers))
;;   ;; initialize rope
;;   ;; (setq ropemacs-enable-shortcuts t)
;;   ;; (setq ropemacs-local-prefix "C-c c-p")  ;esta línea es innecesaria,
;;   ;;                                         ;parece que los prefijos
;;   ;;                                         ;locales no interfieren con
;;   ;;                                         ;nada, en caso contrario, hay
;;   ;;                                         ;que un prefijo diferente al
;;   ;;                                         ;que está por default
;;   (setq ropemacs-global-prefix "C-c p")
;;   ;; (require 'pymacs)    ;al parecer no es necesaria esta línea ya que
;;   ;;                      ;pymacs fué cargado con anterioridad, quizá
;;   ;;                      ;sea conveniente identificar una nueva forma
;;   ;;                      ;de cargar rope sólo cuando es necesario
;;   (pymacs-load "ropemacs" "rope-")
;;   (setq ropemacs-enable-autoimport t)
;;   ;; automatically save project python buffers before refactorings
;;   (setq ropemacs-confirm-saving 'nil)
;;   (ropemacs-mode)
;;   (ac-ropemacs-initialize)
;;   (add-to-list 'ac-sources
;;                'ac-source-ropemacs))
;; (global-set-key "\C-cpl" 'load-ropemacs)


;; ;; Se intenta con esta nueva opción
;; (add-hook 'ein:shared-output-mode-hook
;;           '(lambda ()
;;              (define-key ein:shared-output-mode-map (kbd "q") 'quit-window)))


;; (eval-after-load "ein-notebook"
;;   '(progn
;;      ;; se desaactivan movimientos entre celdas para que no interfiera con
;;      ;; el movimiento entre windows de emacs, hay que modificar el key-map
;;      ;; ein:notebook-mode-map
;;      (define-key ein:notebook-mode-map [C-down] nil)
;;      (define-key ein:notebook-mode-map [C-up] nil)


;;      ;; estos movimientos son remapeados a la tecla shift para no perder
;;      ;; esta funcionalidad
;;      (define-key ein:notebook-mode-map [S-down] 'ein:worksheet-goto-next-input)
;;      (define-key ein:notebook-mode-map [S-up] 'ein:worksheet-goto-prev-input)
;;      (define-key ein:notebook-mode-map (kbd "C-;")
;;        'ein:shared-output-pop-to-buffer)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multiple-cursors, emacs rocks: http://emacsrocks.com/e13.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; -------------------------------------------------------------------
;; Quizás sea conveniente revisar los demás keybinds de magnars, están
;; en la página: https://github.com/magnars/.emacs.d/blob/master/key-bindings.el

(eval-after-load "multiple-cursors"
    '(progn (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
	    (global-set-key (kbd "C->") 'mc/mark-next-like-this)
	    (global-set-key (kbd "C-M-<") 'mc/mark-previous-symbol-like-this)
	    (global-set-key (kbd "C-M->") 'mc/mark-next-symbol-like-this)
	    ;; like the other two, but takes an argument (negative is previous)
	    ;; (global-set-key (kbd "C-M-m") 'mc/mark-more-like-this)
	    (global-set-key (kbd "C-*") 'mc/mark-all-like-this)
	    (global-set-key (kbd "C-M-*") 'mc/mark-all-symbols-like-this)
	    (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
	    (global-set-key (kbd "C-S-c C-e") 'mc/edit-ends-of-lines)
	    (global-set-key (kbd "C-S-c C-a") 'mc/edit-beginnings-of-lines)
	    (global-set-key (kbd "C-S-p") 'mc/mark-pop)
	    (global-set-key (kbd "C-c C-r") 'rename-sgml-tag)
	    ;; No he podido identificar la tecla Hyper, así que estoy probando
	    ;; diferentes opciones, investigar más respecto a ns-function-modifier
	    ;; (setq ns-function-modifier 'hyper )
	    ;; (global-set-key (kbd "H-SPC") 'set-rectangular-region-anchor)
	    ;;Hay que optimizar:
	    (global-set-key (kbd "C-S-SPC") 'set-rectangular-region-anchor)
	    ;; AltGr-a = æ
	    (global-set-key (kbd "M-æ") 'mc/mark-all-like-this-dwim)
	    ;; AltGr-i = →
	    (global-set-key (kbd "M-→") 'mc/insert-numbers)
	    ;; AltGr-r = ¶
	    (global-set-key (kbd "M-¶") 'mc/reverse-regions)
	    ;; AltGr-s = ß
	    (global-set-key (kbd "M-ß") 'mc/sort-regions)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; acejump, http://emacsrocks.com/e10.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; los keybinds son los sugeridos por emacs rocks

(eval-after-load "ace-jump-mode"
    ';; (define-key global-map (kbd "C-ø") 'ace-jump-mode)
    ;; (define-key global-map (kbd "M-ø") 'ace-jump-mode) ; to access in terminal
    (progn
       (define-key global-map (kbd "M-ñ") 'ace-jump-mode) ; to access in terminal
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

(provide 'keybinds-conf)
