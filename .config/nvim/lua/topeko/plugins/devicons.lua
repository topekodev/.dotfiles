return {
    'nvim-tree/nvim-web-devicons',
    dependencies = {
    },
    config = function()
        require('nvim-web-devicons').setup({
            color_icons = true;
            override = {
                json = {
                    icon = "",
                    name = "Json"
                },
                json5 = {
                    icon = "",
                    name = "Json5"
                },
                jsonc = {
                    icon = "",
                    name = "Jsonc"
                },
                js = {
                    icon = "",
                    color = "#F1F134",
                    name = "Js"
                },
                ts = {
                    icon = "",
                    color = "#519aba",
                    name = "TypeScript"
                },
            };
        })
    end
}
