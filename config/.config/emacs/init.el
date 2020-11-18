;; Straight package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; packages
; shallow clones not working properly right now
; (setq straight-vc-git-default-clone-depth 1)
; org mode
(straight-use-package 'org-bullets)
; evil-mode
(straight-use-package 'evil)
(straight-use-package 'evil-snipe)
(straight-use-package 'evil-numbers)
(straight-use-package 'evil-magit)
(straight-use-package 'evil-leader)
(straight-use-package 'evil-surround)
(straight-use-package 'evil-nerd-commenter)
(straight-use-package 'evil-org)
; functionality
(straight-use-package 'helm)
(straight-use-package 'helm-projectile)
(straight-use-package 'magit)
(straight-use-package 'projectile)
(straight-use-package 'avy)
; gui
(straight-use-package 'dashboard)
(straight-use-package 'which-key)
(straight-use-package 'all-the-icons)
(straight-use-package 'page-break-lines)
(straight-use-package 'telephone-line)
(straight-use-package 'doom-themes)
; programming
;; (straight-use-package 'flycheck)
(straight-use-package 'lsp-mode)
(straight-use-package 'company)
(straight-use-package 'yasnippet)
(straight-use-package 'yasnippet-snippets)
(straight-use-package 'cmake-mode)
(require 'cmake-mode)
;; documents
(straight-use-package 'pdf-tools)
(straight-use-package 'auctex)

;; hide GUI
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; scroll off
(setq scroll-margin 7)
(setq scroll-conservatively 999) ;; do not center when scrolling

;; disable bell
(setq ring-bell-function 'ignore)

;; Line numbering
(add-hook 'prog-mode-hook 'display-line-numbers-mode)	; only show numbers in programming buffers
(setq display-line-numbers-type 'relative)		; relative line numbers

;; font size
(set-face-attribute 'default nil :family "IBM Plex Mono" :height 130)

;; Line highlighting
(global-hl-line-mode 1)

;; Show matching parenthesis
(show-paren-mode 1)

;; backup files to another folder
(setq backup-directory-alist `(("." . "~/.saves")))
;; org mode
(setq org-directory "~/.org") ; main org directory
(setq org-agenda-files
      '("~/.org/tasks.org" "~/.org/birthdays.org"
	"~/.org/reminders.org" "~/.org/university.org"))  ; org agenda tasks files

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; evil mode
(setq evil-want-C-u-scroll t)   ; use C-u to scroll up in normal mode
(require 'evil)
(require 'evil-numbers)
(define-key evil-normal-state-map (kbd "+") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "-") 'evil-numbers/dec-at-pt)
(require 'evil-magit)
(require 'evil-nerd-commenter)
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)
(require 'evil-surround)
(global-evil-leader-mode)
(global-evil-surround-mode 1)
(evil-mode 1)
(evil-snipe-mode 1)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "\\" 'evilnc-comment-operator ; if you prefer backslash key
)

;; Company
(require 'company)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))
(add-hook 'after-init-hook 'global-company-mode)
(define-key global-map (kbd "C-.") 'company-files)

;; Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; LSP
(setq gc-cons-threshold 100000000) ; needed because communication generates a lot of garbage
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-keymap-prefix "C-c l")
(require 'lsp-mode)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'python-mode-hook #'lsp)

;; helm mode
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list) ;; List buffers ( Emacs way )
(global-set-key (kbd "C-x r b") 'helm-bookmarks) ;; Bookmarks menu
(global-set-key (kbd "C-x C-f") 'helm-find-files) ;; Finding files with Helm
(global-set-key (kbd "M-c") 'helm-calcul-expression) ;; Use Helm for calculations
(global-set-key (kbd "C-s") 'helm-occur)  ;; Replaces the default isearch keybinding
(global-set-key (kbd "C-h a") 'helm-apropos)  ;; Helmized apropos interface
(global-set-key (kbd "M-y") 'helm-show-kill-ring)  ;; Show kill ring, pick something to pastelm-mode 1)
(require 'helm-projectile)
(helm-projectile-on)

;; projectile
(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; which key
(require 'which-key)
(which-key-mode 1)

;; dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-init-info t)
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

;; avy
(avy-setup-default)
(global-set-key (kbd "C-c C-j") 'avy-resume)
(global-set-key (kbd "C-;")  'avy-goto-char-2)  ;; I use this most frequently

;; modeline
;; for telephone-line configuration needs to be before (telephhone-line-mode 1)
(require 'telephone-line)
(setq telephone-line-primary-left-separator 'telephone-line-cubed-left
      telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
      telephone-line-primary-right-separator 'telephone-line-cubed-right
      telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)
(setq telephone-line-height 24)
(setq telephone-line-lhs
      '((evil   . (telephone-line-evil-tag-segment))
        (accent . (telephone-line-vc-segment
                   telephone-line-erc-modified-channels-segment
                   telephone-line-process-segment))
        (nil    . (telephone-line-minor-mode-segment
                   telephone-line-buffer-segment))))
(setq telephone-line-rhs
      '((nil    . (telephone-line-misc-info-segment))
        (accent . (telephone-line-major-mode-segment))
        (evil   . (telephone-line-airline-position-segment))))
(telephone-line-mode 1)

;; doom themes
(load-theme 'doom-gruvbox t)

;; pdf tools
(pdf-tools-install)
(evil-set-initial-state 'pdf-view-mode 'normal)

;; auctex
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)
