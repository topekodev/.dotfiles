return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    opts = {},
    config = function()
        require('render-markdown').setup({
            file_types = { "markdown", "codecompanion" },
            heading = {
                icons = { '# ', '## ', '### ', '#### ', '##### ', '###### ' },
                position = 'inline',
            },
            checkbox = {
                enabled = true,
                render_modes = false,
                position = 'inline',
                unchecked = {
                    icon = '󰄱 ',
                    highlight = 'RenderMarkdownUnchecked',
                    scope_highlight = nil,
                },
                checked = {
                    icon = '󰱒 ',
                    highlight = 'RenderMarkdownChecked',
                    scope_highlight = nil,
                },
                custom = {
                    todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
                },
            }
        })
    end
}
