return {
    {
        "folke/trouble.nvim", -- The plugin that shows diagnostics in a floating window.

        config = function()
            -- Setup the trouble plugin with custom configurations
            require("trouble").setup({
                icons = false, -- Disable icons in the trouble window.
            })

            -- Keybindings to toggle and navigate the trouble list.
            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle() -- Toggle the trouble window.
            end)

            -- Navigate to the next diagnostic entry (skip groups).
            vim.keymap.set("n", "[t", function()
                require("trouble").next({ skip_groups = true, jump = true })
            end)

            -- Navigate to the previous diagnostic entry (skip groups).
            vim.keymap.set("n", "]t", function()
                require("trouble").previous({ skip_groups = true, jump = true })
            end)
        end,
    },
}
