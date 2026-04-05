vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/folke/noice.nvim",
  "https://github.com/MunifTanjim/nui.nvim",

  -- lsp related plugins
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/creativenull/efmls-configs-nvim",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",

  "https://github.com/nvim-lua/plenary.nvim", -- dependency for harpoon
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "harpoon2",
  },
})

-- plugin configs
require("custom.plugins.config.treesitter")
require("custom.plugins.config.mini")
require("custom.plugins.config.harpoon")
require("custom.plugins.config.snacks")
require("custom.plugins.config.lsp")
require("custom.plugins.config.trouble")
require("custom.plugins.config.noice")
