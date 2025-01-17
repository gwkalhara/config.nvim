return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    -- "nvim-telescope/telescope-fzy-native.nvim",
  },
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
      extensions = {
        fzf = {},
      },
    })

    require("telescope").load_extension("fzf")

    local custom_layout = {
      sorting_strategy = "ascending",
      layout_strategy = "bottom_pane",
      layout_config = {
        preview_width = 0.5,
      },
    }

    local builtin = require("telescope.builtin")
    local nmap = function(lhs, rhs, desc, group)
      group = group or "[F]ind "
      desc = group .. desc
      vim.keymap.set("n", lhs, rhs, { desc = desc, noremap = true, silent = true })
    end

    -- find
    nmap("<leader>ff", builtin.find_files, "[F]iles")
    nmap("<leader>fr", function()
      builtin.oldfiles(require("telescope.themes").get_ivy())
    end, "[R]ecent files")
    nmap("<leader>fs", require("extras.telescope").live_multigrep, "[S]tring")
    nmap("<leader>fw", function()
      builtin.grep_string(require("telescope.themes").get_ivy())
    end, "[W]ord")
    nmap("<leader>fg", "<cmd>Telescope git_status<cr>", "[G]it files(changed)")
    nmap("<leader>fG", "<cmd>Telescope git_files<cr>", "[G]it files(all)")
    nmap("<leader>ft", "<cmd>Telescope treesitter<cr>", "[T]reesitter tags")
    nmap("<leader>fb", function()
      builtin.buffers(require("telescope.themes").get_ivy())
    end, "[B]uffers")

    -- search
    nmap("<leader>sd", function()
      -- builtin.diagnostics()
      Snacks.picker.diagnostics()
    end, "[D]iagnostics", "[S]earch ")
    nmap("<leader>sh", function()
      Snacks.picker.help()
    end, "[H]elp Pages", "[S]earch ")
    nmap("<leader>sm", function()
      builtin.marks(custom_layout)
    end, "[M]arks", "[S]earch ")
    nmap("<leader>sq", function()
      builtin.quickfix(custom_layout)
    end, "[Q]uickfix List", "[S]earch ")

    nmap("<leader>/", function()
      builtin.current_buffer_fuzzy_find({ previewer = false })
    end, "Fuzzy find pattern")

    nmap("<leader>fC", function()
      builtin.find_files({
        cwd = vim.fn.stdpath("config"),
        sorting_strategy = "ascending",
        layout_strategy = "bottom_pane",
        prompt_title = "Config files",
        layout_config = { preview_width = 0.5 },
      })
    end, "[N]eovim [C]onfig files")
    nmap("<leader>fP", function()
      builtin.find_files({
        ---@diagnostic disable-next-line: param-type-mismatch
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
        sorting_strategy = "ascending",
        layout_strategy = "bottom_pane",
        prompt_title = "Config files",
        layout_config = { preview_width = 0.5 },
      })
    end, "[N]eovim [P]lugins")
  end,
}
