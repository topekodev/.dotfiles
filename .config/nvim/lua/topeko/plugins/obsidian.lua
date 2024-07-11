return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "obsidian",
                path = "~/Obsidian",
            }
        },
        notes_subdir = "notes",
        new_notes_location = "notes_subdir",
        -- File names
        ---@param spec { dir: obsidian.Path, title: string|? }
        ---@return string|obsidian.Path The full path to the new note.
        note_path_func = function(spec)
            -- This is equivalent to the default behavior.
            local path = spec.dir / tostring(spec.title)
            return path:with_suffix(".md")
        end,
        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = "notes",
            -- Optional, if you want to change the date format for the ID of daily notes.
            date_format = "%Y-%m-%d",
            -- Optional, if you want to change the date format of the default alias of daily notes.
            alias_format = "%B %-d, %Y",
            -- Optional, default tags to add to each new daily note created.
            default_tags = { "daily-notes" },
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            template = nil
        },
        -- Optional, alternatively you can customize the frontmatter data.
        ---@return table
        note_frontmatter_func = function(note)
            local out = { tags = note.tags }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end

            return out
        end,
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Override file find
            ["<leader>ff"] = {
                action = function()
                    vim.cmd("ObsidianQuickSwitch")
                end,
                opts = { noremap = false, buffer = true },
            },
            -- Override file grep search
            ["<leader>fs"] = {
                action = function()
                    vim.cmd("ObsidianSearch")
                end,
                opts = { noremap = false, buffer = true },
            },
            ["<leader>fd"] = {
                action = function()
                    vim.cmd("ObsidianDailies")
                end,
                opts = { buffer = true },
            },
            ["<leader>ft"] = {
                action = function()
                    vim.cmd("ObsidianTags")
                end,
                opts = { buffer = true },
            },
            ["<leader>fl"] = {
                action = function()
                    vim.cmd("ObsidianLinks")
                end,
                opts = { buffer = true },
            },
            ["<leader>fb"] = {
                action = function()
                    vim.cmd("ObsidianBacklinks")
                end,
                opts = { buffer = true },
            },
            ["<leader>c"] = {
                action = function()
                    vim.cmd("ObsidianNew")
                end,
                opts = { buffer = true },
            },
            ["<leader>o"] = {
                action = function()
                    vim.cmd("ObsidianOpen")
                end,
                opts = { buffer = true },
            },
            -- Smart action depending on context, either follow link or toggle checkbox.
            ["<cr>"] = {
                action = function()
                    return require("obsidian").util.smart_action()
                end,
                opts = { buffer = true, expr = true },
            },
        },
        ui = {
            enable = true,  -- set to false to disable all additional syntax features
            update_debounce = 200,  -- update delay after a text change (in milliseconds)
            max_file_length = 5000,  -- disable UI features for files with more than this many lines
            -- Define how various check-boxes are displayed
            checkboxes = {
                [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                ["x"] = { char = "", hl_group = "ObsidianDone" },
            },
        },
        ---@param url string
        follow_url_func = function(url)
            -- Open the URL in the default web browser.
            -- vim.fn.jobstart({"open", url})  -- Mac OS
            vim.fn.jobstart({"xdg-open", url})  -- linux
        end,
    }
}
