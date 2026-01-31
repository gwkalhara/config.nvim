local Treesitter = {}

Treesitter.config = function(_, opts)
  local parsers = {
    "python",
    "go",
    "lua",

    "markdown",
    "markdown_inline",
    "html",
    "latex",
    "typst",
    "yaml",

    "json",
    "toml",

    "gitcommit",
    "git_rebase",
  }
  require("nvim-treesitter").setup(opts)
  -- require("nvim-treesitter").install(parsers, { max_jobs = 3 })

  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = { "tex", "latex" },
  --   callback = function()
  --     vim.treesitter.stop()
  --   end,
  -- })
end

return Treesitter
