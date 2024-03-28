return {
  "simrat39/rust-tools.nvim",
  dependencies = "neovim/nvim-lspconfig",
  ft = "rust",
  opts = function ()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = require("lsp-zero").on_attach

      return {
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      }
  end,
  config = function (_, opts)
    require('rust-tools').setup(opts)
  end

}
