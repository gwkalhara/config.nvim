return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
	config = function()
		require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<CR>"] = function (prompt_bufnr)
              local actions = require('telescope.actions')
              local action_state = require('telescope.actions.state')
              local picker = action_state.get_current_picker(prompt_bufnr)
              local selected_count = #picker:get_multi_selection()

              if selected_count > 0 then
                -- If there are multiple selections, send them to the quickfix list and open them
                actions.send_selected_to_qflist(prompt_bufnr)
                actions.open_qflist()
                vim.cmd("cdo e")
                vim.cmd("cclose")
              else
                -- If no multiple selections, open the currently highlighted file
                actions.select_default(prompt_bufnr)
              end
            end
          }
        },
      },
    })

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
