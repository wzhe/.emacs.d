;;; init-ui.el --- settings for the Emacs UI

;;; Commentary:
;;; (c) Wzhe, github.com/wzhe/.emacs.d

;;; Code:

;; Font settings
(use-package emacs
  :when (display-graphic-p)
  :config

  (setq inhibit-startup-screen t            ; 禁止启动画面
        inhibit-startup-echo-area-message t ; 禁止echo area message
        inhibit-default-init t              ; 禁止加载default lib
        mouse-yank-at-point t
        initial-buffer-choice  nil
        ;; initial-scratch-message (format ";; Happy Hacking, %s - Emacs ♥ You!\n" user-full-name)
        initial-major-mode 'fundamental-mode) ; 设置默认的major mode
  (fset #'display-startup-echo-area-message #'ignore)

  (setq scroll-step 1
        scroll-margin 1
        scroll-conservatively 101
        scroll-up-aggressively 0.01
        scroll-down-aggressively 0.01
        auto-window-vscroll nil
        fast-but-imprecise-scrolling nil
        mouse-wheel-scroll-amount '(1 ((shift) . 2))
        mouse-wheel-progressive-speed nil ; don't accelerate scrolling
        scroll-preserve-screen-position t
        hscroll-step 1
        hscroll-margin 1)

  ;; Remove hscroll-margin in shells, otherwise it causes jumpiness
  (add-hook 'eshell-mode-hook (lambda() (setq hscroll-margin 0)))
  (add-hook 'term-mode-hook (lambda() (setq hscroll-margin 0)))

  ;; Enable mouse in terminal Emacs
  (add-hook 'tty-setup-hook #'xterm-mouse-mode)

  ;; 禁止光标闪烁
  (blink-cursor-mode -1)
  (setq x-stretch-cursor nil
        visible-cursor nil
        blink-matching-paren nil)

  (setq visible-bell nil              ; 禁止显示警告提示
        ring-bell-function 'ignore)       ; 关闭警告提示音

  (setq line-number-mode t          ; 打开行号显示
        column-number-mode t            ; 打开列号显示
        size-indication-mode t          ; 显示百分比进度
        kill-whole-line t               ; Kill line including '\n'
        line-move-visual nil            ; Move line by visual line
        track-eol t                     ; Keep cursor at end of lines. Require line-move-visual is nil.
        set-mark-command-repeat-pop t)  ; Repeating C-SPC after popping mark pops it again

  ;; Indentation
  (setq-default tab-width 4
                tab-always-indent t
                indent-tabs-mode nil
                fill-column 80)

  ;; Word wrapping
  (setq-default word-wrap t
                truncate-lines t
                show-trailing-whitespace nil ; Don't show trailing whitespace by default
                truncate-partial-width-windows nil)

  ;;============================ fringe start ==========================================
  (setq indicate-buffer-boundaries nil    ; Reduce the clutter in the fringes
        indicate-empty-lines nil)         ; 不显示buffer末尾空行fringe
  (delq 'continuation fringe-indicator-alist) ; Remove continuation arrow on right fringe
  (setq indicate-buffer-boundaries nil)
  (when (fboundp 'set-fringe-mode)
    (set-fringe-mode '(4 . 8)))
  ;; 设置visual line fringe bitmap
  (when (and (fboundp 'define-fringe-bitmap) (display-graphic-p))
    (define-fringe-bitmap 'right-curly-arrow
      [#b00000000
       #b01111100
       #b01111100
       #b00001100
       #b00001100
       #b00000000
       #b00000000])
    (define-fringe-bitmap 'left-curly-arrow
      [#b00000000
       #b00110000
       #b00110000
       #b00111110
       #b00111110
       #b00000000
       #b00000000])
    (set-fringe-bitmap-face 'right-curly-arrow 'warning)
    (set-fringe-bitmap-face 'left-curly-arrow 'warning)
    (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow)))

  (unless (display-graphic-p)
    (setq overflow-newline-into-fringe nil))

  ;; doesn't exist in terminal Emacs; we define it to prevent errors
  (unless (fboundp 'define-fringe-bitmap)
    (fset 'define-fringe-bitmap #'ignore))
  ;;============================ fringe end ==========================================

  ;;============================ window start ========================================
  (unless (assq 'menu-bar-lines default-frame-alist)
    (add-to-list 'default-frame-alist '(menu-bar-lines . 0)) ; 移除菜单栏
    (add-to-list 'default-frame-alist '(tool-bar-lines . 0)) ; 移除工具栏
    (add-to-list 'default-frame-alist '(vertical-scroll-bars))) ; 移除滚动条

;;; 禁止使用对话框
  (setq use-file-dialog nil
        use-dialog-box nil)

                                        ; 标题栏格式设置
  (setq frame-title-format
        '(:eval (if (buffer-file-name)
                    (abbreviate-file-name (buffer-file-name)) "%b")))

  (when *is-mac*
    ;; NOTE Meaningless to railwaycat's emacs-mac build
    (setq ns-use-native-fullscreen nil)
    ;; Render thinner fonts
    (setq ns-use-thin-smoothing t)
    ;; 打开文件时不再创建新的frame
    (setq ns-pop-up-frames nil))

  ;; Don't resize emacs in steps, it looks weird.
  (setq window-resize-pixelwise t
        frame-resize-pixelwise t)

  ;; The native border "consumes" a pixel of the fringe on righter-most splits,
  ;; `window-divider' does not. Available since Emacs 25.1.
  (setq window-divider-default-places t
        window-divider-default-bottom-width 1
        window-divider-default-right-width 1)
  ;; (add-hook 'kevin-load-theme-hook #'window-divider-mode)
  ;;============================ window end ==========================================

  ;;============================ minibuffer start ====================================
  (setq echo-keystrokes 0.02
        enable-recursive-minibuffers t
        resize-mini-windows 'grow-only
        max-mini-window-height 0.15)

  ;; Try really hard to keep the cursor from getting stuck in the read-only prompt
  ;; portion of the minibuffer.
  (setq minibuffer-prompt-properties '(read-only t intangible t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
  ;;============================ minibuffer end ======================================
  ;; (when *is-windows*
  ;;   (setq face-font-rescale-alist '(("Microsoft Yahei Mono" . 1)))
  ;;   (dolist (charset '(kana han symbol cjk-misc bopomofo))
  ;;     (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "Microsoft Yahei Mono" :size 10.5))))
  ;; (when *is-mac*
  ;;   (set-face-attribute 'default nil :font "Monaco 11")
  ;;   (dolist (charset '(kana han symbol cjk-misc bopomofo))
  ;;     (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "华文细黑" :size 14.5)))))

  )

;; Settings for UI theme
(use-package doom-themes
  :init (load-theme 'doom-one t))

(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t
        sml/theme 'respectful)
  (sml/setup))


(use-package cnfonts
  :init (cnfonts-enable)
  )

(provide 'init-ui)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ui.el ends here
