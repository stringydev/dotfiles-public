vim.g.mapleader = " "
vim.opt.encoding = "utf-8"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.title = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.scrolloff = 8

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false

-- vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true

vim.opt.termguicolors = true

vim.opt.backspace = "indent,eol,start"

vim.opt.clipboard:append("unnamedplus")

vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.mouse = ""

vim.opt.shell = "fish"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
