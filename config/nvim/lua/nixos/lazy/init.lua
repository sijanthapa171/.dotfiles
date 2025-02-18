return {
    { --plenary for some plugins
        "nvim-lua/plenary.nvim",
        name = "plenary",
    },
    -- JUST some crazy shit
    "eandrju/cellular-automaton.nvim",
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
}
