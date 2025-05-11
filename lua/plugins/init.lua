return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("tokyonight").setup({ style = "night" })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "folke/which-key.nvim",
    dependencies = { "echasnovski/mini.nvim" },
    event = "VimEnter",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = function()
      ---@diagnostic disable-next-line: undefined-global
      local git_icon, _, _ = MiniIcons.get("filetype", "git")
      return {
        preset = "classic",
        spec = {
          { "<leader>b", group = "[B]uffer" },
          { "<leader>c", group = "[C]ode" },
          { "<leader>t", group = "[T]oggle" },
          { "<leader>f", group = "[F]ind" },
          { "<leader>s", group = "[S]earch" },
          { "<leader>g", group = "[G]it", icon = git_icon },
          { "<leader>o", group = "[O]bsidian" },
          { "<leader>x", group = "Trouble" },
          { "<leader>w", group = "[W]orkspace" },
          { "<leader>h", group = "[H]arpoon" },
          { "<leader>n", group = "[N]otification" },
        },
      }
    end,
  },
  {
    "barrett-ruth/live-server.nvim",
    build = "npm add -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
    config = function()
      require("live-server").setup({
        args = {
          "--browser=zen",
        },
      })
    end,
  },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
    keys = {
      {
        "<leader>u",
        function()
          require("undotree").toggle()
        end,
        desc = "Toggle undotree",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "uga-rosa/ccc.nvim",
    event = "VeryLazy",
    opts = {
      highlighter = {
        auto_enable = true,
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "chentoast/marks.nvim",
    event = "BufWinEnter",
    opts = {
      default_mappings = true,
      signs = true,
    },
  },
  {
    "folke/snacks.nvim",
    version = "*",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      picker = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "fancy",
        top_down = false,
      },
      terminal = { enabled = true },
      indent = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = {
        enabled = true,
        folds = { open = true },
        git = {
          patterns = { "MiniDiffSign", "GitSign" },
        },
      },
      words = { enabled = true },
      git = { enabled = true },
    },
      -- stylua: ignore
    keys = {
      -- search
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "[S]earch [T]odo" },
      -- notifier
      { "<leader>nd", function() Snacks.notifier.hide() end, desc = "[N]otification [D]ismiss" },
      { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "[N]otification [H]istory" },
      -- git
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
      -- words
      { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      {
        "<leader>ttf",
        function()
          Snacks.terminal.toggle("pwsh.exe", {win = {position="float"}})
        end,
        desc = "[T]oggle [T]erminal [F]loat "
      },
      { "<leader>ttb",
      function()
        Snacks.terminal.toggle("pwsh.exe", {win = {position="bottom"}})
      end,
      desc = "[T]oggle [T]erminal [B]ottom "
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
      -- stylua: ignore
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      },
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    --#NOTE: used for the new version(2024)
    branch = "regexp", -- This is the regexp branch, use this for the new version
    ft = "python",
    config = function()
      require("venv-selector").setup({
        settings = {
          search = {
            miniconda3 = {
              command = "fd python.exe$ C:\\Users\\Hp\\miniconda3\\envs\\",
            },
          },
        },
      })
      local wk = require("which-key")
      local map_cond = function()
        return vim.bo.filetype == "python"
      end
      wk.add({
        { "<leader>cv", group = "venv", cond = map_cond },
        {
          "<leader>cvs",
          "<cmd>VenvSelect<cr>",
          desc = "Select venv",
          cond = map_cond,
        },
        {
          "<leader>cvc",
          "<cmd>VenvSelectCached<cr>",
          desc = "Select venv from cache",
          cond = map_cond,
        },
        {
          "<leader>cvp",
          function()
            print(require("venv-selector").venv())
          end,
          desc = "Print selected venv",
          cond = map_cond,
        },
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    version = "*",
    opts = {
      code = { style = "full" },
      checkbox = {
        custom = {
          warn = {
            raw = "[!]",
            rendered = " ",
            highlight = "RenderMarkdownError",
            scope_highlight = nil,
          },
          fix = {
            raw = "[+]",
            rendered = "󱌣 ",
            highlight = "RenderMarkdownHint",
            scope_highlight = nil,
          },
          todo = {
            raw = "[~]",
            rendered = "󰥔 ",
            highlight = "RenderMarkdownTodo",
            scope_highlight = nil,
          },
          arrow = {
            raw = "[>]",
            rendered = "",
            highlight = "RenderMarkdownHint",
            scope_highlight = nil,
          },
        },
      },
    },
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
    },
  },
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    -- event = { "CmdlineEnter" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "pixelneo/vim-python-docstring",
    ft = "python",
    cmd = { "Docstring", "DocstringTypes", "DocstringLine" },
  },
  {
    "TheLeoP/powershell.nvim",
    ---@type powershell.user_config
    ft = "ps1",
    opts = {
      bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      require("ufo").setup({
        fold_virt_text_handler = require("extras.ufo").handler,
        provider_selector = function(_, _, _)
          return { "treesitter", "indent" }
        end,
      })
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open All Folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close All Folds" })
    end,
  },
}
