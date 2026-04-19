(require 'org)
(setq custom-file "~/.config/emacs/custom.el")
(add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))
(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
