;; Setting up groovy-mode,
;; see http://www.emacswiki.org/emacs/GroovyMode

;; Estas configuraciones consideran la instalación de groovy mediante
;; `gvm', el caso de windows requiere otras especificaciones.

(setenv "GROOVY_HOME" "~/.gvm/groovy/current/")

(setenv "PATH" (concat (getenv "PATH")
		       ":" (getenv "GROOVY_HOME") "/bin"))

(set 'groovy-program-name "groovysh")
(provide 'groovy-conf)
