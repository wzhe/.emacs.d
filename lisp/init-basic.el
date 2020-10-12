
;; UTF-8 as the default coding system
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))       ; pretty
(prefer-coding-system 'utf-8)            ; pretty
(setq locale-coding-system 'utf-8)       ; please
(unless *is-windows*
  (setq selection-coding-system 'utf-8)) ; with sugar on top

;; 简化yes-or-no 输入
(defalias 'yes-or-no-p 'y-or-n-p)

;; Don't autosave files or create lock/history/backup files.
(setq auto-save-default nil             ; 不生成 #filename# 临时文件
      create-lockfiles nil              ; 关闭lockfile,NOTE:有风险，建议开启
      make-backup-files nil             ; 关闭备份功能
      delete-by-moving-to-trash t       ; 删除时移除到回收站
      ;; auto-save-list-file-name (concat kevin-cache-dir "autosave")
      ;; backup-directory-alist `(("." . ,(concat kevin-cache-dir "backup/")))
      )

;; Misc
(setq confirm-nonexistent-file-or-buffer t ; Whether confirmation is requested before visiting a new file or buffer.
      confirm-kill-processes nil           ; kill running processes without confirmation on Emacs exit
      inhibit-compacting-font-caches t     ; gc 忽略字体缓存
      find-file-visit-truename t           ; 当是链接时，显示真正的连接
      ;; url-cache-directory          (concat kevin-cache-dir "url/")
      ;; custom-file                  (concat kevin-cache-dir "custom.el")
      uniquify-buffer-name-style 'forward)

;;
;;; Optimizations

;; Emacs "updates" its ui more often than it needs to, so we slow it down slightly.
(setq idle-update-delay 1)

;; Non-nil means reorder bidirectional text for display in the visual order.
;; Disabling this gives Emacs a tiny performance boost.
(setq-default bidi-display-reordering nil)

;; Reduce rendering/line scan work for Emacs by not rendering cursors or regions
;; in non-focused windows.
(setq-default cursor-in-non-selected-windows nil)

;; Non-nil means highlight region even in nonselected windows.
(setq highlight-nonselected-windows nil)

;; More performant rapid scrolling over unfontified regions. May cause brief
;; spells of inaccurate fontification immediately after scrolling.
(setq fast-but-imprecise-scrolling t)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we halve startup times, particularly when we use
;; fonts that are larger than the system default (which would resize the frame).
(setq frame-inhibit-implied-resize t)

;; Don't ping things that look like domain names.
(setq ffap-machine-p-known 'reject)

(provide 'init-basic)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-basic.el ends here
