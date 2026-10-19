;; -*- lexical-binding: t; -*-

;; lexical bindings
(set-default-toplevel-value 'lexical-binding t)

;; Set Customs file so no clutter
(setq custom-file "~/.config/emacs/custom.el")

;; add elpaca hook for extensions
(add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))

(defun my/open-vterm-on-client-connect (&optional frame)
  "Open or switch to vterm and make it take over the entire frame."
  (when (daemonp)
    (with-selected-frame (or frame (selected-frame))
      (let ((vterm-buffer (get-buffer "*vterm*")))
        (if vterm-buffer
            (switch-to-buffer vterm-buffer)
          (vterm)))
      ;; After vterm is open (whether new or existing),
      ;; wipe out any splits so it occupies 100% of the frame.
      (delete-other-windows))))

;; Hook into server window/frame creation for emacsclient
(add-hook 'server-after-make-frame-hook #'my/open-vterm-on-client-connect)

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
(setq initial-major-mode 'vterm-mode)

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
(global-set-key (kbd  "<escape>") #'keyboard-quit)
(delete-selection-mode 1)
(electric-indent-mode 1)
(electric-pair-mode 1)
(windmove-mode 1)
(which-key-mode 1)
(icomplete-mode 1)

(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-14"))
(set-face-attribute 'default nil :font "Iosevka Nerd Font" :height 140)
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)

;; Binds
(global-set-key (kbd "C-M-n") 'move-text-down)
(global-set-key (kbd "C-M-p") 'move-text-up)

(global-set-key (kbd "M-n") #'next-line)
(global-set-key (kbd "M-p") #'previous-line)


(global-unset-key (kbd "M-c"))
(global-set-key (kbd "C-c f") 'find-file)
(global-set-key (kbd "C-c F") 'dired)
(global-set-key (kbd "C-c i") 'consult-buffer)
(global-set-key (kbd "C-c I") 'dired-jump)
(global-set-key (kbd "C-c r") 'consult-recent-file)
(global-set-key (kbd "C-c p a") 'projectile-kill-buffers)
(global-set-key (kbd "C-c p s") 'projectile-switch-project)
(global-set-key (kbd "C-c p g") 'projectile-grep)

(global-set-key (kbd "C-c b d") 'kill-buffer-and-window)
(global-set-key (kbd "C-c b l") '(lambda () (interactive) (switch-to-buffer nil)))
(global-set-key (kbd "C-c b s") #'split-window-right)

(global-set-key (kbd "C-c C-c") 'my/compile-at-project-root)

(defun my/compile-at-project-root (fn &rest args)
  (let ((default-directory (or (ignore-errors (projectile-project-root))
                               default-directory)))
    (apply fn args)))

(advice-add #'compile :around #'my/compile-at-project-root)
(global-set-key (kbd "C-c c") 'capitalize-word)

(global-set-key (kbd "C-c t") 'vterm-toggle)
(global-set-key (kbd "C-c g") 'magit)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C-.") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-C C-,") 'mc/mark-previous-like-this-word)

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

;; More aggressive garbage collecting
(use-package gcmh
  :ensure t
  :init
  (gcmh-mode 1))

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

;; move-text
(use-package move-text
  :ensure t)

(defun indent-region-advice (&rest ignored)
  (let ((deactivate deactivate-mark))
    (if (region-active-p)
        (indent-region (region-beginning) (region-end))
      (indent-region (line-beginning-position) (line-end-position)))
    (setq deactivate-mark deactivate)))

(advice-add 'move-text-up :after 'indent-region-advice)
(advice-add 'move-text-down :after 'indent-region-advice)

;; multiple cursors
(use-package multiple-cursors
  :ensure t)

;; vterm
(use-package vterm
  :ensure t
  :config
  ;; This hook tells Emacs to follow the shell's current directory
  (add-hook 'vterm-set-window-title-functions
            (lambda (title)
              (when (string-match-p "^vterm:" title)
                ;; vterm passes directory info via title escape sequences
                )))

  ;; Alternatively, vterm has a built-in tracking mechanism:
  (setq vterm-kill-buffer-on-exit t)
  (add-hook 'vterm-mode-hook
            (lambda ()
              (setq-local vterm-directory-tracking t)
              (display-line-numbers-mode -1)))
  )

(use-package vterm-toggle
  :ensure t
  :config
  (setq vterm-toggle-project-root t))

;; Allow vterm to trigger find-file directly in the host Emacs instance
(with-eval-after-load 'vterm
  (add-to-list 'vterm-eval-cmds '("find-file" find-file)))

;; Projectile
(use-package projectile
  :ensure t
  :diminish
  :init
  (projectile-mode +1)
  :config
  (setq projectile-project-search-path '("~/Projects"))
  (setq projectile-enable-caching t))


(use-package embrace
  :ensure t
  :bind ("C-," . embrace-commander))

;; Coding essentials
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
   corfu-quit-no-match 'separator))

;; Formatting
(use-package apheleia
  :ensure t
  :diminish
  :hook (prog-mode . apheleia-mode)
  :config
  (setf (alist-get 'go-mode apheleia-mode-alist) 'goimports)
  (setf (alist-get 'odin-mode apheleia-mode-alist) 'odinfmt)
  (setf (alist-get 'odinfmt apheleia-formatters) '("odinfmt" "-stdin")))


;; LSP/Syntax Highlighting
(use-package eglot
  :ensure nil
  :diminish
  :init
  (setq eglot-code-action-indications nil)
  (setq eldoc-echo-area-use-multiline-p t)
  :hook ((go-mode . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (rust-mode . eglot-ensure)
         (tsx-mode . eglot-ensure)
         (lua-mode . eglot-ensure)
         (html-mode . eglot-ensure)
         (css-mode . eglot-ensure)
         (web-mode . eglot-ensure)
         (odin-mode . eglot-ensure))
  :bind (:map eglot-mode-map
              ("C-c C-k" . eldoc-doc-buffer))               ; full docs in a help buffer
  :config
  (setq eglot-autoshutdown t)
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (eglot-inlay-hints-mode -1)))
  (setq-default eglot-workspace-configuration
                '((:gopls . ((staticcheck . t))))))

;; eldoc-box (On-demand via keybinding)
(use-package eldoc-box
  :ensure t
  :bind (:map eglot-mode-map
              ("C-c k" . eldoc-box-eglot-help-at-point))
  :config
  (add-hook 'eglot-managed-mode-hook #'eldoc-box-hover-mode t))

(use-package zig-mode :ensure t)
(use-package rust-mode :ensure t)
(use-package yaml-mode :ensure t)
(use-package toml-mode :ensure t)
(use-package typescript-mode :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package lua-mode :ensure t)
(defun my-odin-mode-setup ()
  (setq-local indent-tabs-mode t)
  (setq-local indent-line-function #'indent-relative))

(use-package odin-mode
  :ensure (:host github :repo "mattt-b/odin-mode")
  :mode ("\\.odin\\'" . odin-mode)
  :hook (odin-mode . my-odin-mode-setup))
