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

(defgroup magica nil
  "Customization group for `magica-mode'."
  :group 'magica-module
  :prefix "magica-"
  :link '(url-link "https://github.com/SuzumiyaAoba/magica-mode"))

(define-minor-mode magica-mode
  ""
  :init-value nil
  :group 'magica-module
  :lighter " Magica"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "h") 'backward-char)
            (define-key map (kbd "j") 'next-line)
            (define-key map (kbd "k") 'previous-line)
            (define-key map (kbd "l") 'forward-char)
            (define-key map (kbd "i") (lambda ()
                                        (interactive)
                                        (magica-mode -1)
                                        (magica-inert-mode +1)))
            (suppress-keymap map t)
            map)

  (if magica-mode
      (magica-mode-enable)
    (magica-mode-disable)))

(defun magica-mode-enable ()
  ""
  (message "magica-mode enabled"))

(defun magica-mode-disable ()
  ""
  (message "magica-mode disabled"))

(define-minor-mode magica-insert-mqode
  ""
  :init-value nil
  :group 'magica-module
  :lighter " Magica"
  :keymap (let ((map (make-sparse-keymap)))
            (global-set-key (kbd "<escape>") (lambda ()
                                          (interactive)
                                          (magica-insert-mode -1)
                                          (magica-mode +1)))
            map)

  (if magica-insert-mode
      (magica-insert-mode-enable)
    (magica-insert-mode-disable)))

(defun magica-insert-mode-enable ()
  (message "magica-insert-mode enabled"))

(defun magica-insert-mode-disable ()
  (message  "magica-insert-mode disabled"))

(provide 'magica)
;;; magica.el ends here
