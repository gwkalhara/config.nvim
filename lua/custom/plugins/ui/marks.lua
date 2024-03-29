return {
	"chentoast/marks.nvim",
	event = "BufWinEnter",
	config = function()
		require("marks").setup()
	end,
}
