
;; Quickly switch windows
(use-package ace-window
  :commands ace-window
  :init
  (global-set-key [remap other-window] #'ace-window)
  :custom-face
  (aw-leading-char-face ((t (:inherit font-lock-keyword-face :bold t :height 3.0))))
  (aw-mode-line-face ((t (:inherit mode-line-emphasis :bold t))))
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
        aw-scope 'frame
        aw-background t))

;; Numbered window shortcuts
(use-package winum
  :hook (after-init . winum-mode)
  :general
  (wzhe/space-key-define
    "1"  'winum-select-window-1
    "2"  'winum-select-window-2
    "3"  'winum-select-window-3
    "4"  'winum-select-window-4
    "5"  'winum-select-window-5
    "6"  'winum-select-window-6
    "7"  'winum-select-window-7
    "8"  'winum-select-window-8
    "9"  'winum-select-window-9
    "w" '(nil :which-key "Window")
    "w c" 'centered-window-mode
    "w d" 'delete-window
    "w o" 'other-window
    "w d" 'delete-window
    "w z" 'zoom-window-zoom
    ;;"w /" '(wzhe/split-window-right-and-focus :wk "split-window-right")
    "w /" 'split-window-right
    ;;"w -" '(wzhe/split-window-below-and-focus :wk "split-window-below")
    "w -" 'split-window-below
    "w m" 'delete-other-windows)
  :init
  (setq window-numbering-scope 'global
        winum-auto-setup-mode-line nil
        winum-ignored-buffers '(" *which-key*")
        winum-auto-assign-0-to-minibuffer t))


(provide 'init-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-window ends here
