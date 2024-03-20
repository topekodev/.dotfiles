return {
    'norcalli/nvim-colorizer.lua',
    config = function()
        require('colorizer').setup({
            'css',
            'html',
            'svelte',
        }, {
            mode = 'background',
            rgb_fn = true,
            names = true,
        })
    end
}
