require("mason").setup()
require("fidget").setup()

--=====================================================
-- builtin lsp progress
--=====================================================
-- require('vim._core.ui2').enable({
--   enable = true, -- Whether to enable or disable the UI.
--   msg = { -- Options related to the message module.
--     ---@type 'cmd'|'msg' Default message target, either in the
--     ---cmdline or in a separate ephemeral message window.
--     ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
--     ---or table mapping |ui-messages| kinds and triggers to a target.
--     targets = 'cmd',
--     cmd = { -- Options related to messages in the cmdline window.
--       height = 0.5 -- Maximum height while expanded for messages beyond 'cmdheight'.
--     },
--     dialog = { -- Options related to dialog window.
--       height = 0.5, -- Maximum height.
--     },
--     msg = { -- Options related to msg window.
--       height = 0.5, -- Maximum height.
--       timeout = 4000, -- Time a message is visible in the message window.
--     },
--     pager = { -- Options related to message window.
--       height = 1, -- Maximum height.
--     },
--   },
-- })
--
-- vim.api.nvim_create_autocmd("LspProgress", {
--   callback = function (ev)
--     local value = ev.data.params.value
--
--     vim.api.nvim_echo({{value.message or "done"}}, false, {
--       id = "lsp." .. ev.data.client_id,
--       kind = "progress",
--       source = "vim.lsp",
--       title = value.title,
--       status = value.kind ~= "end" and "running" or "success",
--       percent = value.percentage,
--     })
--   end
-- })
--
-- Although this works, it blocks the cmd bar
-- so for the time being,will continue to use fidget
--=====================================================

local diagnostic_signs = {
  Error = " ",
  Warn = " ",
  Hint = "",
  Info = "",
}

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
      [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
      [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
      [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    focusable = false,
    style = "minimal",
  },
})

local function lsp_on_attach(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client then
    return
  end

  -- local bufnr = ev.buf
  -- local opts = { noremap = true, silent = true, buffer = bufnr }

  local map = function(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, buffer = ev.buf, desc = "LSP: " .. desc })
  end

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
  map("<leader>ds", Snacks.picker.lsp_symbols, "[D]ocument [S]ymbols")

  -- TODO: Workspaces doesn't seem to work properly, might have to remove this mapping
  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map("<leader>ws", Snacks.picker.lsp_workspace_symbols, "[W]orkspace [S]ymbols")
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
  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = ev.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = ev.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    -- cleanup after lsp detach
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

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }))
      end, "[T]oggle Inlay [H]ints")
    end
  end
end
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAtach", { clear = true }),
  callback = lsp_on_attach,
})

-- luasnip configuration
require("luasnip.loaders.from_vscode").lazy_load()
-- INFO: Snippet mappings
vim.keymap.set({ "i", "s" }, "<C-L>", function()
  require("luasnip").jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
  require("luasnip").jump(-1)
end, { silent = true })

require("blink.cmp").setup({
  keymap = {
    preset = "super-tab",
    ["<Tab>"] = { "accept", "fallback" },
    ["<C-Space>"] = { "show", "hide" },
  },
  snippets = { preset = "luasnip" },
  completion = {
    documentation = { auto_show = true },
    menu = {
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              if ctx.source_name ~= "Path" then
                return (require("lspkind").symbol_map[ctx.kind] or "") .. ctx.icon_gap
              end

              local is_unknown_type =
                vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
              local mini_icon, _ = require("mini.icons").get(
                is_unknown_type and "os" or ctx.item.data.type,
                is_unknown_type and "" or ctx.label
              )

              return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
            end,

            highlight = function(ctx)
              if ctx.source_name ~= "Path" then
                return ctx.kind_hl
              end

              local is_unknown_type =
                vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
              local mini_icon, mini_hl = require("mini.icons").get(
                is_unknown_type and "os" or ctx.item.data.type,
                is_unknown_type and "" or ctx.label
              )
              return mini_icon ~= nil and mini_hl or ctx.kind_hl
            end,
          },
        },
      },
    },
  },
  sources = { default = { "lsp", "snippets", "path", "buffer" } },
  fuzzy = { implementation = "lua" },
})

vim.lsp.config["*"] = {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
}

-- ========================================================
-- server definitions
-- ========================================================
local servers = {
  ["lua_ls"] = {
    filetypes = { "lua" },
    settings = {
      Lua = {
        diagnostics = { globals = { "vim", "Snacks" } },
        telemetry = { enable = false },
      },
    },
  },
  ["gopls"] = {
    cmd = { "gopls" },
    filetypes = { "go", "gotempl", "gowork", "gomod" },
    root_markers = { ".git", "go.mod", "go.work", vim.uv.cwd() },
    settings = {
      gopls = {
        gofumpt = true,
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
        ["ui.inlayhint.hints"] = {
          compositeLiteralFields = true,
          constantValues = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  ["ty"] = {},
  ["ltex_plus"] = {},
  ["texlab"] = {},
}

local server_names = vim.tbl_keys(servers)
-- Iterate over all the server names and add them to the `vim.lsp.config` table.
for _, server_name in ipairs(server_names) do
  vim.lsp.config[server_name] = servers[server_name]
end

vim.lsp.enable(server_names)

-- ==========================================================
-- efm configuration
-- ==========================================================

do
  local stylua = require("efmls-configs.formatters.stylua")
  -- local gofumt = require("efmls-configs.formatters.gofumpt")

  local languages = {
    lua = { stylua },
    -- go = { gofumt },
  }

  vim.lsp.config("efm", {
    filetypes = vim.tbl_keys(languages),
    init_options = { documentFormatting = true },
    settings = {
      rootMarkers = { ".git/" },
      languages = languages,
    },
  })
end
vim.lsp.enable("efm")

local format_augroup = vim.api.nvim_create_augroup("UserAutoFormat", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_augroup,
  pattern = {
    "*.lua",
    -- "*.go",
  },
  callback = function(args)
    -- avoid formatting non-file buffers (helps prevent weird write prompts)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end
    if not vim.bo[args.buf].modifiable then
      return
    end
    if vim.api.nvim_buf_get_name(args.buf) == "" then
      return
    end

    local has_efm = false
    for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
      if c.name == "efm" then
        has_efm = true
        break
      end
    end
    if not has_efm then
      return
    end

    pcall(vim.lsp.buf.format, {
      bufnr = args.buf,
      timeout_ms = 2000,
      filter = function(c)
        return c.name == "efm"
      end,
    })
  end,
})
