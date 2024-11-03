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
      { "ZZ", "ZZ", desc = "Quite all", noremap = false },
      { "ZQ", "ZQ", desc = "Quite without saving", noremap = false },
    })

    wk.add({
      { "<leader>b", group = "Buffer"},
      { "<leader>bb", "<cmd>buffers<cr>", desc = "List buffers"},
      { "<leader>bd", "<cmd>bd<cr>", desc = "Delete buffer"},
      { "<leader>bm", "<cmd>only<cr>", desc = "Maximize buffer"},
    })

	end
}
