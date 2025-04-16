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
