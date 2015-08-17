;; Para utilizar icicles, es recomendable cargarlo después de cargar
;; delete-selection-mode
;; Es IMPORTANTE NO BORRAR de manera contínua icicles, se están
;; generando demasiados errores de manera frecuente con cada
;; actualización
(add-hook 'icicle-mode-hook 'bind-my-icicles-keys)
(add-hook 'icicle-mode-hook 'bind-my-icicles-top-keys)
(defun bind-my-icicles-keys ()
  "Replace some default Icicles minibuffer bindings with others."
  (dolist (map (append (list minibuffer-local-completion-map
                             minibuffer-local-must-match-map)
                       (and (fboundp 'minibuffer-local-filename-completion-map)
                            (list minibuffer-local-filename-completion-map))))
    (when icicle-mode
      (define-key map (icicle-kbd "M-O")
        'icicle-insert-history-element)
      (define-key map (icicle-kbd "M-¬")
        'icicle-all-candidates-list-alt-action))))

(defun bind-my-icicles-top-keys ()
  "Set some Icicles bindings for `icicle-mode'"
  (when icicle-mode
    (define-key icicle-mode-map (icicle-kbd "C-c l") 'icicle-locate)
    (define-key icicle-mode-map (icicle-kbd "C-c C-f") 'icicle-recent-file)))

(require 'icicles)

(setq icicle-top-level-when-sole-completion-delay 0.1)
(setq icicle-zap-to-char-candidates 'icicle-ucs-names)

;; En el caso de archivos, el número de candidatos puede crecer
;; demasiado, por lo que no conviene mostrar los candidatos en ese
;; caso
(setq completion-ignore-case t)
(setq icicle-files-ido-like-flag nil)
;; (setq icicle-buffers-ido-like-flag t)
(icy-mode 1)

(provide 'icicles-conf)
