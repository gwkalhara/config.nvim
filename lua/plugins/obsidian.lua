return {
  "epwalsh/obsidian.nvim",
  version = "*",
  cmd = {
    "ObsidianFollowLink",
    "ObsidianSearch",
    "ObsidianNew",
    "ObsidianTemplate",
    "ObsidianNewFromTemplate",
  },
  ft = "markdown",
  keys = {
    { "<leader>on", mode = "n", "<cmd>ObsidianNew<cr>", desc = "[O]bsidian [N]ew" },
    { "<leader>of", mode = "n", "<cmd>ObsidianSearch<cr>", desc = "[O]bsidian [S]earch" },
    { "<leader>ob", mode = "n", "<cmd>ObsidianBacklinks<cr>", desc = "[O]bsidian [B]ackLinks" },
    { "<leader>ot", mode = "n", "<cmd>ObsidianTags<cr>", desc = "[O]bsidian [T]ags" },
    { "<leader>ow", mode = "n", "<cmd>ObsidianWorkspace<cr>", desc = "[O]bsidian [W]orkspace" },
    { "<leader>oc", mode = "n", "<cmd>ObsidianToggleCheckbox<cr>", desc = "[O]bsidian Toggle[C]heckbox" },
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
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
    mappings = {
      ["gl"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
  },
}
