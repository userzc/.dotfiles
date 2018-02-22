;; el-get configuration
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (require 'package)
  (package-install 'el-get)
  (require 'el-get))
(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")
(el-get 'sync el-get-paquetes-instalados)

(provide 'el-get-conf)
