return {
	"gbprod/yanky.nvim",
	config = function()
		require("yanky").setup()
		local wk = require("which-key")

    wk.add({
      {"p", "<Plug>(YankyPutAfter)", "Paste after"},
      {"P", "<Plug>(YankyPutBefore)", "Paste before"},
      {"<leader>p", group = "Put"},
      {"<leader>pp", "<Plug>(YankyPreviousEntry)", desc = "YankyPreviousEntry" },
      {"<leader>pn", "<Plug>(YankyNextEntry)", desc = "YankyNextEntry" }
    })
	end,
}
