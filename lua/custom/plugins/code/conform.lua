return {
	"stevearc/conform.nvim",
  event="VeryLazy",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- Use a sub-list to run only the first available formatter
				javascript = { { "prettierd", "prettier" } },
        cpp = { "clang-format" },
        json = { "prettier" },
				go = { "gofumpt", "goimports_reviser" },
			},
		})

    require("conform").formatters.black = {
      prepend_args = { "--line-length", "80" },
    }

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
