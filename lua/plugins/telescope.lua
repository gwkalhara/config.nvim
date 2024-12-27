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

    local builtin = require("telescope.builtin")
    local nmap = function(lhs, rhs, desc)
      desc = "[F]ind " .. desc
      vim.keymap.set("n", lhs, rhs, { desc = desc, noremap = true, silent = true })
    end

    nmap("<leader>ff", builtin.find_files, "[F]iles")

    nmap("<leader>fr", function()
      builtin.oldfiles(require("telescope.themes").get_ivy())
    end, "[R]ecent files")

    nmap("<leader>fs", builtin.live_grep, "[S]tring")

    nmap("<leader>fw", function()
      builtin.grep_string(require("telescope.themes").get_ivy())
    end, "[W]ord")

    nmap("<leader>/", function()
      builtin.current_buffer_fuzzy_find({ previewer = false })
    end, "Fuzzy find pattern")

    nmap("<leader>fm", function()
      builtin.marks(custom_layout)
    end, "[M]arks")

    nmap("<leader>fq", function()
      builtin.quickfix(custom_layout)
    end, "[Q]uickfix")

    nmap("<leader>fg", "<cmd>Telescope git_status<cr>", "[G]it files(changed)")
    nmap("<leader>fH", function()
      builtin.help_tags({ previewer = false })
    end, "[H]elp tags")
    nmap("<leader>fG", "<cmd>Telescope git_files<cr>", "[G]it files(all)")
    nmap("<leader>ft", "<cmd>Telescope treesitter<cr>", "[T]reesitter tags")
    nmap("<leader>fb", function()
      builtin.buffers(require("telescope.themes").get_ivy())
    end, "[B]uffers")
    nmap("<leader>fd", builtin.diagnostics, "[D]iagnostics")

    nmap("<leader>fN", function()
      builtin.find_files({
        cwd = vim.fn.stdpath("config"),
        sorting_strategy = "ascending",
        layout_strategy = "bottom_pane",
        prompt_title = "Config files",
        layout_config = { preview_width = 0.5 },
      })
    end, "[N]eovim files")
  end,
}
