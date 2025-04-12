-- return {
--   "github/copilot.vim",
--   config = function()
--     vim.keymap.set("i", "<C-\\>", 'copilot#Accept("\\<CR>")', {
--       expr = true,
--       replace_keycodes = false,
--     })
--     vim.g.copilot_no_tab_map = true
--   end,
-- }
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    -- panel = { enabled = false },
    suggestion = {
      enabled = true,
      keymap = {
        accept = "<M-\\>",
        accept_word = "<M-w>",
        accept_line = "<M-a>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
  },
}

-- vim.keymap.set("i", "<c-]>", neocodeium.accept, { desc = "Accept codeium prompt" })
-- vim.keymap.set("i", "<A-w>", neocodeium.accept_word, { desc = "Accept codeium word" })
-- vim.keymap.set("i", "<A-a>", neocodeium.accept_line, { desc = "Accept codeium line" })
-- vim.keymap.set("i", "<A-e>", neocodeium.cycle_or_complete, { desc = "Cycle prompt up" })
-- vim.keymap.set("i", "<A-r>", function()
