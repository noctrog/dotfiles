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
(straight-use-package 'org-superstar)
(straight-use-package 'org-ref)
(straight-use-package 'org-roam)
(straight-use-package 'org-roam-server)
(straight-use-package 'org-attach-screenshot)
; evil-mode
(straight-use-package 'evil)
(straight-use-package 'evil-collection)
(straight-use-package 'evil-snipe)
(straight-use-package 'evil-numbers)
(straight-use-package 'evil-leader)
(straight-use-package 'evil-surround)
(straight-use-package 'evil-nerd-commenter)
(straight-use-package 'evil-org)
; functionality
(straight-use-package 'helm)
(straight-use-package 'helm-projectile)
(straight-use-package 'helm-bibtex)
(straight-use-package 'magit)
(straight-use-package 'projectile)
(straight-use-package 'general)
(straight-use-package 'avy)
(straight-use-package 'company)
(straight-use-package 'prescient)
(straight-use-package 'company-prescient)
(straight-use-package 'undo-tree)
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
(straight-use-package 'lsp-ui)
(straight-use-package 'lsp-python-ms)
(straight-use-package 'yasnippet)
(straight-use-package 'yasnippet-snippets)
(straight-use-package 'cmake-mode)
(require 'cmake-mode)
(straight-use-package 'yaml-mode)
(straight-use-package 'origami)
(require 'origami)
;; languages
(straight-use-package 'rust-mode)
(require 'rust-mode)
;; documents
(straight-use-package 'pdf-tools)
(straight-use-package 'auctex)
(straight-use-package 'cdlatex)

;; Increases Garbage Collection During Startup
(setq startup/gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)
(defun startup/reset-gc () (setq gc-cons-threshold startup/gc-cons-threshold))
(add-hook 'emacs-startup-hook 'startup/reset-gc)

;; hide GUI
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; hide scroll bar in new frames
(defun my/disable-scroll-bars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))
(add-hook 'after-make-frame-functions 'my/disable-scroll-bars)

;; scroll off
(setq scroll-margin 7)
(setq scroll-conservatively 999) ;; do not center when scrolling

;; disable truncate lines
(set-default 'truncate-lines 0)

;; disable bell
(setq ring-bell-function 'ignore)

;; Line numbering
(add-hook 'prog-mode-hook 'display-line-numbers-mode)	; only show numbers in programming buffers
(setq display-line-numbers-type 'relative)		; relative line numbers

;; font size
(set-face-attribute 'default nil :family "Inconsolata" :height 130)

;; Line highlighting
(global-hl-line-mode 1)

;; Show matching parenthesis
(show-paren-mode 1)
;; Auto pair
(electric-pair-mode 1)

;; backup files to another folder
(setq backup-directory-alist `(("." . "~/.saves")))

;; auto revert remote files
(setq auto-revert-remote-files 1)

;; TRAMP
(setq tramp-default-method "ssh") ; use ssh by default

;; helm mode
(helm-mode 1)

;; org mode
(setq org-export-coding-system 'utf-8)
; indent and hard wrapping
(with-eval-after-load 'org
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'auto-fill-mode) ; hard wrap
  (add-hook 'org-mode-hook 'turn-on-org-cdlatex)) 
(setq org-directory "~/Sync/org") ; main org directory
(setq org-agenda-files '("~/Sync/org/agenda")) ; include all in folder as agenda
(setq org-agenda-span 17
      org-agenda-start-on-weekday nil
      org-agenda-start-day "-3d")
(setq org-agenda-category-icon-alist
      '(
	("tasks" ,"" nil nil :ascent center)
	("university" ,"" nil nil :ascent center)
	("birthdays" ,"" nil nil :ascent center)
	("reminders" ,"" nil nil :ascent center)
	("routine" ,"" nil nil :ascent center)
	))
(setq org-agenda-prefix-format '((agenda . "  %i %?-12t% s")
				 (todo . " %-15:c")
				 (tags . " %-15:c")
				 (search . " %-15:c")))
; TODO poner con general.el
(define-key global-map "\C-cc" 'org-capture)
;; configure org capture templates
(setq org-capture-templates
      '(("t"               ; hotkey
	 "Todo list item"  ; name
	 entry             ; type
					; heading type and title
	 (file+headline "~/Sync/org/agenda/tasks.org" "Tasks")
	 "* TODO %?\n %i\n %a") ; template
	("u"               ; hotkey
	 "University todo item"  ; name
	 entry             ; type
	 (file+headline "~/Sync/org/agenda/university.org" "Tasks")
	 "* TODO %?\n %i") ; template
	("r"
	 "Set reminder"
	 entry
	 (file+headline "~/Sync/org/agenda/reminders.org" "Reminders")
	 "* %?\n %i")
	("b"
	 "BibTex reference"
	 plain
	 (file "~/Sync/org/references.bib")
	 "%i\n\n")
	("d"
	 "Personal diary"
	 entry
	 (file+datetree "~/Sync/org/diary.org.gpg")
	 "** %^{Heading}")
      ))
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-superstar-special-todo-items 'hide)
(setq org-superstar-headline-bullets-list
      '("◉" "◈";; Stop cycling bullets to emphasize hierarchy of headlines.
(setq org-superstar-cycle-headline-bullets nil)
;; Hide away leading stars on terminal.
(setq org-superstar-leading-fallback ?\s) "○" "▷"))
(with-eval-after-load 'org-superstar
  (set-face-attribute 'org-superstar-item nil :height 1.0)
  (set-face-attribute 'org-superstar-header-bullet nil :height 1.2)
  (set-face-attribute 'org-superstar-leading nil :height 1.3))
(require 'org-ref)
(require 'org-roam)
(setq org-roam-directory "~/Sync/org/roam")
(setq org-roam-db-location "~/.org/roam.db")
(setq org-roam-encrypt-files t)
(add-hook 'after-init-hook 'org-roam-mode)
(setq org-roam-completion-system 'helm)
(global-set-key (kbd "C-c r b") 'org-roam)
(global-set-key (kbd "C-c r c") 'org-roam-capture)
(global-set-key (kbd "C-c r d") 'org-roam-doctor)
(global-set-key (kbd "C-c r f") 'org-roam-find-file)
(global-set-key (kbd "C-c r g") 'org-roam-graph)
(global-set-key (kbd "C-c r i") 'org-roam-insert)
(global-set-key (kbd "C-c r m") 'org-roam-mode)
(global-set-key (kbd "C-c r r") 'org-roam-find-ref)
(global-set-key (kbd "C-c r t") 'org-roam-buffer-toggle-display)
(require 'org-roam-server)
(setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 7777
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20)
;; bibtex - TODO pdfs
(setq bibtex-completion-bibliography
      '("~/Sync/org/references.bib"))
(setq org-ref-default-bibliography
      '("~/Sync/org/references.bib"))
(setq org-latex-pdf-process
      (list "latexmk -shell-escape -bibtex -f -pdf %f"))
;; disable <> auto pairing in electric-pair-mode for org-mode
(add-hook
 'org-mode-hook
 (lambda ()
   (setq-local electric-pair-inhibit-predicate
               `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))

;; evil mode
(setq evil-want-C-u-scroll t)   ; use C-u to scroll up in normal mode
(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))
(require 'evil-numbers)
(define-key evil-normal-state-map (kbd "+") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "-") 'evil-numbers/dec-at-pt)
; (require 'evil-magit)
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

;; keybinds
(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"
  "'" '(term :which-key "iterm")
  ;; magit
  "m" '(magit :which-key "magit")
  ;; buffers
  "bn" '(evil-next-buffer :which-key "next buffer")
  "bp" '(evil-previous-buffer :which-key "previous buffer")
  "bd" '(evil-delete-buffer :which-key "delete buffer")
  "bb" '(helm-buffers-list :which-key "change buffer")
  ;; windows
  "wj" '(evil-window-down :which-key "window down")
  "wk" '(evil-window-up :which-key "window up")
  "wh" '(evil-window-left :which-key "window left")
  "wl" '(evil-window-right :which-key "window right")
  "ws" '(evil-window-split :which-key "window split")
  "wv" '(evil-window-vsplit :which-key "window vsplit")
  "wd" '(evil-window-delete :which-key "window delete")
  ;; tabs
  "tn" '(tab-new :which-key "tab new")
  "th" '(tab-previous :which-key "tab previous")
  "tl" '(tab-next :which-key "tab next")
  "tc" '(tab-close :which-key "tab close")
  ;; evil-commenter
  "ci" '(evilnc-comment-or-uncomment-lines :which-key "(un)comment line")
  "cl" '(evilnc-quick-comment-or-uncomment-to-the-line :which-key "(un)comment to the line")
  "cc" '(evilnc-copy-and-comment-lines :which-key "copy & comment")
  "cp" '(evilnc-comment-or-uncomment-paragraphs :which-key "(un)comment parahraphs")
  "cr" '(comment-or-uncomment-region :which-key "(un)comment region")
  "cv" '(evilnc-toggle-invert-comment-line-by-line :which-key "invert comment by line")
  "\\" '(evilnc-comment-operator :which-key "comment operator")
  ;; avy
  ";"  '(avy-goto-char-timer :which-key "avy char timer")
  ;; term
  "tt" '(term :which-key "shell")
  ;; folding
  "fo" '(origami-open-node :which-key "open fold")
  "fao" '(origami-open-all-nodes :which-key "open all folds")
  "fO" '(origami-open-node-recursively :which-key "open fold recursively")
  "fc" '(origami-close-node :which-key "open fold")
  "fac" '(origami-close-all-nodes :which-key "open all folds")
  "fC" '(origami-close-node-recursively :which-key "open fold recursively")
  "ft" '(origami-toggle-node :which-key "toggle fold")
  "fT" '(origami-toggle-node :which-key "toggle fold recursively")
  "ff" '(origami-show-only-node :which-key "fold everything except current")
  "fn" '(origami-next-fold :which-key "move to next fold")
  "fp" '(origami-previous-fold :which-key "move to previous fold")
  "fu" '(origami-undo :which-key "undo fold operation")
  "fr" '(origami-redo :which-key "redo fold operation")
  "fR" '(origami-reset :which-key "origami reset")
  ;; ...
)

;; Company
(require 'company)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "<tab>") nil)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))
(add-hook 'after-init-hook 'global-company-mode)
(define-key global-map (kbd "C-.") 'company-files)
(setq company-minimum-prefix-length 1
      company-idle-delay 0.2) ;; default is 0.2

;; Prescient
(require 'prescient)
(require 'company-prescient)
(prescient-persist-mode 1) ; remembering history between sessions
(company-prescient-mode 1)

;; undo-tree
(global-undo-tree-mode)

;; Yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.config/emacs/snippets" yasnippet-snippets-dir))
(yas-global-mode 1)

;; LSP
(setq gc-cons-threshold 100000000) ; needed because communication generates a lot of garbage
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-keymap-prefix "C-c l")
(require 'lsp-mode)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'python-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'lsp)
(setq lsp-enable-snippet t)
(require 'lsp-python-ms)
(setq lsp-python-ms-auto-install-server t)
(setq python-shell-interpreter "python")

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
(setq dashboard-projects-backend 'projectile)
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))
;; avy
(avy-setup-default)

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
        (nil    . (telephone-line-buffer-segment
		   telephone-line-minor-mode-segment))))
(setq telephone-line-rhs
      '((nil    . (telephone-line-misc-info-segment))
        (accent . (telephone-line-major-mode-segment))
        (evil   . (telephone-line-airline-position-segment))))
(telephone-line-mode 1)

;; doom themes
(load-theme 'doom-gruvbox t)

;; pdf tools
(pdf-tools-install)
;; (evil-set-initial-state 'pdf-view-mode 'normal)

;; auctex
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)
; revert the PDF-buffer after the TeX compilation has finished
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;; rosemacs
;; (add-to-list 'load-path "/opt/ros/melodic/share/emacs/site-lisp")
;; (require 'rosemacs-config)
