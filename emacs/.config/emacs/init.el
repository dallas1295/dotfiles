;; -*- lexical-binding: t; -*-

;; lexical bindings
(set-default-toplevel-value 'lexical-binding t)

;; Set Customs file so no clutter
(setq custom-file "~/.config/emacs/custom.el")

;; add elpaca hook for extensions
(add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))

(dolist (dir '("~/.opencode/bin" "~/opt/bin" "~/.cargo/bin"
               "~/go/bin" "~/thirdparty/bin" "~/.local/bin"))
  (let ((dir (expand-file-name dir)))
    (add-to-list 'exec-path dir)
    (setenv "PATH" (concat dir path-separator (getenv "PATH")))))

;; get trash file
(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

;; Sane defaults (for me)
(setq inhibit-splash-screen t)
(setq-default tab-width 4)
(setq-default standard-indent 2)
(setq-default indent-tabs-mode nil)
(setq auto-save-default nil)
(setq display-line-numbers-type 'relative)

(add-hook 'org-mode-hook
          (lambda ()
            (let ((orig electric-pair-inhibit-predicate))
              (setq-local electric-pair-inhibit-predicate
                          (lambda (c)
                            (if (char-equal c ?<) t (funcall orig c)))))))


(add-hook 'before-save-hook 'delete-trailing-whitespace)

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
(icomplete-mode 1)

(set-face-attribute 'default nil :font "Iosevka Nerd Font" :height 140)
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)

;; Binds
(global-set-key (kbd "M-n") #'next-line)
(global-set-key (kbd "M-p") #'previous-line)


(global-unset-key (kbd "M-c"))
(global-set-key (kbd "M-c f") 'find-file)
(global-set-key (kbd "M-c F") 'dired)
(global-set-key (kbd "M-c i") 'consult-buffer)
(global-set-key (kbd "M-c I") 'dired-jump)
(global-set-key (kbd "M-c g") 'consult-ripgrep)
(global-set-key (kbd "M-c r") 'consult-recent-file)
(global-set-key (kbd "M-c k a") 'projectile-kill-buffers)
(global-set-key (kbd "M-c p s") 'projectile-switch-project)

(global-set-key (kbd "M-c b d") '(kill-buffer-and-window))
(global-set-key (kbd "M-c b l") '(lambda () (interactive) (switch-to-buffer nil)))
(global-set-key (kbd "M-c b s") #'split-window-right)

(global-set-key (kbd "M-c c") 'compile)
(global-set-key (kbd "C-c c") 'capitalize-word)

;; Dependencies

;; dired and ibuffer
(setq display-buffer-alist
      '(("\\*compilation\\*"
         (display-buffer-in-direction)
         (direction . below)
         (window-height . 0.35))
        ("\\*Buffer List\\*" . (display-buffer-same-window))
        ("\\*.*\\*" . (display-buffer-pop-up-window))))

(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :config
  (setq vertico-cycle t
        vertico-count 15))

;; Theme
(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))


;; QoL
(use-package diminish
  :ensure t)

(use-package consult
  :ensure t)

;; Colors for Hex and Brackets
(use-package rainbow-delimiters
  :ensure t
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

;; Magit
(use-package magit
  :ensure t)
(use-package transient
  :ensure t)


;; Projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :config
  (setq projectile-project-search-path '("~/Projects"))
  (setq projectile-enable-caching t))


(use-package embrace
  :ensure t
  :bind ("C-," . embrace-commander))

;; Coding essentials
;; Snippets

;; ;; Completions
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :config
  (setq
   corfu-auto t
   corfu-auto-delay 0.2
   corfu-auto-trigger "."
   corfu-quit-no-match 'separator)
  (add-to-list 'completion-at-point-functions #'tempel-expand))

;; Formatting
(use-package apheleia
  :ensure t
  :diminish
  :hook (prog-mode . apheleia-mode)
  :config
  (setf (alist-get 'go-mode apheleia-mode-alist) 'goimports))


;; LSP/Syntax Highlighting
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
  :hook ((go-mode . eglot-ensure)
         (typescript-mode . eglot-ensure)
         (tsx-mode . eglot-ensure)
         (lua-mode . eglot-ensure)
         (html-mode . eglot-ensure)
         (css-mode . eglot-ensure)
         (web-mode . eglot-ensure)
         (odin-mode . eglot-ensure))
  :config
  (remove-hook 'eglot-managed-mode-hook #'eglot-inlay-hints-mode)
  (add-to-list 'eglot-server-programs
               '((typescript-mode typescript-ts-mode
                                  javascript-mode js-mode js-ts-mode)
                 . my-detect-ts-lsp-server))
  (setq-default eglot-workspace-configuration
                '((:gopls . ((staticcheck . t))))))

(use-package zig-mode :ensure t)
(use-package rust-mode :ensure t)
(use-package yaml-mode :ensure t)
(use-package toml-mode :ensure t)
(use-package typescript-mode :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package lua-mode :ensure t)
(use-package odin-mode
  :ensure (:host github :repo "mattt-b/odin-mode")
  :mode ("\\.odin\\'" . odin-mode))
