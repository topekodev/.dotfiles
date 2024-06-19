return {
    "catppuccin/nvim", name = "catppuccin",
    lazy = true,
    config = function ()
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = true,
            no_italic = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                treesitter = true,
                treesitter_context = true,
                mason = true,
                telescope = {
                    enabled = true
                }
                -- For more plugins integrations (https://github.com/catppuccin/nvim#integrations)
            },
            color_overrides = {
                mocha = {
                    base = "#121012",
                    text = "#F1FFFE",
                    mantle = "#1F1F26",
                    surface0 = "#1F1F26",
                    surface2 = "#2F313A"
                }
            },
            highlight_overrides = {
                mocha = function(mocha)
                    return {
                        Visual = { bg = mocha.surface2 },
                        CursorLine = { bg = mocha.surface0 },
                        CursorLineNr = { fg = mocha.subtext0 },
                        TeleScopeSelection = { bg = mocha.surface2 },
                        TelescopeSelectionCaret = { bg = mocha.surface2 },
                        TabLine = { bg = mocha.base, fg = mocha.subtext0 },
                        TabLineFill = { bg = mocha.base, fg = mocha.subtext0 },
                        TabLineSel = { bg = mocha.red, fg = mocha.base },
                    }
                end
            }
        })
    end
}
