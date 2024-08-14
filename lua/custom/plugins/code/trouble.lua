return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		require("trouble").setup()
		local wk = require("which-key")

    wk.add({
      { "<leader>x", group = "Trouble" },
      { "<leader>xx", "<cmd>Trouble<cr>", desc = "Toggle Trouble", noremap = false },
      { "<leader>xd", "<cmd>Trouble diagnostics<cr>", desc = "Toggle document diagnostics", noremap = false },
      { "<leader>xq", "<cmd>Trouble quickfix<cr>", desc = "Toggle quickfixes", noremap = false },
      { "<leader>xl", "<cmd>Trouble loclist<cr>", desc = "Toggle loclist", noremap = false },
      { "gR", "<cmd>Trouble lsp_references<cr>", desc = "LSP reference", noremap = false }
    })
	end,
}
-- Lua
-- vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
-- vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
-- vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
-- vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
-- vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
-- vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
