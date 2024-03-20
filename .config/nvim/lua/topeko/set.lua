vim.opt.updatetime = 300

vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 5

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"
vim.api.nvim_set_hl(0, 'SignColumn', { clear })

vim.opt.cursorline = true

vim.opt.hlsearch = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"
