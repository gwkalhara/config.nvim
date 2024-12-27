return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    require("telescope").setup({
      defaults = {
        -- TODO: Experiment with this option
        path_display = {
          truncate = 3,
          -- shorten = { len = 1, exclude = { 1, -1 } },
        },
      },
      pickers = {
        find_files = {
          theme = "ivy",
        },
        git_files = {
          theme = "ivy",
        },
        git_status = {
          theme = "ivy",
        },
      },
      extensions = {},
    })

    local custom_layout = {
      sorting_strategy = "ascending",
      layout_strategy = "bottom_pane",
      layout_config = {
        preview_width = 0.5,
      },
    }

    -- local no_preview = function()
    --   return require("telescope.themes").get_dropdown {
    --     borderchars = {
    --       { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    --       prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
    --       results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
    --       preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    --     },
    --     width = 0.8,
    --     previewer = false,
    --     prompt_title = false,
    --   }
    -- end
    --
    require("which-key").add({ { "<leader>f", group = "find" } })

    local builtin = require("telescope.builtin")
    local nmap = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { desc = desc, noremap = true, silent = true })
    end

    -- BUG: go.nvim seems to overide this
    -- nmap("<leader>ff", builtin.find_files, "Find files")
    nmap("<leader>ff", builtin.find_files, "Find files")

    nmap("<leader>fr", function()
      builtin.oldfiles(require("telescope.themes").get_ivy())
    end, "Find recent files")

    nmap("<leader>fs", builtin.live_grep, "Search string")

    nmap("<leader>fw", function()
      builtin.grep_string(require("telescope.themes").get_ivy())
    end, "Search string under cursor")

    nmap("<leader>/", function()
      builtin.current_buffer_fuzzy_find({ previewer = false })
    end, "Fuzzy find pattern")

    nmap("<leader>fm", function()
      builtin.marks(custom_layout)
    end, "Find marks")

    nmap("<leader>fq", function()
      builtin.quickfix(custom_layout)
    end, "Telescope quickfix list")

    nmap("<leader>fg", "<cmd>Telescope git_status<cr>", "Find Git files(changed)")
    nmap("<leader>fH", function()
      builtin.help_tags({ previewer = false })
    end, "Search help tags")
    nmap("<leader>fG", "<cmd>Telescope git_files<cr>", "Find Git files(all)")
    nmap("<leader>ft", "<cmd>Telescope treesitter<cr>", "List treesitter")
    nmap("<leader>fb", function()
      builtin.buffers(require("telescope.themes").get_ivy())
    end, "Search buffers")
    nmap("<leader>fd", builtin.diagnostics, "Search Diagnostics")

    nmap("<leader>fN", function()
      builtin.find_files({
        cwd = vim.fn.stdpath("config"),
        sorting_strategy = "ascending",
        layout_strategy = "bottom_pane",
        prompt_title = "Config files",
        layout_config = { preview_width = 0.5 },
      })
    end, "[F]ind [N]eovim files")
  end,
}
