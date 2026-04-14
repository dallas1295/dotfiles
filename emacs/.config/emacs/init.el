;; move custom out of init.el
(setq custom-file "~/.config/emacs/custom.el")
(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

;; This is simple QoL stuff
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
(which-key-mode 1)

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 135)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)
(global-set-key (kbd "C-c C-v") 'beginning-of-buffer)
(global-set-key (kbd "C-c v") 'end-of-buffer)
(global-set-key (kbd "C-x C-d") 'dired-jump)
(global-set-key (kbd "C-x S-d") 'dired)

(setq display-buffer-alist
      '(("\\*Buffer List\\*" . (display-buffer-same-window))
        ("\\*.*\\*" . (display-buffer-pop-up-window))))

;; for laptop usage
;; Right Alt + H/J/K/L as arrow keys
(define-key key-translation-map (kbd "A-h") (kbd "<left>"))
(define-key key-translation-map (kbd "A-j") (kbd "<down>"))
(define-key key-translation-map (kbd "A-k") (kbd "<up>"))
(define-key key-translation-map (kbd "A-l") (kbd "<right>"))

;; Dired
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

;; Enable Melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Theme
(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))

;; Extensions


(setq org-return-follows-link t)

;; Meow - Modal editing for Emacs
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)

  (meow-leader-define-key
   '("?" . meow-cheatsheet)
   '("." . find-file)
   '("/" . consult-ripgrep)
   '("f r" . consult-recent-file)
   '("," . consult-buffer)
   '("SPC" . project-find-file)
   '("w v" . split-window-right)
   '("w s" . split-window-below)
   '("w d" . delete-window)
   '("w h" . windmove-left)
   '("w j" . windmove-down)
   '("w k" . windmove-up)
   '("w l" . windmove-right)
   '("b b" . consult-buffer)
   '("b k" . (lambda () (interactive) (kill-buffer (current-buffer))))
   '("b n" . next-buffer)
   '("b l" . (lambda () (interactive) (switch-to-buffer nil)))
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument))

  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))

  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("1" . meow-expand-1)
   '("2" . meow-expand-2)
   '("3" . meow-expand-3)
   '("4" . meow-expand-4)
   '("5" . meow-expand-5)
   '("6" . meow-expand-6)
   '("7" . meow-expand-7)
   '("8" . meow-expand-8)
   '("9" . meow-expand-9)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-open-below)
   '("O" . meow-open-above)
   '("p" . meow-yank)
   '("P" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-redo)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("%" . meow-block)
   '("<escape>" . ignore)
   '("SPC" . meow-keypad-start))

  (setq meow-mode-state-list
        '((dired-mode . motion)
          (org-mode . normal)
          (help-mode . motion)
          (info-mode . motion)
          (messages-buffer-mode . motion)
          (special-mode . motion)))
  )

(use-package meow
  :ensure t
  :demand t
  :config
  (meow-setup)
  (meow-global-mode 1)
  (meow-thing-register 'angle
                       '(regexp "<" ">")
                       '(regexp "<" ">"))
  (meow-thing-register 'double-quote
                       '(regexp "\"" "\"")
                       '(regexp "\"" "\""))
  (meow-thing-register 'single-quote
                       '(regexp "'" "'")
                       '(regexp "'" "'"))
  (meow-thing-register 'backtick
                       '(regexp "`" "`")
                       '(regexp "`" "`"))
  (setq meow-char-thing-table
        '((?\( . round)
          (?\[ . square)
          (?\{ . curly)
          (?\< . angle)
          (?\" . double-quote)
          (?\' . single-quote)
          (?\` . backtick)
          (?e . symbol)
          (?w . window)
          (?b . buffer)
          (?p . paragraph)
          (?l . line)
          (?d . defun))))


;; other
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package consult
  :ensure t
  :bind (("C-c b" . consult-buffer)
         ("C-c d" . dired-jump)
         ("C-c r" . consult-ripgrep)))

(use-package sudo-edit
  :ensure t)

(use-package expand-region
  :ensure t
  :bind ("C-S-u" . er/expand-region))

(use-package multiple-cursors
  :ensure t
  :config
  (require 'multiple-cursors)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/majrk-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

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

(use-package rainbow-delimiters
  :ensure t
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(use-package rainbow-mode
  :ensure t
  :hook org-mode prog-mode)

;; Org Mode
(use-package toc-org
  :ensure t
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets
  :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.5))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.3))))
 '(org-level-6 ((t (:inherit outline-5 :height 1.2))))
 '(org-level-7 ((t (:inherit outline-5 :height 1.1)))))

(require 'org-tempo)


;; Modes for Coding

;; Elisp for eval
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-j")
                            (quote eval-print-last-sexp))))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

;; Completions (corfu)
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

;; LSP

;;Typescript projects
(defun my-detect-ts-lsp-server (&optional interactive)
  "Detect TypeScript/JavaScript project type and return appropriate LSP server.
INTERACTIVE is non-nil if called interactively."
  (let ((file (buffer-file-name)))
    (unless file (user-error "Not visiting a file"))
    
    ;; Check for Deno project
    (let ((deno-root (locate-dominating-file file "deno.json")))
      (if deno-root
          ;; Return denols configuration
          (list "deno" "lsp")
        ;; Check for Node.js/TypeScript project
        (let ((node-root (locate-dominating-file file "package.json")))
          (if node-root
              ;; Return typescript-language-server configuration
              (list "typescript-language-server" "--stdio")
            ;; Fallback to typescript-language-server
            (list "typescript-language-server" "--stdio")))))))

(use-package eglot
  :ensure nil ;built-in
  :config
  (add-to-list 'eglot-server-programs
               '((typescript-mode typescript-ts-mode 
                                  javascript-mode js-mode js-ts-mode) 
                 . my-detect-ts-lsp-server))
  (add-hook 'rust-mode-hook 'eglot-ensure)
  (add-hook 'go-mode-hook 'eglot-ensure)
  (add-hook 'typescript-mode-hook 'eglot-ensure)
  (add-hook 'tsx-mode-hook 'eglot-ensure)
  (add-hook 'lua-mode-hook 'eglot-ensure)
  (add-hook 'html-mode-hook 'eglot-ensure)
  (add-hook 'css-mode-hook 'eglot-ensure)
  (add-hook 'zig-mode-hook 'eglot-ensure)
  (add-hook 'cmake-mode-hook 'eglot-ensure))

(setq flymake-show-diagnostics-at-end-of-line 'long)
(setq-default eglot-workspace-configuration
              '((:gopls . ((staticcheck . t)))))

;;  Auto install treesitter grammars
(setq treesit-auto-install 'prompt)

(use-package zig-mode :ensure t)
(use-package racket-mode :ensure t)
(use-package svelte-mode :ensure t)
(use-package go-mode :ensure t)
(use-package rust-mode :ensure t)
(use-package yaml-mode :ensure t)
(use-package toml-mode :ensure t)
(use-package typescript-mode :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package lua-mode :ensure t)
(use-package markdown-mode :ensure t)
(use-package php-mode :ensure t)

(use-package cmake-mode :ensure t)


;; Formatter
(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode 1)
  (setf (alist-get 'go-mode apheleia-mode-alist) 'goimports))
