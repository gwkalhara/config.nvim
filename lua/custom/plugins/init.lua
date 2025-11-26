M = {}

M.plugins = {

  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "night" },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "nvim-mini/mini.nvim",
    version = "*",
    config = require("custom.plugins.config.mini").config,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = require("custom.plugins.config.harpoon").keys,
  },
  {
    "folke/which-key.nvim",
    dependencies = { "nvim-mini/mini.nvim" },
    event = "VimEnter",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = function()
      --   ---@diagnostic disable-next-line: undefined-global
      --   local git_icon, _, _ = MiniIcons.get("filetype", "git")
      return {
        preset = "classic",
        spec = {
          -- { "<leader>b", group = "[B]uffer" },
          -- { "<leader>t", group = "[T]oggle" },
          { "<leader>c", group = "[C]ode" },
          { "<leader>f", group = "[F]ind" },
          { "<leader>g", group = "[G]it" },
          { "<leader>h", group = "[H]arpoon" },
          { "<leader>l", group = "[L]aTeX" },
          { "<leader>n", group = "[N]otification" },
          { "<leader>o", group = "[O]bsidian" },
          { "<leader>s", group = "[S]earch" },
          { "<leader>w", group = "[W]orkspace" },
          { "<leader>x", group = "Trouble" },
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
    keys = {
      -- stylua: ignore
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo", }
,
    },
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
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = require("custom.plugins.config.ufo").config,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = require("custom.plugins.config.noice").opts,
    config = require("custom.plugins.config.noice").config,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "folke/noice.nvim",
      "nvim-tree/nvim-web-devicons",
      "AndreM222/copilot-lualine",
    },
    event = "VeryLazy",
    init = require("custom.plugins.config.lualine").init,
    opts = require("custom.plugins.config.lualine").opts,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("custom.plugins.config.snacks").opts,
    keys = require("custom.plugins.config.snacks").keys,
  },
  {
    "stevearc/conform.nvim",
    version = "*",
    lazy = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = require("custom.plugins.config.conform").opts,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "master",
    build = ":TSUpdate",
    config = require("custom.plugins.config.treesitter").config,
  },
  -- INFO: lsp setup
  require("custom.plugins.config.lsp").spec,
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = require("custom.plugins.config.trouble").opts,
    keys = require("custom.plugins.config.trouble").keys,
  },
  -- {
  --   "wintermute-cell/gitignore.nvim",
  --   cmd = { "Gitignore" },
  --   -- dependencies = { "nvim-telescope/telescope.nvim" },
  --   opts = {},
  -- },
  { dir = "~/Desktop/Code/Langs/Lua/Plugins/fixes/gitignore.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    version = "*",
    opts = require("custom.plugins.config.git").gitsigns_opts,
    config = require("custom.plugins.config.git").gitsigns_config,
  },
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    -- event = { "CmdlineEnter" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      -- panel = { enabled = false },
      suggestion = {
        enabled = true,
        keymap = {
          accept = "<M-\\>",
          accept_word = "<M-w>",
          accept_line = "<M-a>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
    },
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    cmd = { "Obsidian" },
    ft = "markdown",
    dependencies = require("custom.plugins.config.obsidian").dependencies,
    keys = require("custom.plugins.config.obsidian").keys,
    opts = require("custom.plugins.config.obsidian").opts,
  },
  require("custom.plugins.config.latex").spec,
}

return M
