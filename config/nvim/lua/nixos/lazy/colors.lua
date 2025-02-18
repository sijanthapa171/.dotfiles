-- Function to apply color themes with transparent backgrounds for Normal and NormalFloat highlights
function ColorMyPencils(color)
    color = color or "rose-pine" -- Default to "rose-pine" if no color is provided
    vim.cmd.colorscheme(color)

    -- Set transparency for Normal and NormalFloat highlight groups
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    -- Update Lualine theme to match the selected colorscheme
    local lualine_ok, lualine = pcall(require, "lualine")
    if lualine_ok then
        lualine.setup({ options = { theme = color } })
    end
end

return {
    -- Lualine statusline plugin
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto", -- Automatically detects the current colorscheme
                    section_separators = "",
                    component_separators = "",
                },
            })
        end,
    },

    -- Tokyo Night theme (dark theme with variations)
    {
        "folke/tokyonight.nvim",
        lazy = false, -- Load the plugin immediately
        config = function()
            ColorMyPencils("tokyonight")
            require("tokyonight").setup({
                style = "storm", -- Options: "storm", "moon", "night", "day"
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = "dark",
                    floats = "dark",
                },
            })
        end,
    },

    -- Gruvbox theme (dark retro-inspired theme)
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                terminal_colors = true,
                undercurl = true,
                underline = false,
                bold = true,
                italic = { comments = false },
                transparent_mode = true,
            })
            ColorMyPencils("gruvbox")
        end,
    },

    -- Rose Pine theme (soft dark theme)
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_background = true,
                styles = { italic = false },
            })
            ColorMyPencils("rose-pine")
        end,
    },

    -- Solarized Osaka theme (dark variation of Solarized)
    {
        "craftzdog/solarized-osaka.nvim",
        name = "solarized-osaka",
        config = function()
            require("solarized-osaka").setup({
                transparent = true,
                terminal_colors = true,
                day_brightness = 0.3,
            })
            ColorMyPencils("solarized-osaka")
        end,
    },

    -- Nord theme (cool-toned minimalist dark theme)
    {
        "shaunsingh/nord.nvim",
        name = "nord",
        config = function()
            ColorMyPencils("nord")
        end,
    },

    -- Kanagawa theme (dark theme inspired by Japanese art)
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        config = function()
            require("kanagawa").setup({
                transparent = true,
                theme = "dragon", -- Options: "wave", "dragon", "lotus"
            })
            ColorMyPencils("kanagawa")
        end,
    },

    -- Catppuccin theme (aesthetic dark theme)
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                flavour = "auto",
                background = { dark = "mocha" },
                transparent_background = true,
                dim_inactive = { enabled = true, shade = "dark", percentage = 0.15 },
            })
            ColorMyPencils("catppuccin")
        end,
    },

    -- Everforest theme (dark forest-inspired colors)
    {
        "sainnhe/everforest",
        name = "everforest",
        config = function()
            vim.g.everforest_background = "medium" -- Options: "hard", "medium", "soft"
            vim.g.everforest_transparent_background = 1
            ColorMyPencils("everforest")
        end,
    },

    -- Material theme (dark modern palette)
    {
        "marko-cerovac/material.nvim",
        name = "material",
        config = function()
            require("material").setup({
                contrast = { sidebars = true, floating_windows = true },
                styles = { comments = { italic = true } },
                plugins = { "nvim-tree", "telescope", "gitsigns" },
            })
            vim.g.material_style = "darker" -- Options: "darker", "oceanic", "palenight", "deep ocean"
            ColorMyPencils("material")
        end,
    },
}
