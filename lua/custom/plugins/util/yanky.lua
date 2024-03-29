return {
	"gbprod/yanky.nvim",
	config = function()
		require("yanky").setup()
		local wk = require("which-key")
		wk.register({
			p = { "<Plug>(YankyPutAfter)", "Paste after" },
			P = { "<Plug>(YankyPutBefore)", "Paste before" },
		}, {})
		wk.register({
			p = {
				name = "Put",
				p = { "<Plug>(YankyPreviousEntry)", "YankyPreviousEntry" },
				n = { "<Plug>(YankyNextEntry)", "YankyNextEntry" },
			},
		}, { prefix = "<leader>" })
	end,
}
