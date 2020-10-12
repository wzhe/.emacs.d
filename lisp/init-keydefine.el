
(use-package which-key
  :diminish which-key-mode "Ⓚ"
  :hook (after-init . which-key-mode)
  :config
  (setq which-key-idle-delay 0.3
	which-key-compute-remaps t
	which-key-min-display-lines 1
	which-key-add-column-padding 1
	which-key-max-display-columns nil
	which-key-sort-uppercase-first nil
	which-key-side-window-max-width 0.33
	which-key-side-window-max-height 0.25
	which-key-sort-order #'which-key-prefix-then-key-order)
  (which-key-setup-side-window-bottom)
  (add-to-list 'which-key-replacement-alist '(("TAB" . nil) . ("↹" . nil)))
  (add-to-list 'which-key-replacement-alist '(("RET" . nil) . ("⏎" . nil)))
  (add-to-list 'which-key-replacement-alist '(("DEL" . nil) . ("⇤" . nil)))
  (add-to-list 'which-key-replacement-alist '(("SPC" . nil) . ("␣" . nil)))
  ;; rename winum-select-window-1 entry to 1..9
  (add-to-list 'which-key-replacement-alist '(("\\(.*\\)1" . "winum-select-window-1") . ("\\11..9" . "window 1..9")))
  ;; hide winum-select-window-[2-9] entries
  (add-to-list 'which-key-replacement-alist '((nil . "winum-select-window-[2-9]") . t))
  (set-face-attribute 'which-key-local-map-description-face nil :weight 'bold))

(use-package general
  :init
  (general-evil-setup)
  (general-create-definer wzhe/space-key-define
			  :states '(normal visual motion evilified)
			  :keymaps 'override
			  :prefix "SPC"
			  :non-normal-prefix "M-SPC")
  (general-create-definer wzhe/comma-key-define
			  :states '(normal visual motion evilified)
			  :keymaps 'override
			  :prefix ",")
  (general-create-definer wzhe/colon-key-define
			  :states '(normal visual motion evilified)
			  :keymaps 'override
			  :prefix ";")
  :config
  (wzhe/space-key-define
   "d" '(nil :which-key "Delete")
   "d f" 'delete-frame
   "f" '(nil :which-key "File")
   "f s" 'save-buffer
   "j" '(nil :which-key "Jump")
   "s" '(nil :which-key "Search")
   "t" '(nil :which-key "Toggle")
   "t ;" 'toggle-frame-fullscreen
   "t b" 'toggle-scroll-bar
   "t t" 'toggle-truncate-lines)

  (wzhe/colon-key-define
   "e" '(nil :which-key "Emacs")
   "e q" 'save-buffers-kill-terminal
   ;; "e i" '(wzhe/open-init-file :wk "open-init-file")
   "f" '(nil :which-key "Font")
   "f =" 'wzhe/increase-fontsize
   "f -" 'wzhe/decrease-fontsize)

  (wzhe/comma-key-define
   "f" '(nil :which-key "Find")
   "f d" 'xref-find-definitions
   "f f" 'find-file-at-point
   "f r" 'xref-find-references
   "f s" 'xref-find-apropos)
  )
(provide 'init-keydefine)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; core-keydefine.el ends here
