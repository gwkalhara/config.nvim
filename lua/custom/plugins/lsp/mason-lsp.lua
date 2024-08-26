return {
  { "williamboman/mason.nvim" },
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()

      require("mason").setup()
      require("mason-lspconfig").setup({
        -- INFO: language servers
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ruff_lsp",
          "clangd",
          "tsserver",
          "spectral",
          "gopls",
        }
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
        -- INFO: additional tooling
          "black",
          "isort",
          "prettier",
          "clang-format",
          "gofumpt",
          -- "goimports_reviser",
          "golines",
          -- "delve", -- go debugger
        }
      })

      local on_attach = function(_, bufnr)
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        -- -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        -- -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
        local wk = require("which-key")
        wk.add({
          { "K", function() vim.lsp.buf.hover() end, buffer = bufnr, desc = "Hover documentation" },
        })

        wk.add ({
          { "<leader>c", group = "Code" },
          { "<leader>ca", function() vim.lsp.buf.code_action() end, desc = "Code actions" },
          { "<leader>cd", function() vim.diagnostic.open_float() end, desc = "Show floating diagnostics" },
          { "<leader>cr", function() vim.lsp.buf.rename() end, desc = "Rename" },
        })

        wk.add({
          { "gD", function() vim.lsp.buf.declaration() end, desc = "Goto declararion" },
          { "gd", function() vim.lsp.buf.definition() end, desc = "Goto definition" },
          { "gi", function() vim.lsp.buf.implementation() end, desc = "Goto implementation" },
          { "gr", function() vim.lsp.buf.references() end, desc = "Goto references" },
        })

        wk.add({
          { "<leader>w", group = "Workspace" },
          { "<leader>wa", function() vim.lsp.buf.add_workspace_folder() end, desc = "Add folder" },
          { "<leader>wr", function() vim.lsp.buf.remove_workspace_folder() end, desc = "Remove folder" },
        })

      end

      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      --#INFO: LSP setup with neodev
      require("neodev").setup({})
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- INFO: start language server setup
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace"
            }
          }
        }
      })
      lspconfig.ruff_lsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      lspconfig.spectral.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "json", "yaml" }
      })
      lspconfig.ast_grep.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "css"}
      })
      lspconfig.cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities
      })
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {"gopls"},
        filetypes = { "go", "gomod", "gowork", "gotmpl"},
        root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            }
          }
        }
      })
    end
  },
}


