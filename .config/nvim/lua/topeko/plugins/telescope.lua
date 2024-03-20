return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = require('telescope.actions').move_selection_next,
                        ["<C-k>"] = require('telescope.actions').move_selection_previous,
                    },
                    n = {
                        ["<j>"] = require('telescope.actions').move_selection_next,
                        ["<k>"] = require('telescope.actions').move_selection_previous,
                    }
                }
            }
        })
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set("n", "<leader>fb", function()
            vim.cmd("Telescope buffers")
        end)
    end
}
