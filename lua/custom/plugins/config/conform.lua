local Conform = {}
Conform.opts = {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable 'format_on_save lsp_fallback' for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true }
    local lsp_format_opt
    if disable_filetypes[vim.bo[bufnr].filetype] then
      lsp_format_opt = "never"
    else
      lsp_format_opt = "fallback"
    end

    return {
      timeout_ms = 5000,
      lsp_format = lsp_format_opt,
    }
  end,
  formatters_by_ft = {
    lua = { "stylua" },
    -- python = { "isort", "black" },
    python = { "ruff_format" },
    javascript = { "prettier" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
  },
  formatters = {},
}

return Conform
