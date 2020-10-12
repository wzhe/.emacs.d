(use-package evil
  :demand t ; https://github.com/noctuid/general.el/issues/180
  :hook (after-init . evil-mode)
  :init
  (setq evil-magic t
	evil-echo-state t
	evil-default-state 'normal
	evil-want-C-u-scroll t
	evil-want-C-w-delete t
	evil-want-Y-yank-to-eol t
	evil-want-integration t
	evil-want-keybinding nil
	evil-want-visual-char-semi-exclusive t
	evil-indent-convert-tabs t
	evil-ex-search-vim-style-regexp t
	evil-ex-substitute-global t
	evil-ex-visual-char-range t  ; column range for ex commands
	evil-insert-skip-empty-lines t
	evil-disable-insert-state-bindings t ; enable default emacs keybinding in insert state
	;; more vim-like behavior
	evil-symbol-word-search t
	;; don't activate mark on shift-click
	shift-select-mode nil
	evil-cross-lines t
	evil-move-cursor-back t ;; move back the cursor one position when exiting insert mode
	evil-esc-delay 0.01
	evil-mode-line-format 'after)
  ;; ;; evil cursor color
  (setq  evil-default-cursor '("red" box)
	 evil-normal-state-cursor '("red" box)
	 evil-insert-state-cursor '("red" (bar . 2))
	 evil-visual-state-cursor '("red" box)
	 evil-replace-state-cursor '("red" hollow)
	 evil-emacs-state-cursor '("red" hbar))
  :config (evil-mode 1)
  :general
  (wzhe/space-key-define
   "TAB" '(evil-switch-to-windows-last-buffer :wk "switch-to-last-buffer"))
  )
(use-package evil-surround
  :hook (evil-mode . global-evil-surround-mode))

(use-package evil-nerd-commenter
  :general
  (wzhe/space-key-define
   "c" '(nil :which-key "Comment")
   "c l" '(evilnc-comment-or-uncomment-lines :wk "comment-line")
   ;; "c t" '(evilnc-quick-comment-or-uncomment-to-the-line :wk "comment-line")
   "c p" '(evilnc-comment-or-uncomment-paragraphs :wk "comment paragraphs")
   "c y" '(evilnc-copy-and-comment-lines :wk "comment-and-copy-line")))


(provide 'init-evil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-evil.el ends here
