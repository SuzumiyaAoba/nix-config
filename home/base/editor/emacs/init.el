;; init.el --- SuzumiyaAoba's init.el -*- lexical-binding: t -*-

;; (setq debug-on-error t)

;; disable package.el
(with-eval-after-load 'package
  (setopt package-enable-at-startup nil))

;; install elpaca
(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                 ,@(when-let ((depth (plist-get order :depth)))
                                                     (list (format "--depth=%d" depth) "--no-single-branch"))
                                                 ,(plist-get order :repo) ,repo))))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; elpaca integration
(elpaca setup (require 'setup))
(elpaca-wait)

(defun setup-wrap-to-install-package (body _name)
  "Wrap BODY in an `elpaca' block if necessary.
The body is wrapped in an `elpaca' block if `setup-attributes'
contains an alist with the key `elpaca'."
  (if (assq 'elpaca setup-attributes)
      `(elpaca ,(cdr (assq 'elpaca setup-attributes)) ,@(macroexp-unprogn body))
    body))

;; Add the wrapper function
(add-to-list 'setup-modifier-list #'setup-wrap-to-install-package)
(setup-define :elpaca
  (lambda (order &rest recipe)
    (push (cond
	   ((eq order t) `(elpaca . ,(setup-get 'feature)))
	   ((eq order nil) '(elpaca . nil))
	   (`(elpaca . (,order ,@recipe))))
	  setup-attributes)
    ;; If the macro wouldn't return nil, it would try to insert the result of
    ;; `push' which is the new value of the modified list. As this value usually
    ;; cannot be evaluated, it is better to return nil which the byte compiler
    ;; would optimize away anyway.
    nil)
  :documentation "Install ORDER with `elpaca'.
The ORDER can be used to deduce the feature context."
  :shorthand #'cadr)

;; add macros for Setup El

(setup-define :load-after
  (lambda (&rest features)
    (let ((body `(require ',(setup-get 'feature))))
      (dolist (feature (nreverse features))
        (setq body `(with-eval-after-load ',feature ,body)))
      body))
  :documentation "Load the current feature after FEATURES.")

(setup-define :opt
  (lambda (&rest pairs)
    `(setopt ,@pairs))
  :after-loaded t)

;; suppress warning
(setq warning-minimum-level :emergency)

;; options
(defconst my/loading-profile-p nil
  "If non-nil, use built-in profiler.el.")

(defconst my/enable-profile nil
  "If true, enable profile")

;; is-darwin
(defconst is-darwin (string= system-type "darwin"))

;; is-darwin-window
(defconst is-darwin-window (and (string= system-type "darwin")
                                window-system))

;; when-darwin-not-window-system
(defconst is-darwin-not-window (and (string= system-type "darwin")
                                    (not window-system)))

;; profile
(when my/enable-profile
  (require 'profiler)
  (profiler-start 'cpu))

;; disable magic file name
(defconst my/saved-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; start profile
(defconst my/before-load-init-time (current-time))

;;;###autoload
(defun my/load-init-time ()
  "Loading time of user init files including time for `after-init-hook'."
  (let ((time1 (float-time
                (time-subtract after-init-time my/before-load-init-time)))
        (time2 (float-time
                (time-subtract (current-time) my/before-load-init-time))))
    (message (concat "Loading init files: %.0f [msec], "
                     "of which %.f [msec] for `after-init-hook'.")
             (* 1000 time1) (* 1000 (- time2 time1)))))
(add-hook 'after-init-hook #'my/load-init-time t)

(defvar my/tick-previous-time my/before-load-init-time)

;;;###autoload
(defun my/tick-init-time (msg)
  "Tick boot sequence at loading MSG."
  (when my/loading-profile-p
    (let ((ctime (current-time)))
      (message "---- %5.2f[ms] %s"
               (* 1000 (float-time
                        (time-subtract ctime my/tick-previous-time)))
               msg)
      (setq my/tick-previous-time ctime))))

(defun my/emacs-init-time ()
  "Emacs booting time in msec."
  (interactive)
  (message "Emacs booting time: %.0f [msec] = `emacs-init-time'."
           (* 1000
              (float-time (time-subtract
                           after-init-time
                           before-init-time)))))

(add-hook 'after-init-hook #'my/emacs-init-time)

(with-eval-after-load 'comp
  (setq native-comp-async-jobs-number 8)
  (setq native-comp-speed 3)
  (setq native-comp-async-report-warnings-errors nil)
  (setq native-compile-prune-cache t))

(setq make-backup-files nil)
(setq backup-inhibited nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq delete-by-moving-to-trash t)
(setq vc-follow-symlinks t)
(setq ring-bell-function 'ignore)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)

;; improve performance tips
(setup simple
  (setq blink-matching-paren nil)
  (setq auto-mode-case-fold nil)
  (setq vc-handled-backends '(Git))
  (setq-default bidi-display-reordering 'left-to-right)
  (setq bidi-inhibit-bpa t)
  (setq-default cursor-in-non-selected-windows nil)
  (setq highlight-nonselected-windows nil)
  (setq fast-but-imprecise-scrolling t)
  (setq ffap-machine-p-known 'reject)
  (setq idle-update-delay 1.0)
  (setq redisplay-skip-fontification-on-input t)
  (:only-if is-darwin)
  (setq command-line-ns-option-alist nil))

(setup simple
  (set-language-environment "Japanese")
  (prefer-coding-system 'utf-8)
  (set-default 'buffer-file-coding-system 'utf-8))

;; enable magic file name
(setq file-name-handler-alist my/saved-file-name-handler-alist)

;; indent
(setq-default indent-tabs-mode nil)

;; case ignore
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq completion-ignore-case t)

;; copy & paste
(setup (:only-if is-darwin)
  (defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))

  (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))

  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx))

(setup simple
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1))

;; auto-revert-mode
(setup auto-revert-mode
  (global-auto-revert-mode t))

;; native compile
(setup comp
  (:opt native-comp-async-jobs-number 8
        native-comp-speed 2
        native-comp-always-compile t))

;; theme
(setup modus-themes
  (:elpaca t)
  (:opt modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-region '(bg-only no-extend)
        modus-themes-mixed-fonts t
        modus-themes-subtle-line-numbers t
        modus-themes-org-blocks 'gray-background
        modus-themes-common-palette-overrides
	'(
          (comment yellow-cooler)
          ;; (comment yellow-warmer)
          ;; (string green-cooler)
          (string green-warmer)
          ;; (keyword cyan-cooler)
          ))
  (load-theme 'modus-vivendi-tinted t))

;; ace-window
(setup ace-window
  (:elpaca t)
  (:global "C-x o" ace-window)
  (:opt aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

;; anzu
(setup anzu
  (:elpaca t)
  (:global [remap query-replace] anzu-query-replace
           [remap query-replace-regexp] anzu-query-replace-regex)
  (:opt anzu-replace-threshold 1000
        anzu-search-threshold 1000)
  (:with-mode emacs-startup
    (:hook global-anzu-mode))
  (:when-loaded
    (diminish 'anzu-mode))
  (copy-face 'mode-line 'anzu-mode-line))

;; avy
(setup avy
  (:elpaca t)
  (:global "M-g M-g" 'avy-goto-char))

;; consult
(setup consult
  (:elpaca t)
  (:opt consult-preview-raw-size 1024000
        consult-preview-max-size 1024000
        xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  (:global "C-s" consult-line-at)
  (:when-loaded
    (consult-customize
     consult-buffer
     consult-recent-file
     consult-xref
     :preview-key '(:debounce 0.4 any)))

  (defun consult-line-at (&optional at-point)
    "Consult-line uses things-at-point if set C-u prefix."
    (interactive "P")
    (if at-point
        (consult-line (thing-at-point 'symbol))
      (consult-line))))

;; consult-ghq
(setup consult-ghq
  (:elpaca t)
  (:global
   "C-c C-g" consult-ghq-switch-project))

;; diminish
(setup diminish
  (:elpaca t))

;; display-line-numbers
(setup display-line-numbers
  (:opt display-line-numbers-grow-only t)
  (:with-mode prog-mode
    (:hook display-line-numbers-mode))
  (:with-mode text-mode
    (:hook display-line-numbers-mode)))

;; git-gutter
(setup git-gutter
  (:elpaca t)
  (:when-loaded
    (diminish 'git-gutter-mode)
    
    (custom-set-variables
     '(git-gutter:modified-sign " ")
     '(git-gutter:added-sign " ")
     '(git-gutter:deleted-sign " "))
  
    (set-face-background 'git-gutter:modified "purple")
    (set-face-background 'git-gutter:added "green")
    (set-face-background 'git-gutter:deleted "red"))

  (global-git-gutter-mode t))

;; scroll
(setup simple
  (setq scroll-margin 0)
  (setq scroll-conservatively 100000)
  (setq scroll-preserve-screen-position t))

(setup pixel-scroll-precision-mode
  (:only-if is-darwin-window)
  (pixel-scroll-precision-mode t))

;; tree-sitter
(setup tree-sitter-langs
  (:elpaca t)
  (:load-after tree-sitter)
  (:when-loaded
    (diminish 'tree-sitter-mode)))

(setup tree-sitter
  (:elpaca t)
  (:when-loaded
    (global-tree-sitter-mode)))

(setup treesit-auto
  (:elpaca t)
  (:opt treesit-auto-install t)
  (:when-loaded
    (require 'treesit-auto)
    (treesit-auto-add-to-auto-mode-alist 'all)
    (global-treesit-auto-mode)))

;; C-k
(setup simple
  (:opt kill-whole-line t))

;; cape
(setup cape
  (:elpaca t))

(setup minibuffer
  (:when-loaded
    (add-to-list 'completion-at-point-functions #'cape-dabbrev)
    (add-to-list 'completion-at-point-functions #'cape-file)
    (add-to-list 'completion-at-point-functions #'cape-elisp-block)
    (add-to-list 'completion-at-point-functions #'cape-history)))

;; copilot
(setup copilot
  (:elpaca copilot :host github :repo "copilot-emacs/copilot.el")
  (:with-mode prog-mode
    (:hook copilot-mode))
  (:with-map copilot-completion-map
    (:bind "<tab>" copilot-accept-completion)
    (:bind "TAB" copilot-accept-completion))
  (:when-loaded
    (diminish 'copilot-mode)))

;; corfu
(setup corfu
  (:elpaca t)
  (:hook corfu-popupinfo-mode)
  (:opt corfu-atuo t
        corfu-auto-delay 0.5
        corfu-popupifo-delay 0.5
        corfu-quit-no-match t
        corfu-auto-prefix 3
        tab-always-indent 'complete
        text-mode-ispell-word-completion nil)
  (:with-map corfu-mode-map
    (:bind
     "SPC" corfu-insert-separator))
  (global-corfu-mode))

;; corfu-terminal
(setup corfu-terminal
  (:elpaca corfu-terminal :host codeberg :repo "akib/emacs-corfu-terminal")
  (:load-after corfu)
  (:when-loaded
    (corfu-terminal-mode +1)))

;; corfu-perscient
(setup corfu-prescient
  (:elpaca t)
  (:opt corfu-prescient-enable-filtering nil)
  (corfu-prescient-mode +1))

;; terminal
(setup
  (:only-if is-darwin-not-window)
  (set-face-attribute 'vertical-border nil :foreground "gray")
  (set-display-table-slot standard-display-table 'vertical-border (make-glyph-code ?│)))

(setup xterm-mouse-mode
  (:only-if is-darwin-not-window)
  (xterm-mouse-mode t))

(setup mouse-wheel-mode
  (:only-if is-darwin-not-window)
  (mouse-wheel-mode t))

;; ddskk
(elpaca (ccc :branch "master" :version (lambda (_) "1.43")))

(setup ddskk
  (:elpaca t)
  (:global
   "C-x j" skk-mode)
  (:opt skk-preload t
        default-input-method "japanese-skk"
        skk-byte-compile-init-file t
        skk-isearch-mode-enable 'always
        skk-egg-like-newline t
        skk-show-annotation nil
        skk-auto-insert-paren t)

  (defun my/enable-skk-latin-mode ()
    (skk-latin-mode 1))
  (add-hook 'find-file-hook #'my/enable-skk-latin-mode))

;; ddskk
(setup ddskk-posframe
  (:elpaca t)
  (:load-after ddskk)
  (:only-if is-darwin-window)
  (ddskk-posframe-mode t))

;; eldoc
(setup eldoc
  (:elpaca t)
  (:opt eldoc-echo-area-use-multiline-p nil)
  (:global
   "C-c q" toggle-eldoc-doc-buffer)
  (:when-loaded
    (diminish 'eldoc-mode))

  (defun get-buffer-by-regex (regex)
    (car (seq-filter (lambda (buf)
                       (string-match-p regex (buffer-name buf)))
                     (buffer-list))))

  (seq-filter (lambda (buf)
                (string-match-p "^*scratch" (buffer-name buf)))
              (buffer-list))

  (setq eldoc-buffer-regex "^\\*eldoc\\( for [^*]+\\)\?\\*")

  (add-to-list 'display-buffer-alist
               `(,eldoc-buffer-regex                 
                 display-buffer-at-bottom
                 (window-height . 10)))

  (defun toggle-eldoc-doc-buffer (&optional interactive)
    "Toggle the display of the eldoc documentation buffer."
    (interactive '(t))
    (let ((buffer (get-buffer-by-regex eldoc-buffer-regex)))
      (if (and buffer (get-buffer-window buffer))
          (delete-window (get-buffer-window buffer))
        (eldoc-print-current-symbol-info interactive))

      (let* ((buffer (get-buffer-by-regex eldoc-buffer-regex))
             (window (get-buffer-window buffer)))
        (select-window window)))))

;; form-feed
(setup form-feed
  (:elpaca t)
  (:with-mode emacs-lisp-mode
    (:hook form-feed-mode))
  (:when-loaded
    (diminish 'form-feed-mode)))

;; groovy
(setup groovy-mode
  (:elpaca t))

;; highlight-symbol
(setup highlight-symbol
  (:elpaca t)
  (:with-mode prog-mode
    (:hook highlight-symbol-mode)))

;; jsonrpc
(setup jsonrpc
  (:elpaca t)
  (:opt jsonrpc-default-request-timeout 3000)
  (fset #'jsonrpc--log-event #'ignore))

;; keycast
(setup keycast
  (:elpaca t)
  (keycast-tab-bar-mode))

;; lsp-mode
(setup lsp-mode
  (:elpaca t)
  (:opt read-process-output-max (* 1024 1024)
        lsp-headerline-breadcrumb-enable nil
        lsp-enable-symbol-highlighting nil

        lsp-ui-doc-enable t
        lsp-ui-doc-include-signature t
        lsp-ui-doc-header nil
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-show-with-cursor nil
        lsp-eldoc-enable-hover t
        lsp-eldoc-render-all t

        lsp-ui-sideline-enable nil
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-sideline-show-symbol t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-diagnostics nil
        lsp-ui-sideline-show-code-actions nil

        lsp-ui-imenu-enable nil
        lsp-ui-imenu-kind-position 'top
        lsp-ui-imenu-auto-refresh t

        lsp-ui-peek-enable t
        lsp-ui-peek-show-directory t
        lsp-ui-peek-always-show t
        lsp-ui-peek-fontify 'on-demand

        lsp-lens-enable t

        lsp-keymap-prefix "C-c l")
  (:with-mode tsx-mode
    (:hook lsp-deferred))

  (with-eval-after-load 'lsp-mode
    (setq lsp-completion-provider :none))

  (defun corfu-lsp-setup ()
    (setq-local completion-styles '(orderless)
                completion-category-defaults nil))
  (add-hook 'lsp-mode-hook #'corfu-lsp-setup)

  ;; lsp-booster
  (defun lsp-booster--advice-json-parse (old-fn &rest args)
    "Try to parse bytecode instead of json."
    (or
     (when (equal (following-char) ?#)
       (let ((bytecode (read (current-buffer))))
         (when (byte-code-function-p bytecode)
           (funcall bytecode))))
     (apply old-fn args)))
  (advice-add (if (progn (require 'json)
                         (fboundp 'json-parse-buffer))
                  'json-parse-buffer
                'json-read)
              :around
              #'lsp-booster--advice-json-parse)

  (defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
    "Prepend emacs-lsp-booster command to lsp CMD."
    (let ((orig-result (funcall old-fn cmd test?)))
      (if (and (not test?)                             ;; for check lsp-server-present?
               (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
               lsp-use-plists
               (not (functionp 'json-rpc-connection))  ;; native json-rpc
               (executable-find "emacs-lsp-booster"))
          (progn
            (message "Using emacs-lsp-booster for %s!" orig-result)
            (cons "emacs-lsp-booster" orig-result))
        orig-result)))
  (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)
  )

;; lsp-java
(setup lsp-java
  (:elpaca t)
  (:with-mode java-mode
    (:hook lsp-deferred)
    (:hook (lambda ()
             (setq c-basic-offset 2))))
  (:with-mode java-ts-mode
    (:hook lsp-deferred)
    (:hook (lambda () (setq c-basic-offset 2))))
  ;; (:opt lsp-java-compile-null-analysis-mode "disabled")
  (push (concat "-javaagent:"
                (getenv "LOMBOK_JAR_PATH"))
        lsp-java-vmargs))

;; lsp-treemacs
(setup lsp-treemacs
  (:elpaca t))

;; lsp-ui
(setup lsp-ui
  (:elpaca t))

;; magit
(elpaca (transient :branch "main"))

(setup magit
  (:elpaca t)
  (:global
   "C-x g" magit))

;; marginalia
(setup marginalia
  (:elpaca t))

;; markdown-mode
(setup markdown-mode
  (:elpaca t)
  (:file-match "\\.mdx\\'"))

;; moody
(setup moody
  (:elpaca t)
  (require 'moody)
  (moody-replace-mode-line-front-space)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

;; nerd-icons-completion
(setup nerd-icons-completion
  (:elpaca t)
  (:load-after marginalia)
  (:when-loaded
    (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup)
    (nerd-icons-completion-mode)))

;; nerd-icons-corfu
(setup nerd-icons-corfu
  (:elpaca t)
  (:load-after corfu)
  (:when-loaded
    (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)))

;; nerd-icons-dired
(setup nerd-icons-dired
  (:elpaca t)
  (:with-mode dired-mode
    (:hook nerd-icons-dired-mode))
  (:when-loaded
    (diminish 'nerd-icons-dired-mode)))

;; nix-mode
(setup nix-mode
  (:elpaca t))

;; orderless
(setup orderless
  (:elpaca t))

(setup minibuffer
  (:when-loaded
    (:opt completion-styles '(orderless basic)
          completion-category-overrides '((file (styles basic partial-completion))))
    (add-to-list 'completion-styles-alist '(orderless orderless-try-completion orderless-all-completions
                                                      "Completion of multiple components, in any order."))))

;; org-mode
(setup org
  (:elpaca t))

;; prescient
(setup prescient
  (:elpaca t)
  (:opt prescient-aggressive-file-save t)
  (require 'prescient)
  (prescient-persist-mode +1))

;; projectile
(setup projectile
  (:elpaca t)
  (:with-map projectile-mode-map
    (:bind
     "C-c p" projectile-command-map))
  (:with-mode emacs-startup
    (:hook projectile-mode))
  (:opt projectile-generic-dommand "fd . -0 --type f --color=never")
  (:when-loaded
    (diminish 'projectile-mode))
  (projectile-mode +1))

;; recentf-mode
(setup recentf-mode
  (:opt recentf-max-saved-items 100)
  (recentf-mode +1))

;; ripgrep
(setup ripgrep
  (:elpaca t))

;; savehist-mode
(with-eval-after-load 'savehist-mode
  (savehist-mode +1))

;; server
(setup simple
  (:when-loaded
    (require 'server)
    (or (server-running-p) (server-mode))))

;; smartparens
(setup smartparens
  (:elpaca t)
  (:when-loaded
    (diminish 'smartparens-mode))
  (require 'smartparens-config)
  (smartparens-global-mode t))

;; treemacs
(setup treemacs
  (:elpaca t)
  (:global "C-\\" treemacs)
  (:opt treemacs-user-mode-line-format 'none)
  (:when-loaded
    (treemacs-fringe-indicator-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-git-commit-diff-mode t)
    (treemacs-git-mode 'deferred)))

;; treemacs-nerd-icons
(setup treemacs-nerd-icons
  (:elpaca t)
  (require 'treemacs-nerd-icons)
  (treemacs-load-theme "nerd-icons"))

;; treemacs-projectile
(setup treemacs-projectile
  (:elpaca t)
  (:load-after treemacs projectile))

;; typescript
(setup typescript-ts-mode
  (:file-match "\\.ts\\'")
  (:opt typescript-indent-level 2
        typescript-tsx-indent-offset 2))

(setup coverlay
  (:elpaca t))

(setup css-in-js-mode
  (:elpaca css-in-js-mode :host github :repo "orzechowskid/tree-sitter-css-in-js"))

(setup origami
  (:elpaca t))

(setup tsx-mode
  (:elpaca tsx-mode :host github :repo "orzechowskid/tsx-mode.el")
  (:load-after coverlay css-in-js-mode origami)
  (:file-match "\\.[jt]s[x]?\\'"))

;; vertico
(setup vertico
  (:elpaca t)
  (:with-map vertico-map
    (:bind "C-r" vertico-previous
           "C-s" vertico-next))
  (:opt vertico-count 12
        vertico-cycle t)
  (:opt marginalia-mode t)
  (defvar +vertico-current-arrow t)

  (cl-defmethod vertico--format-candidate :around
    (cand prefix suffix index start &context ((and +vertico-current-arrow
                                                   (not (bound-and-true-p vertico-flat-mode)))
                                              (eql t)))
    (setq cand (cl-call-next-method cand prefix suffix index start))
    (if (bound-and-true-p vertico-grid-mode)
        (if (= vertico--index index)
            (concat (nerd-icons-faicon "nf-fa-hand_o_right") "  " cand)
          (concat #("_" 0 1 (display " ")) cand))
      (if (= vertico--index index)
          (concat " " (nerd-icons-faicon "nf-fa-hand_o_right") "  " cand)
        (concat "    " cand))))

  (vertico-mode)

  ;; vertico-directory
  (:with-map vertico-map
    (:bind "C-l" vertico-directory-up
           "DEL" vertico-directory-delete-char)))

;; vertico-prescient
(setup vertico-prescient
  (:elpaca t)
  (:load-after prescient)
  (:opt vertico-prescient-enable-filtering nil)
  (vertico-prescient-mode +1))

;; volatile-highlights
(setup volatile-highlights
  (:elpaca t)
  (:when-loaded
    (diminish 'volatile-highlights-mode)

    (set-face-attribute
     'vhl/default-face nil :foreground "#FF3333" :background "#FFCDCD")
    
    (vhl/define-extension 'undo-tree 'undo-tree-yank 'undo-tree-mode)
    (vhl/install-extension 'undo-tree))

  (volatile-highlights-mode t))

;; end profile
(when my/enable-profile
  (profiler-report)
  (profiler-stop))

