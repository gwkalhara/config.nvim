return {
  "uga-rosa/ccc.nvim",
    event = "BufWinEnter",
    config = function ()
      require("ccc").setup({
        highlighter = {
          auto_enable = true
        }
      })
      local wk = require("which-key")
      wk.add({
        { "<leader>cp", "<cmd>CccPick<cr>", desc = "Pick color" }
      })
    end
}
