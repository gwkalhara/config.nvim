-- local parsers = {
--   "python",
--   "go",
--   "lua",
--
--   "markdown",
--   "markdown_inline",
--   "html",
--   "latex",
--   "typst",
--   "yaml",
--
--   "json",
--   "toml",
--
--   -- "gitcommit",
--   "git_rebase",
-- }

require("nvim-treesitter").setup()
-- require("nvim-treesitter").install(parsers, { max_jobs = 3 })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "tex", "latex" },
--   callback = function()
--     vim.treesitter.stop()
--   end,
-- })

-- Enable treesitter highlighting
vim.api.nvim_create_autocmd("FileType", {
  pattern = require("nvim-treesitter").get_installed(),
  callback = function(ev)
    vim.treesitter.start(ev.buf)
  end,
})
