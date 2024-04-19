(setq package-enable-at-startup nil)
(setq load-prefer-newer t)

(setq inhibit-splash-screen t)

;; スクロールバーを無効
(push '(vertical-scroll-bars) default-frame-alist)
;; メニューバーを無効
(push '(menu-bar-lines . 0) default-frame-alist)
;; ツールバーを無効
(push '(tool-bar-lines . 0) default-frame-alist)

(push '(font . "0xProto-12") default-frame-alist)

(set-face-attribute 'default nil :family "0xProto" :height 100)

;; lsp
;; see: https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
(setenv "LSP_USE_PLISTS" "true")
