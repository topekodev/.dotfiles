vim.g.mapleader = " "

-- Netrw
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Buffers
vim.keymap.set("n", "<leader>n", vim.cmd.bnext)
vim.keymap.set("n", "<leader>N", vim.cmd.bprev)
vim.keymap.set("n", "<leader>db", vim.cmd.bdelete)

-- Tabs
vim.keymap.set("n", "<leader>t", vim.cmd.tabe)
vim.keymap.set("n", "<leader>dt", vim.cmd.tabc)
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        vim.cmd("tabn " .. i)
    end)
end
