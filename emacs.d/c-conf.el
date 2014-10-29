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
             (define-key c++-mode-map (kbd "C-c C-r") 'recompile)
	     (define-key c++-mode-map (kbd "C-c x p") 'acm-run-program)
	     (define-key c-mode-base-map (kbd "C-c u") 'acm-uva-node)
	     (define-key c++-mode-map (kbd "M-j") nil)))

;; c-eldoc
;; considerar incluir en `c-eldoc-includes' las librerías mediante `setq':
;; g++ -o gaussian.os -c -fPIC -I/usr/include/python2.7 -I/usr/lib/python2.7/dist-packages/numpy/core/include gaussian.cpp
;; g++ -o gaussian.so -shared gaussian.os -lboost_python -lpython2.7 -lz -lpthread -ldl -lutil -lboost_numpy

;; (setq c-eldoc-includes
;;       "`boost_python python2.7 pthead util boost_numpy --cflags` -I/usr/include/python2.7 -I/usr/lib/python2.7/dist-packages/numpy/core/include")

(setq c-eldoc-includes
      "`boost_python python2.7 boost_numpy` -I/usr/include/python2.7 -I/usr/lib/python2.7/dist-packages/numpy/core/include")

;; (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
;; (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)

;; Se determina de manera automática el comando de compilación
;; dependiendo de los archivos que hay:
;; Basado en: http://www.emacswiki.org/emacs/CompileCommand
(add-hook
 'c-mode-common-hook
 (lambda ()
   (cond
    ((file-exists-p "SConstruct")
     (progn (set (make-local-variable 'compile-command)
                 "scons -k")))
    ((or (file-exists-p "Makefile") (file-exists-p "makefile"))
     (progn (set (make-local-variable 'compile-command)
                 "make -k")))
    (t (progn
         (set (make-local-variable 'compile-command)
	      ;; emulate make's .c.o implicit pattern rule, but with
	      ;; different defaults for the CC, CPPFLAGS, and CFLAGS
	      ;; variables:
	      ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
	      (let ((file (file-name-nondirectory buffer-file-name)))
		(format "%s -o %s.out %s %s %s"
			(or (getenv "CC") "g++")
			(file-name-sans-extension file)
			(or (getenv "CPPFLAGS") "-DDEBUG=9")
			(or (getenv "CFLAGS") "-ansi -pedantic -Wall -g")
			file))))))))

(provide 'c-conf)
