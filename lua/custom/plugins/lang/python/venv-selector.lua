return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
	opts = {
		-- Your options go here
		-- name = "venv",
		-- auto_refresh = false
	},
	ft = "python",
	keys = {
		-- Keymap to open VenvSelector to pick a venv.
		{ "<leader>cvs", "<cmd>VenvSelect<cr>" },
		-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
		{ "<leader>cvc", "<cmd>VenvSelectCached<cr>" },
	},
	config = function()
		require("venv-selector").setup({})
		local wk = require("which-key")
		wk.register({
			v = {
				name = "venv",
				s = "Select venv",
				c = "Select venv from cache",
			},
		}, { prefix = "<leader>c" })
	end,
}
