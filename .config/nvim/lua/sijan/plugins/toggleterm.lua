return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		-- Use Alt+f to toggle a floating terminal
		open_mapping = [[<A-f>]],
		direction = "float",
		shade_terminals = true,
		-- Keep plugin-provided mappings active in insert/terminal modes
		insert_mappings = true,
		terminal_mappings = true,
	},
}
