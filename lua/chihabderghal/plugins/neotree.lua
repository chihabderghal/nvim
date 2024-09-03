return {
	"nvim-neo-tree/neo-tree.nvim",

	version = "*",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	cmd = "Neotree",

	keys = {
		{ "<leader>op", ":Neotree reveal<CR>", { desc = "NeoTree reveal" } },
	},

	opts = {
		filesystem = {
			window = {
				mappings = {
					["<leader>op"] = "close_window",
				},
			},
		},
	},
}

-- vim: ts=2 sts=2 sw=2 et
