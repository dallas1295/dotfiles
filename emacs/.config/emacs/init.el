(setq custom-file "~/.config/emacs/custom.el")
(add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))
(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(setq inhibit-splash-screen t)
(setq-default tab-width 4)
(setq-default standard-indent 2)
(setq-default indent-tabs-mode nil)
(setq auto-save-default nil)
(setq display-line-numbers-type 'relative)

(add-hook 'org-mode-hook (lambda ()
                           (setq-local electric-pair-inhibit-predicate
                                       `(lambda (c)
                                          (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(global-display-line-numbers-mode 1)
(global-set-key [escape] 'keyboard-escape-quit)
(delete-selection-mode 1)
(electric-indent-mode 1)
(electric-pair-mode 1)
(windmove-mode 1)
(which-key-mode 1)

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 135)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(setq display-buffer-alist
      '(("\\*Buffer List\\*" . (display-buffer-same-window))
        ("\\*.*\\*" . (display-buffer-pop-up-window))))

(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

;; Keybinds
(load "~/.config/emacs/meow.el")

;; Themes
(use-package kanagawa-themes
  :ensure t
  :config
  (load-theme 'kanagawa-dragon t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-icon nil)
  (setq doom-modeline-buffer-file-name-style 'truncate-nil))

;; vterm
(use-package vterm
  :ensure t)

;; Helpful Extensions
(use-package diminish
  :ensure t)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic)))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(use-package consult
  :ensure t)

(use-package sudo-edit
  :ensure t
  :commands sudo-edit)

(use-package rainbow-delimiters
  :ensure t
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(use-package rainbow-mode
  :diminish
  :ensure t
  :hook (org-mode prog-mode))

(use-package toc-org
  :ensure t
  :hook (org-mode . toc-org-enable))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(setq org-return-follows-link t)
(add-hook 'org-mode-hook 'org-indent-mode)

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.5))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.3))))
 '(org-level-6 ((t (:inherit outline-5 :height 1.2))))
 '(org-level-7 ((t (:inherit outline-5 :height 1.1)))))

(require 'org-tempo)

;; Multiple Cursors
(use-package multiple-cursors
  :ensure t
  :config
  (require 'multiple-cursors)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;; Highlights
(use-package hl-todo
  :ensure t
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))


;; Coding stuff
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-j")
                            (quote eval-print-last-sexp))))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :config
  (setq
   corfu-auto t
   corfu-auto-delay 0.2
   corfu-auto-trigger "."
   corfu-quit-no-match 'separator))

(defun my-detect-ts-lsp-server (&optional interactive)
  "Detect TypeScript/JavaScript project type and return appropriate LSP server.
INTERACTIVE is non-nil if called interactively."
  (let ((file (buffer-file-name)))
    (unless file (user-error "Not visiting a file"))
    (let ((deno-root (locate-dominating-file file "deno.json")))
      (if deno-root
          (list "deno" "lsp")
        (let ((node-root (locate-dominating-file file "package.json")))
          (if node-root
              (list "typescript-language-server" "--stdio")
            (list "typescript-language-server" "--stdio")))))))

(use-package eglot
  :ensure nil
  :diminish
  :hook ((rust-mode . eglot-ensure)
         (go-mode . eglot-ensure)
         (typescript-mode . eglot-ensure)
         (tsx-mode . eglot-ensure)
         (lua-mode . eglot-ensure)
         (html-mode . eglot-ensure)
         (css-mode . eglot-ensure)
         (zig-mode . eglot-ensure)
         (cmake-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '((typescript-mode typescript-ts-mode
                                  javascript-mode js-mode js-ts-mode)
                 . my-detect-ts-lsp-server)))

(setq flymake-show-diagnostics-at-end-of-line 'long)
(setq-default eglot-workspace-configuration
              '((:gopls . ((staticcheck . t)))))

(setq treesit-auto-install 'prompt)

(use-package zig-mode :ensure t :mode "\\.zig\\'")
(use-package racket-mode :ensure t :mode "\\.rkt\\'")
(use-package svelte-mode :ensure t :mode "\\.svelte\\'")
(use-package go-mode :ensure t :mode "\\.go\\'")
(use-package rust-mode :ensure t :mode "\\.rs\\'")
(use-package yaml-mode :ensure t :mode "\\.ya?ml\\'")
(use-package toml-mode :ensure t :mode "\\.toml\\'")
(use-package typescript-mode :ensure t :mode "\\.ts\\'")
(use-package dockerfile-mode :ensure t :mode "Dockerfile\\'")
(use-package lua-mode :ensure t :mode "\\.lua\\'")
(use-package markdown-mode :ensure t :mode "\\.md\\'")
(use-package php-mode :ensure t :mode "\\.php\\'")
(use-package cmake-mode :ensure t :mode "CMakeLists\\.txt\\'\\|\\.cmake\\'")

(use-package apheleia
  :ensure t
  :diminish
  :hook (prog-mode . apheleia-mode)
  :config
  (setf (alist-get 'go-mode apheleia-mode-alist) 'goimports))
