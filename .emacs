(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;(setq tab-width 6)
;;(setq indent-tabs-mode t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(setq vc-handled-backends ())

(setq next-line-add-newlines t)

(global-set-key (kbd "C-c t") 'backward-char) ; Ctrl+c t ;; (this was for testing)

;; line highlighting
(global-hl-line-mode 1)
(set-face-background 'hl-line "black")
;;(set-face-background 'highlight "red")
(set-face-foreground 'hl-line "white")

(set-face-attribute 'region nil :background "green")


;; this is for jade syntax highlighting
(add-to-list 'load-path "~/git/config/jade-mode")
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl\\'" . sws-mode))
;; ejs syntax highlighting
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . html-mode))

;; some good javascript stuff
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

;; this is for COLORS
;;(add-to-list 'load-path "~/git/config/color-theme-6.6.0")
;;(require 'color-theme)

;; ---------------------------
;; custom-defined key-bindings
;; ---------------------------
;; insert javadoc comment 
(fset 'insert-java-doc
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("b	/**	*		*	/	 " 0 "%d")) arg)))
(global-set-key (kbd "C-x C-j") 'insert-java-doc)
;; continue javadoc comment (TODO - only if inside existing)
(fset 'continue-java-doc
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote (" * " 0 "%d")) arg)))
(global-set-key (kbd "C-x j") 'continue-java-doc)

;; insert function with err arg (TODO - prompt user for args)
(fset 'insert-err-fun
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("function(x, y) {});		" 0 "%d")) arg)))
(global-set-key (kbd "C-c f 2") 'insert-err-fun)
;; insert function with single arg (TODO - prompt user for args)
(fset 'insert-fun-single-arg
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("function(x) {});		" 0 "%d")) arg)))
(global-set-key (kbd "C-c f 1") 'insert-fun-single-arg)


;; insert console.log statement
(fset 'insert-console-log
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("	console.log();" 0 "%d")) arg)))
(global-set-key (kbd "C-c l") 'insert-console-log)

;; open a required js file
(fset 'open-require-js
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("' 'w.js" 0 "%d")) arg)))
(global-set-key (kbd "C-x n r") 'open-require-js)
;; open in other window (only works if same directory)
(fset 'open-require-js-other
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("' 'wo.js" 0 "%d")) arg)))
(global-set-key (kbd "C-x n o") 'open-require-js-other)

(defun set-eclipse-keys (arg)
  (
   (global-set-key (kbd "C-l") 'forward-char)
   (global-set-key (kbd "C-j") 'backward-char)
   (global-set-key (kbd "C-k") 'next-line)
   (global-set-key (kbd "C-i") 'previous-line)
   (global-set-key (kbd "TAB") 'indent-for-tab-command)
   ))

;; copy previous word (good for copying variables that are repeated)
(fset 'copy-previous
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("b fw" 0 "%d")) arg)))
(global-set-key (kbd "C-c p") 'copy-previous)

;; kill backwards
(fset 'kill-to-front
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote (" m	" 0 "%d")) arg)))
(global-set-key (kbd "C-S-k") 'kill-to-front) ;; doesn't work


;; presumbly moves text
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
	(exchange-point-and-mark))
    (let ((column (current-column))
	  (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
	(transpose-lines arg))
      (forward-line -1)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])
(global-set-key [(meta up)] 'move-text-up)
(global-set-key [(meta down)] 'move-text-down)
;; bind ctrl-o and ctrl-m to moving lines (one over from n & p)
;;(global-set-key (kbd "C-S-p") 'move-text-up)
;;(global-set-key (kbd "C-S-m") 'move-text-down)


(add-to-list 'load-path "~/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; backup files
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups
