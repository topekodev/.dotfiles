vim.g.mapleader = " "

-- Netrw
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Buffers
vim.keymap.set("n", "<leader>h", vim.cmd.bprev)
vim.keymap.set("n", "<leader>l", vim.cmd.bnext)
vim.keymap.set("n", "<leader>db", vim.cmd.bdelete)
vim.keymap.set("n", "<leader>pb", function()
    vim.cmd("Telescope buffers")
end)

-- Tabs
vim.keymap.set("n", "<leader>nt", vim.cmd.tabe)
vim.keymap.set("n", "<leader>dt", vim.cmd.tabc)
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        vim.cmd("tabn " .. i)
    end)
end
