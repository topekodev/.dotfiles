return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local colors = {
            base     = '#121012',
            surface0 = '#1F1F26',
            surface2 = '#2F313A',
            text     = '#F1FFFE',
            subtext0 = '#B7BCD0',
            highlight= '#F38BA8',
        }
        require('lualine').setup({
            options = {
                theme = {
                    normal = {
                        a = { bg = colors.base, fg = colors.text },
                        b = { bg = colors.surface0, fg = colors.text },
                        c = { bg = colors.base, fg = colors.text },
                        x = { bg = colors.base, fg = colors.text },
                        y = { bg = colors.base, fg = colors.text },
                        z = { bg = colors.base, fg = colors.text }
                    },
                    inactive = {
                        a = { bg = colors.base, fg = colors.subtext0 },
                        b = { bg = colors.base, fg = colors.subtext0 },
                        c = { bg = colors.base, fg = colors.subtext0 },
                        x = { bg = colors.base, fg = colors.subtext0 },
                        y = { bg = colors.base, fg = colors.subtext0 },
                        z = { bg = colors.base, fg = colors.subtext0 }
                    },
                },
                icons_enabled = false,
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''}
            },
            sections = {
                lualine_a = {
                    'mode',
                },
                lualine_b = {
                    'buffers'
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    'prgress'
                },
                lualine_z = {
                    'location'
                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
        })
    end
}
