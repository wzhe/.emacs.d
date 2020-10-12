;;; init-elpa --- initialize elpa repository

;;; Commentary:
;;; (c)Wzhe, github.com/wzhe/.emacs.d

;;; Code:

;;; Settings for package archives
(setq package-archives '(
                         ("gnu" . "https://mirrors.163.com/elpa/gnu/")
                         ("melpa" . "https://mirrors.163.com/elpa/melpa/")
                         ("melpa-stable" . "https://mirrors.163.com/elpa/melpa-stable/")
                         ))
;; ;; 
(setq package-check-signature nil)

(require 'package)

;;; Initialize the packages, avoiding a re-initialization
(unless (bound-and-true-p package--initialized) ;; To avoid warnings on 27
  ;; (when (version< emacs-version "27.0")
  (setq package-enable-at-startup nil)
  (package-initialize))

(unless package-archive-contents
  (package-refresh-contents))

;; Settings for use-package package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Configure use-package prior to loading it
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-always-defer t
        use-package-always-demand nil
        use-package-expand-minimally t
        use-package-verbose t))
(setq load-prefer-newer t)

(eval-when-compile
  (require 'use-package))

;; Required by `use-package'
(use-package diminish)
(use-package bind-key)

;; Update GPG keyring for GNU ELPA
(use-package gnu-elpa-keyring-update)

;; Initialization benchmark
;;(when centaur-benchmark-init
(use-package benchmark-init
  :defines swiper-font-lock-exclude
  :commands (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate)
  :init (benchmark-init/activate)
  :config
  (with-eval-after-load 'swiper
    (add-to-list 'swiper-font-lock-exclude 'benchmark-init/tree-mode)))
;;)


;; auto update packages
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-version t
        auto-package-update-hide-results t)
  (auto-package-update-maybe))

(provide 'init-elpa)
;;; init-elpa.el ends here
