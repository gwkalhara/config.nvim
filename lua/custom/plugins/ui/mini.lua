return {
	{
		"echasnovski/mini.surround",
		version = "*",
    event = "BufReadPre",
		config = function()
			require("mini.surround").setup()
		end,
	},
	-- {
	--   'echasnovski/mini.move',
	--   version = '*',
	--   config = function()
	--     require("mini.move").setup()
	--   end
	-- },
	{
		"echasnovski/mini.indentscope",
		version = "*",
    event = "BufReadPre",
		config = function()
			require("mini.indentscope").setup()
		end,
	},
	{
		"echasnovski/mini.comment",
		version = "*",
    event = "BufReadPre",
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = "*",
    event = "BufReadPre",
		config = function()
			require("mini.pairs").setup()
		end,
	},
}
