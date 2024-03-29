return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		require("trouble").setup()
		local wk = require("which-key")
		wk.register({
			x = {
				name = "Trouble",
				x = {
					function()
						require("trouble").toggle()
					end,
					"Toggle Trouble",
				},
				w = {
					function()
						require("trouble").toggle("workspace_diagnostics")
					end,
					"Toggle workspace diagnostics",
				},
				d = {
					function()
						require("trouble").toggle("document_diagnostics")
					end,
					"Toggle document diagnostics",
				},
				q = {
					function()
						require("trouble").toggle("quickfix")
					end,
					"Toggle quickfixes",
				},
				l = {
					function()
						require("trouble").toggle("loclist")
					end,
					"Toggle loclist",
				},
			},
		}, { prefix = "<leader>" })
		wk.register({
			g = {
				function()
					require("trouble").toggle("lsp_references")
				end,
				"LSP reference",
			},
		}, { prefix = "<leader>" })
	end,
}
-- Lua
-- vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
-- vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
-- vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
-- vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
-- vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
-- vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
