;;; init-consts.el --- basic settings before Emacs startup

;;; Commentary:
;;; (c)

;;; Code:

;; Consts to check operating system
(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)))
(defconst *is-unix* (or *is-linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))
(defconst *is-cygwin* (eq system-type 'cygwin))

(defconst *emacs24+* (>= emacs-major-version 24))
(defconst *emacs25+* (>= emacs-major-version 25))
(defconst *emacs26+* (>= emacs-major-version 26))
(defconst *emacs27+* (>= emacs-major-version 27))

(provide 'init-consts)
;;; init-consts.el ends here
