;; Carga de indentación para sql
(eval-after-load "sql"
  '(load-library "sql-indent"))
(add-hook 'sql-mode-hook 'sqlind-minor-mode)


(provide 'sql-conf)
