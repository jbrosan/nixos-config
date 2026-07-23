;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font
      (font-spec :family "Cascadia Code NF"
                 :size 15
                 :weight 'regular)
      doom-variable-pitch-font
      (font-spec :family "Inter"
                 :size 15
                 :weight 'regular)
      doom-big-font
      (font-spec :family "Cascadia Code NF"
                 :size 24
                 :weight 'regular)
      doom-symbol-font
      (font-spec :family "Symbols Nerd Font Mono"
                 :size 15)
      doom-serif-font
      (font-spec :family "Ubuntu"
                 :size 15
                 :weight 'regular))

(setq +ligatures-in-modes
      '(prog-mode
        text-mode
        conf-mode
        markdown-mode
        org-mode))

(setq doom-theme 'doom-one)
(setq display-line-numbers-type 'relative)
(setq org-directory "~/org/")

(setq shell-file-name (executable-find "bash"))
(setq-default explicit-shell-file-name (executable-find "fish"))

(after! vterm
  (setq vterm-shell (executable-find "fish")
        vterm-max-scrollback 100000
        vterm-kill-buffer-on-exit t))

(when (and (fboundp 'treesit-available-p)
           (treesit-available-p))
  (setq major-mode-remap-alist
        '((bash-mode       . bash-ts-mode)
          (css-mode        . css-ts-mode)
          (go-mode         . go-ts-mode)
          (javascript-mode . js-ts-mode)
          (js-json-mode    . json-ts-mode)
          (python-mode     . python-ts-mode)
          (typescript-mode . typescript-ts-mode)
          (yaml-mode       . yaml-ts-mode))))

(setq auto-save-default t
      make-backup-files t
      backup-directory-alist
      `(("." . ,(expand-file-name "backups/" doom-cache-dir)))
      auto-save-file-name-transforms
      `((".*" ,(expand-file-name "autosave/" doom-cache-dir) t)))

(setq-default line-spacing 0.08)
