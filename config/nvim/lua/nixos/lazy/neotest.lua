return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neotest/nvim-nio",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "marilari88/neotest-vitest",
            "nvim-neotest/neotest-plenary",
        },
        config = function()
            local neotest = require("neotest")

            -- Set up Neotest with the desired adapters
            neotest.setup({
                adapters = {
                    require("neotest-vitest"), -- Adapter for Vitest tests
                    require("neotest-plenary").setup({
                        -- Custom configuration for Plenary adapter
                        min_init = "./scripts/tests/minimal.vim", -- Standard Vim rc file location for tests
                    }),
                },
            })

            -- Key mapping to run tests with Neotest
            vim.keymap.set("n", "<leader>tc", function()
                neotest.run.run() -- Run the test under the cursor
            end)
        end,
    },
}
