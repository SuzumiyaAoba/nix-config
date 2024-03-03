(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(straight-use-package 'org)

(use-package diminish
  :straight t
  :demand t)

(use-package org
  :straight t
  :custom
  (org-src-preserve-indentation t)
  (org-edit-src-content-indentation 0)
  (org-src-tab-acts-natively t)
  :config
  ;; 前回起動時に生成された config.el を削除
  (if (file-exists-p (expand-file-name "config.el" user-emacs-directory))
      (delete-file (expand-file-name "config.el" user-emacs-directory)))
  
  (org-babel-load-file
   (expand-file-name "config.org"
                     user-emacs-directory)))
