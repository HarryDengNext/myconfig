(global-set-key "\C-h" 'backward-delete-char-untabify)
;(global-set-key "\d" 'delete-char)
(setq inhibit-splash-screen t)
;;(global-display-line-number-mode t)
(tool-bar-mode 0)
(setq initial-frame-alist
      (append initial-frame-alist
              '((width  . 85)
                (height . 35))))
(set-frame-font "Jetbrains Mono 15" nil t)
;;(setq-default indent-tabs-mode nil)
;;(setq-default tab-width 4)
;;(setq-default standard-indent 4)
(add-hook 'c-mode-hook
          (lambda ()
            (setq c-basic-offset 4)       ; 缩进 4 个空格
            (setq indent-tabs-mode nil))) ; 使用空格

(add-hook 'c++-mode-hook
          (lambda ()
            (setq c-basic-offset 4)       ; 缩进 4 个空格
            (setq indent-tabs-mode nil)))

;; 确保 Backspace 向后删除（默认行为）
(global-set-key (kbd "<backspace>") 'delete-backward-char)

;; 设置 TAB 缩进为 4 个空格，仅在 Fundamental Mode 中
(defun insert-four-spaces ()
  "Insert four spaces"
  (interactive)
  (insert "    ")

  )

;; 启用系统剪贴板交互
(setq select-enable-clipboard t)
(setq select-enable-primary t) ; （可选）使用 X primary selection（Linux 特定）
(global-font-lock-mode t)
(global-hl-line-mode t)
(show-paren-mode t)
;;(setq indent-line-function 'insert-four-spaces)
;;(global-set-key (kbd "TAB") 'insert-four-spaces)

(define-derived-mode my-mode text-mode "MyMode"
  "A custion mode"
  (setq-local tab-width 4)
  (setq-local indent-tabs-mode nil)
  (setq-local indent-line-function 'insert-four-spaces)
  (display-line-numbers-mode 1)
  (local-set-key (kdb "TAB") 'insert-four-spaces)
  )
(setq-default major-mode 'my-mode)

(add-hook 'fundamental-mode-hook
          (lambda ()
            (setq tab-width 2)           ; 缩进宽度为 4
            (setq indent-tabs-mode nil)  ; 使用空格
			(electric-indent-local-mode -1)
;;			(setq-local indent-line-function 'insert-four-spaces)
			))


(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(setq flycheck-go-vet-enabled t)
;; 设置回车缩进
;;(add-hook 'fundamental-mode-hook
;;          (lambda ()
;;(local-set-key (kbd "RET") 'newline-and-indent)))



(global-display-line-numbers-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(dracula))
 '(custom-safe-themes
   '("603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961"
     default))
 '(package-selected-packages '(dracula-theme flycheck go-mode rust-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
