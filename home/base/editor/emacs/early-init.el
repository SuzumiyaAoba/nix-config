;; improve performance

;; Garbage Collection
(setq gc-cons-threshold 100000000)
(setq garbage-collection-messages nil)

(setq package-enable-at-startup nil)
(setq load-prefer-newer t)

;; Inhibit
(setq inhibit-splash-screen t)
(setq frame-inhibit-implied-resize t)
(setq inhibit-compacting-font-caches t)

;; I/O
(when (boundp 'read-process-output-max)
  ;; 1MB in bytes, default 4096 bytes
  (setq read-process-output-max 1048576))

(push '(vertical-scroll-bars) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)

;; fonts
(set-face-attribute 'default nil :family "0xProto" :height 140)
;; (set-face-attribute 'default nil :family "Explex" :height 140)

;; lsp
;; see: https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
(setenv "LSP_USE_PLISTS" "true")

;; see: https://apribase.net/2024/07/09/emacs-eln-cache/
(when (boundp 'native-comp-eln-load-path)
  ;; コンパイルしたバイナリの出力先を変更する
  (startup-redirect-eln-cache
   (expand-file-name "~/.local/share/emacs/eln-cache/")))

(with-eval-after-load 'comp
  (setopt native-comp-async-jobs-number 8
          native-comp-speed 1
          native-comp-always-compile t))

(with-eval-after-load 'warnings
  ;; native comp の warning を抑える
  (setopt warning-suppress-types '((comp))))
