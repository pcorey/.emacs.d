;; Helpful links:
;; 
;; - https://sam217pa.github.io/2016/09/02/how-to-build-your-own-spacemacs/
;; - https://dev.to/huytd/emacs-from-scratch-1cg6
;; - https://sam217pa.github.io/2016/09/13/from-helm-to-ivy/#fnref:2

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq delete-old-versions -1 )
(setq inhibit-startup-screen t )
(setq ring-bell-function 'ignore )
(setq coding-system-for-read 'utf-8 )
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)
(setq default-fill-column 80)
(setq initial-scratch-message "")
(setq word-wrap t)

;; https://github.com/danielmai/.emacs.d/blob/master/config.org
(defalias 'yes-or-no-p 'y-or-n-p)
(blink-cursor-mode -1)
(show-paren-mode t)

(setq-default mode-line-format nil)

;; (toggle-word-wrap)
(global-auto-revert-mode t)
(global-display-line-numbers-mode)
(electric-pair-mode)


;; Package Management
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
			 ("gnu"       . "http://elpa.gnu.org/packages/")
			 ("melpa"     . "https://melpa.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Path management
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; Vim mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (setq-default evil-escape-delay 0.2))

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(use-package writeroom-mode
  :ensure t
  :init
  (setq-default writeroom-major-modes '(markdown-mode))
  :config
  (global-writeroom-mode))

;; Font
;; (add-to-list 'default-frame-alist '(font . "Fira Code-14" ))
;; (set-face-attribute 'default t :font "Fira Code-14" )
(add-to-list 'default-frame-alist '(font . "Cascadia Code-12" ))
(set-face-attribute 'default t :font "Cascadia Code-12" )

;; Themes
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-peacock t))

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; (use-package lsp-mode
;;   :ensure t
;;   :init
;;   (setq lsp-auto-guess-root t)
;;   (setq lsp-prefer-flymake nil)
;;   :config
;;   (add-hook 'js2-mode-hook #'lsp)
;;   (add-hook 'rjsx-mode-hook #'lsp))

;; (use-package lsp-ui
;;   :ensure t
;;   :requires lsp-mode flycheck
;;   :config
;;   (setq lsp-ui-doc-enable t
;;   	lsp-ui-doc-use-childframe nil
;;   	lsp-ui-doc-position 'top
;;   	lsp-ui-doc-include-signature t
;;   	lsp-ui-sideline-enable nil
;;   	lsp-ui-flycheck-enable t
;;   	lsp-ui-flycheck-list-position 'right
;;   	lsp-ui-flycheck-live-reporting t
;;   	lsp-ui-peek-enable t
;;   	lsp-ui-peek-list-width 60
;;   	lsp-ui-peek-peek-height 25)
;;   (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; (use-package company-lsp
;;   :ensure t
;;   :commands company-lsp)

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

;; Elixir
(use-package elixir-mode
  :ensure t)

;; Javascript
(use-package js2-mode 
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))
(use-package rjsx-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode)))
(use-package add-node-modules-path
  :ensure t)
(use-package prettier-js
  :ensure t
  :init
  (require 'prettier-js)
  (add-hook 'js2-mode-hook 'add-node-modules-path)
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'add-node-modules-path)
  (add-hook 'web-mode-hook 'prettier-js-mode))

;; Markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Multi-Term
(use-package multi-term
  :ensure t
  :init
  (setq multi-term-program "/bin/zsh"))

;; Ivy & friends
(use-package ivy
  :ensure t)
(use-package counsel
  :ensure t)

;; Ranger
(use-package ranger 
  :ensure t
  :init
  (setq ranger-show-hidden t))

;; Code commenting
(use-package evil-nerd-commenter :ensure t)

;; Project management
(use-package projectile
  :ensure t
  :init
  (setq projectile-completion-system 'ivy)
  (setq projectile-indexing-method 'alien)
  (setq projectile-sort-order 'recently-active)

  ; Route errors to /dev/null
  (setq projectile-git-submodule-command "git submodule --quiet foreach 'echo $path' 2>/dev/null | tr '\\n' '\\0'")
  :config
  (projectile-mode))
(use-package counsel-projectile 
  :ensure t
  :config
  (counsel-projectile-mode))

;; Workspaces
(use-package perspective
  :ensure t
  :config
  (persp-mode))
(use-package persp-projectile
  :ensure t)

;; Surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; JS Doc
(use-package js-doc
  :ensure t)

;; Edit this config
(defun edit-emacs-configuration ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun toggle-buffers ()
  (interactive)
  (switch-to-buffer nil))

;; Keybindings
(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "Kj" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "KJ" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "kJ" 'evil-normal-state))
(use-package general
  :ensure t
  :config 
  (general-define-key
   "M-x" 'counsel-M-x)
  (general-define-key
   :states '(normal visual emacs)
   ;; "/" 'swiper
   "gcc" 'evilnc-comment-or-uncomment-lines)
  (general-define-key
   :states '(normal visual)
   "C-u" 'scroll-down-command
   "C-d" 'scroll-up-command)
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"
   "'"   'multi-term
   "/"   'counsel-rg
   ":"   'counsel-M-x
   "."   'edit-emacs-configuration
   "\""  'split-window-below
   "%"  'split-window-right
   "TAB" 'toggle-buffers

   "p" 'projectile-command-map
   "pp" 'projectile-persp-switch-project
   "pf" 'counsel-projectile-find-file

   "b" '(:ignore t :which-key "Buffers")
   "bb"  'ivy-switch-buffer

   "w" '(:ignore t :which-key "Window")
   "wl"  'windmove-right
   "wh"  'windmove-left
   "wk"  'windmove-up
   "wj"  'windmove-down
   "w\""  'split-window-below
   "w%"  'split-window-right
   "wx"  'delete-window

   "a" '(:ignore t :which-key "Applications")
   "ar" 'ranger
   "ad" 'deer

   "s" '(:ignore t :which-key "Search")
   "sc" 'evil-ex-nohighlight
   "sl" 'ivy-resume

   "t" '(:ignore t :which-key "Toggles")
   "tn" 'display-line-numbers-mode
   "tl" 'toggle-truncate-lines

   "T" 'counsel-load-theme
   
   "x" '(:ignore t :which-key "Text")
   "xl" '(:ignore t :which-key "Lines")
   "xls" 'sort-lines
   
   "g" '(:ignore t :which-key "Code?")
   "gc" 'evilnc-comment-or-uncomment-lines

   "d" '(:ignore t :which-key "Comments")
   "df" 'js-doc-insert-function-doc
   "dm" 'js-doc-insert-file-doc
   )
  (general-define-key
   :states '(visual)
   "gc" 'evilnc-comment-or-uncomment-lines))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (olivetti which-key use-package ranger prettier-js multi-term js2-mode general exec-path-from-shell evil doom-themes counsel-projectile))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
