--- requiring all the mappings
require("nixos.remaps")
require("nixos.set")
require("nixos.lazy_init")

-- Create an augroup for NixOS-specific autocommands
local augroup = vim.api.nvim_create_augroup
local nixos= augroup("nixos", {})
-- Create an augroup for yank highlight autocommands
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})
-- Function to reload a specific module using plenary
function R(name)
    require("plenary.reload").reload_module(name)
end

-- Add custom file type for templ files
vim.filetype.add({
    extension = {
        templ = "templ",
    },
})
-- Highlight text after yank with 'IncSearch' highlighting group for 40ms
autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})
-- Automatically trim trailing whitespaces before writing to a file
autocmd({ "BufWritePre" }, {
    group = nixos,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
-- Setup key mappings for LSP when attached to a buffer
autocmd("LspAttach", {
    group = nixos,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "<leader>vws", function()
            vim.lsp.buf.workspace_symbol()
        end, opts)
        vim.keymap.set("n", "<leader>vd", function()
            vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "<leader>vca", function()
            vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "<leader>vrr", function()
            vim.lsp.buf.references()
        end, opts)
        vim.keymap.set("n", "<leader>vrn", function()
            vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set("i", "<C-h>", function()
            vim.lsp.buf.signature_help()
        end, opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.goto_prev()
        end, opts)
    end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
