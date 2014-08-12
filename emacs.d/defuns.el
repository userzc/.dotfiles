;; ;; Parece ser que este `advice' no es necesario debido a las funciones
;; ;; que se definen en la parte de abajo
(defadvice open-line (after open-line-reindent-line activate)
  "Indenta la nueva línea, sólo en los 'major-mode' apropiados"
  (if (member (buffer-local-value 'major-mode (current-buffer))
              '(c++-mode nxml-mode malabar-mode))
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
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

;; Borrar los espacios en blanco innecesarios al final de las lineas
(add-hook 'before-save-hook 'cleanup-buffer-safe)

;; funciones para el juez uva online acm icpc
(defun acm-problem (id_problem)
  "Esta función abre o genera una carpeta con sus respectivos
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

(defun acm-run-program ()
  "Esta función ejecuta el archivo compilado pasandole en input
correspondiente mediante un flujo."
  (interactive)
  (let ((id_problem (car (split-string (buffer-name) "\\."))))
    (if (shell-command
         (format ".\\/%s.out < %sinput.txt" id_problem id_problem)
         "*results*" "*result-errors*")
        (progn  (switch-to-buffer-other-window "*results*")
                (fundamental-mode)
                (message "Displaying results"))
      (progn (message "Something went wrong")))))

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
  "(α)Esta función tiene el objetivo de recolectar todos los enlaces
utilizados en el documento org para poder ponerlos como
referencias al final del mismo."
  (interactive)
  (fundamental-mode)
  (let
      ((original-buffer (current-buffer)))
    (switch-to-buffer-other-window "*links*")
    (switch-to-buffer-other-window original-buffer)
    (while (search-forward "\[\[" nil t) ;se busca "[[1][2]]"
      (progn  (forward-char -2)
              (mark-sexp)
              (kill-ring-save (mark) (point))
              (switch-to-buffer-other-window "*links*")
              (yank)			;pegar "[[1][2]]"
	      (move-beginning-of-line nil)
	      (delete-pair)		;generar "[1][2]"
	      (kill-sexp)
	      (move-beginning-of-line nil)
	      (delete-pair)
	      (insert "- ")		;generer "- 2"
	      (move-end-of-line nil)
	      (insert "\n")
	      (yank)
	      (move-beginning-of-line nil)
	      (insert "  ")
	      (delete-pair)
	      (move-end-of-line nil)
	      (insert "\n")		;generar: "- 2"
	      (end-of-buffer)		;         "  1"
              (switch-to-buffer-other-window original-buffer)
              (sp-forward-sexp)))
    (progn
      (message "link recollection terminated")
      (org-mode)
      (end-of-buffer)
      (insert "\n* Referencias\n")
      (insert-buffer "*links*")
      (kill-buffer "*links*"))))

(provide 'defuns)
