" 1. 开启行号
set number

" 2. 设置字体（仅对 GUI 版 Neovim 生效，如 nvim-qt）

set guifont=JetBrains\ Mono:h14


" 3. 缩进设置（Tab 为 4 个空格）
set tabstop=4     " Tab 显示为 4 个空格宽度
set shiftwidth=4  " 自动缩进时使用 4 个空格
set expandtab     " 将 Tab 转换为空格

" 4. 开启代码高亮
syntax on

" 5. 开启代码折叠（基于语法）
set foldmethod=syntax
set foldlevel=99  " 默认不折叠

colorscheme desert
