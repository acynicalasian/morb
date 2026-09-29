# Should be equal to `home-manager.users.your-username.home.programs = { emacs = (import this file); }`
# Make sure programs.home-manager.enable = true

{
  enable = true;
  extraConfig =
  ''
    (global-display-line-numbers-mode t)
    (column-number-mode t)
    (require 'mwheel)
    (require 'mouse)
    (unless (display-graphic-p)
    \t(xterm-mouse-mode t))
    (mouse-wheel-mode t)
    (global-set-key [mouse-4] 'next-line)
    (global-set-key [mouse-5] 'previous-line)
    (setq pixel-scroll-precision-large-scroll-height 40.0)
    (setq scroll-preserve-screen-position 'always)
    (use-package lsp-ui)
    (require 'lsp-mode)
    (require 'lsp-ui-doc)
    (require 'nixfmt)
    (lsp-ui-doc-enable t)
    (lsp-ui-doc-position at-point)
    (lsp-ui-doc-show-with-mouse t)
    (lsp-headerline-breadcrumb-mode t)
    (add-hook 'prog-mode-hook #'lsp)
    (require 'nix-mode)
    (use-package nix-mode
    \t:mode "\\.nix\\'")
    (setq lsp-haskell-server-path "haskell-language-server")
    (load-theme 'catppuccin :no-confirm)
    (setq catppuccin-flavor 'frappe)
    (catppuccin-reload)
    ;; Fairly positive this is broken for tty so commented out for now.
    ;; flycheck popup
    ;; (add-hook 'flycheck-after-syntax-check-hook
    ;;   (lambda  ()
    ;;     (if flycheck-current-errors
    ;;         (flycheck-list-errors)
    ;;       (when (get-buffer "*Flycheck errors*")
    ;;         (switch-to-buffer "*Flycheck errors*")
    ;;         (kill-buffer (current-buffer))))))
    (add-to-list 'display-buffer-alist
      '((derived-mode . flycheck-error-list-mode)
        (display-buffer-reuse-window display-buffer-below-selected)
        (window-height . 0.3)
        (dedicated . t)
        (preserve-size . (t . t))))
  '';
  extraPackages = epkgs: with epkgs; [
    lsp-mode
    lsp-ui
    lsp-haskell
    nix-mode
    company
    catppuccin-theme
    nixfmt
  ];
}
<
