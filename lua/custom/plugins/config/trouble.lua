local Trouble = {}

Trouble.opts = {
  modes = {
    diagnostics = {
      focus = true,
    },
    lsp = {
      focus = false,
      win = { position = "right", size = 0.4 },
    },
    lsp_references = {
      focus = true,
      win = { position = "right", size = 0.4 },
    },
    lsp_document_symbols = {
      focus = true,
      win = { position = "right", size = 0.4 },
    },
    symbols = {
      desc = "document symbols",
      mode = "lsp_document_symbols",
      focus = false,
      win = { position = "right" },
      filter = {
        -- remove Package since luals uses it for control flow structures
        ["not"] = { ft = "lua", kind = "Package" },
        any = {
          -- all symbol kinds for help / markdown files
          ft = { "help", "markdown" },
          -- default set of symbol kinds
          kind = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
          },
        },
      },
    },
  },
}
-- stylua: ignore
Trouble.keys = {
  { "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP [R]eferences (Trouble)", },
  { "<leader>xd", "<cmd>Trouble diagnostics toggle focues=false<cr>", desc = "[D]iagnostics (Trouble)", },
  { "<leader>xs", "<cmd>Trouble lsp_document_symbols toggle focus=true<cr>", desc = "Code [S]ymbols (Trouble)", },
  { "<leader>xL", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "[L]SP Definitions / references / ... (Trouble)", },
  { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "[Q]uickfix List (Trouble)", },
}

return Trouble
