local gh = function(url_name)
  return "https://github.com/" .. url_name
end

vim.pack.add({
  gh("nvim-mini/mini.nvim"),
  gh("nvim-treesitter/nvim-treesitter"),
  gh("folke/snacks.nvim"),
  gh("folke/trouble.nvim"),
  gh("folke/noice.nvim"),
  gh("MunifTanjim/nui.nvim"),

  -- lsp related plugins
  gh("neovim/nvim-lspconfig"),
  gh("mason-org/mason.nvim"),
  gh("j-hui/fidget.nvim"),
  gh("creativenull/efmls-configs-nvim"),
  {
    src = gh("saghen/blink.cmp"),
    version = vim.version.range("1.*"),
  },
  gh("L3MON4D3/LuaSnip"),
  gh("rafamadriz/friendly-snippets"),

  gh("nvim-lua/plenary.nvim"), -- dependency for harpoon
  {
    src = gh("ThePrimeagen/harpoon"),
    version = "harpoon2",
  },
})

-- plugin configs
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("UserPluginLoading", { clear = true }),
  callback = function()
    require("custom.plugins.config.trouble")
    require("custom.plugins.config.noice")
    require("custom.plugins.config.treesitter")
    require("custom.plugins.config.harpoon")
  end,
})
require("custom.plugins.config.mini")
require("custom.plugins.config.snacks")
require("custom.plugins.config.lsp")
