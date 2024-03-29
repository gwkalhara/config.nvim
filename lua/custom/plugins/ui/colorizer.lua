return {
  "norcalli/nvim-colorizer.lua",
  event = "BufWinEnter",
  config = function ()
    local colorizer = require("colorizer")
    colorizer.setup()
    local wk = require("which-key")
    wk.register({
      U = {
        name = "UI",
        c = { "<cmd>ColorizerToggle<cr>", "Toggle colorizer"}
      }
    }, {prefix = "leader"})
  end
}
