;; straight.el
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

;; see: https://minosjp.hatenablog.com/entry/2020/12/03/221536
(defvar my-gui-setup-hook nil
  "List of functions to call at initializing Emacs as GUI.")

(defun my-func-called-at-gui-initialization (&optional frame)
  "Function called at GUI initialization."
  (unless frame (setq frame (selected-frame)))
  (with-selected-frame frame
    (when (display-graphic-p)
      (run-hooks 'my-gui-setup-hook)
      (modify-frame-parameters frame default-frame-alist)
      (remove-hook 'after-make-frame-functions #'my-func-called-at-gui-initialization))))

(defun my-gui-setup ()
  "Setup if Emacs is running on GUI."
  (add-hook 'my-gui-setup-hook
	    (lambda()
              (scroll-bar-mode -1)
	      (tool-bar-mode -1)
              (menu-bar-mode -1)
))
  (add-hook 'after-make-frame-functions #'my-func-called-at-gui-initialization)
  (my-func-called-at-gui-initialization))

(use-package emacs
  :init
  (add-hook 'after-init-hook #'my-gui-setup)
  
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)

  (add-hook 'prog-mode-hook #'display-line-numbers-mode)
  (add-hook 'text-mode-hook #'display-line-numbers-mode)

  (setq native-comp-async-report-warnings-errors nil)

  (setq custom-file "~/.emacs.d/custom.el")
  (if (file-exists-p "~/.emacs.d/custom.el")
      (load custom-file))

  (setq scroll-margin 0
	scroll-conservatively 100000
	scroll-preserve-screen-position t)
  (setq scroll-preserve-screen-position t)

  (set-language-environment "Japanese")
  (prefer-coding-system 'utf-8)
  (set-default 'buffer-file-coding-system 'utf-8)

  (setq global-auto-revert-non-file-buffers t)
  (global-auto-revert-mode)

  (savehist-mode)
  (recentf-mode)

  (global-hl-line-mode)

  (setq-default indent-tabs-mode nil)

  (setq make-backup-files nil
	auto-save-default nil
	delete-by-moving-to-trash t
        vc-follow-symlinks t)

  (defalias 'yes-or-no-p 'y-or-n-p)

  (setq completion-cycle-threshold 3)
  (setq tab-always-indent 'complete)

  (xterm-mouse-mode t)
  (mouse-wheel-mode t)
  (global-set-key [mouse-4] '(lambda () (interactive) (scroll-down 3)))
  (global-set-key [mouse-5] '(lambda () (interactive) (scroll-up 3)))

  ;; clipboard
  (defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))

  (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
	(process-send-string proc text)
	(process-send-eof proc))))

  (when (eq system-type 'darwin)
    (setq interprogram-cut-function 'paste-to-osx)
    (setq interprogram-paste-function 'copy-from-osx)))

(use-package dired
  :custom
  (dired-do-revert-buffer t)
  (dired-recursive-copies 'always)
  (dired-isearch-filenames t))

(use-package exec-path-from-shell
  :straight t
  :config
  (exec-path-from-shell-initialize))

;; (use-package doom-themes
;;   :straight t
;;   :config
;;   (setq doom-themes-enable-bold t
;; 	doom-themes-enable-italic t)
;;   (load-theme 'doom-one t))

;; (use-package one-themes
;;   :straight t
;;   :config
;;   (load-theme 'one-light t))

(use-package gruvbox-theme
  :straight t
  :config
  (load-theme 'gruvbox-dark-hard t)

  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)))

(use-package doom-modeline
  :straight t
  :disabled t
  :init
  (doom-modeline-mode 1))

(use-package moody
  :straight t
  :custom
  (moody-mode-line-height 24)
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (moody-replace-eldoc-minibuffer-message-function))

;;
;; Icons
;;

(use-package nerd-icons
  :straight t)

(use-package nerd-icons-dired
  :straight t
  :after nerd-icons
  :diminish nerd-icons-dired-mode
  :commands (nerd-icons-dired-mode)
  :hook ((dired-mode . nerd-icons-dired-mode)))

(use-package tab-bar
  :custom
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-select-tab-modifiers '(super))
  (tab-bar-tab-hints t)
  (tab-bar-new-button-show nil)
  (tab-bar-close-button-show nil)
  (tab-bar-format '(tab-bar-format-tabs tab-bar-separator))
  :config
  (tab-bar-mode +1)

  ;; see: https://christiantietze.de/posts/2022/02/emacs-tab-bar-numbered-tabs/
  (defvar tb/circle-numbers-alist
    (concat "⓪"
            "①②③④⑤⑥⑦⑧⑨⑩"
            "⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳"
            "㉑㉒㉓㉔㉕㉖㉗㉘㉙㉚"
            "㉛㉜㉝㉞㉟㊱㊲㊳㊴㊵"
            "㊶㊷㊸㊹㊺㊻㊼㊽㊾㊿"))
  (defun tb/tab-bar-tab-name-format-hints (name _tab i)
    "Show absolute numbers on tabs in the tab bar before the tab name.
It has effect when `tab-bar-tab-hints' is non-nil."
    (if tab-bar-tab-hints
        (format "%s %s"
                (if (< i (length tb/circle-numbers-alist))
                    (substring tb/circle-numbers-alist i (+ i 1))
                  (number-to-string i))
                name)
      name))
  (setq tab-bar-tab-name-format-functions
        '(tb/tab-bar-tab-name-format-hints
          tab-bar-tab-name-format-close-button
          tab-bar-tab-name-format-face)))

;;
;; IME
;;

(use-package ddskk
  :straight t
  :defer t
  :commands (skk-mode skk-latin-mode)
  :init
  (defun my/enable-skk-latin-mode ()
    (skk-mode 1)
    (skk-latin-mode 1))
  :bind (("C-x C-j" . skk-mode))
  :hook ((after-change-major-mode . my/enable-skk-latin-mode)))

;;
;; Undo/Redo
;;

(use-package undohist
  :straight t)

(use-package undo-tree
  :straight t
  :diminish undo-tree-mode
  :custom
  (undo-tree-auto-save-history nil)
  :config
  (global-undo-tree-mode))

(use-package flymake
  :straight t
  :diminish flymake-mode)

(use-package flymake-diagnostic-at-point
  :straight t)

(use-package flymake-popon
  :straight (flymake-popon :type git :repo "https://codeberg.org/akib/emacs-flymake-popon.git")
  :diminish flymake-popon-mode
  :config
  (global-flymake-popon-mode))

(use-package prescient
  :straight t)

(use-package vertico
  :straight t
  :init
  (vertico-mode))

(use-package vertico-prescient
  :straight t)

(use-package marginalia
  :straight t
  :init
  (marginalia-mode))

(use-package consult
  :straight t
  :defer t
  :bind (("s-g" . consult-ripgrep)
         ("s-s" . consult-line)
	 :map minibuffer-local-map
	 ("M-s" . consult-hisotry)
	 ("M-r" . consult-history))
  :custom
  (consult-preview-raw-size 1024000)
  (consult-preview-max-size 1024000)
  :config
  (consult-customize
   consult-buffer :preview-key "M-."))

(use-package consult-ghq
  :straight t
  :defer t
  :commands (consult-ghq-switch-project)
  :bind (("C-c C-g" . consult-ghq-switch-project)))

(use-package consult-yasnippet
  :straight t)

(use-package corfu
  :straight (:files (:defaults "extensions/*"))
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0)
  (completion-styles '(basic))
  (corfu-popupinfo-delay nil)
  :config
  (global-corfu-mode))

(use-package corfu-terminal
  :straight t
  :after corfu
  :config
  (corfu-terminal-mode +1))

(use-package kind-icon
  :straight t
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package orderless
  :straight t
  :defer t
  :custom
  (completion-styles '(orderless basic)))

(use-package corfu-prescient
  :straight t)

(use-package treemacs
  :straight t
  :defer t
  :bind (("C-\\" . treemacs))
  :config
  (treemacs-indent-guide-mode t)
  (treemacs-fringe-indicator-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-git-commit-diff-mode t)
  (treemacs-git-mode 'deferred))

(use-package treemacs-nerd-icons
  :straight t
  :after treemacs
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package treemacs-projectile
  :straight t
  :after (treemacs projectile))

(use-package treemacs-magit
  :straight t
  :after (treemacs magit))

(use-package treemacs-tab-bar
  :straight t
  :after treemacs
  :config (treemacs-set-scope-type 'Tabs))

(use-package anzu
  :straight t
  :defer 1
  :diminish anzu-mode
  :commands (anzu-query-replace anzu-query-replace-regex anzu-mode-line)
  :bind (([remap query-replace] . anzu-query-replace)
	 ([remap query-replace-regexp] . anzu-query-replace-regex))
  :custom ((anzu-replace-threshold 1000)
	   (anzu-search-threshold 1000))
  :hook ((emacs-startup . (lambda () (global-anzu-mode +1))))
  :config
  (copy-face 'mode-line 'anzu-mode-line))

(use-package volatile-highlights
  :straight t
  :diminish volatile-highlights-mode
  :custom-face
  (vhl/default-face ((nil (:foreground "#FF3333" :background "#FFCDCD"))))
  :config
  (volatile-highlights-mode t)

  (vhl/define-extension 'undo-tree 'undo-tree-yank 'undo-tree-mode)
  (vhl/install-extension 'undo-tree))

(use-package indent-guide
  :straight t
  :diminish indent-guide-mode
  :config
  (indent-guide-global-mode))

(use-package highlight-indent-guides
  :disabled t
  :straight t
  :init
  (defun my/highlight-indent-guides--bitmap-line (width height crep zrep)
    "Defines a solid guide line, one pixel wide.
Use WIDTH, HEIGHT, CREP, and ZREP as described in
`highlight-indent-guides-bitmap-function'."
    (let* ((left (/ (- width 1) 2))
           (right (- width left 1))
           (row (append (make-list left zrep) (make-list 1 crep) (make-list right zrep)))
           rows)
      (dotimes (i height rows)
	(setq rows (cons row rows)))))
  :custom ((highlight-indent-guides-method 'character)
	   (highlight-indent-guides-bitmap-function #'my/highlight-indent-guides--bitmap-line)
	   (highlight-indent-guides-auto-character-face-perc 40)
	   (highlight-indent-guides-auto-top-character-face-perc 100)
	   (highlight-indent-guides-auto-enabled t)
	   (highlight-indent-guides-responsive t))
  :hook ((prog-mode . highlight-indent-guides-mode)))

(use-package dimmer
  :disabled t
  :straight t
  :hook ((emacs-startup . dimmer-mode))
  :custom
  (dimmer-fraction 0.6)
  :config
  (dimmer-configure-which-key)
  (dimmer-configure-hydra)
  (dimmer-configure-posframe)
  (dimmer-configure-magit))

(use-package ace-window
  :straight t
  :defer t
  :bind (("M-o" . other-window)
         ("C-x o" . ace-window))
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-background nil)
  :config
  (custom-set-faces
   '(aw-leading-char-face
     ((t
       (:foreground "deep sky blue" :bold t :height 3.0))))))

(use-package smartparens
  :straight t
  :diminish smartparens-mode
  :config
  (require 'smartparens-config)

  (smartparens-global-mode t))

(use-package which-key
  :straight t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom))

(use-package projectile
  :straight t
  :diminish projectile-mode
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map))
  :hook ((emacs-startup . projectile-mode))
  :custom
  (projectile-generic-dommand "fd . -0 --type f --color=never"))

(use-package ripgrep
  :straight t)

;;
;; git
;;

(use-package blamer
  :straight t)

(use-package git-timemachine
  :straight t)

(use-package git-modes
  :straight t)

(use-package git-gutter
  :straight t
  :diminish git-gutter-mode
  :custom ((git-gutter:unchaged-sign " ")
	   (git-gutter:modified-sign " ")
	   (git-gutter:added-sign " ")
	   (git-gutter:deleted-sign " "))
  :config
  (set-face-background 'git-gutter:unchanged (face-attribute 'line-number :background))
  (set-face-background 'git-gutter:modified "#f1fa8c")
  (set-face-background 'git-gutter:added "#50fa7b")
  (set-face-background 'git-gutter:deleted "#ff79c6")

  (global-git-gutter-mode +1))

(use-package magit
  :straight t
  :defer t
  :commands (magit)
  :bind (("C-x g" . magit))
  :custom
  (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

;;
;; programming
;;

(use-package eldoc
  :diminish eldoc-mode)

(use-package yasnippet
  :straight t
  :diminish yas-minor-mode
  :bind (("C-x y i" . yas-insert-snippet)
         ("C-x y t" . yas-describe-tables))
  :custom
  (yas-snippet-dirs `(,(locate-user-emacs-file "yasnippets")))
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :straight t)

(use-package editorconfig
  :straight t
  :diminish editorconfig-mode
  :config
  (editorconfig-mode))

(use-package tree-sitter-langs
  :straight t
  :after tree-sitter
  :config
  (tree-sitter-require 'tsx)
  (add-to-list 'tree-sitter-major-mode-language-alist '(tsx-ts-mode . tsx)))

(use-package tree-sitter
  :straight t
  :defer t
  :diminish tree-sitter-mode
  :hook ((typescript-mode . tree-sitter-hl-mode)
	 (tsx-ts-mode . tree-sitter-hl-mode)))

(use-package treesit-auto
  :straight t
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))

(use-package lsp-mode
  :straight t
  :diminish lsp-lens-mode
  :commands lsp
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-show-with-cursor t)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit t)

  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-symbol t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-diagnostics nil)
  (lsp-ui-sideline-show-code-actions nil)

  (lsp-ui-imenu-enable nil)
  (lsp-ui-imenu-kind-position 'top)

  (lsp-ui-peek-enable t)
  (lsp-ui-peek-show-directory t)
  (lsp-ui-peek-always-show t)
  (lsp-ui-peek-fontify 'on-demand)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((lsp-mode . lsp-enable-which-key-integration)
         (lsp-mode . lsp-lens-mode)
         (scala-mode . lsp)
         (typescript-ts-mode . lsp)
         (tsx-ts-mode . lsp))
  :config
  (with-eval-after-load 'lsp-mode
    (setq lsp-completion-provider :none))

  (defun corfu-lsp-setup ()
    (setq-local completion-styles '(orderless)
                completion-category-defaults nil))
  (add-hook 'lsp-mode-hook #'corfu-lsp-setup))

(use-package lsp-ui
  :straight t
  :commands lsp-ui-mode)

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list)

(use-package dap-mode
  :straight t)

;;
;; modes
;;

(use-package markdown-mode
  :straight t
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.mdx\\'" . markdown-mode))
  :init
  (setq markdown-command "multimarkdown"))

(use-package paredit
  :straight t
  :diminish paredit-mode
  :hook ((emacs-lisp-mode . paredit-mode)
         (clojure-mode . paredit-mode))
  :config
  (define-key paredit-mode-map (kbd "C-j") nil))

(use-package typescript-ts-mode
  :straight t
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode))
  :custom
  (typescript-indent-level 2)
  (typescript-tsx-indent-offset 2))

(use-package javascript-mode
  :straight t
  :mode (("\\.mjs\\'" . js-ts-mode)
         ("\\.cjs\\'" . js-ts-mode))
  :custom
  (js-indent-level 2))

(use-package mmm-mode
  :straight t)

(use-package css-in-js-mode
  :straight '(css-in-js-mode :type git
                             :host github
                             :repo "orzechowskid/tree-sitter-css-in-js")
  :hook ((tsx-ts-mode . css-in-js-mode))
  :config
  (css-in-js-mode-fetch-shared-library))

(use-package css-mode
  :config
  (setq-default css-indent-offset 2))

(use-package yaml-mode
  :straight t)

(use-package groovy-mode
  :straight t
  :hook ((groovy-mode . (lambda ()
                          (setq indent-tabs-mode t)
                          (setq tab-width 4)))))

(use-package zig-mode
  :straight t
  :mode (("\\.zig\\'" . zig-mode)))

(use-package clojure-mode
  :straight t
  :hook ((clojure-mode . aggressive-indent-mode)))

(use-package clojure-ts-mode
  :straight t)

(use-package cider
  :straight t)

(use-package scala-mode
  :straight t
  :interpreter ("scala" . scala-mode))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
  ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
  (setq sbt:program-options '("-Dsbt.supershell=false")))

(use-package lsp-metals
  :straight t)

(use-package nix-mode
  :straight t)

(use-package astro-ts-mode
  :straight t)

(use-package org
  :straight t
  :custom
  (system-time-locate nil)
  (org-startup-with-inline-images t)
  (org-hide-leading-stars t)
  (org-ellipsis " ▼")
  (org-fontify-quote-and-verse-blocks t)
  (org-use-speed-commands t)

  (org-display-custom-times t)
  (org-image-actual-width nil)

  (org-agenda-tags-column 0)
  (org-agenda-block-separator ?─)
  (org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "⭠ now ─────────────────────────────────────────────────")

  ;; see: https://misohena.jp/blog/2021-08-29-colorize-saturday-and-japanese-holidays-in-org-agenda.html
  (org-agenda-day-face-function (lambda (date)
				  (let ((face (cond
					       ;; 土曜日
					       ((= (calendar-day-of-week date) 6)
						'(:inherit org-agenda-date :foreground "#0df"))
					       ;; 日曜日か日本の祝日
					       ((or (= (calendar-day-of-week date) 0)
						    (let ((calendar-holidays japanese-holidays))
						      (calendar-check-holidays date)))
						'org-agenda-date-weekend)
					       ;; 普通の日
					       (t 'org-agenda-date))))
				    ;; 今日は色を反転
				    (if (org-agenda-today-p date) (list :inherit face :inverse-video t) face))))
  :config
  (setq org-time-stamp-custom-formats '("<%Y年%m月%d日(%a)>" . "<%Y年%m月%d日(%a)%H時%M分>")))

(use-package org-bars
  :straight (org-bars :type git
		      :host github
		      :repo "tonyaldon/org-bars")
  :hook ((org-mode . (lambda ()
		       (require 'org-bars)
		       (org-bars-mode)))))

(use-package org-modern
  :straight t
  :hook ((emacs-startup . global-org-modern-mode))
  :custom
  (org-modern-hidE-stars nil)
  (org-modern-list
   '((?- . "-")
     (?* . "•")
     (?+ . "‣")))
  (org-modern-timestamp '(" %Y年%m月%d日(%a) " . " %H時%M分 "))
  :init
  (setq org-modern-star (list #("󰎥" 0 1 (face (:family "Symbols Nerd Font Mono" :height 1.0) font-lock-face (:family "Symbols Nerd Font Mono" :height 1.0) display (raise 0.0) rear-nonsticky t))
			      #("󰎨" 0 1 (face (:family "Symbols Nerd Font Mono" :height 1.0) font-lock-face (:family "Symbols Nerd Font Mono" :height 1.0) display (raise 0.0) rear-nonsticky t))
			      #("󰎫" 0 1 (face (:family "Symbols Nerd Font Mono" :height 1.0) font-lock-face (:family "Symbols Nerd Font Mono" :height 1.0) display (raise 0.0) rear-nonsticky t))
			      #("󰎲" 0 1 (face (:family "Symbols Nerd Font Mono" :height 1.0) font-lock-face (:family "Symbols Nerd Font Mono" :height 1.0) display (raise 0.0) rear-nonsticky t))
			      #("󰎯" 0 1 (face (:family "Symbols Nerd Font Mono" :height 1.0) font-lock-face (:family "Symbols Nerd Font Mono" :height 1.0) display (raise 0.0) rear-nonsticky t))
			      ))
  :config
  (let ((comment-color (face-attribute 'font-lock-comment-face :foreground)))
    (custom-theme-set-faces
     'user
     `(org-quote ((t (:inherit org-block :slant italic :foreground ,comment-color))))))

  (setq org-ditaa-jar-path "~/.nix-profile/lib/ditaa.jar")
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ditaa . t)))
  )

(use-package org-modern-indent
  :straight (org-modern-indent :type git
			       :host github
			       :repo "jdtsmith/org-modern-indent")
  :defer t
  :config
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

(use-package sqlite-mode
  :straight t)
