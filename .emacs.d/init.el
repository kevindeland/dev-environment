;; -*- mode: emacs-lisp -*-
;; Simple .emacs configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------
(add-to-list 'load-path "~/.emacs.d/lisp")
(let ((default-directory "~/.emacs.d/lisp"))
  (normal-top-level-add-subdirs-to-load-path))
(require 'cl)
(require 'ido)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'linum)
;;(require 'smooth-scrolling)
(require 'whitespace)
(require 'dired-x)
(require 'compile)
(ido-mode t)
(menu-bar-mode -1)
(normal-erase-is-backspace-mode 0)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq column-number-mode t)
(setq inhibit-startup-message t)
(setq save-abbrevs nil)
(setq show-trailing-whitespace t)
(setq suggest-key-bindings t)
(setq vc-follow-symlinks t)


(require 'typewriter)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs$" . web-mode))
(setq-default indent-tabs-mode nil)

;; fucking backups
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
                `((".*" ,temporary-file-directory t)))

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))
(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

;; R mode?
					; automatically get the correct mode
auto-mode-alist (append (list '("\\.c$" . c-mode)
			      '("\\.tex$" . latex-mode)
			      '("\\.S$" . S-mode)
			      '("\\.s$" . S-mode)
			      '("\\.R$" . R-mode)
			      '("\\.r$" . R-mode)
;;			      '("\\.html$" . html-mode)
			      '("\\.emacs" . emacs-lisp-mode)
			      )
			auto-mode-alist)

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; open glsl mode
(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))


;; markdown -mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "monaco"))))
 '(column-marker-1 ((t (:background "red"))))
 '(diff-added ((t (:foreground "cyan"))))
 '(flymake-errline ((((class color) (background light)) (:background "Red"))))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "red"))))
 '(fundamental-mode-default ((t (:inherit default))))
 '(highlight ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(isearch ((((class color) (min-colors 8)) (:background "yellow" :foreground "black"))))
 '(linum ((t (:foreground "black" :weight bold))))
 '(region ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(secondary-selection ((((class color) (min-colors 8)) (:background "gray" :foreground "cyan"))))
 '(show-paren-match ((((class color) (background light)) (:background "black"))))
 '(vertical-border ((t nil)))
 '(web-mode-html-attr-custom-face ((t (:inherit web-mode-html-attr-name-face :foreground "magenta"))))
 '(web-mode-html-attr-name-face ((t (:foreground "blue" :weight bold))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "blue" :weight bold))))
 '(web-mode-html-tag-face ((t (:foreground "blue" :weight bold)))))

;; ------------
;; -- Macros --
;; ------------
;;(load "defuns-config.el")
(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
(global-set-key "\M-=" 'align-equals)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\M-n" 'next5)
(global-set-key "\M-p" 'prev5)
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-i" 'back-window)
(global-set-key "\C-z" 'zap-to-char)
;;(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-d" 'kill-word)
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key "\M-u" 'zap-to-char)

(fset 'insert-console-log
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("	console.log();" 0 "%d")) arg)))
;;(global-set-key (kbd "C-c l") 'insert-console-log)




;; ---------------------------
;; -- JS Mode configuration --
;; ---------------------------
(load "js-config.el")
(add-to-list 'load-path "~/.emacs.d/jade-mode") ;; github.com/brianc/jade-mode
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-firefox)))


;; open a required js file
(fset 'open-require-js
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("' 'w.js" 0 "%d")) arg)))
(global-set-key (kbd "C-x n r") 'open-require-js)
;; open in other window (only works if same directory)
(fset 'open-require-js-other
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("' 'wo.js" 0 "%d")) arg)))
(global-set-key (kbd "C-x n o") 'open-require-js-other)



(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
	  (lambda ()
	    (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; for Golang syntax highlighting
(add-to-list 'load-path "~/Misc/emacs/go-mode.el/")
(require 'go-mode-load)

(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)
;;(global-set-key (kbd "C-8") 'dabbrev-expan

(fset 'insert-javadoc
   "\C-p\C-e\C-m/**\C-m*\C-i\C-m*\C-i/\C-p\C-i ")
(global-set-key (kbd "C-x j") 'insert-javadoc)

(fset 'open-init-file
   "\C-x\C-f!\C-?~/.emacs.d/init.el\C-m\C-[>")

(fset 'comment-html-line
   "\C-[m<!--\C-e-->")
(global-set-key (kbd "C-c h") 'comment-html-line)

;;;;;;
;; Jess Mode
;;;;;;
(add-to-list 'load-path "~/.emacs.d/jess-mode-1.2/")
(autoload 'jess-mode "jess-mode" "Jess Editing Mode" t nil)
(autoload 'run-jess "inf-jess" "Inferior Jess Mode" t nil)
(add-hook 'jess-mode-hook
          #'(lambda ()
              (auto-fill-mode t)
              (turn-on-font-lock)))
;;(setq auto-mode-alist
;;      (append auto-mode-alist '(("\\.clp$" . jess-mode))))
(add-to-list 'auto-mode-alist '("\\.clp\\'" . jess-mode))
(add-to-list 'auto-mode-alist '("\\.wme$" . jess-mode))
(add-to-list 'auto-mode-alist '("\\.pr$" . jess-mode))
