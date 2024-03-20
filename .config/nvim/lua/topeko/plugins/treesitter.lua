return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "windwp/nvim-ts-autotag"
    },
    build = ":TSUpdate",
    config = function()
        local treesitter = require('nvim-treesitter.configs')
        local treesitter_context = require('treesitter-context')

        treesitter.setup {
            ensure_installed = {
                "javascript", "typescript", "css", "html", "json", "svelte", "yaml", "java", "python", "bash", "c", "lua", "vim", "vimdoc", "query"
            },

            sync_install = false,

            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },

            autotag = {
                enable = true
            }
        }

        treesitter_context.setup {
            enable = true,
            line_numbers = true
        }
    end
}

