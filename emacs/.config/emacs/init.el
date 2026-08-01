;; Set Customs file so no clutter
(setq custom-file "~/.config/emacs/custom.el")

;; add elpaca hook for extensions
(add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))

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
(global-set-key (kbd "M-c i") 'switch-to-buffer)
(global-set-key (kbd "M-c I") 'dired-jump)
(global-set-key (kbd "M-c k a") 'projectile-kill-buffers)
(global-set-key (kbd "M-c p s") 'projectile-switch-project)


(global-set-key (kbd "M-c b d") '(lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key (kbd "M-c b l") '(lambda () (interactive) (switch-to-buffer nil)))
(global-set-key (kbd "M-c b s") #'split-window-right)

(global-set-key (kbd "M-c c") 'compile)
(global-set-key (kbd "M-c o") 'magit)
(global-set-key (kbd "C-c c") 'capitalize-word)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-unset-key (kbd "C-S-<down-mouse-1>"))
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

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

;; Theme
(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))

;; QoL
(use-package diminish
  :ensure t)

(use-package multiple-cursors
  :ensure t
  :config
  (setq mc/always-run-for-all t)
  (dolist (cmd '(my/mc-add-cursor-here my/mc-cursor-forward-word overwrite-mode))
    (add-to-list 'mc/cmds-to-run-once cmd)
    (setq mc/cmds-to-run-for-all (remove cmd mc/cmds-to-run-for-all))))

;; Colors for Hex and Brackets
(use-package rainbow-delimiters
  :ensure t
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(use-package rainbow-mode
  :diminish
  :ensure t
  :hook (org-mode prog-mode))

;; Org-mode
(setq org-confirm-babel-evaluate nil)
(setq org-babel-default-header-args '((:results . "silent")))

(use-package toc-org
  :ensure t
  :hook (org-mode . toc-org-enable))

(use-package
  org-bullets
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
 '(org-level-6 ((t (:inherit outline-6 :height 1.2))))
 '(org-level-7 ((t (:inherit outline-7 :height 1.1)))))

;; | Typing the below + TAB | Expands to ...                          |
;; |------------------------+-----------------------------------------|
;; | <a                     | '#+BEGIN_EXPORT ascii' … '#+END_EXPORT  |
;; | <c                     | '#+BEGIN_CENTER' … '#+END_CENTER'       |
;; | <C                     | '#+BEGIN_COMMENT' … '#+END_COMMENT'     |
;; | <e                     | '#+BEGIN_EXAMPLE' … '#+END_EXAMPLE'     |
;; | <E                     | '#+BEGIN_EXPORT' … '#+END_EXPORT'       |
;; | <h                     | '#+BEGIN_EXPORT html' … '#+END_EXPORT'  |
;; | <l                     | '#+BEGIN_EXPORT latex' … '#+END_EXPORT' |
;; | <q                     | '#+BEGIN_QUOTE' … '#+END_QUOTE'         |
;; | <s                     | '#+BEGIN_SRC' … '#+END_SRC'             |
;; | <v                     | '#+BEGIN_VERSE' … '#+END_VERSE'         |

(require 'org-tempo)

(setq org-directory "~/org")
(setq org-todo-keywords
      '((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE(d)" "CANCELLED(c)")))
(setq org-log-done 'time)
(setq org-log-into-drawer t)


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
  (setq projectile-project-search-path '("~/projects"))
  (setq projectile-enable-caching t))


(use-package embrace
  :ensure t
  :bind ("C-," . embrace-commander))

;; Coding essentials
;; Snippets
;; (use-package tempel
;;   :ensure t
;;   :commands (tempel-expand tempel-done)
;;   :config
;;   (global-set-key (kbd "M-+") 'tempel-expand))

;; (use-package tempel-collection
;;   :ensure t)

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
;;    corfu-quit-no-match 'separator)
;;   (add-to-list 'completion-at-point-functions #'tempel-expand))

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
         (odin-mode . eglot-ensure)
         (cmake-mode . eglot-ensure))

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
(use-package cmake-mode :ensure t)
(use-package odin-mode
  :ensure (:host github :repo "mattt-b/odin-mode")
  :mode ("\\.odin\\'" . odin-mode))
