;; workaround to get package archive's update in emacs-snapshot taken
;; from:
;; https://github.com/LiaoPengyu/emacs.d/blob/fc7a6fedb5c496c613d6d19a4fcdab18b36a8d87/init-elpa.el

(require 'cl)

;; Se establece de manera adecuada `package-user-dir' para que en
;; windows no sea necesario descargar todos los paquetes en cada
;; sincronización de repositorio
(if (eq system-type 'windows-nt)
    (setq package-user-dir "~\\.elpa")
  (setq package-user-dir "~/.emacs.d/elpa"))

;; Intentando nueva forma para descargar paquetes, basado en
;; https://github.com/purcell/emacs.d y
;; https://github.com/magnars/.emacs.d/blob/master/setup-package.el
(unless
    (file-exists-p
     (concat package-user-dir "/archives/melpa"))
  (package-refresh-contents))

(require 'package)
(setq package-archives
      '(("marmalade" . "https://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("melpa-stable" . "http://stable.melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

(setq package-pinned-packages
      '((magit . "melpa-stable")
        (magit-popup . "melpa-stable")
        (lacarte . "marmalade")
	(groovy-mode . "melpa")
	(projectile . "melpa-stable")))

(defvar package-filter-function nil
  "Optional predicate function used to internally filter packages
  used by package.el.

The function is called with the arguments PACKAGE VERSION ARCHIVE
where PACKAGE is a symbol, VERSION is a vector as produced by
`version-to-list', and ARCHIVE is the string name of the package
archive.")

(defadvice package--add-to-archive-contents
    (around filter-packages (package archive) activate)
  "Add filtering of available packages using
`package-filter-function', if non-nil."
  (when (or (null package-filter-function)
            (funcall package-filter-function
                     (car package)
                     (funcall (if (fboundp 'package-desc-version)
                                  'package--ac-desc-version
                                'package-desc-vers)
                              (cdr package))
                     archive))
    ad-do-it))

(setq package-filter-function
      (lambda (package version archive)
        (and
         (not (memq package '(eieio)))
         (or (not (string-equal archive "melpa"))
             (not (memq package '(slime)))))))

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

(package-initialize)

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))


;; hilight current line in package-menu-mode
(add-hook 'package-menu-mode-hook
          '(lambda ()
             (hl-line-mode 1)))


(provide 'package-conf)
