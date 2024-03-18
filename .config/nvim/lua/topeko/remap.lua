vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>,", vim.cmd.bprev)
vim.keymap.set("n", "<leader>.", vim.cmd.bnext)
vim.keymap.set("n", "<leader>-", vim.cmd.bdelete)
vim.keymap.set("n", "<leader>l", function()
    vim.cmd("Telescope buffers")
end)
