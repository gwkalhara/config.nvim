return {
	"folke/which-key.nvim",
  dependencies = { "echasnovski/mini.icons" },
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

    wk.add({
      { "<leader>l", group = "Lazy" },
      { "<leader>ll", "<cmd>Lazy<cr>", desc = "Open Lazy", noremap = false },
      { "<leader>ls", "<cmd>Lazy sync<cr>", desc = "Run Lazy sync", noremap = false },
      { "ZZ", "ZZ", desc = "Quite all", noremap = false },
      { "ZQ", "ZQ", desc = "Quite without saving", noremap = false }
    })
	end
}
