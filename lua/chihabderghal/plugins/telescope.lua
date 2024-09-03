-- vim: ts=2 sts=2 sw=2 et
return {
	"nvim-telescope/telescope.nvim",

	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",

		{
			"nvim-telescope/telescope-fzf-native.nvim",

			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},

		{
			"nvim-tree/nvim-web-devicons",
			enabled = vim.g.have_nerd_font,
		},
	},

	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- Basic bindings, see `:help telescope.builtin` for help
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags)
		vim.keymap.set("n", "<leader>sk", builtin.keymaps)
		vim.keymap.set("n", "<leader>pf", builtin.git_files)
		vim.keymap.set("n", "<leader>ff", builtin.find_files)
		vim.keymap.set("n", "<leader>ss", builtin.builtin)
		vim.keymap.set("n", "<leader>sw", builtin.grep_string)
		vim.keymap.set("n", "<leader>sg", builtin.live_grep)
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics)
		vim.keymap.set("n", "<leader>sr", builtin.resume)
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles)
		vim.keymap.set("n", "<leader><leader>", builtin.buffers)

		-- Binding to search in the current buffer
		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end)

		-- Binding to search in open files
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end)

		-- Binding to search Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end)
	end,
}
