return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		local ensure_installed = {
			"prettier",
			"stylua",
			"eslint_d",
			"shfmt",
			"ruff",
			"phpcsfixer"
		}
		if vim.fn.has("win32") == 0 then
			table.insert(ensure_installed, "checkmake")
		end

		require("mason-null-ls").setup({
			ensure_installed = ensure_installed,
			automatic_installation = true,
		})


		local sources = {
			formatting.phpcsfixer,
			formatting.prettierd,
			formatting.prisma_format,
			formatting.stylua,
			formatting.black,
			formatting.fish_indent,
			formatting.gofmt,
			formatting.goimports,
			formatting.goimports_reviser,
			formatting.golines,
			formatting.isort,
			formatting.rustywind,
			formatting.sqlfluff.with({
				extra_args = { "--dialect", "mysql" }
			}),
			formatting.phpcbf,
			formatting.phpcsfixer,
			formatting.shfmt.with({ args = { "-i", "4" } }),
			require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
			require("none-ls.formatting.ruff_format"),
		}
		if vim.fn.has("win32") == 0 then
			table.insert(sources, diagnostics.checkmake)
		end

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}
