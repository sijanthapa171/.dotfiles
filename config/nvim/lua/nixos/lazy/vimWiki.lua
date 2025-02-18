return {
    "vimwiki/vimwiki",
    event = "BufEnter *.md",
    keys = { "<leader>ww", "<leader>wt" },
    init = function()
        vim.g.vimwiki_list = {
            {
                path = "~/personal/vimWiki",
                syntax = "markdown",
                ext = "md",
            },
        }
    end,
}
