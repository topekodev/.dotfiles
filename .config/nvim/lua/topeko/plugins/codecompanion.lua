return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function ()
        local companion = require("codecompanion")
        local companion_adapters = require("codecompanion.adapters")
        companion.setup({
            adapters = {
                gemini = function ()
                    return companion_adapters.extend("gemini", {
                        --GEMINI_API_KEY
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = "gemini",
                    keymaps = {
                        send = {
                            modes = { n = "<CR>" },
                        },
                        close = {
                            modes = { n = "<C-c>", i = "<C-c>" },
                        },
                    },
                },
                inline = {
                    adapter = "gemini",
                    keymaps = {
                        accept_change = {
                            modes = { n = "<C-a>" },
                        },
                        reject_change = {
                            modes = { n = "<C-c>" },
                        },
                    },
                },
            },
            display = {
                chat = {
                    intro_message = "CodeCompanion ✨ Press ? for options",
                    show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
                    separator = "─", -- The separator between the different messages in the chat buffer
                    show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
                    show_settings = true, -- Show LLM settings at the top of the chat buffer?
                    show_token_count = true, -- Show the token count for each response?
                    start_in_insert_mode = false, -- Open the chat buffer in insert mode?
                    debug_window = {
                    },
                    window = {
                        layout = "vertical", -- float|vertical|horizontal|buffer
                        position = "right", -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
                        border = "single",
                        height = 0.8,
                        width = 0.35,
                        relative = "editor",
                        opts = {
                            breakindent = true,
                            cursorcolumn = false,
                            cursorline = true,
                            foldcolumn = "0",
                            linebreak = true,
                            list = false,
                            numberwidth = 1,
                            signcolumn = "no",
                            spell = false,
                            wrap = true,
                        },
                    },
                },
                action_palette = {
                    prompt = "Prompt ", -- Prompt used for interactive LLM calls
                    provider = "telescope", -- default|telescope|mini_pick
                    opts = {
                        show_default_actions = true, -- Show the default actions in the action palette?
                        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
                    },
                },
            },
        })
    end,
    -- Keymaps
    vim.keymap.set({ "n" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true });
    vim.keymap.set({ "v" }, "<leader>a", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true });
    vim.keymap.set({ "n", "v" }, "fa", "<cmd>CodeCompanion<cr>", { noremap = true, silent = true });
}
