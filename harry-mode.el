;;; harry-mode.el --- A custom major mode for Harry -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Harry

;; Author: Harry
;; Version: 1.0
;; Keywords: harry mode

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A custom major mode for Harry's needs.

;; 加载harry-mode
;; (load-file "~/.emacs.d/harry-mode.el")
;; (setq-default major-mode 'harry-mode)

;;; Code:

(defgroup harry-mode nil
  "A custom major mode for Harry."
  :group 'languages)

(defcustom harry-mode-tab-width 4
  "Default tab width for harry-mode."
  :type 'integer
  :group 'harry-mode)

;; 定义关键字列表
(defvar harry-mode-keywords
  '(
    ;; 数据类型
    "int" "float" "double" "char" "string" "bool" "void"
    "var" "let" "const" "mut" "static" "dynamic" "auto"
    "uint" "int8" "int16" "int32" "int64" "uint8" "uint16" "uint32" "uint64"
    "byte" "short" "long" "unsigned" "signed"
    
    ;; 控制流关键字
    "if" "else" "elif" "switch" "case" "default"
    "for" "while" "do" "break" "continue" "return"
    "try" "catch" "finally" "throw" "throws"
    
    ;; 函数和类相关
    "function" "def" "class" "struct" "interface" "enum"
    "public" "private" "protected" "internal" "export"
    "import" "package" "module" "namespace" "using"
    
    ;; 其他常用关键字
    "new" "delete" "this" "super" "self" "null" "undefined"
    "true" "false" "nil" "none" "void" "async" "await"
    "yield" "defer" "go" "chan" "select" "type" "interface"
    ))

;; 定义语法高亮
(defvar harry-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; 添加注释语法
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?\n "> b" table)
    table))

;; 定义字体锁定关键字
(defvar harry-mode-font-lock-keywords
  `(
    ;; 关键字高亮
    (,(regexp-opt harry-mode-keywords 'words) . font-lock-keyword-face)
    ;; 字符串高亮
    ("\".*?\"" . font-lock-string-face)
    ;; 数字高亮
    ("\\b[0-9]+\\b" . font-lock-constant-face)
    ;; 函数名高亮
    ("\\b\\([a-zA-Z_][a-zA-Z0-9_]*\\)\\s-*(" 1 font-lock-function-name-face)
    ;; 类型名高亮
    (,(regexp-opt '("int" "float" "double" "char" "string" "bool" "void"
                    "uint" "int8" "int16" "int32" "int64"
                    "uint8" "uint16" "uint32" "uint64"
                    "byte" "short" "long") 'words)
     . font-lock-type-face)
    ;; 常量高亮
    ("\\b[A-Z_][A-Z0-9_]*\\b" . font-lock-constant-face)
    ))

;; 定义缩进函数
(defun harry-mode-indent-line ()
  "Indent current line in harry-mode."
  (interactive)
  (let ((indent-col (harry-mode-calculate-indent)))
    (when indent-col
      (indent-line-to indent-col))))

(defun harry-mode-calculate-indent ()
  "Calculate the indentation for the current line."
  (save-excursion
    (back-to-indentation)
    (let ((indent 0)
          (prev-line-indent 0))
      ;; 获取上一行的缩进
      (forward-line -1)
      (back-to-indentation)
      (setq prev-line-indent (current-column))
      
      ;; 检查当前行和上一行的内容
      (forward-line 1)
      (back-to-indentation)
      
      (cond
       ;; 如果当前行以 } 开头，减少缩进
       ((looking-at "}")
        (setq indent (- prev-line-indent harry-mode-tab-width)))
       
       ;; 如果上一行以 { 结尾，增加缩进
       ((save-excursion
          (forward-line -1)
          (end-of-line)
          (backward-char)
          (looking-at "{"))
        (setq indent (+ prev-line-indent harry-mode-tab-width)))
       
       ;; 其他情况保持与上一行相同的缩进
       (t
        (setq indent prev-line-indent)))
      
      (max 0 indent))))

;; 定义主模式
(define-derived-mode harry-mode text-mode "Harry"
  "A custom major mode for Harry."
  :syntax-table harry-mode-syntax-table
  (setq-local tab-width harry-mode-tab-width)
  (setq-local indent-tabs-mode nil)
  (setq-local indent-line-function 'harry-mode-indent-line)
  (setq-local font-lock-defaults '(harry-mode-font-lock-keywords))
  (display-line-numbers-mode 1)
  
  ;; 绑定Tab键到缩进函数
  (local-set-key (kbd "TAB") 'harry-mode-indent-line)
  
  ;; 启用自动缩进
  (setq-local electric-indent-mode t)
  (setq-local electric-indent-chars '(?\n ?{ ?} ?: ?;)))

;; 设置默认缩进
(add-hook 'harry-mode-hook
          (lambda ()
            (setq-local tab-width harry-mode-tab-width)
            (setq-local indent-tabs-mode nil)
            ;; 启用自动缩进
            (electric-indent-local-mode 1)))

(provide 'harry-mode)

;;; harry-mode.el ends here 