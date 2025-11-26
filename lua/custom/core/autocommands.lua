--groups

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

-- Map q to close
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "man", "help", "qf", "infoview", "diff" }, -- "startuptime",
  callback = function(ev)
    vim.keymap.set("n", "q", ":close<CR>", { buffer = ev.buf, silent = true })
  end,
})
