;; Este archivo sirve para arreglar un problema de compatibilidad en
;; la instalaciòn del ambiente bàsico de trabajo en CentOS: comenta
;; las opciones sobre el fringe en el archivo default-conf.el.
(goto-char (point-min))
(insert ";; Avoid image-types error\n")
(insert "(setq image-types nil )\n\n")
(search-forward "Fringe" nil t)
(print "search completed")
(beginning-of-line)
(insert ";; ")
(forward-line)
(beginning-of-line)
(insert ";; ")
(print "Fringe should be commented out by now")
