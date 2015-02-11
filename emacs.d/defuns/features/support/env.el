(require 'f)

(defvar defuns-support-path
  (f-dirname load-file-name))

(defvar defuns-features-path
  (f-parent defuns-support-path))

(defvar defuns-root-path
  (f-parent defuns-features-path))

(add-to-list 'load-path defuns-root-path)

(require 'defuns)
(require 'espuds)
(require 'ert)

(Setup
 ;; Before anything has run
 )

(Before
 ;; Before each scenario is run
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )
