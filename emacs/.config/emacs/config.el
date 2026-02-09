(add-to-list 'load-path "~/.config/emacs/scripts/")

(require 'elpaca-setup)  ;; The Elpaca Package Manager
(require 'buffer-move)   ;; Buffer-move for better window management

(use-package evil
  :ensure t
  :demand t
  :after elpaca
  :diminish
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))
(use-package evil-collection
  :after evil
  :diminish
  :ensure t
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))
(use-package evil-tutor :ensure t :diminish)
(use-package evil-escape
  :ensure t
  :diminish
  :after evil
  :config
  (evil-escape-mode)
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.2))
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; Using RETURN to follow links in Org/Evil 
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
(setq org-return-follows-link  t)

(use-package general
  :ensure t
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer emacaroni/leader-key
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode
  
  ;; general
  (emacaroni/leader-key
    "SPC" '(find-file :wk "Find File")
    "/" '(counsel-M-x :wk "Counsel M-x")
    "co" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config")
    "cr" '(reload-init-file :wk "Reload config")
    "fr" '(counsel-recentf :wk "Find recent files")
    "-" '(dired :wk "File Explorer (Dired)")
    "." '(counsel-fzf :wk "Fuzzy finder"))

   ;; org
   (emacaroni/leader-key
    "o" '(:ignore t :wk "Org")
    "o a" '(org-agenda :wk "Org agenda")
    "o e" '(org-export-dispatch :wk "Org export dispatch")
    "o i" '(org-toggle-item :wk "Org toggle item")
    "o t" '(org-todo :wk "Org todo")
    "o B" '(org-babel-tangel :wk "Org babel tangle")
    "o T" '(org-todo-list :wk "Org todo list")
    "o b" '(org-table-insert-hline :wk "Insert hline in table")
    "o d" '(org-time-stamp :wk "Org time stamp"))
    ;; buffer
    (emacaroni/leader-key
     "b" '(:ignore t :wk "Buffer")
     "bb" '(switch-to-buffer :wk "Switch buffer")
     "bk" '(kill-this-buffer :wk "Close current buffer")
     "bn" '(next-buffer :wk "Next buffer")
     "bp" '(previous-buffer :wk "Previous buffer")
     "bi" '(ibuffer :wk "IBuffer")
     "bd" '(evil-window-delete :wk "Close window")
     "bw" '(evil-window-new :wk "New window"))
    ;; splits
    (emacaroni/leader-key
      "s" '(:ignore t :wk "Split")
      "sh" '(evil-window-split :wk "New horizontal split")
      "sv" '(evil-window-vsplit :wk "New vertical split"))
    ;; dired
    (emacaroni/leader-key
     "d" '(:ignore t :wk "Dired")
     "dl" '(dired :wk "Open dired")
     "dj" '(dired-jump :wk "Dired jump to current")
     "dn" '(neotree-dir :wk "Open directory in neotree")
     "dp" '(peep-dired :wk "Peep-dired"))
    ;; evaluation
    (emacaroni/leader-key
     "e" '(:ignore t :wk "Evaluate")
     "eb" '(eval-buffer :wk "Evaluate elisp in buffer")
     "ed" '(eval-defun :wk "Evaluate defun containing or after point")
     "ee" '(eval-expression :wk "Evaluate an elisp expression")
     "el" '(eval-last-sexp :wk "Evaluate elisp expression before point")
     "er" '(eval-region :wk "Evaluate elisp in region"))
    ;; window
    (emacaroni/leader-key
     "w" '(:ignore t :wk "Window")
     "wn" '(evil-window-next :wk "Wind next")
     "wh" '(evil-window-left :wk "Window left")
     "wl" '(evil-window-right :wk "Window right")
     "wk" '(evil-window-up :wk "Window up")
     "wj" '(evil-window-down :wk "Window down")
     "wH" '(buf-move-left :wk "Buffer move left")
     "wJ" '(buf-move-down :wk "Buffer move down")
     "wK" '(buf-move-up :wk "Buffer move up")
     "wL" '(buf-move-right :wk "Buffer move right"))
    ;; toggles
    (emacaroni/leader-key
     "t" '(:ignore t :wk "Terminal")
     "tf" '(neotree-toggle :wk "Toggle neotree")
     "tl" '(visual-line-mode :wk "Toggle truncated lines")
     "tt" '(vterm-toggle :wk "Toggle vterm")
     "te" '(eshell :wk "Open eshell"))
    
    ;; projectile
    (emacaroni/leader-key
     "p" '(projectile-command-map :wk "Projectile"))
)

(use-package nerd-icons
  :ensure t
  :if (display-graphic-p))

(use-package nerd-icons-dired
:ensure t
  :hook (dired-mode . (lambda () (nerd-icons-dired-mode t))))
(use-package nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(setq backup-directory-alits '((".a' ~/.Trash")))

(use-package diminish :ensure t)

(use-package dired-open
  :ensure t
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

(use-package peep-dired
  :ensure t
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "ENTER") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
    (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
    (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
)

;;(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode))
(use-package flymake
  :ensure t
  :defer t
  :diminish)

(set-face-attribute 'default nil
  :font "JetBrainsMono Nerd Font"
  :height 150 
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Nebula Sans"
  :height 140
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrainsMono Nerd Font"
  :height 150
  :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-17"))

;; Uncomment the following line if line spacing needs adjusting.
;;(setq-default line-spacing 0.12)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(use-package transient :ensure t)
(use-package magit :ensure t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq display-line-numbers-type 'relative)

(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab )

(delete-selection-mode 1)
(electric-indent-mode -1)
(electric-pair-mode 1)

;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
;; Corrected hook to stop < from auto-closing in Org mode
(add-hook 'org-mode-hook 
          (lambda ()
            (setq-local electric-pair-inhibit-predicate
                        (lambda (c)
                          (if (char-equal c ?<)
                              t ;; Return t means "Do NOT pair this character"
                            (when electric-pair-inhibit-predicate
                              (funcall electric-pair-inhibit-predicate c)))))))

(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed
(global-display-line-numbers-mode 1) ;; Display line numbers
(global-visual-line-mode nil)  ;; Enable truncated lines
(menu-bar-mode -1)           ;; Disable the menu bar 
(scroll-bar-mode -1)         ;; Disable the scroll bar
(tool-bar-mode -1)           ;; Disable the tool bar
(setq org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.

(use-package counsel
  :ensure t
  :diminish
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :ensure t
  :diminish
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package nerd-icons-ivy-rich
  :ensure t
  :init (nerd-icons-ivy-rich-mode 1))
(use-package ivy-rich
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(use-package company
  :ensure t
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :ensure t
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package lua-mode :ensure t)
(use-package haskell-mode :ensure t)
(use-package go-mode :ensure t)
(use-package elixir-mode :ensure t)
(use-package rust-mode :ensure t)
(use-package json-mode :ensure t)
(use-package typescript-mode :ensure t)
(use-package lsp-mode :ensure t)

(use-package jsonrpc)
(use-package project)
(use-package eglot
     :ensure t
     :hook ((go-mode . eglot-ensure)
            (rust-mode . eglot-ensure)
            (typescript-mode . eglot-ensure)
	    (json-mode . eglot-ensure)
	    (lua-mode . eglot-ensure)))

(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1)
  (setf (alist-get 'go-mode apheleia-mode-alist)
        '(goimports gofmt)))

(global-set-key [escape] 'keyboard-escape-quit)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35      ;; sets modeline height
        doom-modeline-bar-width 5    ;; sets right bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon t)) ;; adds folder icon next to persp name

(use-package toc-org
  :ensure t
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-superstar :ensure t)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(require 'org-tempo)

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))

(use-package rainbow-mode
  :ensure t
  :hook 
  ((org-mode prog-mode) . rainbow-mode))
;; Delimiters
(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
	 (clojure-mode .rainbow-delimiters-mode)))

(defun reload-init-file ()
  (interactive)
  (load-file user-init-file)
  (load-file user-init-file))

(use-package eshell-syntax-highlighting
  :ensure t
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
;; eshell-aliases-file -- sets an aliases file for the eshell.
  
(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package vterm
  :ensure t
  :config
(setq shell-file-name "/bin/zsh"
      vterm-max-scrollback 5000))

(use-package vterm-toggle
  :ensure 
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.60))))

(use-package sudo-edit
   :ensure t
   :after general
   :config
     (emacaroni/leader-key
       "fu" '(sudo-edit-find-file :wk "Sudo find file")
       "fU" '(sudo-edit :wk "Sudo edit file"))
)

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
    
(load-theme 'doom-gruvbox t)
)

;; Set transparency for the current frame (the one launching)
(set-frame-parameter (selected-frame) 'alpha-background 85)

;; Set transparency for all future frames
(add-to-list 'default-frame-alist '(alpha-background . 85))

(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
  which-key-sort-order #'which-key-key-order-alpha which-key-sort-uppercase-first nil
  which-key-add-column-padding 1
  which-key-max-display-columns nil
  which-key-min-display-lines 6
  which-key-side-window-slot -10
  which-key-side-window-max-height 0.25
  which-key-idle-delay 0.2
  which-key-max-description-length 25
  which-key-allow-imprecise-window-fit nil
  which-key-separator " → " ))
