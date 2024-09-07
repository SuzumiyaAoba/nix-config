(setq gc-cons-threshold (* 40 gc-cons-threshold)) ; 800K * n
(setq garbage-collection-messages nil)

(setq package-enable-at-startup nil)
(setq load-prefer-newer t)

(setq inhibit-splash-screen t)

(push '(vertical-scroll-bars) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)

(set-face-attribute 'default nil :family "0xProto" :height 140)

;; lsp
;; see: https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
(setenv "LSP_USE_PLISTS" "true")
