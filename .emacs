(require 'package) ; only once in init.el
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize) ; only once in init.el

(setq initial-scratch-message nil)
(setq inhibit-startup-message t)  
(delete-selection-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)
(set-default 'truncate-lines t)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(add-to-list 'load-path "/home/alexc/.emacs.d/desktops")
(require 'desktop+)
(desktop-save-mode 1)

(require 'psvn)

(load "/home/alexc/.emacs.d/elpa/ess-17.11/ess-site.el")

(global-set-key (kbd "<f5>") (lambda () (interactive) (shell-command "~/medidore1/tools/output/mb1-set-firmware")))

;; (require 'color-theme)                                                                      
;; (color-theme-initialize)

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(global-set-key [M-right] 'other-window)
(global-set-key [M-left] 'other-window)
(global-set-key [M-S-right] 'next-multiframe-window)
(global-set-key [M-S-left] 'next-multiframe-window)

;; autoload configuration
;; (Not required if you have installed Wanderlust as XEmacs package)
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; Directory where icons are placed.
;; Default: the peculiar value to the running version of Emacs.
;; (Not required if the default value points properly)
(setq wl-icon-directory "~/work/wl/etc")

;; SMTP server for mail posting. Default: nil
(setq wl-smtp-posting-server "smtp.iusa.com.mx")
;; NNTP server for news posting. Default: nil
(setq wl-nntp-posting-server "nntp.iusa.com.mx")


(helm-mode 1)
;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(global-set-key (kbd "C-x C-S-f") 'helm-find)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-f") 'helm-occur)
(setq helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)
(setq helm-apropos-fuzzy-match t)
(setq helm-split-window-default-side 'right)
(setq helm-gtags-fuzzy-match t)

;; Indentation
(setq-default indent-tabs-mode nil)
(setq c-default-style "bsd")
(setq tab-width 4) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(add-hook 'tcl-mode-hook 'helm-gtags-mode)
(setq helm-gtags-auto-update t)
(setq helm-gtags-ignore-case t)
(setq helm-gtags-path-style (quote root))

;; key bindings
(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
  (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack))

(ac-config-default)

;; CC-mode
(add-hook 'c-mode-hook '(lambda ()
			  (local-set-key (kbd "RET") 'newline-and-indent)
			  ;; (linum-mode t)
                          (setq comment-start "//"
                                comment-end   "")))

(setq compilation-read-command t)
(global-set-key (kbd "<f7>") 'recompile)
(global-set-key [M-down] 'next-buffer)
(global-set-key [M-up] 'previous-buffer)

;;----------------------------------------------------------
;; ---- BEGIN Email client ----
;;----------------------------------------------------------
;; (add-to-list 'load-path "~/.emacs.d/dotEmacs/mu4e")
(require 'mu4e)

;; default
(setq mu4e-maildir "~/mail/IUSA")
(setq mu4e-drafts-folder "/[IUSA].Drafts")
(setq mu4e-sent-folder   "/[IUSA].Sent Mail")
(setq mu4e-trash-folder  "/[IUSA].Trash")

;; don't save message to Sent Messages, IUSA/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/[IUSA].Sent Mail"   . ?s)
         ("/[IUSA].Trash"       . ?t)
         ("/[IUSA].All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
(setq
 user-mail-address "acdelatorre@iusa.com.mx"
 user-full-name  "AlexC"
 message-signature
 (concat
  "AlexC\n"
  "Email: acdelatorre@iusa.com.mx\n"
  "\n"))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
;; (setq message-send-mail-function 'smtpmail-send-it
;;       starttls-use-gnutls t
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials
;;       '(("smtp.gmail.com" 587 "renws1990@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)

;; alternatively, for emacs-24 you can use:
(setq message-send-mail-function 'smtpmail-send-it
    smtpmail-stream-type 'starttls
    smtpmail-default-smtp-server "smtp.iusa.com.mx"
    smtpmail-smtp-server "smtp.iusa.com.mx"
    smtpmail-smtp-service 587)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)



;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; For HTML mails
(setq
 w3m-command "/usr/local/bn/w3m"
 mu4e-html2text-command "w3m -dump -T text/html"
 mu4e-view-show-images t
 mu4e-image-max-width 800
 mu4e-view-prefer-html t
 mu4e-use-fancy-chars t)

(require 'helm-mu)
(setq helm-mu-default-search-string "(maildir:/INBOX OR maildir:/Sent)")
(define-key mu4e-main-mode-map "s" 'helm-mu)
(define-key mu4e-headers-mode-map "s" 'helm-mu)
(define-key mu4e-view-mode-map "s" 'helm-mu)

;; Choose the style you prefer for desktop notifications
;; If you are on Linux you can use
;; 1. notifications - Emacs lisp implementation of the Desktop Notifications API
;; 2. libnotify     - Notifications using the `notify-send' program, requires `notify-send' to be in PATH
;;
;; On Mac OSX you can set style to
;; 1. notifier      - Notifications using the `terminal-notifier' program, requires `terminal-notifier' to be in PATH
;; 1. growl         - Notifications using the `growl' program, requires `growlnotify' to be in PATH
(mu4e-alert-set-default-style 'libnotify)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)
(setq mu4e-alert-email-notification-types '(count))

;;----------------------------------------------------------
;; ---- END Email client ----
;;----------------------------------------------------------


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(c-offsets-alist (quote ((case-label . +))))
 '(cloc-executable-location "/usr/bin/cloc")
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("8343be3a733414342075a9a42c6fa1ee9f64c2af179e5fec68febba34f05bd06" default)))
 '(dired-dwim-target t)
 '(dired-listing-switches "-aBhl --group-directories-first")
 '(helm-ag-use-grep-ignore-list t)
 '(helm-follow-mode-persistent t)
 '(helm-gtags-use-input-at-cursor t)
 '(hexl-bits 32)
 '(markdown-command "pandoc -f markdown_github")
 '(mediawiki-site-alist
   (quote
    (("Iusa Wiki" "https://172.16.208.28/mediawiki" "Acdelatorre" "" nil "Página principal"))))
 '(package-selected-packages
   (quote
    (mu4e-alert helm-mu emr dired-k elscreen magit ztree 0blayout pdf-tools cloc csv-mode csv php-mode green-screen-theme dired-rsync dired-single desktop+ helm-codesearch helm-ag ag xclip adoc-mode phi-search-mc markdown-mode pandoc-mode mediawiki notmuch yasnippet-snippets yasnippet-classic-snippets multiple-cursors helm-gtags helm-cscope helm-c-yasnippet fuzzy ess babel auto-complete)))
 '(reb-re-syntax (quote string))
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(tab-width 4)
 '(xclip-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
