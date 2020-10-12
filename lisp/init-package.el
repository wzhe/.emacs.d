;;; init-package --- initialize the plugins
;;; Commentary:
;;; (c)Wzhe, github.com/wzhe/.emacs.d

;;; Code:

;; Settings for exec-path-from-shell
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :init (exec-path-from-shell-initialize))


;; Settings for C-a behavior
(use-package crux
  :bind (("C-a" . crux-move-beginning-of-line)
         ("C-c ^" . crux-top-join-line)
	     ("C-x ," . crux-find-user-init-file)
         ("C-S-d" . crux-duplicate-current-line-or-region)
         ("C-S-k" . crux-smart-kill-line))) ; We can use C-S-<Backspace> instead.

;; Hungry Delete - delete multi spaces with one <delete> key
(use-package hungry-delete
  :bind (("C-c DEL" . hungry-delete-backward)
         ("C-c d" . hungry-delete-forward)))

;; drag-stuff - move lines up/down
(use-package drag-stuff
  :bind (("<M-up>". drag-stuff-up)
         ("<M-down>" . drag-stuff-down)))

;; Settings for company
(use-package company
  :diminish (company-mode " Com.")
  :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
  :hook (after-init . global-company-mode)
  :config (setq company-dabbrev-code-everywhere t
		        company-dabbrev-code-modes t
		        company-dabbrev-code-other-buffers 'all
		        company-dabbrev-downcase nil
		        company-dabbrev-ignore-case t
		        company-dabbrev-other-buffers 'all
		        company-require-match nil
		        company-minimum-prefix-length 2
		        company-show-numbers t
		        company-tooltip-limit 20
		        company-idle-delay 0
		        company-echo-delay 0
		        company-tooltip-offset-display 'scrollbar
		        company-begin-commands '(self-insert-command)))

(use-package company-quickhelp
  :hook (prog-mode . company-quickhelp-mode)
  :init (setq company-quickhelp-delay 0.3))

;; Better sorting and filtering
(use-package company-prescient
  :init (company-prescient-mode 1))


;; Settings for magit
;; I quit using magit on windows, 'cause its performance sucks
;; I use emacs builtin vc & cli-git on windows instead
(use-package magit
  :unless *is-windows*
  :bind ("C-x g" . magit-status))

;; Settings for yasnippet
(use-package yasnippet
  :diminish yas-minor-mode
  :init (yas-global-mode)
  :config
  (add-to-list 'yas-snippet-dirs (concat
				                  (file-name-directory user-emacs-directory)
				                  "snippets"))
  (use-package yasnippet-snippets
    :after yasnippet)
  (use-package auto-yasnippet
    :bind (("C-o" . aya-open-line)
           ("H-w" . aya-create)
           ("H-y" . aya-expand))))

;; Settings for projectile
;; Using after-init hook makes emacs starts up faster than config projectile-mode
(use-package projectile
  :diminish (projectile-mode " Proj.")
  :hook (after-init . projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map))

;; Enable flymake on default
(use-package flymake
  :ensure nil
  :diminish (flymake " Fly.")
  :hook (prog-mode . flymake-mode)
  :bind (("M-n" . flymake-goto-next-error)
         ("M-p" . flymake-goto-prev-error)))

;; Settings for highlight parentheses
(use-package highlight-parentheses
  :diminish
  :hook (prog-mode . highlight-parentheses-mode))

(use-package rainbow-delimiters
  :diminish
  :hook (prog-mode . rainbow-delimiters-mode))

;; Restart emacs
(use-package restart-emacs)

;; Beacon mode
(use-package beacon
  :hook (after-init . beacon-mode))

(use-package keycast
  :commands keycast-mode)

;; Writable `grep' buffer
(use-package wgrep
  :init
  (setq wgrep-auto-save-buffer t
        wgrep-change-readonly-file t))

(use-package youdao-dictionary
  :commands youdao-dictionary-search-at-point+
  :general ("C-c y" 'youdao-dictionary-search-at-point+)
  :config
  ;; Enable Cache
  (setq url-automatic-caching t)
  ;; Set file path for saving search history
  ;; (setq youdao-dictionary-search-history-file (expand-file-name "youdao" kevin-cache-dir))
  ;; Enable Chinese word segmentation support
  (setq youdao-dictionary-use-chinese-word-segmentation t))

(provide 'init-package)

;;; init-package.el ends here
