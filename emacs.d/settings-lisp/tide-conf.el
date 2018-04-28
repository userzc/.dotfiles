;; sample config
(add-hook 'typescript-mode-hook
          (lambda ()
            (message "Setting up typescript")
            (tide-setup)
            (eldoc-mode +1)
            ;; company is an optional dependency. You have to
            ;; install it separately via package-install
            (auto-complete-mode -1)
            ;; (message ".. enabling company-mode")
            (company-mode +1)
            (flycheck-mode +1)
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (message "Normal typescript setup finished")))

;; ;; aligns annotation to the right hand side
;; (setq company-tooltip-align-annotations t)

;; Tide can be used along with web-mode to edit tsx files
;; (require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (tide-setup)
              (flycheck-mode +1)
              (setq flycheck-check-syntax-automatically '(save mode-enabled))
              (eldoc-mode +1)
              (company-mode +1))))

(provide 'tide-conf)
