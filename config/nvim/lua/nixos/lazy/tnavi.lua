return {
	"christoomey/vim-tmux-navigator",
	vim.keymap.set("n", "<C-w>w", "<cmd>TmuxNavigateNext<CR>"),
	vim.keymap.set("n", "<C-w>h", "<cmd>TmuxNavigateLeft<CR>"),
	vim.keymap.set("n", "<C-w>j", "<cmd>TmuxNavigateDown<CR>"),
	vim.keymap.set("n", "<C-w>k", "<cmd>TmuxNavigateUp<CR>"),
	vim.keymap.set("n", "<C-w>l", "<cmd>TmuxNavigateRight<CR>"),
}
