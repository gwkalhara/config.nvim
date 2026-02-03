local Obsidian = {}
Obsidian.keys = {
  { "<leader>on", mode = "n", "<cmd>Obsidian new<cr>", desc = "[O]bsidian [N]ew" },
  { "<leader>of", mode = "n", "<cmd>Obsidian search<cr>", desc = "[O]bsidian [S]earch" },
  { "<leader>ob", mode = "n", "<cmd>Obsidian backlinks<cr>", desc = "[O]bsidian [B]ackLinks" },
  { "<leader>ot", mode = "n", "<cmd>Obsidian tags<cr>", desc = "[O]bsidian [T]ags" },
  { "<leader>ow", mode = "n", "<cmd>Obsidian workspace<cr>", desc = "[O]bsidian [W]orkspace" },
  { "<leader>oc", mode = "n", "<cmd>Obsidian toggle_checkbox<cr>", desc = "[O]bsidian Toggle[C]heckbox" },
}
Obsidian.dependencies = {
  "nvim-lua/plenary.nvim",

  "nvim-treesitter/nvim-treesitter",
}
Obsidian.opts = {
  -- templates = { folder = "templates", date_format = "%Y-%m-%d-%a", time_format = "%H:%M", },
  legacy_commands = false,
  workspaces = {
    {
      name = "code",
      path = "C:/Users/Hp/Documents/ObsidianVault/code",
    },
    {
      name = "personal",
      path = "C:/Users/Hp/Documents/ObsidianVault/personal",
    },
  },
  ui = {
    enable = false,
    checkboxex = {
      ["-"] = { char = "󰰱", hl_group = "ObsidianTilde" },
    },
  },
  statusline = {
    format = "{{backlinks}} backlinks",
  },
}

return Obsidian
