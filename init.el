;; -*- coding: utf-8; lexical-binding: t; -*-

(let* ((minver "26.1"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires %s or higher" minver)))


(setq emacs-load-start-time (current-time))

(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

(defvar my-debug nil "Enable debug mode.")

;; don't GC during startup to save time
(setq gc-cons-threshold most-positive-fixnum)

;; {{ emergency security fix
;; https://bugs.debian.org/766397
(with-eval-after-load 'enriched
  (defun enriched-decode-display-prop (start end &optional param)
    (list start end)))
;; }}

;; Speed up startup
(defvar centaur-gc-cons-threshold (if (display-graphic-p) 16000000 1600000)
  "The default value to use for `gc-cons-threshold'. If you experience freezing,
decrease this. If you experience stuttering, increase this.")

(defvar centaur-gc-cons-upper-limit (if (display-graphic-p) 400000000 100000000)
  "The temporary value for `gc-cons-threshold' to defer it.")

(defvar centaur-gc-timer (run-with-idle-timer 10 t #'garbage-collect)
  "Run garbarge collection when idle 10s.")

(defvar default-file-name-handler-alist file-name-handler-alist)

(setq file-name-handler-alist nil)
(setq gc-cons-threshold centaur-gc-cons-upper-limit
      gc-cons-percentage 0.5)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    "Restore defalut values after startup."
	    (setq file-name-handler-alist default-file-name-handler-alist)
	    (setq gc-cons-threshold centaur-gc-cons-threshold
		  gc-cons-percentage 0.1)

	    ;; GC automatically while unfocusing the frame
	    ;; `focus-out-hook' is obsolete since 27.1
	    (if (boundp 'after-focus-change-function)
		(add-function :after after-focus-change-function
			      (lambda ()
				(unless (frame-focus-state)
				  (garbage-collect))))
	      (add-hook 'focus-out-hook 'garbage-collect))

	    ;; Avoid GCs while using `ivy'/`counsel'/`swiper' and `helm', etc.
	    ;; @see http://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/
	    (defun my-minibuffer-setup-hook ()
	      (setq gc-cons-threshold centaur-gc-cons-upper-limit))

	    (defun my-minibuffer-exit-hook ()
	      (setq gc-cons-threshold centaur-gc-cons-threshold))

	    (add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
	    (add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)))

;; Load path
;; Optimize: Force "lisp"" and "site-lisp" at the head to reduce the startup time.
(defun update-load-path (&rest _)
  "Update `load-path'."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

(advice-add #'package-initialize :after #'update-load-path)

(update-load-path)

(defvar best-gc-cons-threshold
  4000000
  "Best default gc threshold value.  Should NOT be too big!")

;; (push (expand-file-name "~/.emacs.d/lisp") load-path)
;;(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "lisp/")))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-consts)
(require 'init-elpa)
(require 'init-keydefine)

;; (require 'init-startup)
(require 'init-basic)
(require 'init-ivy)
(require 'init-evil)
(require 'init-org)
(require 'init-window)

(require 'init-package)
(require 'init-linum-mode)

(require 'init-lsp)
(require 'init-ui)

(when (file-exists-p custom-file)
  (load-file custom-file))

(when (require 'time-date nil t)
  (message "Emacs startup time: %d seconds."
	   (time-to-seconds (time-since emacs-load-start-time))))
;;; init.el ends here
(put 'narrow-to-region 'disabled nil)
