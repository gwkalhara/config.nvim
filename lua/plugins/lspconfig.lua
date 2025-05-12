return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    version = "*",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      {
        -- NOTE: Mason must be loaded before dependants
        "mason-org/mason.nvim",
        version = "*",
        opts = {
          max_concurrent_installers = 2,
        },
      },
      {
        "mason-org/mason-lspconfig.nvim",
        version = "*",
        dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      },
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
      },

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",

      "ray-x/go.nvim", -- required to get the `gopls` server settings
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- INFO: These mappings are taken from `kickstart.nvim`
          -- need to replace them if necessary.

          map("K", vim.lsp.buf.hover, "[H]over docs")
          map("<C-k>", vim.lsp.buf.signature_help, "Signature help", "i")

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          -- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("gd", Snacks.picker.lsp_definitions, "[G]oto [D]efinition")

          -- Find references for the word under your cursor.
          -- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("gr", Snacks.picker.lsp_references, "[G]oto [R]eferences")

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map("gI", Snacks.picker.lsp_implementations, "[G]oto [I]mplementation")
          -- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          -- map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          -- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
          -- map("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
          map("gy", Snacks.picker.lsp_type_definitions, "[G]oto [T]ype Definition")

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

          -- TODO: Workspaces doesn't seem to work properly, might have to remove this mapping
          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
          map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd folder")
          map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")
          map("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "[W]orkspace [L]ist folders")

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

          --  This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                  group = "kickstart-lsp-highlight",
                  buffer = event2.buf,
                })
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }

      -- BUG: This part doesn't seem to work
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end
      vim.diagnostic.config({ signs = { text = diagnostic_signs } })

      -- BUG: This isn't working either
      -- -INFO: Taken from my original config
      -- for type, icon in pairs(signs) do
      --   local hl = "DiagnosticSign" .. type
      --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      -- end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- INFO: Special setup for gopls
      -- `go.nvim` overides mappings when running on_attach functions
      -- the fields have to be seperately passed
      local _, gopls_config = pcall(require("go.lsp").config)
      if gopls_config == nil then
        gopls_config = {
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        }
      else
        gopls_config = {
          capabilities = gopls_config.capabilities,
          cmd = gopls_config.cmd,
          filetypes = gopls_config.filetypes,
          flags = gopls_config.flags,
          handlers = gopls_config.handlers,
          message_level = gopls_config.message_level,
          settings = gopls_config.settings,
          root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
        }
      end

      -- INFO: Servers are defined here
      -- local servers = {
      -- lua_ls = {
      --   -- cmd = { ... },
      --   -- filetypes = { ... },
      --   -- capabilities = {},
      --   settings = {
      --     Lua = {
      --       completion = {
      --         callSnippet = "Replace",
      --       },
      --       -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      --       diagnostics = { disable = { "missing-fields" } },
      --     },
      --   },
      -- },
      -- gopls = gopls_config,
      --   pyright = { filetypes = "python" },
      --   ruff = { filetypes = "python" },
      --   ts_ls = {},
      --   cssls = {},
      --   texlab = {},
      --   ast_grep = { filetypes = { "html", "css" } },
      --   spectral = { filetypes = { "json", "yaml" } },
      --   emmet_ls = {
      --     init_options = {
      --       html = { options = { ["bem.enabled"] = true } },
      --     },
      --     filetypes = {
      --       "css",
      --       "eruby",
      --       "html",
      --       "htmldjango",
      --       "javascript",
      --       "javascriptreact",
      --       "less",
      --       "sass",
      --       "scss",
      --       "svelte",
      --       "pug",
      --       "typescriptreact",
      --       "vue",
      --     },
      --   },
      -- }

      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- INFO: additional tooling
        "stylua",
        "black",
        "isort",
        "prettier",
        "gofumpt",
        "goimports-reviser",
        "golines",
      })
      -- INFO: install servers
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
        auto_update = true,
        start_delay = 10000,
      })

      ---@diagnostic disable-next-line: missing-fields
      require("mason-lspconfig").setup({ automatic_enable = true })
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- TODO: look into this:: https://github.com/NTBBloodbath/nvim/blob/main/lua/core/lsp.lua

      -- setup servers with new api
      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        ---@diagnostic disable-next-line: undefined-field
        root_markers = { ".luarc.json", ".git", vim.uv.cwd() },
        settings = {
          Lua = {
            telemetry = {
              enable = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      }
      vim.lsp.enable("lua_ls")

      vim.lsp.config.gopls = gopls_config
      vim.lsp.enable("gopls")

      vim.lsp.config.pyright = { filetypes = "python" }
      vim.lsp.enable("pyright")

      vim.lsp.config.ruff = { filetypes = "python" }
      vim.lsp.enable("ruff")

      vim.lsp.enable("ts_ls")
      vim.lsp.enable("cssls")
      vim.lsp.enable("texlab")

      vim.lsp.config.ast_grep = { filetypes = { "html", "css" } }
      vim.lsp.enable("ast_grep")

      vim.lsp.config.spectral = { filetypes = { "json", "yaml" } }
      vim.lsp.enable("spectral")

      vim.lsp.config.emmet_ls = {
        init_options = { html = { options = { ["bem.enabled"] = true } } },
        filetypes = {
          "css",
          "eruby",
          "html",
          "htmldjango",
          "javascript",
          "javascriptreact",
          "less",
          "sass",
          "scss",
          "svelte",
          "pug",
          "typescriptreact",
          "vue",
        },
      }
      vim.lsp.enable("emmet_ls")
    end,
  },
}
