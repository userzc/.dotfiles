;; Se inicia de nuevo con emacs 24
;; tested on emacs-version "24.3.1"
;; not working on emacs-version "24.3.50.1"
;; Para deshabilitar tool-bar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; Emacs gurus don't need no stinking scroll bars
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backend-files t)

(defvar lista-paquetes-instalados
  '(ac-math ace-jump-mode ack-and-a-half auctex auto-complete
	    bookmark+ c-eldoc cl-lib clues-theme color-theme
	    color-theme-gruber-darker color-theme-sanityinc-tomorrow
	    color-theme-solarized color-theme-wombat+ cyberpunk-theme
	    dash deferred dired+ dired-details dired-details+ ein
	    enclose expand-region git-commit-mode gitconfig-mode
	    github-theme gitignore-mode google-c-style google-contacts
	    icicles icomplete+ ido-better-flex magit
	    mark-more-like-this markdown-mode melpa monokai-theme
	    multi-term multiple-cursors nose oauth2 popup purty-mode
	    python qsimpleq-theme rainbow-delimiters rainbow-mode
	    request smart-mode-line smart-tab tango-2-theme
	    tangotango-theme textile-mode websocket wgrep windsize
	    wrap-region yasnippet zenburn-theme zencoding-mode
	    powerline)
  "Lista de paquetes instalados actualmente en mi configuración.")

;; ;; esta parte es para comprobar que paquetes están installados
;; (loop for p in lista-paquetes-instalados
;;       when (package-installed-p p) do
;;       (print p))

(require 'cl)

;; Intentando nueva forma para descargar paquetes, basado en
;; https://github.com/purcell/emacs.d y
;; https://github.com/magnars/.emacs.d/blob/master/setup-package.el
(unless (file-exists-p "~/.emacs.d/elpa/archives/melpa")
  (package-refresh-contents))

(defun packages-install (packages)
  "Función para determinar si todos los paquetes de la lista de
paquetes están instalados en la máquina actual."
  (loop for p in packages
        when (not (package-installed-p p)) do (package-install p)
        finally (return t)))

;; On-demand installation of packages
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(defun init--install-packages ()
  (packages-install
   lista-paquetes-instalados))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; ;; Para los números de línea
;; (global-linum-mode 1)
;; (setq linum-format "%d ")

;; ;; smart-modeline-mode
;; (sml/setup)

;; ;; abl-mode, no parece funcionar para nada
;; (load-file "~/.emacs.d/elpa/abl-mode-20120718.1655/abl-mode.el")
;; (require 'abl)
;; (add-hook 'python-mode-hook 'abl-mode-hook)
;; (setq nose-command "nosetest -s %s")
;; (setq vem-activate-command "workon %s")
;; (setq vem-create-commad "mkvirtualenv %s")

;; Para cargar archivos en `~/.emacs.d'
(add-to-list 'load-path user-emacs-directory)


;; Configuración para diferentes archivos
(require 'automodes-conf)

;; ibuffer > list-buffer
(global-set-key (kbd "C-x C-b") 'ibuffer-list-buffers)

;; zap-up-to-char
(require 'misc)
(global-set-key (kbd "M-Z") 'zap-up-to-char)

;; easier navigation, assumes `misc.el'
(global-set-key (kbd "M-F") 'forward-to-word)
(global-set-key (kbd "M-B") 'backward-to-word)

;; delete-pairs
(global-set-key (kbd "C-c d") 'delete-pair)

;; Para quitar el cursor del mouse cuando estorba
(mouse-avoidance-mode 'banish)

;; Para los números de columna
(column-number-mode 1)

;; Para utilizar enclose-mode en todos los buffers
;; https://github.com/rejeep/enclose
(enclose-global-mode t)
(enclose-add-encloser "`" "`")
;; (enclose-add-encloser "$" "$")
(add-to-list 'enclose-except-modes 'dired-mode)

;; Se reindenta la línea después de insertar un caracter.
;; SE PUEDE ESPERAR QUE NECESITA CORRECCIÓN POSTERIOR, EN CASO DE QUE
;; SEA NECESARIO.
(defadvice enclose-trigger (after enclose-reindent-line activate)
  "Indenta la línea actual, sólo en los 'major-mode' apropiados"
  (if (member (buffer-local-value 'major-mode (current-buffer)) '(c++-mode))
      (indent-for-tab-command)))

;; ;; Parece ser que este `advice' no es necesario debido a las funciones
;; ;; que se definen en la parte de abajo
(defadvice open-line (after open-line-reindent-line activate)
  "Indenta la nueva línea, sólo en los 'major-mode' apropiados"
  (if (member (buffer-local-value 'major-mode (current-buffer))
              '(c++-mode))
      (save-excursion
        (next-line)
        (indent-for-tab-command))))

;; Opening new lines can be finicky.
;; http://whattheemacsd.com/editing-defuns.el-01.html
(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)

;; Para ayudar a copiar una línea completa
(global-set-key (kbd "C-c k") 'kill-whole-line)

;; Para reindentar el buffer después de borrar un "tag"
(defadvice sgml-delete-tag (after reindent-buffer activate)
  "Reindenta el buffer después de eliminar un 'tag'"
  (cleanup-buffer))

;; Hay que revisar con cuidado el paquete `smart-parens'.
;; Similar a `paredit'.
;; https://github.com/Fuco1/smartparens

;; Para utilizar wrap-region-mode en todos los buffers
;; https://github.com/rejeep/wrap-region
;; Al parecer tengo que utilizar el paquete "cl" para que funcione
;; de manera correcta
;; (require 'cl)
(wrap-region-global-mode t)
(wrap-region-add-wrapper "*" "*" nil 'org-mode)
(wrap-region-add-wrapper "/" "/" nil 'org-mode)
(wrap-region-add-wrapper "_" "_" nil 'org-mode)
(wrap-region-add-wrapper "`" "`" nil '(gfm-mode markdown-mode emacs-lisp-mode))
(wrap-region-add-wrapper "$" "$" nil '(python-mode markdown-mode))

(add-to-list 'wrap-region-except-modes 'ibuffer-mode)
(add-to-list 'wrap-region-except-modes 'term-mode)

(global-set-key [remap goto-line] 'goto-line-with-feedback)

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

(eval-after-load "octave-inf"
  '(progn
     (define-key inferior-octave-mode-map [C-d] nil)
     (define-key inferior-octave-mode-map [C-up] nil)
     (define-key inferior-octave-mode-map [C-right] nil)
     (define-key inferior-octave-mode-map [C-left] nil)))


;; Para cargar google c style:

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
;; If you want the RETURN key to go to the next line and space over
;; to the right place, add this to your .emacs right after the load-file:
;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; Al parecer es en c++-mode-map que se deben de añadir las cosas, en
;; caso de que empiece a hacer considerablemente grande la lista de
;; configuraciones para los modos relacionados con C, es preferible
;; definir una función con un nombre particular en lugar de usar la
;; función "lambda"
(add-hook 'c-initialization-hook
          '(lambda ()
             (define-key c++-mode-map (kbd "C-c C-c") 'compile)
             (define-key c++-mode-map (kbd "C-c C-r") 'recompile)))

;; c-eldoc
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
(add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)

;; Uniquify
(require 'uniquify )
(setq uniquify-buffer-name-style 'post-forward)


;; Para contestar "y-or-n" en lugar de  "yes-or-no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Para indicar lineas vacias
(set-default 'indicate-empty-lines t)

;; Para recuperar 'shell-command-on-region'
(global-set-key (kbd "M-¬") 'shell-command-on-region)

;; Fringes pequeñas
(set-fringe-mode '(1 . 1))

;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)

;; julia-mode
(add-to-list 'load-path "~/julia_test/julia/contrib/")
(condition-case nil
    (require 'julia-mode)
  (error
   (message "Didn't find Julia Mode'")))


;; Al parecer las siguientes lineas hacen que cualquier subdirectorio
;; de la carpeta "~/.emacs.d/lisp/" sea cargada al load-path, lo cual
;; es necesario para los paquetes:
;; - nxhtml     : se obtiene mumamo-mode y más.
;; - linkd      : Drew Adams lo utiliza p/documentaciones de sus paquetes
(add-to-list 'load-path "~/.emacs.d/lisp/")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; Borrar los espacios en blanco innecesarios al final de las lineas
(add-hook 'before-save-hook 'cleanup-buffer-safe)

;; La siguiente opción se añade para poder utilizar emacs como servidor
;; en particular en ipython y en octave
(server-start)


;; Las siguientes lineas son para probar el paquete Bookmark+
(require 'bookmark+)
(global-set-key "\C-cb" bookmark-map)
(global-set-key "\C-cbc" bmkp-set-map)
(global-unset-key "\C-xp")

;; Para utilizar el paquete dired+
(require 'dired+)

;; Se añade la librería "dired-x", extensiones necesarias por ejemplo
;; para abrir varios archivos marcados en dired mode, etc.
;; Se puede investigar cómo hacer algo similar con icicles
(add-hook 'dired-load-hook
          (function (lambda () (load "dired-x"))))

;; dired-details+
(require 'dired-details+)
(setq-default dired-details-hidden-string "--- " )

;; Para utilizar el modo "Delete Selection Mode"
;; que borra la region seleccionada cuando se presiona una tecla
(delete-selection-mode t)

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
      (define-key map (icicle-kbd "M-¬")
        'icicle-all-candidates-list-alt-action))))

(require 'icicles)
(defun bind-my-icicles-top-keys ()
  "Set some Icicles bindings for `icicle-mode'"
  (when icicle-mode
    (define-key icicle-mode-map (icicle-kbd "C-c l") 'icicle-locate)))

(setq icicle-top-level-when-sole-completion-delay 0.1)
(setq icicle-zap-to-char-candidates 'icicle-ucs-names)
;; En el caso de archivos, el número de candidatos puede crecer
;; demasiado, por lo que no conviene mostrar los candidatos en ese
;; caso
(setq completion-ignore-case t)
(setq icicle-files-ido-like-flag nil)
;; (setq icicle-buffers-ido-like-flag t)
(icy-mode 1)


;; ;; Ido backup settings
(ido-mode -1)
;; (setq ido-enable-flex-mathching t)
;; (setq ido-everywhere t)
;; (ido-better-flex/enable)
;; (ido-mode 1)

;; para utilizar "expand-region" similar a como viene en emacsrocks.com/e09.html
;; con un key-bind que no viene recomendado en la página de github
(require 'expand-region)
(global-set-key (kbd "M-_") 'er/expand-region)
(global-set-key (kbd "C-M-_") 'er/contract-region)

;; para ver paréntesis en pares
(show-paren-mode t)

;; para moverse atravez de los "windows":, e.g.: c-left  =  windmove-left
(windmove-default-keybindings 'control)

;; para utilizar yasnippet
(require 'yasnippet)
;; hay que chacar como se utiliza el directorio ~/.emacs.d/snippets
;; (setq yas/snippet-dirs '("~/.emacs.d/snippets" "~/.emacs.d/extras/imported"))
(yas/global-mode 1)


;; para utilizar desktop y se guarden los ultimos buffers que se editaban
(desktop-save-mode 1)
(add-to-list 'desktop-minor-mode-table '(icicle-mode nil))
(add-to-list 'desktop-minor-mode-handlers  '(icicle-mode . nil))
;; (add-to-list 'desktop-minor-mode-table (icy-mode nil))

;; para utilizar icomplete+
(icomplete-mode t)
(eval-after-load "icomplete" '(progn (require 'icomplete+)))

;; para que el diccionario por default de aspell sea castellano8
(setq ispell-dictionary "castellano8")

;; para utilizar sólo espacios
(setq indent-tabs-mode nil)

;; Ack-and-a-half
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
;; always ask for directory in which to run ack
(setq ack-and-a-half-prompt-for-directory t)

;; funciones para el juez uva online acm icpc
(defun acm-problem (id_problem)
  "esta función abre o genera una carpeta con sus respectivos
archivos en base al nombre del problema de la uva que se intenta
resolver"
  (interactive "sUVA Problem Id:")
  (let (nuevo-dir-problem)
    (setq nuevo-dir-problem (concat "~/Documents/ACM-ICPC/Tried/" id_problem))
    (message nuevo-dir-problem)
    (if (file-directory-p nuevo-dir-problem)
        (progn
          (message  (concat "Ya existe: " id_problem))
          (find-file (concat nuevo-dir-problem "/" id_problem "output.txt"))
          (find-file (concat nuevo-dir-problem "/" id_problem  "input.txt"))
          (find-file (concat nuevo-dir-problem "/" id_problem ".cpp")))
      (progn
        (message (concat "Se crea: " id_problem))
        (dired-create-directory nuevo-dir-problem)
        (find-file (concat nuevo-dir-problem "/" id_problem ".cpp"))
        (find-file (concat nuevo-dir-problem "/" id_problem "output.txt"))
        (find-file (concat nuevo-dir-problem "/" id_problem  "input.txt"))))))

(global-set-key (kbd "C-c C-n") 'acm-problem)

;; zencoding-mode
(require 'zencoding-mode)
;; Auto-start on any markup modes
(add-hook 'sgml-mode-hook 'zencoding-mode)
(define-key zencoding-mode-keymap (kbd "C-c C-j") 'zencoding-expand-line)
(define-key zencoding-mode-keymap (kbd "C-j") 'nil)
(define-key zencoding-mode-keymap (kbd "<C-return>") 'nil)

;; Webjump let's you quickly search google, wikipedia, emacs wiki
(global-set-key (kbd "C-x g") 'webjump)
(global-set-key (kbd "C-x M-g") 'browse-url-at-point)

;; magit-mode
(global-set-key (kbd "C-c M-m") 'magit-status)

;; full screen magit-status, http://whattheemacsd.com/setup-magit.el-01.htmln
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(require 'magit)
(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)


;; nose-mode
(require 'nose)
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key "\C-ca" 'nosetests-all)
            (local-set-key "\C-cmo" 'nosetests-module)
            (local-set-key "\C-c." 'nosetests-one)
            (local-set-key "\C-cpa" 'nosetests-pdb-all)
            (local-set-key "\C-cpm" 'nosetests-pdb-module)
            (local-set-key "\C-cp." 'nosetests-pdb-one)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; powerline, ver: https://github.com/jonathanchu/emacs-powerline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; version previously installed:
;; https://github.com/milkypostman/powerline

(setq powerline-default-separator 'wave)

(powerline-default-theme)
;; (powerline-center-theme)
;; (powerline-vim-theme)
;; (powerline-nano-theme)

;; ;;--------------------------------------------------------------------
;; ;; Another version: installed
;; ;; https://github.com/jonathanchu/emacs-powerline
;; ;;--------------------------------------------------------------------
;; ;; La configuración debe depender del color-theme, lo cual crea
;; ;; icompatibilidades, quizá después tenga la intensión de configurarlo
;; ;; adecuadamente
;; (require 'powerline)
;; (setq powerline-arrow-shape 'arrow)   ;; give your mode-line curves1
;; (defun powerline-settings ()
;;   "Personal settings for powerline"
;;   (interactive)
;;   (progn
;;     ;; (setq powerline-arrow-shape 'arrow)   ;; the default
;;     ;; (setq powerline-arrow-shape 'curve)   ;; give your mode-line curves1
;;     ;; (setq powerline-arrow-shape 'arrow14) ;; best for small fonts
;;     ;; (setq powerline-color1 "grey22")
;;     ;; (setq powerline-color2 "grey40")
;;     ;; (setq powerline-color1 "MediumPurple1")
;;     ;; (setq powerline-color2 "purple1")
;;     (setq powerline-color1 "#657b83")
;;     (setq powerline-color2 "#839496")
;;     (set-face-attribute 'mode-line nil
;;                         :foreground "#fdf6e3"
;;                         :background "orchid4"
;;                         :box nil)
;;     (set-face-attribute 'mode-line-inactive nil
;;                         :box nil)))

;; (defadvice color-theme-wombat+ (after wombat+-powerline-reload activate)
;;   "Reload powerline settings"
;;   (powerline-settings))

;; (defadvice load-theme (after load-theme-powerline-reload activate)
;;   "Reload powerline settings"
;;   (powerline-settings))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load-theme & color-theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Se define la siguiente variable para compatibilidad de los temas
;; solarized en terminal, sin embargo no son tan buenos como uno
;; esperaría
;; (setq solarized-termcolors 256)

;; Añadiendo caminos a `custom-theme-load-path'
(add-to-list 'custom-theme-load-path
             "~/.emacs.d/lisp/emacs-tron-theme/")
(add-to-list 'custom-theme-load-path
             "~/.emacs.d/elpa/tangotango-theme-20121014.1916/")

;; Something is wrong with this, but what?
;; (add-to-list 'custom-theme-load-path
;;              (car (directory-files
;; 		   (concat user-emacs-directory "elpa" )
;; 		   nil "tangotango-theme*")))

(add-to-list 'custom-theme-load-path
             "~/.emacs.d/elpa/github-theme-0.0.3/")
(add-to-list 'custom-theme-load-path
             "~/.emacs.d/lisp/default-black-theme/")
(add-to-list 'custom-theme-load-path
             "~/.emacs.d/elpa/moe-theme-20130625.1427/")


;; (require 'moe-theme-switcher)
;; (require 'color-theme )
;; (setq color-theme-load-all-themes nil)
;; (load-file
;;  "~/.emacs.d/elpa/color-theme-wombat+-0.0.2/color-theme-wombat+.el")
;; (color-theme-wombat+)
;; (load-theme 'wombat+ t)
(load-theme 'tangotango t)
;; (load-theme 'wombat t)
;; (load-theme 'tango-2 t)
;; (load-theme 'cyberpunk t)  ; no funciona con multi-term
;; (load-theme 'tron t)
;; (load-theme 'github t)
;; (load-theme 'moe-light t)
;; (load-theme 'monokai t)
;; (load-theme 'clues t)
;; (load-theme 'assemblage t)
;; (load-theme 'default-black t)
;; (custom-set-faces '(default ((t (:background "nil")))))
;; (load-theme 'zenburn t)
;; (load-theme 'sanityinc-tomorrow-day t)
;; (load-theme 'solarized-light t)
;; (load-theme 'qsimpleq t)

;; ;; font
;; (set-default-font "Inconsolata-12")
(if (equal system-type 'gnu/linux)
    (condition-case nil
	(set-default-font "Ubuntu Mono-11")
      (error
       (set-default-font "Inconsolata-11")))
  (condition-case nil
      (set-default-font "Inconsolata-11")
    (error
     (set-default-font "DejaVu Sans Mono-10"))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rotate-windows, ver: http://whattheemacsd.com/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This snippet flips a two-window fame, so that left is right, or up
;; is down. It's sanity preserving if you've got a sliver of OCD.
;;
;; In the case of multiple windows, the snippeet shifts the order of
;; the window, like the next invariant permutation.
(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; toggle-window-splilt, ver: http://whattheemacsd.com/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Annoyed when Emacs opens the window below instead at the side?
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))



;; Window rotations and toggle, from:
;; https://github.com/magnars/.emacs.d/blob/master/key-bindings.el
(global-set-key (kbd "C-x -") 'rotate-windows)
(global-set-key (kbd "C-x C--") 'toggle-window-split)
(global-unset-key (kbd "C-x C-+")) ;; don't zoom like this


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Cleanup buffer application for every-day use
;; as seen on emacsrocks: http://emacsrocks.com/e12.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun cleanup-buffer-safe ()
  "Perform a bunch of safe operations on the whitespace content of a buffer.
Does not indent buffer, because it is used for a before-save-hook, and that
might be bad."
  (interactive)
  (delete-trailing-whitespace))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (untabify (point-min) (point-max))
  (cleanup-buffer-safe)
  (indent-region (point-min) (point-max)))

(global-set-key (kbd "C-c n") 'cleanup-buffer)
;; Se necesita encontrar un nuevo key-bind para esta función y poder
;; intentar `abl-mode' con sus default key-binds.
(global-set-key (kbd "C-c w") 'cleanup-buffer-safe)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nXhtml, ver: http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Se puede cambiar la versión compilada de este archivo por la
;; extención sin compilar [.elc <=> .el]

;; (load "~/.emacs.d/lisp/nxhtml/autostart.elc")
(load "~/.emacs.d/lisp/nxhtml/autostart.el")

(setq debug-on-error nil)
(setq mumamo-background-colors nil)

;; Esta parte en particular no la he podido hechar a andar para
;; probarla con ein-mode para IPython Notebook, hace falta checar que
;; se puede hacer con la siguiente línea de código.
;; ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;; Para activar nXhtml, en particular para utilizar MuMaMo,
;; (require 'nxhtml-autostart)

;; Como alternativa se puede utilizar un archivo `.dir-locals.el' para
;; definir variables locales con el siguiente código:
;; ((html-mode . ((eval . (django-html-mumamo-mode)))))

;; `C-d' to terminate process and kill buffer in shell buffers,
;; ver: http://whattheemacsd.com/setup-shell.el-01.html
(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))

(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map
              (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))

;; Make it work in inferior processes: octave-inferior, imaxima, etc.
(add-hook 'comint-mode-hook
          (lambda ()
            (define-key comint-mode-map
              (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multi-term
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Es necesario deshabilitar "yas/minor-mode" en este "major-mode" para
;; poder tener acceso a autocompletion mediante TAB
(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)
(eval-after-load 'desktop
  '(push "\\*MULTI-TERM-DEDICATED\\*" desktop-clear-preserve-buffers))

;; (setq multi-term-program "/bin/bash")   ;; use bash
(setq multi-term-program "/bin/zsh") ;; or use zsh...

;; Para evitar que el buffer dedicato sea considerado al cambiar a
;; otra ventana
(setq multi-term-dedicated-skip-other-window-p t)

;; (global-set-key (kbd "C-c t") 'multi-term-next)
;; hay que buscar otro `key-bind' que sí funcione en `python-mode'
(global-set-key (kbd "C-c c m") 'multi-term-dedicated-toggle)
(global-set-key (kbd "C-c c M") 'multi-term) ;; create a new one

(defadvice multi-term-dedicated-open
  (after do-select-dedicated-window )
  "Seleciona buffer `*MULTI-TERM-DEDICATED*' al utilizar el
  `multi-term-dedicated-open', útil al usar
  `multi-term-dedicated-toggle'."
  (multi-term-dedicated-select))

;; Para evitar que "yasnippet" interfiera con la completación mediante
;; TAB en "zsh"
(add-hook 'term-mode-hook
          '(lambda ()
             ;; To change from `char-mode' to `line-mode'
             (define-key term-raw-map (kbd "C-c C-j") 'term-line-mode)
             (setq yas/minor-mode nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuración GNUS para Gmail
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq user-full-name "René Zurita Corro" )
(setq user-mail-address "zc.rene@gmail.com" )
(setq gnus-select-method
      '(nnimap "gmail"
               (nnimap-address "imap.gmail.com")
               (nnimap-server-port 993)
               (nnimap-stream ssl)))
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials
      '(("smtp.gmail.com" 587 "zc.rene@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-local-domain "yourcompany.com")
;; Make Gnus NOT ignore [Gmail] mailboxes
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

;; Integración con google-contacts
(require 'google-contacts-gnus)

;; Integración para complementar nombres en los mensajes
(require 'google-contacts-message)
;; Esta parte requiere hacer unos ajustes con "smart-tab" para que no
;; se bloquee la función de complementación, pero eso requiere un poco
;; de pruebas con más calma, de momento si se desactiva "smart-tab" en
;; el modo de mensajes

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

;;--------------------------------------------------------------------
;; http://cx4a.org/software/auto-complete/manual.html#Enable_auto-complete-mode_automatically_for_specific_modes
;;--------------------------------------------------------------------
;; Ver las configuraciones hechas en "load-ropemacs" para más detalles.

;;--------------------------------------------------------------------
;; El siguiente código fué tomado de
;; http://www.enigmacurry.com/2009/01/21/autocompleteel-python-code-completion-in-emacs/
;; con la finalidad de integrar auto-complete-mode con rope, sin
;; embargo parece no ser tan necesario, de culaquier forma se deja
;; para futuras referencias
;;--------------------------------------------------------------------

;; (defun prefix-list-elements (list prefix)
;;   (let (value)
;;     (nreverse
;;      (dolist (element list value)
;;        (setq value (cons (format "%s%s" prefix element) value))))))
;; (defvar ac-source-rope
;;   '((candidates
;;      . (lambda ()
;;          (prefix-list-elements (rope-completions) ac-target))))
;;   "Source for Rope")
;; (defun ac-python-find ()
;;   "Python `ac-find-function'."
;;   (require 'thingatpt)
;;   (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
;;     (if (null symbol)
;;         (if (string= "." (buffer-substring (- (point) 1) (point)))
;;             (point)
;;           nil)
;;       symbol)))
;; (defun ac-python-candidate ()
;;   "Python `ac-candidates-function'"
;;   (let (candidates)
;;     (dolist (source ac-sources)
;;       (if (symbolp source)
;;           (setq source (symbol-value source)))
;;       (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
;;              (requires (cdr-safe (assq 'requires source)))
;;              cand)
;;         (if (or (null requires)
;;                 (>= (length ac-target) requires))
;;             (setq cand
;;                   (delq nil
;;                         (mapcar (lambda (candidate)
;;                                   (propertize candidate 'source source))
;;                                 (funcall (cdr (assq 'candidates source)))))))
;;         (if (and (> ac-limit 1)
;;                  (> (length cand) ac-limit))
;;             (setcdr (nthcdr (1- ac-limit) cand) nil))
;;         (setq candidates (append candidates cand))))
;;     (delete-dups candidates)))
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;          (auto-complete-mode 1)
;;          (set (make-local-variable 'ac-sources)
;;               (append ac-sources '(ac-source-rope) '(ac-source-yasnippet)))
;;          (set (make-local-variable 'ac-find-function) 'ac-python-find)
;;          (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
;;          (set (make-local-variable 'ac-auto-start) nil)))


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

;; para utilizar las fuentes de euler-math
;; (eval-after-load "imaxima"
;;   '(setq imaxima-latex-preamble "\\usepackage{euler}"))
(autoload 'maxima-mode "maxima" "maxima mode" t)
(autoload 'imaxima "imaxima" "frontend for maxima with image support" t)
(autoload 'maxima "maxima" "maxima interaction" t)
(autoload 'imath-mode "imath" "imath mode for math formula input" t)
(setq imaxima-latex-preamble "\\usepackage{euler}")
(setq imaxima-use-maxima-mode-flag t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; imath-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; en este mode estoy interesado en eliminar las expresiones latex
;; que están al lado de expresiones de maxima, hasta el momento
;; he identificado la expresión regular que las localiza:
;; "&{latex.*latex}"
;; necesito definir una función que las elimine automáticamente
;; y después ejecute la función form-to-image

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python, el siguiente código enlaza ipython con python.el gallina
;; por alguna razón no está funcionando con ipython 0.12, así que lo
;; cambio, debe de quedar pendiente en la lista de python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'python)
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args "console --colors=linux --existing"
 python-shell-prompt-regexp "in \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
 "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
 "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
 ;; la siguiente línea es cambiada para probar la funcionalidad
 ;; de la completación en ipython
 "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
 ;; "';'.join(get_ipython().complete('''%s''')[1])\n"
 )
;; "';'.join(get_ipython().complete('''%s''')[1])\n")

;; para utilizar completación de historial como en terminal
(define-key inferior-python-mode-map [(meta p)]
  'comint-previous-matching-input-from-input)
(define-key inferior-python-mode-map [(meta n)]
  'comint-next-matching-input-from-input)
(define-key inferior-python-mode-map [(control meta n)]
  'comint-next-input)
(define-key inferior-python-mode-map [(control meta p)]
  'comint-previous-input)
(define-key inferior-python-mode-map (kbd "C-c C-z") 'quit-window)

;; ;; imenu for fgallina's python
;; (add-hook 'python-mode-hook
;;   (lambda ()
;;     (setq imenu-create-index-function 'python-imenu-create-index)))

;; las siguientes líneas impiden que el movimiento entre windows se
;; modifique por los keybinds de comint
(define-key comint-mode-map [C-down] nil)
(define-key comint-mode-map [C-up] nil)
(define-key comint-mode-map [C-right] nil)
(define-key comint-mode-map [C-left] nil)

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
  (setq ropemacs-global-prefix "C-c p")
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
(global-set-key "\C-cpl" 'load-ropemacs)

;;(require 'pymacs)
;;(pymacs-load "ropemacs" "rope-")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ein, emacs ipython notebook
;; http://tkf.github.com/emacs-ipython-notebook/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; para intentar corregir el problema con mumamo
;; (defadvice ein:url-no-cache
;;   (around ein:url-no-cache-no (url) activate)
;;   "do not use jquery-like caching workaround."
;;   (setq ad-return-value url))

;; use `multilang-mode' based notebook mode (mode defined in `ein')
;; when mumamo is not installed
(setq ein:notebook-modes
      '(ein:notebook-mumamo-mode ein:notebook-multilang-mode))

;; (eval-after-load "ein:notebooklist"
;;   '(progn
;;      (hl-line-mode 1)))

;; hilight current line in ein:notebooklist-mode
(add-hook 'ein:notebooklist-mode-hook
	  '(lambda ()
	     (hl-line-mode 1)))

;; Se aumenta a un valor conveniente para utilizar el kernel
(setq ein:query-timeout 60000)
(setq ein:use-auto-complete-superpack t)
(setq ein:complete-on-dot nil)

;; Workaround the annoying warnings:
;;    Warning (mumamo-per-buffer-local-vars):
;;    Already 'permanent-local t: buffer-file-name
(when (and (>= emacs-major-version 24)
           (>= emacs-minor-version 2))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

;; Se intenta con esta nueva opción
(add-hook 'ein:shared-output-mode-hook
          '(lambda ()
             (define-key ein:shared-output-mode-map (kbd "q") 'quit-window)))

;; Se intenta agregar sources para auto-complete para el modo ein en
;; la variable ein:ac-sources, su valor usual es:
;; (ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers)
;; (setq ein:ac-sources '(ac-source-yasnippet ac-source-abbrev
;;       ac-source-dictionary ac-source-words-in-same-mode-buffers))


(eval-after-load "ein-notebook"
  '(progn
     ;; se desaactivan movimientos entre celdas para que no interfiera con
     ;; el movimiento entre windows de emacs, hay que modificar el key-map
     ;; ein:notebook-mode-map
     (define-key ein:notebook-mode-map [C-down] nil)
     (define-key ein:notebook-mode-map [C-up] nil)

     ;; estos movimientos son remapeados a la tecla shift para no perder
     ;; esta funcionalidad
     (define-key ein:notebook-mode-map [S-down] 'ein:worksheet-goto-next-input)
     (define-key ein:notebook-mode-map [S-up] 'ein:worksheet-goto-prev-input)
     (define-key ein:notebook-mode-map (kbd "C-;")
       'ein:shared-output-pop-to-buffer)

     ;; Para evitar que 'desktop' destruya buffers relacionados con 'ein'.
     (eval-after-load 'desktop
       '(push "\\*ein:.*\\*" desktop-clear-preserve-buffers))
     ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multiple-cursors, emacs rocks: http://emacsrocks.com/e13.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; -------------------------------------------------------------------
;; Quizás sea conveniente revisar los demás keybinds de magnars, están
;; en la página: https://github.com/magnars/.emacs.d/blob/master/key-bindings.el

(require 'multiple-cursors)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
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
(global-set-key (kbd "M-æ") 'mc/mark-all-like-this-dwim)        ;AltGr-a = æ
(global-set-key (kbd "M-→") 'mc/insert-numbers)                 ;AltGr-i = →
(global-set-key (kbd "M-¶") 'mc/reverse-regions)                ;AltGr-r = ¶
(global-set-key (kbd "M-ß") 'mc/sort-regions)                   ;AltGr-s = ß

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; mark multiple, emacs rocks: http://emacsrocks.com/e08.html
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; -------------------------------------------------------------------
;; ;; Se necesita probar las funcionalidades del paquete de multiple
;; ;; cursors, así que se debe de comentar esta línea para ver de que se
;; ;; trata todo el alboroto
;; (require 'inline-string-rectangle)
;; (global-set-key (kbd "C-x r t") 'inline-string-rectangle)

;; (require 'mark-more-like-this)
;; (global-set-key (kbd "C-<") 'mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mark-next-like-this)
;; like the other two, but takes an argument (negative is previous)
;; (global-set-key (kbd "C-M-m") 'mark-more-like-this)
;; (global-set-key (kbd "C-*") 'mark-all-like-this)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; acejump, http://emacsrocks.com/e10.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; los keybinds son los sugeridos por emacs rocks

(require 'ace-jump-mode)
;; (define-key global-map (kbd "C-ø") 'ace-jump-mode)
;; (define-key global-map (kbd "M-ø") 'ace-jump-mode) ; to access in terminal
(define-key global-map (kbd "M-ñ") 'ace-jump-mode) ; to access in terminal
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode-pop-mark)

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

;; ;; active babel languages
;; (org-babel-do-load-languages
;; org  'org-babel-load-languages
;;  '((sh . t)
;;    (octave . t)
;;    ;; (maxima . t)
;;    (python . t)
;;    ;; (cpp . t)
;;    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUCTeX, RefTeX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Para utilizar AUCTeX con documentos multi-arichivos, archivos de estilo
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; Para auto cargar RefTex con modos tipo LaTex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

;; Para utilizar RefTex con AUCTeX
(setq reftex-plug-into-AUCTeX t)

;; ;; Para utilizar Evince con archivos pdf
;; (setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
;; (setq TeX-view-program-selection '((output-pdf "Evince")))

;; Para habilitar correlación de manera automática
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(setq TeX-source-correlate-start-server t)


;; ;; Para utilizar cleveref con RefTex
;; ;; (add-to-list 'reftex-ref-style-alist
;; ;;           '("Cleveref" "cleveref"
;; ;;             (("\\cref" ?c) ("\\Cref" ?b)))) ; TODO crefrange
;; ;; (setq reftex-ref-style-default-list '("Default" "Cleveref"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuraciones originales para Synctex y Evince
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Para intentar evitar que se cuelgue con synctex
(require 'tex)
(defun TeX-synctex-output-page ()
  "Return the page corresponding to the current source position.
This method assumes that the document was compiled with SyncTeX
enabled and the `synctex' binary is available."
  (let ((synctex-output
         (with-output-to-string
           (call-process "synctex" nil (list standard-output nil) nil "view"
                         "-i" (format "%s:%s:%s" (line-number-at-pos)
                                      (current-column)
                                      ;; The real file name (not symbolic) fixed
                                      ;; for the synctex path bug
                                      (concat (file-name-directory (file-truename (buffer-file-name)))
                                              "./"
                                              (file-name-nondirectory (buffer-file-name))))
                         "-o" (TeX-active-master (TeX-output-extension))))))
    (if (string-match "Page:\\([0-9]+\\)" synctex-output)
        (match-string 1 synctex-output)
      "1")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuraciones tomadas de internet ; SyncTeX basics
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; un-urlify and urlify-escape-only should be improved to handle all special characters, not only spaces.
;; The fix for spaces is based on the first comment on http://emacswiki.org/emacs/AUCTeX#toc20
(defun un-urlify (fname-or-url)
  "Transform file:///absolute/path from Gnome into /absolute/path with very limited support for special characters"
  (if (string= (substring fname-or-url 0 8) "file:///")
      (url-unhex-string (substring fname-or-url 7))
    fname-or-url))

(defun urlify-escape-only (path)
  "Handle special characters for urlify"
  (replace-regexp-in-string " " "%20" path))

(defun urlify (absolute-path)
  "Transform /absolute/path to file:///absolute/path for Gnome with very limited support for special characters"
  (if (string= (substring absolute-path 0 1) "/")
      (concat "file://" (urlify-escape-only absolute-path))
    absolute-path))

;; SyncTeX backward search - based on http://emacswiki.org/emacs/AUCTeX#toc20, reproduced on http://tex.stackexchange.com/a/49840/21017
(defun th-evince-sync (file linecol &rest ignored)
  (let* ((fname (un-urlify file))
         (buf (find-file fname))
         (line (car linecol))
         (col (cadr linecol)))
    (if (null buf)
        (message "[Synctex]: Could not open %s" fname)
      (switch-to-buffer buf)
      (goto-line (car linecol))
      (unless (= col -1)
        (move-to-column col)))))

(defvar *dbus-evince-signal* nil)

(defun enable-evince-sync ()
  (require 'dbus)
  ;; cl is required for setf, taken from:
  ;; http://lists.gnu.org/archive/html/emacs-orgmode/2009-11/msg01049.html
  (require 'cl)
  (when (and
         (eq window-system 'x)
         (fboundp 'dbus-register-signal))
    (unless *dbus-evince-signal*
      (setf *dbus-evince-signal*
            (dbus-register-signal
             :session nil "/org/gnome/evince/Window/0"
             "org.gnome.evince.Window" "SyncSource"
             'th-evince-sync)))))

(add-hook 'LaTeX-mode-hook 'enable-evince-sync)

;; SyncTeX forward search - based on
;; http://tex.stackexchange.com/a/46157 universal time, need by evince
(defun utime ()
  (let ((high (nth 0 (current-time)))
        (low (nth 1 (current-time))))
    (+ (* high (lsh 1 16) ) low)))

;; Forward search.  Adapted from
;; http://dud.inf.tu-dresden.de/~ben/evince_synctex.tar.gz
(defun auctex-evince-forward-sync (pdffile texfile line)
  (let ((dbus-name
         (dbus-call-method :session
                           "org.gnome.evince.Daemon"  ; service
                           "/org/gnome/evince/Daemon" ; path
                           "org.gnome.evince.Daemon"  ; interface
                           "FindDocument"
                           (urlify pdffile)
                           t     ; Open a new window if the file is
                                        ; not opened.
                           )))
    (dbus-call-method :session
                      dbus-name
                      "/org/gnome/evince/Window/0"
                      "org.gnome.evince.Window"
                      "SyncView"
                      (urlify-escape-only texfile)
                      (list :struct :int32 line :int32 1)
                      (utime))))

(defun auctex-evince-view ()
  (let ((pdf (file-truename (concat default-directory
                                    (TeX-master-file (TeX-output-extension)))))
        (tex (buffer-file-name))
        (line (line-number-at-pos)))
    (auctex-evince-forward-sync pdf tex line)))

;; New view entry: Evince via D-bus.
(setq TeX-view-program-list '())
(add-to-list 'TeX-view-program-list
             '("EvinceDbus" auctex-evince-view))

;; Prepend Evince via D-bus to program selection list
;; overriding other settings for PDF viewing.
(setq TeX-view-program-selection '())
(add-to-list 'TeX-view-program-selection
             '(output-pdf "EvinceDbus"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; "smart tab" y "hippie expand"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tal como se ve en:
;; https://github.com/rmm5t/dotfiles/blob/master/emacs.d/rmm5t/tabs.el
;; y funciona como en http://www.youtube.com/watch?v=a-jrn_ba41w

(require 'smart-tab)

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

(global-set-key (kbd "TAB") 'smart-tab)


;; se utiliza un nuevo método para modificar tamaños de ventanas en
;; lugar del codigo que se tiene en la seccion

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         window resize
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'windsize)
(setq windsize-cols 2)
(setq windsize-rows 1)
(windsize-default-keybindings)


(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
