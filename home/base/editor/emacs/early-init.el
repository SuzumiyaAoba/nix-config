(setq package-enable-at-startup nil)
(setq load-prefer-newer t)

(setq inhibit-splash-screen t)

;; スクロールバーを無効
(push '(vertical-scroll-bars) default-frame-alist)
;; メニューバーを無効
(push '(menu-bar-lines . 0) default-frame-alist)
;; ツールバーを無効
(push '(tool-bar-lines . 0) default-frame-alist)

(set-face-attribute 'default nil :family "0xProto")

(add-hook 'after-init-hook
          (lambda ()
            (cond ((display-graphic-p)
                   (set-fontset-font nil 'japanese-jisx0213.2004-1 "HackGen Console NF")
                   (set-fontset-font nil 'japanese-jisx0213-2 "HackGen Console NF")
                   (set-fontset-font nil 'katakana-jisx0201 "HackGen Console NF")))))

;; lsp
;; see: https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
(setenv "LSP_USE_PLISTS" "true")
