;;; emacs.el --- -*- lexical-binding: t; -*-

;;; Commentary:
;; hi linter, fuck off.

;;; Code:

;; Basic emacs prefs
(global-display-line-numbers-mode t)
(global-display-fill-column-indicator-mode t)
(column-number-mode t)
(auto-fill-mode t)
(set-fill-column 80)
(electric-pair-mode t)

;; Mouse: wheel direction is flipped for macOS-style scrolling
(mouse-wheel-mode t)
(setq mouse-wheel-flip-direction t)
(unless (display-graphic-p)
  (xterm-mouse-mode t))

(setq scroll-preserve-screen-position 'always
      pixel-scroll-precision-large-scroll-height 40.0)

;; Theme
(use-package catppuccin-theme
  :custom
  (catppuccin-flavor 'frappe)
  :config
  (load-theme 'catppuccin :no-confirm))

;; Completion popups
(use-package company
  :hook (after-init . global-company-mode))

;; Diagnostics, with a persistent problems list that C-x o skips
(defun my/flycheck-show-error-list ()
  "Open the Flycheck error list without taking focus, if not already visible."
  (when (and flycheck-current-errors
             (not (get-buffer-window "*Flycheck errors*")))
    (save-selected-window
      (flycheck-list-errors))))

(use-package flycheck
  :hook ((after-init . global-flycheck-mode)
         (flycheck-after-syntax-check . my/flycheck-show-error-list))
  :config
  (add-to-list 'display-buffer-alist
               '("\\*Flycheck errors\\*"
                 (display-buffer-in-side-window)
                 (side . bottom)
                 (slot . 0)
                 (window-height . 0.15)
                 (window-parameters . ((no-other-window . t)
                                       (no-delete-other-windows . t))))))

;; File sidebar that C-x o skips (C-c t toggles/focuses it)
(use-package treemacs
  :bind ("C-c t" . treemacs)
  :custom
  (treemacs-width 30)
  (treemacs-is-never-other-window t))

;; Language server support
;; Tries LSP in every programming buffer except Emacs Lisp. If no server is
;; found, lsp-mode shows its usual "no server" message, which serves as a
;; reminder to add one to home.packages. Server downloads are disabled
;; because Nix manages the servers.
(defun my/lsp-maybe-start ()
  "Start LSP in this buffer unless it is an Emacs Lisp buffer."
  (unless (derived-mode-p 'emacs-lisp-mode)
    (lsp-deferred)))

(use-package lsp-mode
  :hook (prog-mode . my/lsp-maybe-start)
  :custom
  (lsp-headerline-breadcrumb-enable t)
  (lsp-enable-suggest-server-download nil))

;; Hover docs (mouse hover) and inline info
(use-package lsp-ui
  :after lsp-mode
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-show-with-mouse t))

(use-package lsp-haskell
  :after lsp-mode
  :custom
  ;; Use the HLS on PATH (e.g. a project's pinned one from a dev shell)
  ;; instead of the wrapper, which caused GHC ABI mismatches.
  (lsp-haskell-server-path "haskell-language-server"))

;; Nix
(use-package nix-mode)
(use-package nixfmt
  :hook (nix-mode . nixfmt-on-save-mode))

;;; emacs.el ends here
