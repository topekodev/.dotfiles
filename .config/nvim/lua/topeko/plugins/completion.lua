return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
    },
    config = function()
        local cmp = require("cmp")

        local luasnip = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect"
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = {
                ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<CR>'] = cmp.mapping.confirm({
                    select = false,
                    behavior = cmp.ConfirmBehavior.Replace
                }),
--                ['<C-y>'] = function()
--                    require("copilot.suggestion").accept()
--                end,
                ['<C-e>'] = cmp.mapping.close(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
--                    elseif require("copilot.suggestion").is_visible() then
--                        require("copilot.suggestion").accept()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" })
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip", },
                { name = "buffer" },
                { name = "path" }
            })
        })
    end
}

