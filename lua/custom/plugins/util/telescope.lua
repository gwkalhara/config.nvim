return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup()
		-- local builtin = require('telescope.builtin')
		--vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Find files"})
		--vim.keymap.set('n', '<leader>fs', builtin.live_grep, {desc = "Search string"})
		--vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "Search buffers"})
		--vim.keymap.set('n', '<leader>fg', builtin.git_files, {desc = "Find Git files"})
		--vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {desc = "Find recent files"})

		local wk = require("which-key")
		wk.register({
			f = {
				name = "find",
				f = { "<cmd>Telescope find_files<cr>", "Find files" },
				s = { "<cmd>Telescope live_grep<cr>", "Search string" },
				b = { "<cmd>Telescope buffers<cr>", "Search buffers" },
				g = { "<cmd>Telescope git_files<cr>", "Find Git files" },
				r = { "<cmd>Telescope oldfiles<cr>", "Find recent files" },
			},
		}, { prefix = "<leader>" })
	end,
}
