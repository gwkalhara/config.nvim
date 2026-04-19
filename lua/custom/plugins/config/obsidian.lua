require("obsidian").setup({
  legacy_commands = false,
  workspaces = {
    {
      name = "code",
      path = "~/Documents/Obsidian/code",
    },
    {
      name = "personal",
      path = "~/Documents/Obsidian/personal",
    },
  },
})

vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<cr>", { desc = "Search obsidian notes" })
