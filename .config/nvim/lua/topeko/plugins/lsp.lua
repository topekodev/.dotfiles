return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true }
    },
    config = function()
        local lspconfig = require("lspconfig")

        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local opts = { noremap = true, silent = true}
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true
                        }
                    }
                }
            }
        })

        local signs = {
            Error = "🚫",
            Warn = "⚠️",
            Hint = "💡",
            Info = "ℹ️"
        }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        lspconfig["tsserver"].setup({
            capabilities = capabilities,
            on_attach = on_attach
        })

        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach
        })

        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach
        })

        lspconfig["pyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach
        })

        lspconfig["svelte"].setup({
            capabilities = capabilities,
            on_attach = on_attach
        })
    end
}
