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
        }
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
        -- INFO: additional tooling
          "black",
          "prettier",
          "clang-format"
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
        wk.register({K = {
          function()
            vim.lsp.buf.hover()
          end,
          "Hover documentation"
        }}, {buffer = bufnr})

        wk.register({
          c = {
            name = "Code",
            r = {
              function()
                vim.lsp.buf.rename()
              end,
              "Rename",
            },
            a = {
              function()
                vim.lsp.buf.code_action()
              end,
              "Code actions",
            },
            d = {
              function()
                vim.diagnostic.open_float()
              end,
              "Show floating diagnostics",
            },
          },
        }, { prefix = "<leader>" })
        wk.register({
          D = {
            function()
              vim.lsp.buf.declaration()
            end,
            "Goto declararion"
          },
          d = {
            function()
              vim.lsp.buf.definition()
            end,
            "Goto definition"
          },
          i = {
            function()
              vim.lsp.buf.implementation()
            end,
            "Goto implementation"
          },
          r = {
            function()
              vim.lsp.buf.references()
            end,
            "Goto references"
          },
        }, { prefix = "g" })
        wk.register({
          w = {
            name = "Workspace",
            a = {
              function()
                vim.lsp.buf.add_workspace_folder()
              end,
              "Add folder"
            },
            r = {
              function()
                vim.lsp.buf.remove_workspace_folder()
              end,
              "Remove folder"
            },
            -- l = {
            --   function()
            --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            --   end
            -- },
          }
        }, { prefix = "<leader>" })
      end

      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- INFO: start language server setup
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
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
    end
  },
}


