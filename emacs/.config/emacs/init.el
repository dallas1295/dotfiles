;; -*- lexical-binding: t; -*-
;; lexical bindings
(set-default-toplevel-value 'lexical-binding t)

;; Set Customs file so no clutter
(setq custom-file "~/.config/emacs/custom.el")

;; add elpaca hook for extensions
(add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))

(defun dallas/open-vterm-on-client-connect (&optional frame)
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
(add-hook 'server-after-make-frame-hook #'dallas/open-vterm-on-client-connect)

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
(setq confirm-kill-processes nil)
(setq use-short-answers t)

(add-hook 'emacs-startup-hook
          (lambda ()
            ;; 1. Make sure *scratch* exists and remains untouched
            (get-buffer-create "*scratch*")
            ;; 2. Create a dedicated *vterm* buffer, switch to it, and start vterm inside it
            (let ((buf (get-buffer-create "*vterm*")))
              (switch-to-buffer buf)
              (vterm-mode))))

(add-hook 'org-mode-hook
          (lambda ()
            (let ((orig electrci-pair-inhibit-predicate))
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
;; (icomplete-mode 1)

(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-14"))
(set-face-attribute 'default nil :font "Iosevka Nerd Font" :height 140)
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)

;; Binds
(global-set-key (kbd "C-M-n") 'move-text-down)
(global-set-key (kbd "C-M-p") 'move-text-up)

(global-unset-key (kbd "M-c"))
(global-set-key (kbd "C-c f") 'find-file)
(global-set-key (kbd "C-c F") 'dired)
(global-set-key (kbd "C-c i") 'consult-buffer)
(global-set-key (kbd "C-c I") 'dired-jump)
(global-set-key (kbd "C-c r") 'consult-recent-file)
(global-set-key (kbd "C-c p a") 'projectile-kill-buffers)
(global-set-key (kbd "C-c p s") 'projectile-switch-project)
(global-set-key (kbd "C-c p g") 'projectile-grep)

(global-set-key (kbd "C-c b d") 'delete-window)
(global-set-key (kbd "C-c b D") 'kill-buffer-and-window)
(global-set-key (kbd "C-c b l") '(lambda () (interactive) (switch-to-buffer nil)))
(global-set-key (kbd "C-c b s") #'split-window-right)
(global-set-key (kbd "M-c c") 'compile)
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

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; sudo editing
(use-package sudo-edit
  :ensure t)

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
  (setq vterm-kill-buffer-on-exit t)
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
  :bind ("C-c t" . vterm-toggle)
  :config
  ;; Keep the toggle window neatly at the bottom using your display rules
  (setq vterm-toggle-fullscreen-p nil)
  (add-to-list 'display-buffer-alist
               '("\\*vterm\\*"
                 (display-buffer-below-selected)
                 (window-height . 0.3)
                 (preserve-size . (nil . t)))))

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
;; (use-package corfu
;;   :ensure t
;;   :init
;;   (global-corfu-mode)
;;   :config
;;   (setq
;;    corfu-auto t
;;    corfu-auto-delay 0.2
;;    corfu-auto-trigger "."
;;    corfu-quit-no-match 'separator))

(use-package completion-preview
  :ensure nil
  :demand t
  :bind
  ( :map completion-preview-active-mode-map
    ("M-i" . completion-preview-insert-word)
    ("M-n" . completion-preview-next-candidate)
    ("M-p" . completion-preview-prev-candidate)
    ("M-<return>" . completion-preview-insert)
    ;; With TAB we effectively defer to the *Completions* buffer to
    ;; show more completion candidates at once.
    ("<tab>" . completion-preview-complete))
  :config
  (setq completion-preview-minimum-symbol-length 2)
  (setq completion-preview-idle-delay 0.25)
  (with-eval-after-load 'org
    (add-to-list 'completion-preview-commands #'org-self-insert-command))
  (global-completion-preview-mode 1))

(add-to-list 'display-buffer-alist
             '("\\*Completions\\*"
               (display-buffer-below-selected)
               (window-height . fit-window-to-buffer)
               (preserve-size . (nil . t))))

;; I have a more detailed configuration (and explanation) that works
;; with Emacs 31 built-in completion capabilities:
;; https://protesilaos.com/codelog/2026-07-29-emacs-default-minibuffer-completion-overview/.
(use-package minibuffer
  :ensure nil
  :demand t
  :bind
  ( :map completion-in-region-mode-map
    ("M-i" . minibuffer-choose-completion)
    ("M-n" . minibuffer-next-completion)
    ("M-p" . minibuffer-previous-completion))
  :config
  (setq completion-show-help nil)
  ;; (setq completions-header-format nil)
  (setq completions-format 'one-column)
  (setq completions-max-height 12)
  (setq completion-auto-help t)
  (setq completion-auto-select t)
  (setq minibuffer-visible-completions t)
  (setq completion-eager-update t))


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
(defun dallas/toggle-eldoc-box ()
  "Toggle eldoc-box open or closed without ever trapping cursor focus."
  (interactive)
  (if (and (boundp 'eldoc-box--frame)
           eldoc-box--frame
           (frame-live-p eldoc-box--frame)
           (frame-visible-p eldoc-box--frame))
      ;; If the box is open, close it (even if focus is inside it)
      (if (eq (selected-frame) eldoc-box--frame)
          (progn
            ;; Select main frame back and quit
            (select-frame-set-input-focus (car (frame-list)))
            (eldoc-box-quit-frame))
        (eldoc-box-quit-frame))
    ;; Otherwise, open it at point
    (eldoc-box-help-at-point)))


(defun dallas/show-and-focus-eldoc-buffer ()
  "Open the context-aware eldoc documentation buffer and immediately select/focus its window."
  (interactive)
  (let ((win (eldoc-doc-buffer t)))
    (when (window-live-p win)
      (select-window win))))

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
              ("C-c k" . dallas/toggle-eldoc-box)
              ("C-c C-k" . dallas/show-and-focus-eldoc-buffer))               ; full docs in a help buffer
  :config
  (setq eglot-autoshutdown t)
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (eglot-inlay-hints-mode -1)))
  (setq-default eglot-workspace-configuration
                '((:gopls . ((staticcheck . t))))))



(use-package eldoc
  :ensure nil
  :config
  ;; Tell ElDoc how to combine and display signatures
  (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Allow ElDoc to use up to 5 lines so long signatures fit cleanly
  (setq eldoc-echo-area-use-multiline-p 5)
  (setq eldoc-idle-delay 0.1))

;; eldoc-box (Strictly on-demand via C-c k)
(use-package eldoc-box
  :ensure t)

(add-to-list 'display-buffer-alist
             '("\\*eldoc\\*"
               (display-buffer-below-selected)
               (window-height . fit-window-to-buffer)
               (preserve-size . (nil . t))))

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
