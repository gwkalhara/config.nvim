--groups
local filetype_group = vim.api.nvim_create_augroup("filetype-group", { clear = true })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- netrw keymappings
vim.api.nvim_create_autocmd("filetype", {
  pattern = "netrw",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<Tab>", "<CR>", { noremap = true, silent = true })
  end,
})

-- TODO: Temporarily disabled to see it is still necessary
-- since most `go` related functionality is handled by `go.nvim`
-- Go specefic autocmd
-- error checking for go
-- formatting(tabs)
-- vim.api.nvim_create_autocmd("filetype", {
--   group = filetype_group,
--   pattern = "go",
--   callback = function()
--     -- formatting
--     vim.opt_local.expandtab = false -- Use tabs instead of spaces
--     vim.opt_local.shiftwidth = 4 -- Set width for auto-indent
--     vim.opt_local.tabstop = 4 -- Set width of a tab character
--     vim.opt_local.softtabstop = 4 -- Match tab behavior with tabstop
--
--     -- keymaps
--     vim.keymap.set("n", "<leader>cR", function()
--       vim.cmd("LspRestart")
--     end, { buffer = true, desc = "Restart LSP" })
--   end,
-- })
