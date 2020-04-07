;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Lucas Yuji Harada"
      user-mail-address "lucasyharada@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-molokai)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(setq lsp-python-ms-extra-paths (list "./promotional_price_variables/etls/experiments" "./src"))


(use-package org-pdftools
  :config (setq org-pdftools-root-dir "~")
  (with-eval-after-load 'org
    (org-link-set-parameters "pdftools"
                             :follow #'org-pdftools-open
                             :complete #'org-pdftools-complete-link
                             :store #'org-pdftools-store-link
                             :export #'org-pdftools-export)
    (add-hook 'org-store-link-functions 'org-pdftools-store-link)))

(use-package org-noter-pdftools
  :after (org-noter))

(setq TeX-PDF-mode t)
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")

;; smart F keys, and fix to magit conflict
(after! evil-snipe
  (setq evil-snipe-repeat-keys t
        evil-snipe-override-evil-repeat-keys t))
(add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)

;; (require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)

;; (add-to-list 'display-buffer-alist
;;              `(,(rx bos "*Flycheck errors*" eos)
;;               (display-buffer-reuse-window
;;                display-buffer-in-side-window)
;;               (side            . bottom)
;;               (reusable-frames . visible)
;;               (window-height   . 0.33)))

;; web-mode settings https://emacs.stackexchange.com/questions/23810/getting-proper-indentation-for-python-flask-templates?rq=1
(setq web-mode-engines-alist
             '(("php" . "\\.phtml\\'")
               ("jinja" . "\\.djhtml\\")))

;; (setq dap-python-executable "/home/mag/Documents/personal/zoo_python/zoo_venv/bin/python")
(add-hook 'js2-mode-hook (lambda () ( setq flycheck-checker 'javascript-standard) ))
(add-hook 'python-mode-hook (lambda () ( setq flycheck-checker 'python-flake8) ))
