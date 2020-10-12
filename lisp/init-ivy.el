
;; Settings for ivy & counsel & swiper
(use-package ivy
  :defer 1
  :demand
  :diminish
  :hook (after-init . ivy-mode)
  :config (ivy-mode 1)
  (setq ivy-height 15
	ivy-wrap t
	ivy-fixed-height-minibuffer t
	;; don't use ^ as initial input
	ivy-initial-inputs-alist nil
	;; disable magic slash on non-match
	ivy-magic-slash-non-match-action nil
	;; show recent files in switch buffer
	ivy-use-virtual-buffers t
	ivy-count-format "(%d/%d) "
	enable-recursive-minibuffers t
	ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

(use-package counsel
  :after (ivy)
  :general
  (wzhe/space-key-define
    "SPC" 'counsel-M-x
    "b" '(nil :which-key "buffer")
    "b b" 'counsel-switch-buffer
    "f f" 'counsel-find-file
    "f r" 'counsel-recentf
    "s /" 'counsel-rg
    "s s" 'swiper-all)
  :bind (("M-x" . counsel-M-x)
	 ("C-h b" . counsel-descbinds)
	 ("C-h f" . counsel-describe-function)
	 ("C-h v" . counsel-describe-variable)
	 ("C-x C-f" . counsel-find-file)
	 ("C-c f" . counsel-recentf)
	 ("C-c g" . counsel-git)))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
	 ("C-r" . swiper-isearch-backward))
  :config (setq swiper-action-recenter t
		swiper-include-line-number-in-search t))

;; An alternative M-x interface for Emacs
;;(use-package amx
;;  :init
;;  (setq amx-history-length 10
;;	amx-save-file (concat wzhe-cache-dir "amx-items"))
;;  :general (wzhe/space-key-define "SPC" 'amx))

(provide 'init-ivy)
;;; init-ivy.el ends here
