--- Uncomment the two plugins below if you want to manage the language servers from neovim
return {
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

      -- Add additional capabilities supported by nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- lsp_zero.on_attach(function(client, bufnr)
			lsp_zero.on_attach(function(_, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })

				local wk = require("which-key")
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
				}, { prefix = "<leader>", buffer = bufnr })
        wk.register({
          d = {
            function ()
              vim.lsp.buf.definition()
            end,
            "Go to definition"
          },
          D = {
            function ()
              vim.lsp.buf.declaration()
            end,
            "Go to declaration"
          },
          i = {
            function ()
              vim.lsp.buf.implementation()
            end,
            "List all implementations"
          },
          o = {
            function ()
              vim.lsp.buf.type_definition()
            end,
            "Jump to type definition"
          },
          r = {
            function ()
              vim.lsp.buf.references()
            end,
            "List all references"
          },
          s = {
            function ()
              vim.lsp.buf.signature_help()
            end,
            "Display signature info"
          },
        }, {prefix="g"})
			end)

			lsp_zero.set_sign_icons({
				-- error = "✘",
				-- warn = "▲",
				-- hint = "⚑",
				-- info = "»",
				error = "",
				warn = "",
				hint = "",
				info = "󰋽",
			})
			-- to learn how to use mason.nvim with lsp-zero
			-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"ruff_lsp",
          "clangd",
          "tsserver",
          "rust_analyzer"
				},
				handlers = {
					lsp_zero.default_setup,
				},
			})
      --#INFO: server setups 
      require('lspconfig').clangd.setup({
        on_attach = lsp_zero.on_attach,
        capabilities = capabilities
      })
      require('lspconfig').lua_ls.setup({
        on_attach = lsp_zero.on_attach,
        capabilities = capabilities
      })
      -- INFO: disabled to work with rust-tools plugin
      -- require("lspconfig").rust_analyzer.setup({
      --   on_attach = lsp_zero.on_attach,
      --   capabilities = capabilities,
      --   filetypes = {"rust"},
      --   root_dir = require("lspconfig.util").root_pattern("Cargo.toml"),
      --   settings = {
      --     ["rust-analyzer"] = {
      --       cargo = {
      --         allFeatures = true,
      --       },
      --     },
      --   },
      -- })
		end,
	},
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function ()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "black",
          "prettier",
          "clang-format"
        }
      })
    end
  },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"L3MON4D3/LuaSnip", -- snippet engine
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			"rafamadriz/friendly-snippets", -- useful snippets
			"onsails/lspkind.nvim", -- vs-code like pictograms
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- snippets
					{ name = "snippy" },
					{ name = "buffer" }, -- text within current buffer
					{ name = "path" }, -- file system paths
				}),
				mappings = {
					["<C-y>"] = cmp.mapping.confirm({ select = false }),
					["<C-e>"] = cmp.mapping.abort(),
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
					["<C-p>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item({ behavior = "insert" })
						else
							cmp.complete()
						end
					end),
					["<C-n>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item({ behavior = "insert" })
						else
							cmp.complete()
						end
					end),
				},
				mapping = cmp.mapping.preset.insert({
					["<tab>"] = cmp.mapping.confirm({ select = true }),

					-- scroll up and down the documentation window
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
				}),
			})
		end,
	},
	{ "L3MON4D3/LuaSnip" },
}
