local local_plugins = {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            -- Initialize harpoon
            harpoon:setup()

            -- Keymaps to add current file to harpoon
            vim.keymap.set("n", "<leader>A", function()
                harpoon:list():prepend()
            end)
            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
            end)
            -- Toggle the harpoon quick menu
            vim.keymap.set("n", "<C-e>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            -- Keymaps to select specific harpoon files
            vim.keymap.set("n", "<C-h>", function()
                harpoon:list():select(1)
            end)
            vim.keymap.set("n", "<C-t>", function()
                harpoon:list():select(2)
            end)
            vim.keymap.set("n", "<C-n>", function()
                harpoon:list():select(3)
            end)
            vim.keymap.set("n", "<C-s>", function()
                harpoon:list():select(4)
            end)

            -- Keymaps to replace files in harpoon list
            vim.keymap.set("n", "<leader><C-h>", function()
                harpoon:list():replace_at(1)
            end)
            vim.keymap.set("n", "<leader><C-t>", function()
                harpoon:list():replace_at(2)
            end)
            vim.keymap.set("n", "<leader><C-n>", function()
                harpoon:list():replace_at(3)
            end)
            vim.keymap.set("n", "<leader><C-s>", function()
                harpoon:list():replace_at(4)
            end)
        end,
    },
}

return local_plugins
