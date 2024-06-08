return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy=true,
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{ "filename" },
				},
				lualine_x = {
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = { fg = "#ff9e64" },
					},
					-- {
					-- require("noice").api.status.message.get_hl,
					-- cond = require("noice").api.status.message.has,
					-- },
					{
						require("venv-selector").get_active_venv,
						cond = function()
							if require("venv-selector").get_active_venv == nil then
								return false
							else
								return true
							end
						end,
						color = { fg = "#ff9e64" },
					},
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
						color = { fg = "#ff9e64" },
          },
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
						color = { fg = "#ff9e64" },
					},
					{
						require("noice").api.status.search.get,
						cond = require("noice").api.status.search.has,
						color = { fg = "#ff9e64" },
					},
					"encoding",
					-- "fileformat",
					-- "filetype",
				},
				lualine_y = {
					"progress",
					"location",
				},
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {
				"neo-tree",
				"lazy",
				"mason",
				"trouble",
				"aerial",
			},
		})
	end,
}
