return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim"
    },
    config = function()
        local mason = require("mason")

        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({ PATH = "append" })

        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "bashls",
                "ts_ls",
                "html",
                "htmx",
                "cssls",
                "pyright",
                "svelte",
                "rust_analyzer",
                "gopls",
            },
            automatic_installation = true
        })
    end
}
