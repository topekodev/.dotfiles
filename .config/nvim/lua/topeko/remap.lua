vim.g.mapleader = " "

-- Netrw
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
-- using yazi instead

-- Create file
vim.keymap.set('n', '<leader>c', function()
    local file = vim.fn.input("Enter filename or path: ")
    if (file ~= "") then
        vim.cmd(':e ' .. file)
    else
        vim.cmd(':echo "Aborted"')
    end
end)

-- Alternate file
vim.keymap.set("n", "<leader>s", function()
    vim.cmd(":e#")
end)

-- Buffers
vim.keymap.set("n", "<leader>n", vim.cmd.bnext)
vim.keymap.set("n", "<leader>p", vim.cmd.bprev)
vim.keymap.set("n", "<leader>db", vim.cmd.bdelete)
vim.keymap.set("n", "<leader>Db", ":bdelete!<CR>")

-- Diagnostics
vim.keymap.set("n", "<leader>ll", function()
    vim.cmd(':lua vim.diagnostic.setqflist()')
end)

-- Tabs
-- vim.keymap.set("n", "<leader>t", vim.cmd.Texplore)
vim.keymap.set("n", "<leader>t", vim.cmd.tabe)
vim.keymap.set("n", "<leader>dt", vim.cmd.tabc)
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        vim.cmd("tabn " .. i)
    end)
end

-- tmux-sessionizer
vim.keymap.set("n", "<C-f>", ":silent !tmux neww ~/.scripts/tmux-sessionizer.sh<CR>")
