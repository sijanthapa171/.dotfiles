return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5", -- Specifies the version of Telescope to install.

    dependencies = {
        "nvim-lua/plenary.nvim", -- Required for Telescope to function properly.
    },

    config = function()
        -- Basic setup for Telescope.
        require("telescope").setup({})

        -- Access Telescope's builtin functions.
        local builtin = require("telescope.builtin")

        -- Key mappings for different search actions.
        -- Find files using Telescope.
        vim.keymap.set("n", "<leader>pf", builtin.find_files, {})

        -- Find files in a Git repository using Telescope.
        vim.keymap.set("n", "<C-p>", builtin.git_files, {})

        -- Grep search for the current word under the cursor.
        vim.keymap.set("n", "<leader>pws", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)

        -- Grep search for the current WORD under the cursor (ignores case).
        vim.keymap.set("n", "<leader>pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)

        -- General grep search with a prompt for custom input.
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        -- Search for help tags (useful for finding Neovim documentation).
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    end,
}
