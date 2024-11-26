return {
    'nvim-tree/nvim-web-devicons',
    dependencies = {
    },
    config = function()
        require('nvim-web-devicons').setup({
            color_icons = true;
            override = {
                -- tweaks
                zip = {
                    icon = "",
                    color = "#eca517",
                    name = "Zip"
                },
                sevenzip = {
                    icon = "",
                    color = "#eca517",
                    name = "7z"
                },
                rar = {
                    icon = "",
                    color = "#eca517",
                    name = "Rar"
                },
                flac = {
                    icon = "",
                    color = "#00afff",
                    name = "FreeLosslessAudioCodec"
                },
                -- fixes
                json = {
                    icon = "",
                    color = "#dddddd",
                    name = "Json"
                },
                json5 = {
                    icon = "",
                    color = "#dddddd",
                    name = "Json5"
                },
                jsonc = {
                    icon = "",
                    color = "#dddddd",
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
                mp4 = {
                    icon = "",
                    color = "#fd971f",
                    name = "Mp4"
                },
                m4v = {
                    icon = "",
                    color = "#fd971f",
                    name = "M4V"
                },
                mov = {
                    icon = "",
                    color = "#fd971f",
                    name = "MOV"
                },
                mkv = {
                    icon = "",
                    color = "#fd971f",
                    name = "Mkv"
                },
                webm = {
                    icon = "",
                    color = "#fd971f",
                    name = "Webm"
                },
            };
        })
    end
}
