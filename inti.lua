-- 基本设置
vim.opt.number = true          -- 显示行号
vim.opt.tabstop = 4            -- Tab 宽度为 4 个空格
vim.opt.shiftwidth = 4         -- 缩进宽度为 4 个空格
vim.opt.expandtab = true       -- Tab 转换为空格
vim.opt.smartindent = true     -- 智能缩进
vim.opt.syntax = "on"          -- 开启语法高亮
vim.opt.termguicolors = true   -- 启用真彩色支持
vim.opt.cursorline = true      -- 高亮当前行
vim.opt.showmatch = true       -- 高亮匹配的括号
vim.opt.encoding = "utf-8"     -- 设置编码为 UTF-8

-- 搜索设置
vim.opt.ignorecase = true      -- 搜索忽略大小写
vim.opt.smartcase = true       -- 智能大小写搜索

-- 其他实用设置
vim.opt.wrap = false           -- 禁用自动换行
vim.opt.mouse = "a"            -- 启用鼠标支持
vim.opt.clipboard = "unnamedplus" -- 使用系统剪贴板