;; `neotree', https://github.com/jaypei/emacs-neotree
(setq neo-theme 'arrow)
(add-hook 'neotree-mode-hook 'hl-line-mode)
(setq projectile-switch-project-action 'neotree-projectile-action)
(provide 'neotree-conf)
