return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            --- add formatters and diagnostics here
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.nixfmt,
                -- null_ls.builtins.diagnostics."name".
            },
        })
    end,
}
