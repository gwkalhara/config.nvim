return {
  "kdheepak/lazygit.nvim",
  event = "VeryLazy",
  keys = { "<leader>g"},
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>g", group = "Git" },
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    })
  end
}
