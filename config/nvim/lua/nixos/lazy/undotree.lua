return {
    "mbbill/undotree", -- The plugin that visualizes undo history.

    config = function()
        -- Set up a keybinding to toggle the undo tree window.
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
}
