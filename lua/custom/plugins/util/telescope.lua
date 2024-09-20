return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup()

		local wk = require("which-key")
    wk.add({
      { "<leader>f", group = "find"},
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Search string" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Search buffers" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find recent files" },
      { "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "List treesitter" },
    })
	end,
}
