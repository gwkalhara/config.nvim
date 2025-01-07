local custom_snippest = function()
  local ls = require("luasnip") -- Load luasnip
  local s = ls.snippet -- Snippet shorthand
  local t = ls.text_node -- Text node shorthand
  local i = ls.insert_node -- Text insert position

  -- INFO: `todo-comments` snippets
  -- List of styles
  local styles =
    { "INFO", "TEST", "BUG", "WARN", "TODO", "PERF", "HACK", "FIX", "ERROR" } -- Iterate through styles and add snippets
  for _, style in ipairs(styles) do
    ls.add_snippets("all", {
      s(style:lower(), {
        t(style .. ": "),
        i(0, "comment"),
      }),
    })
  end

  ls.add_snippets("python", {
    s({ trig = "args kwargs", name = "Func parameters" }, {
      t("*args, **kwargs"),
    }),
  })
end

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      "L3MON4D3/LuaSnip",
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
    -- INFO: Completion sources
    "onsails/lspkind.nvim",
    "saadparwaiz1/cmp_luasnip",

    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "gamithaKalharaW/cmp-go-pkgs",
  },
  config = function()
    local lspkind = require("lspkind")
    lspkind.init()

    local kind_formatter = lspkind.cmp_format({
      mode = "symbol_text",
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
        go_pkgs = "[pkgs]",
      },
    })

    -- See `:help cmp`
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.config.setup({})

    cmp.setup({
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      formatting = {
        fields = { "abbr", "kind", "menu" },
        expandable_indicator = true,
        format = function(entry, vim_item)
          -- Lspkind setup for icons
          vim_item = kind_formatter(entry, vim_item)

          return vim_item
        end,
      },
      completion = { completeopt = "menu,menuone,preview,noinsert" },

      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-Space>"] = cmp.mapping.complete({}),
      }),
      sources = {
        {
          name = "lazydev",
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = "go_pkgs" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      },
    })
    custom_snippest()

    -- INFO: Snippet mappings
    vim.keymap.set({ "i", "s" }, "<C-L>", function()
      luasnip.jump(1)
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-J>", function()
      luasnip.jump(-1)
    end, { silent = true })
  end,
}
