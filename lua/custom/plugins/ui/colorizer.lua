return {
  "norcalli/nvim-colorizer.lua",
  event = "BufWinEnter",
  config = function ()
    local colorizer = require("colorizer")
    colorizer.setup()
  end
}
