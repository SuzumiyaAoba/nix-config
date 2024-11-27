;;; magica.el --- Magica provides modal editing what you want  -*- lexical-binding: t; -*-

;; Copyright (C) 2024  SuzumiyaAoba

;; Author: SuzumiyaAoba <SuzumiyaAoba@gmail.com>
;; Keywords: magica-module

;; Version: 0.0.0
;; Package-Requires: ((emacs "24.1"))
;; URL: https://github.com/SuzumiyaAoba/magica-mode

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Magica provides modal editing what you want.

;;; Code:

(require 'cl-lib)

(defgroup magica nil
  "Customization group for `magica-mode'."
  :group 'magica
  :prefix "magica-"
  :link '(url-link "https://github.com/SuzumiyaAoba/magica-mode"))

(define-minor-mode magica-mode
  ""
  :init-value nil
  :group 'magica-module
  :lighter " Magica"

  (if magica-mode
      (magica-normal-mode)))

(defcustom magica-escape nil
  "")

(defvar magica-current-state 'normal
  "")

(defvar magica--states '()
  "")

(defmacro magica--make-keymap (&rest args)
  "Create a sparse keymap with the specified bindings.
KEYMAP is an optional keyword argument that can be used to specify an existing keymap to modify.
The remaining arguments are alternating keys and functions to bind in the keymap.
This macro also suppresses all local bindings in the created keymap."
  `(let ((keymap (make-sparse-keymap)))
     ,@(cl-loop for (key func) on args by #'cddr collect
                `(define-key keymap (kbd ,key)
                             ,(if (and (listp func) (eq (car func) 'lambda))
                                  func
                                `(quote ,func))))
     (suppress-keymap keymap t)
     keymap))

(defmacro magica-define-state (&rest args)
  "Define a state with a specified keymap and behavior."
  (let* ((state (plist-get args :state))
         (keymap (plist-get args :keymap))
         (mode-name (intern (concat "magica-" (symbol-name (cadr state)) "-mode")))
         (expanded-keymap (macroexpand-all `(magica--make-keymap ,@keymap))))
    `(progn
       (define-minor-mode ,mode-name
         ""
         :init-value nil
         :group 'magica
         :lighter " Magica"
         :keymap ,expanded-keymap)
       (setq magica--states (if (member ,state magica--states)
                                magica--states
                              (cons ,state magica--states))))))

(magica-define-state
 :state  'normal
 :keymap ("h" backward-char
          "j" next-line
          "k" previous-line
          "l" forward-char
          "i" (lambda ()
                (interactive)
                (magica-normal-mode -1)
                (magica-insert-mode +1))
          "x" delete-char
          "0" move-beginning-of-line
          "$" move-end-of-line))

(define-minor-mode magica-insert-mode
  ""
  :init-value nil
  :group 'magica
  :lighter " Magica"
  :keymap (let ((map (make-sparse-keymap)))
            (global-set-key (kbd "<escape>") (lambda ()
                                               (interactive)
                                               (magica-insert-mode -1)
                                               (magica-normal-mode +1)))
            map))

(defun magica--unset-escape ()
  ""
  (global-set-key (kbd "<escape>") nil))

(provide 'magica)
;;; magica.el ends here
