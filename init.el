(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(require 'cl)
(defvar richfitz/packages '(dockerfile-mode
			    json-mode
			    markdown-mode
                            org
                            powerline
			    typescript-mode
                            writegood-mode
                            yaml-mode)
  "Default packages")

(defun richfitz/packages-installed-p ()
  (loop for pkg in richfitz/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))
(unless (richfitz/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg richfitz/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(let ((ess-path "~/.emacs.d/site-lisp/ess/lisp"))
  (if (file-directory-p ess-path)
      (progn
	(add-to-list 'load-path ess-path)
	(require 'ess-site))
    (message "%s" "Run ./setup/ess to configure ess")))

(add-hook 'ess-mode-hook
	  (lambda()
	    (ess-toggle-underscore nil)
	    (setq inferior-R-args "--no-restore-history --no-save")
	    (setq ess-indent-with-fancy-comments nil)
	    (setq ess-indent-level 2)))

(defconst richfitz/cc-style
  '("gnu"
    (c-offsets-alist . ((innamespace . [0])))))
(c-add-style "richfitz/cc-style" richfitz/cc-style)
(defun richfitz/cc-mode-hook ()
  (c-set-style "richfitz/cc-style"))
(add-hook 'c-mode-hook 'richfitz/cc-mode-hook)
(add-hook 'c++-mode-hook 'richfitz/cc-mode-hook)

(add-hook 'markdown-mode-hook
          (lambda ()
            (auto-fill-mode -1)
            (whitespace-mode -1)
            (visual-line-mode t)))

;; minimal decorations
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; less on startup
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;; needed to work on a mac as expected
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(global-set-key "\M-h" 'ns-do-hide-emacs)
(global-set-key "\M-m" 'iconify-or-deiconify-frame)

;; indenting
(setq tab-width 2)
(setq indent-tabs-mode nil)

;; less leftover files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; less typing
(defalias 'yes-or-no-p 'y-or-n-p)

;; basic behaviour
(setq echo-keystrokes 0.1)
(setq use-dialog-box nil)
(setq visible-bell t)
(show-paren-mode t)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
(setq require-final-newline t)
(global-auto-revert-mode t)

;; subtle visible bell
(setq visible-bell nil)
(setq ring-bell-function
      (lambda ()
        (let ((orig-fg (face-foreground 'mode-line)))
          (set-face-foreground 'mode-line "#F2804F")
          (run-with-idle-timer 0.1 nil
                               (lambda (fg) (set-face-foreground 'mode-line fg))
                               orig-fg))))

;; ido mode
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t
      ido-everywhere t
      ido-auto-merge-work-directories-length -1)


;; (require 'powerline)
;; (powerline-default-theme)

;; keybindings
(global-set-key [M-f4] 'kill-this-buffer)

(global-set-key "\M-c" 'comment-region)
(global-set-key "\M-C" 'uncomment-region)
(global-set-key "\M-g" 'goto-line)
(global-unset-key "\C-z")

;; (require 'powerline)
;; (powerline-default-theme)
;; (set-face-attribute 'mode-line nil
;;                     :foreground "Black"
;;                     :background "DarkOrange"
;;                     :box nil)

(load "~/.emacs.d/lisp/utils.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango)))
 '(package-selected-packages
   (quote
    (dockerfile-mode smart-mode-line-powerline-theme smart-mode-line powerline writegood-mode yaml-mode "org" markdown-mode)))
 '(sml/mode-width
   (if
       (eq
	(powerline-current-separator)
	(quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (car powerline-default-separator-dir)))
		   (quote powerline-active1)
		   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (cdr powerline-default-separator-dir)))
		   (quote powerline-active1)
		   (quote sml/global))))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (car powerline-default-separator-dir)))
		   (quote sml/global)
		   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (cdr powerline-default-separator-dir)))
		   (quote powerline-active2)
		   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t nil)))
 '(markdown-inline-code-face ((t (:inherit font-lock-constant-face)))))
