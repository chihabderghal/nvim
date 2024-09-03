require("chihabderghal")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"folke/zen-mode.nvim", -- Zen mode
	"lervag/vimtex", -- LaTeX
	"aklt/plantuml-syntax", -- PLantUML Syntax
	{ "numToStr/Comment.nvim", opts = {} }, -- "gc" to comment visual regions/lines

	{ import = "chihabderghal.plugins" },
	{ import = "chihabderghal.plugins.themes" },
}, { ui = {} })
