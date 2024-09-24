return {
  "norcalli/nvim-colorizer.lua",
  event = "BufWinEnter",
  config = function ()
    local colorizer = require("colorizer")
    colorizer.setup()
    local wk = require("which-key")
    wk.add({
      { "<leader>Uc", "<cmd>ColorizerToggle<cr>", desc = "Toggle colorizer" }
    })
  end
}
