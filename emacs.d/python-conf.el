;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nueva funcionalidad experimental para cargar rope y pymacs sólo ;;
;; cuando son necesarios                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun load-ropemacs ()
  "load pymacs and ropemacs, special configurations made by René Zurita Corro."
  ;; initialize pymacs
  (interactive)
  (autoload 'pymacs-apply "pymacs")
  (autoload 'pymacs-call "pymacs")
  (autoload 'pymacs-eval "pymacs" nil t)
  (autoload 'pymacs-exec "pymacs" nil t)
  (autoload 'pymacs-load "pymacs" nil t)
  (autoload 'pymacs-autoload "pymacs")
  ;; module "desktop" savagely kills `*pymacs*' in some circumstances.
  ;; let's avoid such damage.
  (eval-after-load 'desktop
    '(push "\\*pymacs\\*" desktop-clear-preserve-buffers))
  ;; initialize rope
  ;; (setq ropemacs-enable-shortcuts t)
  ;; (setq ropemacs-local-prefix "C-c c-p")  ;esta línea es innecesaria,
  ;;                                         ;parece que los prefijos
  ;;                                         ;locales no interfieren con
  ;;                                         ;nada, en caso contrario, hay
  ;;                                         ;que un prefijo diferente al
  ;;                                         ;que está por default
  ;; (setq ropemacs-global-prefix "C-x p") ;esta línea interfiere con los
  ;; 					   ;keybinds de `projetile', por
  ;; 					   ;lo que se comenta para
  ;; 					   ;restaurar su valor original
  ;; 					   ;`C-xp', se deja como
  ;; 					   ;referencia en caso de
  ;; 					   ;posibles confilctos
  ;; 					   ;posteriores
  ;; (require 'pymacs)    ;al parecer no es necesaria esta línea ya que
  ;;                      ;pymacs fué cargado con anterioridad, quizá
  ;;                      ;sea conveniente identificar una nueva forma
  ;;                      ;de cargar rope sólo cuando es necesario
  (pymacs-load "ropemacs" "rope-")
  (setq ropemacs-enable-autoimport t)
  ;; automatically save project python buffers before refactorings
  (setq ropemacs-confirm-saving 'nil)
  (ropemacs-mode)
  (ac-ropemacs-initialize)
  (add-to-list 'ac-sources
               'ac-source-ropemacs))
;; (global-set-key "\C-cpl" 'load-ropemacs)
(global-set-key "\C-xpl" 'load-ropemacs)

;;(require 'pymacs)
;;(pymacs-load "ropemacs" "rope-")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python, el siguiente código enlaza ipython con python.el gallina
;; por alguna razón no está funcionando con ipython 0.12, así que lo
;; cambio, debe de quedar pendiente en la lista de python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'python)
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args "console --colors=linux --existing"
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
 "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
 "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
 "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
 )

(provide 'python-conf)
