return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
		local wk = require("which-key")
		wk.setup()

		wk.register({
			l = {
				name = "Lazy",
				l = { "<cmd>Lazy<cr>", "Open Lazy", noremap = false },
				s = { "<cmd>Lazy sync<cr>", "Run Lazy sync", noremap = false },
			},
			q = {
				name = "Quit",
				q = { "<cmd>qa<cr>", "Quite all" },
				s = { "<cmd>wqa<cr>", "Write quite all" },
				x = { "<cmd>qa!<cr>", "Quite without saving" },
			},
		}, { prefix = "<leader>" })
	end,
}
