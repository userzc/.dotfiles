;; ;; Parece ser que este `advice' no es necesario debido a las funciones
;; ;; que se definen en la parte de abajo
(defadvice open-line (after open-line-reindent-line activate)
  "Indenta la nueva línea, sólo en los 'major-mode' apropiados"
  (if (member (buffer-local-value 'major-mode (current-buffer))
              '(c++-mode nxml-mode malabar-mode html-mode))
      (save-excursion
        ;; (next-line) ;this is for interactive use
        (forward-line)
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

;; Para reindentar el buffer después de borrar un "tag"
(defadvice sgml-delete-tag (after reindent-buffer activate)
  "Reindenta el buffer después de eliminar un 'tag'"
  (cleanup-buffer))

(defun goto-line-with-feedback ()
  "
Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (setq original-display display-line-numbers)
  (unwind-protect
      (progn
        (setq display-line-numbers t)
        (goto-line (read-number "Goto line: ")))
    (setq display-line-numbers original-display)))

;; Borrar los espacios en blanco innecesarios al final de las lineas
(add-hook 'before-save-hook 'cleanup-buffer-safe)

;; funciones para el juez uva online acm icpc
(defun acm-problem (id_problem)
  "Esta función genera una carpeta y archivos dentro de la misma
en base al número del problema de la UVA que se intenta resolver
o abre los archivos correspondientes a un problema ya intentado,
dando opciones para completado en el minibuffer si no se ha
marcado como resuelto."
  (interactive
   (list (completing-read
          "UVA Problem Id:"
          (mapcar
           (lambda (x) (substring x 0 (- (length x) 1)))
           (cdr (cdr (sort (file-name-all-completions
                            "" "~/Documents/ACM-ICPC/Tried/")
                           'string<)))))))
  (let* ((dir-problem nil)
         (dir-tried (concat "~/Documents/ACM-ICPC/Tried/" id_problem))
         (dir-accepted (concat "~/Documents/ACM-ICPC/Accepted/" id_problem)))
    (cond
     ((file-directory-p dir-accepted) (setq dir-problem dir-accepted))
     ((file-directory-p dir-tried) (setq dir-problem dir-tried)))
    (if dir-problem
        (progn
          (message  (concat "Ya existe: " id_problem))
          (find-file (concat dir-problem "/" id_problem "output.txt"))
          (find-file (concat dir-problem "/" id_problem  "input.txt"))
          (find-file (concat dir-problem "/" id_problem ".cpp")))
      (progn
        (setq dir-problem (concat "~/Documents/ACM-ICPC/Tried/" id_problem))
        (message (concat "Se crea: " id_problem))
        (dired-create-directory dir-problem)
        (find-file (concat dir-problem "/" id_problem ".cpp"))
        (find-file (concat dir-problem "/" id_problem "output.txt"))
        (find-file (concat dir-problem "/" id_problem  "input.txt"))))))

(defun acm-run-program ()
  "Esta función ejecuta el archivo compilado pasandole en input
correspondiente mediante un flujo. Se aprovecha la estructura de
archivos creada por la función `acm-problem'."
  (interactive)
  (let* ((prog-name (car (split-string (buffer-name) "\\.")))
         (prog-results-buffer (concat "*results " prog-name "*" ))
         (prog-errors-buffer (concat "*errors " prog-name "*" ))
         (input-name (parent-directory-name))
         (command (format ".\\/%s.out < %sinput.txt" prog-name input-name)))
    (if (shell-command command prog-results-buffer prog-errors-buffer)
        (progn  (switch-to-buffer-other-window prog-results-buffer)
                (view-mode)
                (message (concat "acm-run-program: " command)))
      (progn (message "acm-run-program: something went wrong")))))

(defun parent-directory-name ()
  "Función adicional para auxiliar en pasar archivos de entrada a
diferentes programas dentro de la carpeta de un problema de la
UVA que no necesariamente contienen su nombre el problema al cual
se refieren."
  (interactive)
  (let* ((lista-elementos (split-string (buffer-file-name) "/" ))
         (longitud (length lista-elementos))
         (named-buffer (nth (- longitud 2) lista-elementos)))
    (progn named-buffer)))

(defun acm-uva-node (command)
  "[α] Esta función provee una interfáz a
`uva-node'[https://github.com/lucastan/uva-node], de forma que se
pueda ejecutar una variedad de subcomandos relacionados."
  (interactive
   (let ((uva-node-subcommands '("view" "show" "send" "status" "use")))
     (list
      (completing-read
       "uva-node command:" uva-node-subcommands nil nil nil nil "status"))))
  (let* ((id_problem (car (split-string (buffer-name) "\\.")))
         (uva-node-path "$HOME/.nvm/versions/node/v5.10.1/bin/uva")
         (node-path "$HOME/.nvm/versions/node/v5.10.1/bin/node")
         (output-buffer "*uva-node-results*")
         (full-uva-command
          (concat node-path " " uva-node-path " " command)
          )
         (commands-use-id-list '("send" "view"))
         (compilation-buffer-name-function
          (lambda (&rest ignore)
            "Función local para establecer el nombre del buffer
          de compilación de manera apropiada" output-buffer))
         (previous-compile-command compile-command))
    (if (member command commands-use-id-list)
        (progn
          (message (concat "Current file" (buffer-file-name)))
          (setq uva-args
                (if (string= command "send")
                    (buffer-file-name)
                  id_problem))
          (setq full-uva-command  (concat full-uva-command " " uva-args))))
    (message (concat "=: Executing [ " full-uva-command " ] :="))
    (if (progn (compile full-uva-command t))
        (progn (message "Displaying results"))
      (progn (message "Something Went Wrong!!")))
    (setq compile-command previous-compile-command)
    (with-current-buffer output-buffer
      (progn
        (view-mode)
        (setq buffer-read-only t)))))

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
  (cond ((not (> (count-windows) 1))
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

;; `C-d' to terminate process and kill buffer in shell buffers,
;; ver: http://whattheemacsd.com/setup-shell.el-01.html
(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))

;; Replace region, in order to user s-lower-camel-case
;; https://github.com/magnars/.emacs.d/blob/051101a4564255b3b4931a30ed9ec6d849a3c923/defuns/editing-defuns.el
(defun replace-region-by (fn)
  (let* ((beg (region-beginning))
         (end (region-end))
         (contents (buffer-substring beg end)))
    (delete-region beg end)
    (insert (funcall fn contents))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode functionality for MS Office export
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun org-html-export-to-docx (&optional OUTPUT-BUFFER
                                          ERROR-BUFFER ASYNC
                                          SUBTREEP VISIBLE-ONLY
                                          EXT-PLIST)
  "Esta función tiene el objetivo de facilitar la exportación de
notas tomadas con emacs en org mode para depués ser formateadas
en Word 2013 según los estándares de la FVP."
  (interactive "P")
  ;; Se exporta sólo el cuerpo para evitar el título
  (org-html-export-to-html ASYNC SUBTREEP VISIBLE-ONLY t EXT-PLIST)
  (let
      ((aux-html-file
        (concat (car (split-string (buffer-name) "\\.")) ".html"))
       (docx-file
        (concat (car (split-string (buffer-name) "\\.")) ".docx")))
    (shell-command
     (concat "pandoc -s " aux-html-file " -o " docx-file))
    (delete-file aux-html-file)))

(defun org-get-references-used ()
  "[α] Esta función tiene el objetivo de recolectar todos los enlaces
utilizados en el documento org para poder ponerlos como
referencias al final del mismo."
  (interactive)
  (let ((links-buffer "*links*" ))
    (get-buffer-create links-buffer)
    (goto-char (point-min))
    (while (search-forward-regexp "\\[\\(\\[.*?\\]\\)\\(\\[.*?\\]\\)?\\]" nil t)
      (progn
        (if (match-string 2)
            (progn
              (message "Link and Description found")
              (with-current-buffer links-buffer
                (insert (format-time-string "- %Y.%m.%d, ")))
              (append-to-buffer links-buffer
                                (+ (match-beginning 2) 1) (- (match-end 2) 1))
              (with-current-buffer links-buffer (insert "\n\n  "))
              (append-to-buffer links-buffer
                                (+ (match-beginning 1) 1) (- (match-end 1) 1))
              (with-current-buffer links-buffer (insert "\n\n")))
          (progn
            ;; En esta parte se debe decidir que hacer en el caso de
            ;; referencias a archivos locales
            (message "Only link found [No description]")))))
    (progn
      (message "link recollection terminated")
      (end-of-buffer)
      (insert "\n* Referencias\n\n")
      (insert-buffer-substring links-buffer)
      (kill-buffer links-buffer))))

;; org to md export (There seems to be a few other similar functions)
(defun org-md-export (&optional file_name)
  "Esta función exporta file_name.org a file_name.md mediante  org-ruby"
  (interactive "P")
  ;; org-ruby readme.org --translate markdown > readme.md
  (let ((input-org (concat (car (split-string (buffer-name) "\\.")) ".org"))
        (output-md (concat (car (split-string (buffer-name) "\\.")) ".md")))
    (shell-command
     (concat "org-ruby " input-org " --translate markdown > " output-md))))

;; Explore pages with firefox

(defun browse-url-of-buffer-firefox (&optional buffer)
  "Ask WWW browser Firefox to display BUFFER.
Display the current buffer if BUFFER is nil.  Display only the
currently visible part of BUFFER (from a temporary file) if
buffer is narrowed."
  (interactive)
  (save-excursion
    (and buffer (set-buffer buffer))
    (let ((file-name
           ;; Ignore real name if restricted
           (and (not (buffer-narrowed-p))
                (or buffer-file-name
                    (and (boundp 'dired-directory) dired-directory)))))
      (or file-name
          (progn
            (or browse-url-temp-file-name
                (setq browse-url-temp-file-name
                      (convert-standard-filename
                       (make-temp-file
                        (expand-file-name "burl" browse-url-temp-dir)
                        nil ".html"))))
            (setq file-name browse-url-temp-file-name)
            (write-region (point-min) (point-max) file-name nil 'no-message)))
      (async-shell-command
       (concat "firefox "
               file-name) "*async-firefox-output*" "*async-firefox-error*"))))

(defun neotree-toogle-icons-theme ()
  "Toggle neotree theme between `icons' and `arrow'"
  (interactive)
  (progn
    (if (eq neo-theme 'icons)
        (setq neo-theme 'arrow)
      (setq neo-theme 'icons)))
  (neotree-refresh))

;; Read File Content into a String, so that it can be used with restclient-mode
;; http://ergoemacs.org/emacs/elisp_read_file_content.html
(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (goto-char (point-min))
    (while (search-forward "\n" nil t) (replace-match "" nil t))
    (buffer-string)))

(defun display-ansi-colors ()
  "Función para colorear logs con códigos de color"
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))


;; Revisar la página 63 de "Writing GNU Emacs Extensions.PDF" para más
;; información sobre cómo realizar todo sin necesitar interacción del
;; usuario
(defun clean-ansi-colors ()
  "Función para eliminar códigos de color, principalmente de archivos logs"
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-filter-region (point-min) (point-max))
    (query-replace "[1A" "" nil (point-min) (point-max))
    (query-replace "[2K" "" nil (point-min) (point-max))))

;; shorthand for interactive lambdas
;; https://github.com/magnars/.emacs.d/blob/master/defuns/misc-defuns.el
(defmacro λ (&rest body)
  `(lambda ()
     (interactive)
     ,@body))

;; Copy filename to get path
(defun copy-file-name ()
  "Put the current file name on the kill-ring/clipboard"
  (interactive)
  ;; Set filename depending on the prefix arg or the mode
  (let ((filename
         (cond
          ;; When its a dired buffer or there is a C-u prefix arg, get directory name
          ((or (equal major-mode 'dired-mode) (equal current-prefix-arg '(4))) default-directory)
          ;; If there is no C-u prefix arg, get the file name
          ((equal current-prefix-arg nil) buffer-file-name))))
    ;; If file is defined, put it in the kill-ring
    (when filename
      (kill-new filename)
      (message filename))))

(provide 'defuns)
