return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local colors = {
            bg       = '#1F1F26',
            fg       = '#F1FFFE',
            yellow   = '#ECBE7B',
            cyan     = '#008080',
            darkblue = '#081633',
            green    = '#98be65',
            orange   = '#FF8800',
            violet   = '#a9a1e1',
            magenta  = '#c678dd',
            blue     = '#51afef',
            red      = '#F38BA8',
        }
        require('lualine').setup({
            options = {
                theme = {
                    normal = {
                        a = { fg = colors.fg, bg = colors.bg },
                        b = { fg = colors.fg, bg = colors.red },
                        c = { fg = colors.fg, bg = colors.bg }
                    },
                    inactive = {
                        a = { fg = colors.fg, bg = colors.bg },
                        b = { fg = colors.fg, bg = colors.bg },
                        c = { fg = colors.fg, bg = colors.bg }
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
