local Treesitter = {}

Treesitter.config = function(_, opts)
  local parsers = {
    "python",
    "go",
    "lua",

    "json",
    "toml",

    "gitcommit",
    "git_rebase",
  },


  require("nvim-treesitter").setup(opts)
  require("nvim-treesitter").install(parsers, {max_jobs=1})

  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = { "tex", "latex" },
  --   callback = function()
  --     vim.treesitter.stop()
  --   end,
  -- })
end

return Treesitter
