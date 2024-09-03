return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	cond = true,
	config = function()
		vim.cmd([[ colorscheme gruvbox ]])
	end,
}

-- vim: ts=2 sts=2 sw=2 et
