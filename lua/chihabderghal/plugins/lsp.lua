return {
	"neovim/nvim-lspconfig",

	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		-- LspAttach autocmd
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				-- Helper function to define bindings
				local map = function(keys, func)
					vim.keymap.set("n", keys, func, { buffer = event.buf })
				end

				-- General LSP bindings
				map("gd", require("telescope.builtin").lsp_definitions)
				map("gr", require("telescope.builtin").lsp_references)
				map("gI", require("telescope.builtin").lsp_implementations)
				map("<leader>D", require("telescope.builtin").lsp_type_definitions)
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols)
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)
				map("<leader>rn", vim.lsp.buf.rename)
				map("<leader>ca", vim.lsp.buf.code_action)
				map("K", vim.lsp.buf.hover)
				map("gD", vim.lsp.buf.declaration)

				-- Autocmds are used to highlight references of the word under the cursor
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end
			end,
		})

		--  Add new capabilities with nvim cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- LSP servers
		local servers = {
			gopls = {},
			pyright = {},
			clangd = {},
			tsserver = {
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
      },
			html = { filetypes = { "html" } },
			docker_compose_language_service = {},
			dockerls = {},
			ansiblels = {},
			yamlls = {},
			jsonls = {},
			texlab = {},
			bashls = {},
			phpactor = {},

			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
		}

		-- Setup Mason
		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"markdownlint",
			"hadolint",
			"flake8",
		})

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}

-- vim: ts=2 sts=2 sw=2 et
